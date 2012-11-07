class BackerObserver < ActiveRecord::Observer
  observe :backer

  def after_create(backer)
    backer.define_key
    backer.define_payment_method
  end

  def before_save(backer)

    if backer.confirmed and backer.confirmed_at.nil?
      backer.confirmed_at = Time.now
      Notification.create_notification(:confirm_backer, backer.user, :backer => backer,  :project_name => backer.project.name)
    end


    backer.user.save
  end

  def after_save(backer)
      Notification.create_notification_once(:project_success, backer.project.user, {'project_id' => backer.project.id}, project: backer.project) if backer.project.successful?
  end

end
