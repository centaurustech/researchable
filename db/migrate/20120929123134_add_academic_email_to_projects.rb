class AddAcademicEmailToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :academic_email, :string
  end
end
