require "byebug"
require_relative "1_board"

class Minesweeper
    def self.new_game(board_size, bomb_number)
        board = Board.prep_board(board_size, bomb_number)
        board.set_tile_neighbors
        board.set_tile_bomb_count
        self.new(board)
    end

    def initialize(board)
        @board = board
    end

    attr_reader :board

    def get_pos
        pos = nil
        valid = false
        until pos && valid
            puts "Please enter a position in a row,col format (ex: 3,4):"
            print "> "

            begin
                pos = parse_pos(gets.chomp)
            rescue
                puts "Invalid position entered, please try again."
                puts ""

                pos = nil
            end
            valid = valid_pos?(pos)
            unless valid
                puts "Invalid position entered, please try again."
                puts ""
            end
        end
        pos
    end

    def parse_pos(input)
        input
            .split(",")
            .map(&:to_i)
    end

    def valid_pos?(pos)
        pos.is_a?(Array) &&
        pos.length == 2 &&
        pos.all? { |x| x.between?(0, @board.size - 1) }
    end

    def get_move_type
        type = nil
        valid = false
        until type && valid
            puts "Reveal or Flag? (r/f):"
            print "> "
            type = gets.chomp
            valid = valid_move_type?(type)
            unless valid
                puts "Invalid move type, please try again."
                puts ""
            end
        end
        type
    end

    def valid_move_type?(type)
        ["r","f"].include?(type.downcase)
    end

    def play_turn
        system("clear")
        self.board.render

        move_type = self.get_move_type
        pos = self.get_pos

        if move_type == "f"
            self.board.flag_tile(pos)
        else
            self.board.chain_reveal_tile(pos)
        end
        system("clear")
        self.board.render
    end
end