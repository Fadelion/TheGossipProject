class CreateGossipsTagsJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :gossips, :tags do |t|
      t.index :gossip_id
      t.index :tag_id
    end
  end
end
