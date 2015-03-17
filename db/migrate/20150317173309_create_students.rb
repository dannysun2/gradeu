class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :firstname
      t.string :lastname
      t.integer :age
      t.string :gender
      t.integer :user_id
      t.integer :classgroup_id

      t.timestamps null: false
    end
  end
end
