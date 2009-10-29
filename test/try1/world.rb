class World

  $TILE_SIZE = 32
  $SPRITE_SIZE = 16
  $SPRITE_TYPE = {
    'SAND'  => {
      :O1 => 9,
      :O2 => 0
    },
    'GRASS' => {
      :O1 => 1,
      :O2 => 2
    },

    'SAND_GRASS' => {
      :NW => 4,
      :NN => 5,
      :NE => 6,
      :EE => 10,
      :SE => 14,
      :SS => 13,
      :SW => 12,
      :WW => 8,
      :X1 => 3,
      :X2 => 7,
      :X3 => 11,
      :X4 => 15
    }
  }

  attr_reader :player

  def initialize(window)
    @ground_sprites = Gosu::Image.load_tiles(window, 'media/map_water.png', $SPRITE_SIZE, $SPRITE_SIZE, true)
    @player = Player.new(window)
    @tiles = {}
  end

  def update(window)
    @player.update

    set_tile('SAND', 3, 4)
    set_tile('SAND', 5, 5)
#    set_tile('SAND', 1, 5)
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

    # set NW
    remote = get_tile(kx - 2, ky - 2)
    if remote.base_type != type
      get_tile(kx - 1, ky - 1).type = type + '_' + remote.base_type
      get_tile(kx - 1, ky - 1).dir = :NW
#    elsif remote.type != type
#      get_tile(kx - 1, ky - 1).type = remote.type
#      get_tile(kx - 1, ky - 1).dir = :NW
    else
      get_tile(kx - 1, ky - 1).type = type
      get_tile(kx - 1, ky - 1).dir = :O1
    end

    # set NN
    remote = get_tile(kx, ky - 2)
    if remote.base_type != type
      get_tile(kx, ky - 1).type = type + '_' + remote.base_type
      get_tile(kx, ky - 1).dir = :NN
    elsif remote.not_origin? and remote.type != type
      if remote.dir == :EE
        get_tile(kx, ky - 1).type = remote.type
        get_tile(kx, ky - 1).dir = :X2
      elsif remote.dir == :SE or remote.dir == :SW
        get_tile(kx, ky - 1).type = type
        get_tile(kx, ky - 1).dir = :O1
      else
        get_tile(kx, ky - 1).type = remote.type
        get_tile(kx, ky - 1).dir = :X1
      end
    else
      get_tile(kx, ky - 1).type = type
      get_tile(kx, ky - 1).dir = :O1
    end

    # set NE
    remote = get_tile(kx + 2, ky - 2)
    if remote.base_type != type
      get_tile(kx + 1, ky - 1).type = type + '_' + remote.base_type
      get_tile(kx + 1, ky - 1).dir = :NE
#    elsif remote.type != type
#      get_tile(kx + 1, ky - 1).type = remote.type
#      get_tile(kx + 1, ky - 1).dir = :NE
    else
      get_tile(kx + 1, ky - 1).type = type
      get_tile(kx + 1, ky - 1).dir = :O1
    end

    # set WW
    remote = get_tile(kx - 2, ky)
    if remote.base_type != type
      get_tile(kx - 1, ky).type = type + '_' + remote.base_type
      get_tile(kx - 1, ky).dir = :WW
    elsif remote.not_origin? and remote.type != type
      if remote.dir == :NN
        get_tile(kx - 1, ky).type = remote.type
        get_tile(kx - 1, ky).dir = :X1
      elsif remote.dir == :SW or remote.dir == :NW
        get_tile(kx - 1, ky).type = type
        get_tile(kx - 1, ky).dir = :O1
      else
        get_tile(kx - 1, ky).type = remote.type
        get_tile(kx - 1, ky).dir = :X4
      end
    else
      get_tile(kx - 1, ky).type = type
      get_tile(kx - 1, ky).dir = :O1
    end

    # set SE
    remote = get_tile(kx + 2, ky + 2)
    if remote.base_type != type
      get_tile(kx + 1, ky + 1).type = type + '_' + remote.base_type
      get_tile(kx + 1, ky + 1).dir = :SE
#    elsif remote.type != type
#      get_tile(kx + 1, ky + 1).type = remote.type
#      get_tile(kx + 1, ky + 1).dir = :SE
    else
      get_tile(kx + 1, ky + 1).type = type
      get_tile(kx + 1, ky + 1).dir = :O1
    end

    # set SS
    remote = get_tile(kx, ky + 2)
    if remote.base_type != type
      get_tile(kx, ky + 1).type = type + '_' + remote.base_type
      get_tile(kx, ky + 1).dir = :SS
    elsif remote.not_origin? and remote.type != type
      if remote.dir == :EE
        get_tile(kx, ky + 1).type = remote.type
        get_tile(kx, ky + 1).dir = :X3
      elsif remote.dir == :NE or remote.dir == :NW
        get_tile(kx, ky + 1).type = type
        get_tile(kx, ky + 1).dir = :O1
      else
        get_tile(kx, ky + 1).type = remote.type
        get_tile(kx, ky + 1).dir = :X4
      end
    else
      get_tile(kx, ky + 1).type = type
      get_tile(kx, ky + 1).dir = :O1
    end

    # set SW
    remote = get_tile(kx - 2, ky + 2)
    if remote.base_type != type
      get_tile(kx - 1, ky + 1).type = type + '_' + remote.base_type
      get_tile(kx - 1, ky + 1).dir = :SW
#    elsif remote.type != type
#      get_tile(kx - 1, ky + 1).type = remote.type
#      get_tile(kx - 1, ky + 1).dir = :SW
    else
      get_tile(kx - 1, ky + 1).type = type
      get_tile(kx - 1, ky + 1).dir = :O1
    end

    # set EE
    remote = get_tile(kx + 2, ky)
    if remote.base_type != type
      get_tile(kx + 1, ky).type = type + '_' + remote.base_type
      get_tile(kx + 1, ky).dir = :EE
    elsif remote.not_origin? and remote.type != type
      if remote.dir == :NN
        get_tile(kx + 1, ky).type = remote.type
        get_tile(kx + 1, ky).dir = :X2
      elsif remote.dir == :SE or remote.dir == :NE
        get_tile(kx + 1, ky).type = type
        get_tile(kx + 1, ky).dir = :O1
      else
        get_tile(kx + 1, ky).type = remote.type
        get_tile(kx + 1, ky).dir = :X3
      end
    else
      get_tile(kx + 1, ky).type = type
      get_tile(kx + 1, ky).dir = :O1
    end
  end

end

