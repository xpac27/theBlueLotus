class Tile

  attr_accessor :type, :dir

  def initialize
    @type = 'GRASS'
    @dir = :O1
  end

  def draw(s, x, y)
    # find image scale
    f = $TILE_SIZE / $SPRITE_SIZE

    s[$SPRITE_TYPE[@type][@dir]].draw(x, y, 0, f, f)
  end

  def base_type
    @type.split('_')[0]
  end

  def not_origin?
    @type.include?('_')
  end

end

