class Enemy

  attr_accessor :x, :y

  def initialize(window, world)
#    @sprite = Gosu::Image.new(window, 'media/base/enemy.png')
    @sprite = Gosu::Image.new(window, 'media/base/isometric/enemy.png')
    @x = 0.0
    @y = 0.0
    @speed = 0.03
    @world = world
    @window = window
    @direction = 0
  end

  def update
    @direction = rand(7) if rand(80) == 1

    case @direction
      when 0 then translate(0, -1)
      when 1 then translate(1, -1)
      when 2 then translate(1, 0)
      when 3 then translate(1, 1)
      when 4 then translate(0, 1)
      when 5 then translate(-1, 1)
      when 6 then translate(-1, 0)
      when 7 then translate(-1, -1)
    end

  end

  def draw(cx, cy)
#    @sprite.draw_rot((@x + cx) * 32, (@y + cy) * 32, 2, 45 * @direction, 0.5, 0.5)
    @sprite.draw((cx + @x - @y) * 32, (((@x + @y) / 2) + cy) * 32, 2)
  end

  def translate(x, y)
    nx = @x + x * @speed
    ny = @y + y * @speed

    if @world.get_tile(nx.floor, ny.floor).type != 1
      @direction = rand(7)
    else
      @x = nx
      @y = ny
    end
  end

end

