class CreateConnects < ActiveRecord::Migration
  def change
    create_table :connects do |t|
      t.integer :clip_id
      t.integer :category_id
      t.timestamps null: false
    end
  end
end
