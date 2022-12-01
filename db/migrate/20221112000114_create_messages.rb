class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages, id: false, primary_key: :event_id do |t|
      t.string :event_id, null: false
      t.string :trace_id, null: false
      t.string :actor_id, null: false
      t.string :stream, null: false
      t.string :event_type, null: false
      t.timestamp :timestamp, null: false
      t.json :data, null: false
    end
    add_index :messages, :trace_id
    add_index :messages, :stream
    add_index :messages, :event_id, unique: true
  end
end
