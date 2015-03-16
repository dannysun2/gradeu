class CreateClassgroups < ActiveRecord::Migration
  def change
    create_table :classgroups do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
