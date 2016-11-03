class CreateCells < ActiveRecord::Migration[5.0]
  def change
    create_table :cells do |t|
      t.integer :value, default: 0

      t.timestamps
    end
  end
end
