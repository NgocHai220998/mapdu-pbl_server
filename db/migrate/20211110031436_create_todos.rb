class CreateTodos < ActiveRecord::Migration[6.1]
  def change
    create_table :todos do |t|
      t.integer :work_space_id
      t.string :title
      t.text :description
      t.integer :priority
      t.integer :status

      t.timestamps
    end
  end
end
