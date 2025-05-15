class CreatePrivateMessagesUsersJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :private_messages, :users do |t|
      t.index :private_message_id
      t.index :user_id
    end
  end
end
