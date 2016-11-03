class RemoveCellFromBoard < ActiveRecord::Migration[5.0]
  def change
    remove_column :boards, :cell
  end
end
