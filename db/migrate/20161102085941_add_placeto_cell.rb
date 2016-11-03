class AddPlacetoCell < ActiveRecord::Migration[5.0]
  def change
    add_column :cells, :place, :integer
  end
end
