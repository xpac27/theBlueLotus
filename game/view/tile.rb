module View

  class Tile

    def initialize(m)
      @media = m
    end

    def draw(x, y, z)
      $MEDIA_LIST[@media].draw((x*32), (y*32) - 16, z)
    end

  end

end
