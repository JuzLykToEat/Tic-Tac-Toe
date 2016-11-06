class Game < ApplicationRecord
  has_one :board

  WINNING_COMBINATION = [
    [0,1,2], [3,4,5], [6,7,8],

    [0,3,6], [1,4,7], [2,5,8],

    [0,4,8], [2,4,6]
  ]

  def determine_winner(cells)
    winning_player = nil

    WINNING_COMBINATION.each do |a|
      if cells.value_of_cell(a[0]) == cells.value_of_cell(a[1]) && cells.value_of_cell(a[1]) == cells.value_of_cell(a[2]) && cells.value_of_cell(a[2]) != 0
        winning_player = cells.value_of_cell(a[0])
      end
    end
    winning_player
  end

  def game_winner(cells)
    self.update(outcome: determine_winner(cells))
  end

  def available_moves(cells)
    available = []
    cells.each do |cell|
      if cell.value == 0
        available << cell
      end
    end
    available
  end

  def game_draw(cells)
    if available_moves(cells).empty?
      self.outcome = 0
    end
  end

  def score(cells)
    if determine_winner(cells) == 2
      return 10
    elsif determine_winner(cells) == 1
      return -10
    else
      return 0
    end
  end

  def minimax(cells)
    possible_cells = cells.dup

    return score(cells) if determine_winner(cells)

    scores = []

    available_moves(possible_cells).each do |move|
      if possible_cells.where(value: 1).count > possible_cells.where(value: 2).count
        move.value = 2
      else
        move.value = 1
      end

      scores[move.place] = minimax(possible_cells)
    end
  end


end
