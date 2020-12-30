class CreateDirectMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :direct_messages do |t|
      t.text :message,    null: false
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
      t.timestamps
    end
  end
end
