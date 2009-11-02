class Tile

  attr_reader :type

  def initialize(w)
    @window = w
    @type = 0
#    @text = Gosu::Font.new(@window, Gosu::default_font_name, 15)
  end

  def type=(t)
    @type = t
    case @type
#    when 1 then @sprite = Gosu::Image.new(@window, 'media/base/ground.png', true)
#    when 2 then @sprite = Gosu::Image.new(@window, 'media/base/wall.png', true)
    when 1 then @sprite = Gosu::Image.new(@window, 'media/base/isometric/ground.png', true)
    when 2 then @sprite = Gosu::Image.new(@window, 'media/base/isometric/wall_1.png', true)
    when 3 then @sprite = Gosu::Image.new(@window, 'media/base/isometric/wall_2.png', true)
    when 4 then @sprite = Gosu::Image.new(@window, 'media/base/isometric/wall_3.png', true)
    end
  end

  def draw(x, y, z)
    return unless @type != 0

    case @type
    when 1 then h = 0
    when 2 then h = 1
    when 3 then h = 2
    when 4 then h = 3
    end
#    @sprite.draw(x * 32, y * 32, 0) if @sprite

    px = x * 32
    py = y * 32 - 8 * h
    pz = z - 1

    @sprite.draw(px - 32, py, pz)
#    @text.draw(z, px - 8, py + 8, 5000, 1.0, 1.0, 0xFFCCCCCC)
  end

end

