class Player

  attr_reader :x, :y

  def initialize(window)
    @image = Gosu::Image.new(window, 'media/blurp.png', true)
    @x = 0.0
    @y = 0.0
  end

  def update
  end

  def draw(window)
    px = (window.width / 2) - (@image.width / 2)
    py = (window.height/ 2) - (@image.height / 2)
    @image.draw(px, py, 2)
  end

  def translate(x, y)
    @x += x
    @y += y
  end
end

