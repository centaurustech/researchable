# coding: utf-8
class Project < ActiveRecord::Base

  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::UrlHelper
  include ERB::Util
  include Rails.application.routes.url_helpers

  delegate :display_status, :display_progress, :display_image, :display_expires_at,
    :display_pledged, :display_goal,
    :to => :decorator
  
  belongs_to :user
  belongs_to :category
  has_many :projects_curated_pages
  has_many :curated_pages, :through => :projects_curated_pages
  has_many :backers, :dependent => :destroy
  has_many :rewards, :dependent => :destroy
  has_many :updates, :dependent => :destroy
  has_many :notifications, :dependent => :destroy
  has_one :project_total
  has_one :academic_email
  has_and_belongs_to_many :managers, :join_table => "projects_managers", :class_name => 'User'
  accepts_nested_attributes_for :rewards
  has_vimeo_video :video_url, :message => I18n.t('project.vimeo_regex_validation')
    
  auto_html_for :about do
    html_escape :map => {
      '&' => '&amp;',
      '>' => '&gt;',
      '<' => '&lt;',
      '"' => '"' }
    image
    youtube width: 600, height: 430, wmode: "opaque"
    vimeo width: 600, height: 403
    redcloth :target => :_blank
    link :target => :_blank
  end

  scope :visible, where(visible: true)
  scope :recommended, where(recommended: true)
  scope :expired, where("finished OR expires_at < current_timestamp")
  scope :not_expired, where("finished = false AND expires_at >= current_timestamp")
  scope :expiring, not_expired.where("expires_at < (current_timestamp + interval '2 weeks')")
  scope :not_expiring, not_expired.where("NOT (expires_at < (current_timestamp + interval '2 weeks'))")
  scope :recent, where("current_timestamp - projects.created_at <= '15 days'::interval")
  scope :successful, where(successful: true)
  scope :recommended_for_home, ->{
    includes(:user, :category, :project_total).
    recommended.
    visible.
    not_expired.
    order('random()').
    limit(4)
  }
  scope :expiring_for_home, ->(exclude_ids){
    includes(:user, :category, :project_total).where("coalesce(id NOT IN (?), true)", exclude_ids).visible.expiring.order('date(expires_at), random()').limit(3)
  }
  scope :recent_for_home, ->(exclude_ids){
    includes(:user, :category, :project_total).where("coalesce(id NOT IN (?), true)", exclude_ids).visible.recent.not_expiring.order('date(created_at) DESC, random()').limit(3)
  }

  search_methods :visible, :recommended, :expired, :not_expired, :expiring, :not_expiring, :recent, :successful
  validates_presence_of :name, :user, :category, :about, :headline, :goal, :expires_at, :academic_email
  validates_length_of :headline, :maximum => 140
  validates_uniqueness_of :permalink, :allow_blank => true, :allow_nil => true
  validates_format_of :permalink, with: /^(\w|-)*$/, :allow_blank => true, :allow_nil => true
  mount_uploader :video_thumbnail, LogoUploader
  before_create :store_image_url
  
  validate :media_present?
  def media_present?
    if video_url.blank? and flickr_url.blank?
     #one at least must be filled in, add a custom error message
     return false
    elsif !video_url.blank? and !flickr_url.blank?
     #both can't be filled in, add custom error message
     return false
    else
     return true
    end
  end
  
  
  def store_image_url
    self.image_url = vimeo.thumbnail unless self.image_url
  end
  
  def self.unaccent_search search
    joins(:user).where("unaccent(projects.name || headline || about || coalesce(users.name,'') || coalesce(users.address_city,'')) ~* unaccent(?)", search)
  end
  
  def users_who_backed
    User.who_backed_project(self.id)
  end

  def decorator
    @decorator ||= ProjectDecorator.new(self)
  end
    
  def to_param
    "#{self.id}-#{self.name.parameterize}"
  end

  def display_image
    return image_url if image_url
    return "user.png" unless vimeo.thumbnail
    vimeo.thumbnail
  end

  def display_expires_at
    I18n.l(expires_at.to_date)
  end

  def display_pledged
    number_to_currency pledged, :unit => '$', :precision => 0, :delimiter => '.'
  end

  def display_goal
    number_to_currency goal, :unit => '$', :precision => 0, :delimiter => '.'
  end

  def pledged
    project_total ? project_total.pledged : 0.0
  end

  def total_backers
    project_total ? project_total.total_backers : 0
  end

  def display_status
    if successful? and expired?
      'successful'
    elsif expired?
      'expired'
    elsif waiting_confirmation?
      'waiting_confirmation'
    elsif in_time?
      'in_time'
    end
  end

  def successful?
    return successful if finished
    pledged >= goal
  end

  def expired?
    finished || expires_at < Time.now
  end

  def waiting_confirmation?
    return false if finished or successful?
    expired? and Time.now < 3.weekdays_from(expires_at)
  end

  def in_time?
    !expired?
  end

  def progress
    ((pledged / goal * 100).abs).round.to_i
  end

  def display_progress
    return 100 if successful?
    return 8 if progress > 0 and progress < 8
    progress
  end

  def time_to_go
    if expires_at >= 1.day.from_now
      time = ((expires_at - Time.now).abs/60/60/24).round
      {:time => time, :unit => pluralize_without_number(time, I18n.t('datetime.prompts.day').downcase)}
    elsif expires_at >= 1.hour.from_now
      time = ((expires_at - Time.now).abs/60/60).round
      {:time => time, :unit => pluralize_without_number(time, I18n.t('datetime.prompts.hour').downcase)}
    elsif expires_at >= 1.minute.from_now
      time = ((expires_at - Time.now).abs/60).round
      {:time => time, :unit => pluralize_without_number(time, I18n.t('datetime.prompts.minute').downcase)}
    elsif expires_at >= 1.second.from_now
      time = ((expires_at - Time.now).abs).round
      {:time => time, :unit => pluralize_without_number(time, I18n.t('datetime.prompts.second').downcase)}
    else
      {:time => 0, :unit => pluralize_without_number(0, I18n.t('datetime.prompts.second').downcase)}
    end
  end

  def remaining_text
    pluralize_without_number(time_to_go[:time], I18n.t('remaining_singular'), I18n.t('remaining_plural'))
  end
  
  def download_video_thumbnail
    self.video_thumbnail = open(self.vimeo.thumbnail) if self.video_url
  rescue OpenURI::HTTPError => e
    ::Airbrake.notify({ :error_class => "Vimeo thumbnail download", :error_message => "Vimeo thumbnail download: #{e.inspect}", :parameters => video_url}) rescue nil
  rescue TypeError => e
    ::Airbrake.notify({ :error_class => "Carrierwave does not like thumbnail file", :error_message => "Carrierwave does not like thumbnail file: #{e.inspect}", :parameters => video_url}) rescue nil
  end
  
  def can_back?
    visible? and not expired? and not rejected?
  end

  def finish!
    return unless expired? and can_finish and not finished
    notify_observers(:notify_users)
  end

  def as_json(options={})
    {
      id: id,
      name: name,
      user: user,
      category: category,
      image: display_image,
      headline: headline,
      progress: progress,
      display_progress: display_progress,
      pledged: display_pledged,
      created_at: created_at,
      time_to_go: time_to_go,
      remaining_text: remaining_text,
      url: (self.permalink.blank? ? "/projects/#{self.to_param}" : '/' + self.permalink),
      full_uri: I18n.t('site.base_url') + (self.permalink.blank? ? Rails.application.routes.url_helpers.project_path(self) : '/' + self.permalink),
      expired: expired?,
      successful: successful?,
      waiting_confirmation: waiting_confirmation?,
      display_status_to_box: I18n.t("project.display_status.#{display_status}").capitalize,
      display_expires_at: display_expires_at,
      in_time: in_time?
    }
  end
  
  after_create :flickrimages
    private
      def flickrimages 
        unless self.flickr_url.blank?
          line = self.flickr_url
          regex = Regexp.new('photos\/[^\/]+\/([0-9]+)')
          tmp = line.scan(regex)
          flickr_id = tmp.join
          flickr_image = FlickRaw.url_z(flickr.photos.getInfo(:photo_id => flickr_id))
          flickr_thumb = FlickRaw.url_m(flickr.photos.getInfo(:photo_id => flickr_id))
          flickr_square = FlickRaw.url_q(flickr.photos.getInfo(:photo_id => flickr_id))
          self.update_attributes(:flickr_image => flickr_image)
          self.update_attributes(:flickr_thumb => flickr_thumb)
          self.update_attributes(:flickr_square => flickr_square)
        end
        if self.image_url.blank?
          self.update_attributes(:image_url => flickr_image)
        end
      end

end
