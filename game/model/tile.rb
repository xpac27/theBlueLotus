require './view/tile'


module Model

  class Tile

    def initialize(x, y, w, m, h)
      @x = x
      @y = y
      @walkable = w
      @height = h
      @view = View::Tile.new(m)
    end

    def update
    end

    def draw(sx, sy)
      @view.draw(@x - @y + sx, ((@x + @y)/2.0) - @height + sy, @x*32 + @y*32)
    end

  end

end
