class CreateStreams < ActiveRecord::Migration[7.0]
  def change
    create_table :streams, id: false, primary_key: :stream do |t|
      t.string :stream, null: false
      t.integer :message_count, null: false
      t.string :last_message_id, null: false
      t.integer :last_message_global_position, null: false

      t.timestamps
    end
    add_index :streams, :stream, unique: true
  end
end
