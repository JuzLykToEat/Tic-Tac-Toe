class Game < ApplicationRecord
  has_one :board

  WINNING_COMBINATION = [
    [0,1,2], [3,4,5], [6,7,8],

    [0,3,6], [1,4,7], [2,5,8],

    [0,4,8], [2,4,6]
  ]

  def game_winner(cell)
    WINNING_COMBINATION.each do |a|
      if cell.find_by(place: a[0]).value == cell.find_by(place: a[1]).value && cell.find_by(place: a[1]).value == cell.find_by(place: a[2]).value
        self.update(outcome: cell.find_by(place: a[0]).value)
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
