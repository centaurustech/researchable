class AddFlickrToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :flickr_url, :text
  end
end
