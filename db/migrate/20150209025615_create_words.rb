class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :vietnamese
      t.string :japanese
      t.references :category, index: true

      t.timestamps null: false
    end
    add_index :words, :vietnamese, unique: true
  end
end
