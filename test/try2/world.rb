class World

  attr_reader :player

  def initialize(window)
    @window = window
    @player = Player.new(window, self)
    @enemy_1 = Enemy.new(window, self)
    @enemy_2 = Enemy.new(window, self)
    @enemy_3 = Enemy.new(window, self)
    @enemy_4 = Enemy.new(window, self)
    @enemy_5 = Enemy.new(window, self)
    @tiles = {}

    @player.x = 4
    @player.y = 3

    @enemy_1.x = 3
    @enemy_1.y = 2
    @enemy_2.x = 4
    @enemy_2.y = 2
    @enemy_3.x = 4
    @enemy_3.y = 2
    @enemy_4.x = 4
    @enemy_4.y = 2
    @enemy_5.x = 4
    @enemy_5.y = 2

    @map = [
      [2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2],
      [2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2],
      [2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 2],
      [2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 2],
      [2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2],
      [2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2],
      [2, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 2],
      [2, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 1, 2],
      [2, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 2],
      [2, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 2],
      [2, 1, 2, 2, 2, 2, 1, 1, 1, 2, 2, 2, 1, 1, 1, 2],
      [2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2],
      [2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2]
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
    @enemy_3.update
    @enemy_4.update
    @enemy_5.update
  end

  def draw
#    cx =  @window.width / 64.0 - @player.x
#    cy =  @window.height / 64.0 - @player.y
    cx =  @window.width / 64.0 - (@player.x - @player.y)
    cy =  @window.height / 64.0 -  ((@player.x + @player.y) / 2.0)

    (@window.width / 32).ceil.times do |x|
      (@window.height / 32).ceil.times do |y|
#        get_tile(x, y).draw(cx + x, cy + y)
        get_tile(x, y).draw(cx + x - y, cy + ((x + y) / 2.0))
      end
    end
    @player.draw
    @enemy_1.draw(cx, cy)
    @enemy_2.draw(cx, cy)
    @enemy_3.draw(cx, cy)
    @enemy_4.draw(cx, cy)
    @enemy_5.draw(cx, cy)
  end

end

