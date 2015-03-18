class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :weight
      t.string :name
      t.integer :grade
      t.integer :student_id
      t.integer :user_id
      t.integer :classgroup_id

      t.timestamps null: false
    end
  end
end
