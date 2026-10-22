class CreateProjects < ActiveRecord::Migration[8.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :status
      t.boolean :archived

      t.timestamps
    end
  end
end
