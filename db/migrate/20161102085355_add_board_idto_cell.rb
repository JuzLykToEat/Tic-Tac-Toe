class AddBoardIdtoCell < ActiveRecord::Migration[5.0]
  def change
    add_column :cells, :board_id, :integer
  end
end
