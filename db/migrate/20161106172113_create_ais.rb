class CreateAis < ActiveRecord::Migration[5.0]
  def change
    create_table :ais do |t|

      t.timestamps
    end
  end
end
