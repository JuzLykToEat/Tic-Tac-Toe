class GamesController < ApplicationController

  def show
    @game = Game.find_by(id: params[:id])
    @board = Board.find_by(game_id: params[:id])
    @cell = @board.cells.order(place: :asc)
    player_turn?

    @ai = Ai.find_by(id: 1)
    @cells_array = @ai.cells_array(@cell)

    if !@ai.game_ended?(@cells_array) && @current_player == 2
      depth = 0
      @best_move = @ai.minimax(@cells_array, @current_player)
      @cell.find_by(place: @best_move).update(value: 2)
      redirect_to(:back)
    end

    @game.game_draw(@cell)
    @game.determine_winner(@cell)
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

    def player_turn?
      if @cell.where(value: 1).count > @cell.where(value: 2).count
        @current_player = 2
      else
        @current_player = 1
      end
    end

end
