class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.references :category, index: true
      t.references :user, index: true
      t.text :words
      t.text :answers

      t.timestamps null: false
    end
  end
end
