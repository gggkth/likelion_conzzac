class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.integer :user_id
      t.string :content
      t.integer :frequency
      t.timestamps null: false
    end
  end
end
