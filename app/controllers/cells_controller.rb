class CellsController < ApplicationController
  before_action :find_cell

  def place_x
    if @cell.value == 0
      value = 1
    end
  end

  def place_o
    if @cell.value == 0
      value = 2
    end
  end

  private

  def find_cell
    @board = Board.find_by(id: params[:board_id])
    @cell = @board.cell.find_by(place: params[:position])
  end
end
