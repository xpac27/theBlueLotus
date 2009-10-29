class World

  $TILE_SIZE = 32
  $SPRITE_SIZE = 16
  $SPRITE_TYPE = {
    'SAND'  => {:OO => 0},
    'GRASS' => {:OO => 1},

    'SAND_GRASS' => {
      :NE => 3,
      :NN => 4,
      :NW => 5,
      :WW => 8,
      :SW => 9,
      :SS => 10,
      :SE => 11,
      :EE => 6
    }
  }

  attr_reader :player

  def initialize(window)
    @ground_sprites = Gosu::Image.load_tiles(window, 'media/ground.png', $SPRITE_SIZE, $SPRITE_SIZE, true)
    @player = Player.new(window)
    @tiles = {}
  end

  def update(window)
    @player.update

    set_tile('SAND', 3, 4)
    set_tile('SAND', 5, 5)
    set_tile('SAND', 1, 5)
  end

  def draw(window)
    (2 + (window.width / $TILE_SIZE).ceil).times do |x|
      (2 + (window.height / $TILE_SIZE).ceil).times do |y|
        # find tile's coordinate on the map
        kx = ((@player.x - (window.width / 2)) / $TILE_SIZE).floor + x
        ky = ((@player.y - (window.height / 2)) / $TILE_SIZE).floor + y
        # find tile's position on the screen
        px = ($TILE_SIZE * x) - ((@player.x - (window.width / 2)) % $TILE_SIZE)
        py = ($TILE_SIZE * y) - ((@player.y - (window.height / 2)) % $TILE_SIZE)
        # draw tile on screen
        get_tile(kx, ky).draw(@ground_sprites, px, py)
      end
    end
    @player.draw(window)
  end

  def get_tile(kx, ky)
    # name tile's key with its coordinates
    key = kx.to_s + '-' + ky.to_s
    # if tile doew not exists create it
    @tiles[key] ||= Tile.new
  end

  def set_tile(type, kx, ky)
    get_tile(kx, ky).type = type

    # set NE
    remote = get_tile(kx - 2, ky - 2)
    if remote.base_type != type
      get_tile(kx - 1, ky - 1).type = type + '_' + remote.base_type
      get_tile(kx - 1, ky - 1).dir = :NE
    elsif remote.type != type
      get_tile(kx - 1, ky - 1).type = remote.type
      get_tile(kx - 1, ky - 1).dir = :NE
    else
      get_tile(kx - 1, ky - 1).type = type
      get_tile(kx - 1, ky - 1).dir = :OO
    end

    # set NN
    remote = get_tile(kx - 2, ky - 2)
    if remote.base_type != type
      get_tile(kx, ky - 1).type = type + '_' + remote.base_type
      get_tile(kx, ky - 1).dir = :NN
    elsif remote.type != type
      get_tile(kx, ky - 1).type = remote.type
      get_tile(kx, ky - 1).dir = :NN
    else
      get_tile(kx, ky - 1).type = type
      get_tile(kx, ky - 1).dir = :OO
    end

    # set NW
    remote = get_tile(kx - 2, ky - 2)
    if remote.base_type != type
      get_tile(kx + 1, ky - 1).type = type + '_' + remote.base_type
      get_tile(kx + 1, ky - 1).dir = :NW
    elsif remote.type != type
      get_tile(kx + 1, ky - 1).type = remote.type
      get_tile(kx + 1, ky - 1).dir = :NW
    else
      get_tile(kx + 1, ky - 1).type = type
      get_tile(kx + 1, ky - 1).dir = :OO
    end

    # set EE
    remote = get_tile(kx - 2, ky - 2)
    if remote.base_type != type
      get_tile(kx - 1, ky).type = type + '_' + remote.base_type
      get_tile(kx - 1, ky).dir = :EE
    elsif remote.type != type
      get_tile(kx - 1, ky).type = remote.type
      get_tile(kx - 1, ky).dir = :EE
    else
      get_tile(kx - 1, ky).type = type
      get_tile(kx - 1, ky).dir = :OO
    end

    # set SE
    remote = get_tile(kx - 2, ky - 2)
    if remote.base_type != type
      get_tile(kx + 1, ky + 1).type = type + '_' + remote.base_type
      get_tile(kx + 1, ky + 1).dir = :SE
    elsif remote.type != type
      get_tile(kx + 1, ky + 1).type = remote.type
      get_tile(kx + 1, ky + 1).dir = :SE
    else
      get_tile(kx + 1, ky + 1).type = type
      get_tile(kx + 1, ky + 1).dir = :OO
    end

    # set SS
    remote = get_tile(kx - 2, ky - 2)
    if remote.base_type != type
      get_tile(kx, ky + 1).type = type + '_' + remote.base_type
      get_tile(kx, ky + 1).dir = :SS
    elsif remote.type != type
      get_tile(kx, ky + 1).type = remote.type
      get_tile(kx, ky + 1).dir = :SS
    else
      get_tile(kx, ky + 1).type = type
      get_tile(kx, ky + 1).dir = :OO
    end

    # set SW
    remote = get_tile(kx - 2, ky - 2)
    if remote.base_type != type
      get_tile(kx - 1, ky + 1).type = type + '_' + remote.base_type
      get_tile(kx - 1, ky + 1).dir = :SW
    elsif remote.type != type
      get_tile(kx - 1, ky + 1).type = remote.type
      get_tile(kx - 1, ky + 1).dir = :SW
    else
      get_tile(kx - 1, ky + 1).type = type
      get_tile(kx - 1, ky + 1).dir = :OO
    end

    # set WW
    remote = get_tile(kx - 2, ky - 2)
    if remote.base_type != type
      get_tile(kx + 1, ky).type = type + '_' + remote.base_type
      get_tile(kx + 1, ky).dir = :WW
    elsif remote.type != type
      get_tile(kx + 1, ky).type = remote.type
      get_tile(kx + 1, ky).dir = :WW
    else
      get_tile(kx + 1, ky).type = type
      get_tile(kx + 1, ky).dir = :OO
    end
  end

end

