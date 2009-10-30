class World

  attr_reader :player

  def initialize(window)
    @window = window
    @player = Player.new(window, self)
    @enemy_1 = Enemy.new(window, self)
    @enemy_2 = Enemy.new(window, self)
    @tiles = {}

    @player.x = 4
    @player.y = 3

    @enemy_1.x = 3
    @enemy_1.y = 2
    @enemy_2.x = 4
    @enemy_2.y = 2

    @map = [
      [2, 2, 2, 2, 2, 2, 2, 2],
      [2, 1, 1, 1, 1, 1, 1, 2],
      [2, 1, 2, 1, 1, 1, 1, 2],
      [2, 1, 1, 1, 1, 2, 1, 2],
      [2, 1, 1, 1, 1, 1, 1, 2],
      [2, 2, 2, 2, 2, 2, 2, 2]
    ]

    @map.each_index{|x|
      @map[x].each_index{|y|
        get_tile(y, x).type = @map[x][y]
      }
    }
  end

  def get_tile(x, y)
    @tiles[x.to_s + '-' + y.to_s] ||= Tile.new(@window)
  end

  def update
    @player.update
    @enemy_1.update
    @enemy_2.update
  end

  def draw
    cx =  @window.width / 64 - @player.x
    cy =  @window.height / 64 - @player.y

    (@window.width / 32).ceil.times do |x|
      (@window.height / 32).ceil.times do |y|
#        get_tile(x, y).draw(cx + x, cy + y)
        get_tile(x, y).draw(
          cx + x - y,
          cy + ((x + y) / 2)
        )
#        get_tile(x, y).draw(
#          cx + x,
#          cy + y + (x%2 / 2.0)
#        )
      end
    end
    @player.draw
    @enemy_1.draw(cx, cy)
    @enemy_2.draw(cx, cy)
  end

end

