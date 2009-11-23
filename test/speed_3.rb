require 'rubygems'
require 'opengl'
require 'rubygame'


class Game

	def initialize
		@screen = Rubygame::Screen.new([640, 480])
		@screen.title = "Test rubygame"

		@queue = Rubygame::EventQueue.new
		@clock = Rubygame::Clock.new
		@clock.target_framerate = 60

		@state = :playing

    @items = []
    1000.times {
      @items += [Square.new(@screen)]
    }
	end

	def run
		loop do
      # PLAYING
			if @state == :playing
				update
				draw
			end
			@clock.tick
		end
	end

  def update
    @items.each {|item|
      item.update
    }

    if @clock.lifetime%100 == 0
      puts @clock.framerate.to_s + ' fps'
    end

		@queue.each {|ev|
      case ev
        # QUIT EVENT
        when Rubygame::QuitEvent
          Rubygame.quit
          exit
        # KEY PRESSED
        when Rubygame::KeyDownEvent
          case ev.key
            when Rubygame::K_ESCAPE
              Rubygame.quit
              exit
        end
      end
    }
  end

  def draw
    @screen.fill([0,0,0])
    @items.each {|item|
      item.draw
    }
    @screen.update
  end

end


class Square

  def initialize(screen)
    @screen = screen
    @size = 5
    @speed = 0.5
    @x = @screen.width / 2
    @y = @screen.height / 2
    @direction = 0
  end

  def draw
    @screen.draw_box_s([@x-@size, @y-@size], [@x+@size,@y+@size], [255,0,0])
  end

  def update
    @direction = rand(7) if rand(30/@speed) == 1
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

  def translate(x, y)
    nx = @x + x * @speed
    ny = @y + y * @speed

    @x = nx
    @y = ny
  end

end


game = Game.new
game.run

