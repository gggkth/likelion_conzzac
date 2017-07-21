class CreateClips < ActiveRecord::Migration
  def change
    create_table :clips do |t|
      t.text :thumbnail_url
      t.string :title
      t.text :content
      t.integer :view
      t.text :clip_url
      t.integer :uploader_id
      t.integer :source_id

      t.timestamps null: false
    end
  end
end
