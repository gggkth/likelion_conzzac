class Add < ActiveRecord::Migration
  def change
    add_column :frequents, :frequency, :integer
  end
end
