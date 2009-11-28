module View

  class Tile

    def initialize(m)
      @image = Gosu::Image.new($WINDOW, m)
    end

    def draw(x, y, z)
      @image.draw((x*32), (y*32) - 16, z)
    end

  end

end
