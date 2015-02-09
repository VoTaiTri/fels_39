class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :user_id
      t.references :lesson_id
      t.references :result_id
      t.string  :action_type 

      t.timestamps null: false
    end
  end
end
