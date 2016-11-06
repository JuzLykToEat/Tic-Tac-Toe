class Game < ApplicationRecord
  has_one :board

  def determine_winner(cells)
    WINNING_COMBINATION.each do |a|
      if cells.value_of_cell(a[0]) == cells.value_of_cell(a[1]) && cells.value_of_cell(a[1]) == cells.value_of_cell(a[2]) && cells.value_of_cell(a[2]) != 0
        self.update(outcome: cells.value_of_cell(a[0]))
      end
    end
  end

  def game_draw(cells)
    available = []
    cells.each do |cell|
      if cell.value == 0
        available << cell
      end
    end

    if available.empty?
      self.outcome = 0
    end
  end

end
