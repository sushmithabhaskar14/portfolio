class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :project_url
      t.text :description
      t.text :attachment

      t.timestamps
    end
  end
end
