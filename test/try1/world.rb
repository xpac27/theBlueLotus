class World

  attr_reader :player

  TILE_SIZE = 64

  def initialize(window)
    @player = Player.new(window)
    @tiles = {}
  end

  def update(window)
    @player.update

#    @tiles.each{|k, v| puts k }
  end

  def draw(window)
    @player.draw(window)

    (1 + (window.width / TILE_SIZE).ceil).times do |x|
      (2 + (window.height / TILE_SIZE).ceil).times do |y|
        # find tile's coordinate on the map
        kx = ((@player.x - (window.width / 2)) / TILE_SIZE).floor + x
        ky = ((@player.y - (window.height / 2)) / TILE_SIZE).floor + y
        # find tile's position on the screen
        px = (TILE_SIZE * x) - ((@player.x - (window.width / 2)) % TILE_SIZE)
        py = (TILE_SIZE * y) - ((@player.y - (window.height / 2)) % TILE_SIZE)
        # name tile's key with its coordinates
        key = kx.to_s + '-' + ky.to_s
        # if tile doew not exists create it
        @tiles[key] ||= Tile.new(window)
        # draw tile on screen
        @tiles[key].draw(px, py)
      end
    end
  end
end

