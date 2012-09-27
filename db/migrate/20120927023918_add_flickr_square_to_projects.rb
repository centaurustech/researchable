class AddFlickrSquareToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :flickr_square, :text
  end
end
