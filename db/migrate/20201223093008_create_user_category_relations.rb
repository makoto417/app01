class CreateUserCategoryRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :user_category_relations do |t|
      t.references :user,    foreign_key: true
      t.references :category, foreign_key: true
      t.timestamps
    end
  end
end
