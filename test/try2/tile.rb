class Tile

  attr_reader :type

  def initialize(w)
    @window = w
  end

  def type=(t)
    @type = t
    case @type
#    when 1 then @sprite = Gosu::Image.new(@window, 'media/base/ground.png', true)
#    when 2 then @sprite = Gosu::Image.new(@window, 'media/base/wall.png', true)
    when 1 then @sprite = Gosu::Image.new(@window, 'media/base/isometric/ground.png', true)
    when 2 then @sprite = Gosu::Image.new(@window, 'media/base/isometric/wall_1.png', true)
    when 3 then @sprite = Gosu::Image.new(@window, 'media/base/isometric/wall_2.png', true)
    end
  end

  def draw(x, y)
    case @type
    when 1 then h = 0
    when 2 then h = 1
    when 3 then h = 2
    end
#    @sprite.draw(x * 32, y * 32, 0) if @sprite
    @sprite.draw(x * 32 - 16, y * 32 + 24 - 8 * h, 0) if @sprite
  end

end

