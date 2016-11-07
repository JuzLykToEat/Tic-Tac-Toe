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
    if current_player == 1
      current_player = 2
    end
    current_player
  end

  def minimax(cells, current_player)
    return score(cells) if game_ended?(cells)

    scores = {}
    potential_move = []
    potential_move = available_cells_position(cells)

    potential_move.each do |position|
      possible_cells = cells.dup
      if current_player == 2
        possible_cells[position] = 2
      else
        possible_cells[position] = 1
      end

      scores[position] = minimax(possible_cells, switch_player(current_player))
    end

    if current_player == 2
      best_choice, best_score = scores.max_by { |_k, v| v }
      return best_choice
    else
      best_choice, best_score = scores.min_by { |_k, v| v }
      return best_choice
    end
  end


end
