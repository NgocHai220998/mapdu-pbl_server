class CreateWorkSpaces < ActiveRecord::Migration[6.1]
  def change
    create_table :work_spaces do |t|
      t.integer :user_id
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
