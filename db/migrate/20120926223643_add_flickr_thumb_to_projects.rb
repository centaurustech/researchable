class AddFlickrThumbToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :flickr_thumb, :text
  end
end
