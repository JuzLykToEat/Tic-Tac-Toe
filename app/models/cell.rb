class Cell < ApplicationRecord
  belongs_to :board

  def self.value_of_cell(position)
    self.find_by(place: position).value
  end

end
