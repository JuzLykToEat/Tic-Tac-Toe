class Ai < ApplicationRecord

  def winner(cells)
    winning_player = nil

    WINNING_COMBINATION.each do |a|
      if cells[a[0]] == cells[a[1]] && cells[a[1]] == cells[a[2]] && cells[a[2]] != 0
        winning_player = cells[a[0]]
      end
    end
    winning_player
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
    winner(cells).present? || available_cells_position(cells).empty?
  end

  def minimax(cells)
    return score(cells) if game_ended?(cells)

    scores = []

    available_cells_position(cells).each do |position|
      possible_cells = cells.dup
      if possible_cells.count(1) > possible_cells.count(2)
        possible_cells[position] = 2
      else
        possible_cells[position] = 1
      end

      scores[position] = minimax(possible_cells)
    end

    if @current_player == 2
      @choice = scores.each_with_index.max[1]
      return scores[@choice]
    else
      @choice = scores.each_with_index.min[1]
      return scores[@choice]
    end
  end


end
