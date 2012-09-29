class DropNotNullFromProjectsVideoUrl < ActiveRecord::Migration
  def up
    execute "ALTER TABLE projects ALTER video_url drop not null"
  end

  def down
    execute "ALTER TABLE projects ALTER video_url add not null"
  end
end
