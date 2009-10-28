class Curseur
  def initialize(window)
    @image = Gosu::Image.new(window,'media/square_cursor.png', true)
    @x = @y = @angle = 0.0
    puts @iteration_x
    puts @image.width
  end

  def teleportation(window)
    x = window.mouse_x
    y = window.mouse_y
    pos_x = x - (x % @image.width) + @image.width / 2
    pos_y = y - (y % @image.height) + @image.height / 2
    @x, @y = pos_x, pos_y
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end
end
