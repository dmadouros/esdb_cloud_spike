class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories, id: false, primary_key: :category do |t|
      t.string :category, null: false
      t.integer :message_count, null: false
      t.string :last_message_id, null: false
      t.integer :last_message_global_position, null: false

      t.timestamps
    end
    add_index :categories, :category, unique: true
  end
end
