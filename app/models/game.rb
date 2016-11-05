class Game < ApplicationRecord
  has_one :board

  WINNING_COMBINATION = [
    [0,1,2], [3,4,5], [6,7,8],

    [0,3,6], [1,4,7], [2,5,8],

    [0,4,8], [2,4,6]
  ]

  def game_winner(cell)
    WINNING_COMBINATION.each do |a|
      if cell.value_of_cell(a[0]) == cell.value_of_cell(a[1]) && cell.value_of_cell(a[1]) == cell.value_of_cell(a[2]) && cell.value_of_cell(a[2]) != 0
        self.update(outcome: cell.value_of_cell(a[0]))
      end
    end
  end

  def game_draw(cell)
    available = []
    cell.each do |cell|
      if cell.value == 0
        available << cell
      end
    end

    if available.empty?
      self.outcome = 0
    end
  end


end
