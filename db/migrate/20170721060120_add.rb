class Add < ActiveRecord::Migration
  def change
    add_column :frequents, :frequent, :integer
  end
end
