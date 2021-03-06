class Ai < ApplicationRecord

  def winner(cells)
    winning_player = nil

    WINNING_COMBINATION.each do |a|
      if cells[a[0]] == cells[a[1]] && cells[a[1]] == cells[a[2]] && cells[a[2]] != 0
        winning_player = cells[a[0]]
      end
    end
    return winning_player
  end

  def cells_array(cells)
    cells_array = []
    cells.each do |cell|
      cells_array[cell.place] = cell.value
    end
    cells_array
  end

# this will return the score depending of the outcome of the stimulation from the algorithm
  def score(cells)
    if winner(cells) == 2
      return 10
    elsif winner(cells) == 1
      return -10
    else
      return 0
    end
  end

  def available_cells_position(cells)
    dummy = cells.dup
    available = []

    dummy.count(0).times do
      available << dummy.index(0)
      dummy[dummy.index(0)] = 1
    end

    available
  end

  def game_ended?(cells)
    available_cells = []
    available_cells = available_cells_position(cells)

    return winner(cells) || available_cells.empty?
  end

  def switch_player(current_player)
    current_player == 2 ? 1 : 2
  end

# the minimax algorithm used to determine the best move
# best move will be the move that returns the highest score
  def minimax(cells, current_player)
    return score(cells) if game_ended?(cells)

    scores = {}
    potential_move = []
    potential_move = available_cells_position(cells)

# each potential move will be placed on the board and the outcome will give the score
    potential_move.each do |position|
      possible_cells = cells.dup
      if current_player == 2
        possible_cells[position] = 2
      else
        possible_cells[position] = 1
      end

      scores[position] = minimax(possible_cells, switch_player(current_player))
    end

# the move that score the highest will be used
    if current_player == 2
      @best_move, best_score = scores.max_by { |_k, v| v }
      return best_score
    else
      @best_move, best_score = scores.min_by { |_k, v| v }
      return best_score
    end
  end

# the returned best move will be applied
  def best_move(cells)
    cells.find_by(place: @best_move).update(value: 2)
  end

end
