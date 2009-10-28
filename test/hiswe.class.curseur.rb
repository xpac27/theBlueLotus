class Curseur
  def initialize(window)
    @image = Gosu::Image.new(window,'media/square_cursor.png', true)
    @x = @y = @angle = 0.0
    puts window.width
  end

  def teleportation(x, y)
    @x, @y = x, y
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end
end
