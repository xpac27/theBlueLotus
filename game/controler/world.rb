require 'util/fps'
require 'util/debug'
require 'model/tile'


module Controler

  class World

    def initialize
      @fps = Fps.new(:periodic)
      @debug = Debug.new()
      @tile_list = []

      load_media('media/list.txt')
      load_map('map/test.txt')
    end

    def update
      @fps.draw
      @debug.draw
    end

    def draw
      @tile_list.each{|tile|
        tile.draw(8, 2)
      }
    end

    def load_media(path)
      print 'Loading media ... '
      file = File.open(path, File::RDONLY)
      $MEDIA_LIST = []
      while line = file.gets
        $MEDIA_LIST += [Gosu::Image.new($WINDOW, line.strip)]
      end
      puts 'done'
    end

    def load_map(path)
      print 'Loading map ... '
      file = File.open(path, File::RDONLY)
      @map_width = file.gets.to_i
      @map_height = file.gets.to_i
      n = 0
      while line = file.gets
        line.split('|').each{|i|
          x = n % @map_width
          y = n / @map_height
          i = i.split(' ')
          @tile_list += [Model::Tile.new(x, y, i[0].to_i, i[1].to_i, i[2].to_f)]
          n += 1
        }
      end
      puts 'done'
    end

  end

end
