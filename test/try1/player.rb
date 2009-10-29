class Player

  attr_reader :x, :y

  SPRITE_WIDTH = 48
  SPRITE_HEIGHT = 64

  def initialize(window)
    @sprites = Gosu::Image.load_tiles(window, 'media/ladygaga.png', SPRITE_WIDTH, SPRITE_HEIGHT, true)
    @x = 0.0
    @y = 0.0
    @speed = 3
    @current_tile = 0
    @direction = 0
  end

  def update
  end

  def draw(window)
    # calculate screen's center
    px = (window.width / 2) - (@sprites[@current_tile].width / 2)
    py = (window.height/ 2) - (@sprites[@current_tile].height / 2)

    # find which sprite to use
    s = @current_tile + (4 * @direction)

    # draw the sprite
    @sprites[s].draw(px, py, 2)
  end

  def translate(x, y)
    @direction = 2 if x == 1
    @direction = 1 if x == -1
    @direction = 0 if y == 1
    @direction = 3 if y == -1

    @x += x * @speed
    @y += y * @speed

    @current_tile = (Gosu::milliseconds / 100) % 4
  end

end

