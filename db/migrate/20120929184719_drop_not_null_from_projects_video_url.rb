class DropNotNullFromProjectsVideoUrl < ActiveRecord::Migration
  def up
    execute "ALTER TABLE projects ALTER video_url drop not null"
    execute "ALTER TABLE projects drop CONSTRAINT projects_video_url_not_blank"
  end

  def down
    execute "ALTER TABLE projects ALTER video_url add not null"
    execute "ALTER TABLE projects ADD CONSTRAINT projects_video_url_not_blank"
  end
end
