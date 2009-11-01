class Player

  attr_accessor :x, :y

  def initialize(window, world)
#    @sprite = Gosu::Image.new(window, 'media/base/player.png')
    @sprite = Gosu::Image.new(window, 'media/base/isometric/player.png')
    @x = 0.0
    @y = 0.0
    @speed = 0.05
    @world = world
    @window = window
    @direction = 0
  end

  def update
  end

  def draw
#    @sprite.draw_rot(@window.width / 2, @window.height / 2 - 16, 2, 45 * @direction, 0.5, 0.5)
    @sprite.draw(@window.width / 2, @window.height / 2, 1)
  end

  def translate(x, y)
    @direction = 2 if x == 1 and y == 0
    @direction = 6 if x == -1 and y == 0
    @direction = 4 if x == 0 and y == 1
    @direction = 0 if x == 0 and y == -1

    @direction = 5 if x == -1 and y == 1
    @direction = 3 if x == 1 and y == 1
    @direction = 1 if x == 1 and y == -1
    @direction = 7 if x == -1 and y == -1

    nx = @x + x * @speed
    ny = @y + y * @speed

    return unless @world.get_tile(nx.floor, ny.floor).type == 1

    @x = nx
    @y = ny
  end

end

