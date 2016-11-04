class Game < ApplicationRecord
  has_one :board

  WINNING_COMBINATION = [
    [0,1,2], [3,4,5], [6,7,8],

    [0,3,6], [1,4,7], [2,5,8],

    [0,4,8], [2,4,6]
  ]

  def game_winner(board)
    WINNING_COMBINATION.each do |a|
      if position[a[0]] == position[a[1]] && position[a[1]] == position[a[2]]
        self.outcome = position[a[0]].value
      end
    end
  end

  def game_draw(board)
    available = []
    position.each do |position|
      if position.value == 0
        available << position
      end
    end

    if available.empty?
      self.outcome = 0
    end
  end

end
