class Board < ApplicationRecord
  has_many :cells
  belongs_to :game

  def initialize
    position = Array.new(9)

    for i in 0..8
      position[i] = Cell.new
      position[i].place = i
    end
  end

  
end
