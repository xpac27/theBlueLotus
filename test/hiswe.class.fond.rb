class Fond
  def initialize(window, size_x, size_y)
    @window = window
    @x = @y = 0.0
    @vx = @vy = 0.0
    @width = 32
    @height = 32
    @iteration_x = (size_x / @width).round + 1
    @iteration_y = (size_y / @height).round + 1
    @image = Gosu::Image.new(window, 'media/map_monde.png', true, 104, 152, @width, @height)
  end

  def draw
    @iteration_x.times do |x|
      @iteration_y.times do |y|
      pos_x = @image.width * (x - 1) + (@x % @image.width)
      pos_y = @image.height * (y - 1) + (@y % @image.height)
        @image.draw(pos_x,pos_y, 0)
      end
    end
  end

  def translate(x, y)
    if @vx < 3.0 and @vx > -3.0 then @vx += x end
    if @vy < 3.0 and @vy > -3.0 then @vy += y end
  end

  def update
    @x += @vx
    @y += @vy
    if @vx > 0 then @vx -= 0.2 end
    if @vx < 0 then @vx += 0.2 end
    if @vy > 0 then @vy -= 0.2 end
    if @vy < 0 then @vy += 0.2 end
    if @vx > -0.2 and @vx < 0.2 then @vx = 0 end
    if @vy > -0.2 and @vy < 0.2 then @vy = 0 end
  end
end
