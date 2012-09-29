class AlterDefaultPorjectStatusToLive < ActiveRecord::Migration
  def up
    execute "ALTER TABLE projects ALTER visible SET DEFAULT true"
  end

  def down
    execute "ALTER TABLE projects ALTER visible SET DEFAULT false"
  end
end
