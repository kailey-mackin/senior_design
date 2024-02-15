class GroupUsers < ActiveRecord::Migration
  def change
    create_table :group_users do |t|
    t.integer :group_id
    t.integer :user_id
  end

  add_index :quiz_sounds, [:group_id, :user_id], unique: true
  end
end
