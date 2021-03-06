class GamesController < ApplicationController

# the page to display the game and holds the flow of the game
  def show
    @game = Game.find_by(id: params[:id])
    @board = Board.find_by(game_id: params[:id])
    @cell = @board.cells.order(place: :asc)
    player_turn?

    @ai = Ai.find_or_create_by(id: 1)
    @cells_array = @ai.cells_array(@cell)

# this part is runned when it's the ai's turn
    if !@ai.game_ended?(@cells_array) && @current_player == 2
      @ai.minimax(@cells_array, @current_player)
      @ai.best_move(@cell)
      redirect_to(:back)
    end

# determine the outcome of the game
    @game.game_draw(@cell)
    @game.determine_winner(@cell)
  end

# A new game, board and 9 cells are created during a new game
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

# determine who's turn it is now. 1 is player & 2 is ai
    def player_turn?
      if @cell.where(value: 1).count > @cell.where(value: 2).count
        @current_player = 2
      else
        @current_player = 1
      end
    end

end
