require_relative "0_tile"

class Board
    def self.prep_board(board_size, bomb_number)        
        all_tiles = []
        bomb_number.times { all_tiles << Tile.new(true) }
        all_tiles << Tile.new until all_tiles.count == board_size * board_size
        all_tiles.shuffle!

        grid = []
        board_size.times do |row|
            grid << []
            board_size.times do |col|
                grid[row] << all_tiles.shift
            end
        end
        
        self.new(grid, bomb_number)
    end

    def initialize(grid, bomb_number)
        @grid = grid
        @bombs_left = bomb_number
    end

    attr_accessor :grid

    

    def render
        header = "  " + (0...@grid.size).to_a.join(" ")
        counter_text = "Bombs remaining: #{@bombs_left}"
        # Bomb counter
        padding = (header.length - counter_text.length) / 2
        puts " ".ljust(padding, " ") + counter_text
        puts "-".ljust(header.length, "-")
        # Grid header
        puts header
        @grid.each.with_index do |row, i|
            puts i.to_s + " " + row.join(" ")
        end
        true
    end

end