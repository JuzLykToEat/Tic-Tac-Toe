class BoardsController < ApplicationController

  def create
    @board = Board.new(game_id: params[:id])
    @board.new_board
    binding.pry
  end

end
