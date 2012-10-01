class DropPaypalEmailFromProjects < ActiveRecord::Migration
  def up
    execute "alter table projects drop column paypal_email"
  end
end
