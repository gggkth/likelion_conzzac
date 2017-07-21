class CreateScraps < ActiveRecord::Migration
  def change
    create_table :scraps do |t|
      t.integer :clip_id
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
