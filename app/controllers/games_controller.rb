class GamesController < ApplicationController

  def show
    @game = Game.find_by(id: params[:id])
    @board = Board.find_by(game_id: params[:id])
    @cell = @board.cells.order(place: :asc)

    player_turn?
    @game.game_winner(@cell)
    @game.game_draw(@cell)
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

    def player_turn?
      if @cell.where(value: 1).count > @cell.where(value: 2).count
        @current_player = 2
      else
        @current_player = 1
      end
    end

end
