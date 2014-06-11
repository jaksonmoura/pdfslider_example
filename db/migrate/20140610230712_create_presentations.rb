class CreatePresentations < ActiveRecord::Migration
  def change
    create_table :presentations do |t|
      t.references :user, index: true
      t.string :title
      t.integer :qte_slides
      t.string :pdf_name

      t.timestamps
    end
  end
end
