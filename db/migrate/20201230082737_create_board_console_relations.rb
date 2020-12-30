class CreateBoardConsoleRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :board_console_relations do |t|
      t.references :board,   foreign_key: true
      t.references :console, foreign_key: true
      t.timestamps
    end
  end
end
