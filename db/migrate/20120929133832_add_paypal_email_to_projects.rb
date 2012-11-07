class AddPaypalEmailToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :paypal_email, :string
  end
end
