class Tile
  def initialize(window)
    @image = Gosu::Image.new(window, 'media/empty.png', true)
  end

  def draw(x, y)
    @image.draw(x, y, 0)
  end
end

