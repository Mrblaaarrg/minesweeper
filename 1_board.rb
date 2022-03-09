require "byebug"
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

    def [](pos)
        row, col = pos
        @grid[row][col]
    end

    def find_neighbors(tile_coords)
        row, col = tile_coords
        neighbors = []
        (0..row + 1).each do |x|
            next unless x >= row - 1
            next if @grid[x].nil?
            (0..col + 1).each do |y|
                next unless y >= col - 1
                next if x == row && y == col
                neighbor = @grid[x][y]
                neighbors <<  neighbor unless neighbor.nil?
            end
        end
        neighbors
    end

    def set_tile_neighbors
        @grid.each.with_index do |row, ri|
            row.each.with_index do |tile, ci|
                coords = [ri, ci]
                neighbors = find_neighbors(coords)
                tile.get_neighbors(neighbors)
            end
        end
    end

    def set_tile_bomb_count
        @grid.each.with_index do |row, ri|
            row.each.with_index do |tile, ci|
                coords = [ri, ci]
                tile.get_bomb_count
            end
        end
    end

    def flag_tile(pos)
        self[pos].flagged ? self[pos].unflag : self[pos].flag
    end

    def reveal_tile(pos)
        self[pos].reveal
    end

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

    def size
        @grid.size
    end

    def cheat_reveal
        @grid.each.with_index do |row, ri|
            row.each.with_index do |tile, ci|
                coords = [ri, ci]
                tile.reveal
            end
        end
    end

end