class Fond
  def initialize(window)
    @window = window
    @x = @y = 0.0
    @vx = @vy = 0.0
    @width = 16
    @height = 16
    @iteration_x = ( window.width / @width).round + 1
    @iteration_y = ( window.height / @height).round + 1
    @image = Gosu::Image.new(window, 'media/map_monde.png', true, 64, 192, @width, @height)
    @peinture = Gosu::Image.new(window, 'media/map_monde.png', true, 64, 224, @width, @height)

    @map_monde =  {}
      @iteration_x.times do |x|
        @iteration_y.times do |y|
          kx = @image.width * (x - 1) + (@x % @image.width)
          ky = @image.height * (y - 1) + (@y % @image.height)
          current_cell = kx.to_s + '-' + ky.to_s
          @map_monde[current_cell] =  @image
       end
      end
#     p @map_monde
  end

  def draw
    @iteration_x.times do |x|
        @iteration_y.times do |y|
          kx = @image.width * (x - 1) + (@x % @image.width)
          ky = @image.height * (y - 1) + (@y % @image.height)
          current_cell = kx.to_s + '-' + ky.to_s
          @map_monde[current_cell].draw(kx, ky, 0)
       end
      end
  end

  def translate(x, y)
    if @vx < 3.0 and @vx > -3.0 then @vx += x end
    if @vy < 3.0 and @vy > -3.0 then @vy += y end
  end

  def click(window)
    x = window.mouse_x
    y = window.mouse_y

    pos_x = x - (x % @image.width)
    pos_y = y - (y % @image.height)
    current_cell = pos_x.to_s + '-' + pos_y.to_s

    @map_monde[current_cell] = @peinture

  end

  def update
#    @x += @vx
#    @y += @vy
#    if @vx > 0 then @vx -= 0.2 end
#    if @vx < 0 then @vx += 0.2 end
#    if @vy > 0 then @vy -= 0.2 end
#    if @vy < 0 then @vy += 0.2 end
#    if @vx > -0.2 and @vx < 0.2 then @vx = 0 end
#    if @vy > -0.2 and @vy < 0.2 then @vy = 0 end
  end
end
