class CreateFrequents < ActiveRecord::Migration
  def change
    create_table :frequents do |t|
      t.integer :clip_id
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
