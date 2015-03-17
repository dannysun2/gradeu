class Adduserstoclass < ActiveRecord::Migration
  def change
     add_column :classgroups, :user_id, :integer
  end
end
