require_relative "1_board"

class Minesweeper
    def self.new_game(board_size, bomb_number)
        board = Board.prep_board(board_size, bomb_number)
        board.set_tile_neighbors
        self.new(board)
    end

    def initialize(board)
        @board = board
    end

    attr_reader :board
end