class CreateCategoriesPresentations < ActiveRecord::Migration
  def change
    create_table :categories_presentations do |t|
      t.belongs_to :category, index: true
      t.belongs_to :presentation, index: true
    end
  end
end
