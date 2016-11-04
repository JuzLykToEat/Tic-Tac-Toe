class Board < ApplicationRecord
  has_many :cells
  belongs_to :game

  def new_cell(i)
    position = Cell.new
    position.place = i
    position.board_id = self.id
    position.save!
  end

  def new_board

    for i in 0..8
      new_cell(i)
    end

  end

end
