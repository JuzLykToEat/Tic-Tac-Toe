class GamesController < ApplicationController

  def show
    @game = Game.find_by(id: params[:id])
    @board = Board.find_by(game_id: params[:id])
    @cell = @board.cells.all
  end

  def create
    @game = Game.new

    if @game.save
      @board = Board.new(game_id: @game.id)

      if @board.save
        @board.new_board
        redirect_to game_path(@game.id)
      end

    end
  end

  private

    def game_params
      params.require(:game).permit(:outcome)
    end

end
