class CreateUserConsoleRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :user_console_relations do |t|
      t.references :user,    foreign_key: true
      t.references :console, foreign_key: true
      t.timestamps
    end
  end
end
