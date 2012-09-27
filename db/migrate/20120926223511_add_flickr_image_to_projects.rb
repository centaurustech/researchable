class AddFlickrImageToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :flickr_image, :text
  end
end
