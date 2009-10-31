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
    when 2 then @sprite = Gosu::Image.new(@window, 'media/base/isometric/wall.png', true)
    end
  end

  def draw(x, y)
#    @sprite.draw(x * 32, y * 32, 0) if @sprite
    @sprite.draw(x * 32 - 16, y * 32 + 16, 0) if @sprite
  end

end

