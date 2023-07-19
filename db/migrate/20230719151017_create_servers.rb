class CreateServers < ActiveRecord::Migration[7.0]
  def change
    create_table :servers do |t|
      t.string :discord_server_id, null: false, unique: true
      t.integer :music_volume, null: false, unique: false, default: 5
      t.boolean :is_read_unconnected_user_message, null: false, unique: false, default: false
      t.boolean :is_read_user_name, null: false, unique: false, default: true
      t.boolean :is_read_message, null: false, unique: false, default: true
      t.boolean :is_auto_join, null: false, unique: false, default: true
      t.timestamps
    end
  end
end
