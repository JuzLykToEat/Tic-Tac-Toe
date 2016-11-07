class CellsController < ApplicationController
  before_action :find_cell

  def place_x
    if @cell.value == 0
      value = 1
    end

    update_value(value)
    redirect_to(:back)
  end

  def place_o
    if @cell.value == 0
      value = 2
    end

    update_value(value)
    redirect_to(:back)
  end

  private

  def find_cell
    @cell = Cell.find_by(id: params[:cell_id])
  end

  def update_value(value)
    if @cell
      @cell.update(value: value)
    end
  end
end
