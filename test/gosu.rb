#!/usr/bin/env ruby

require 'rubygems'
require 'gosu'

class MyWindow < Gosu::Window
  def initialize
    super(640, 480, false)
    self.caption = 'World'

    @world  = World.new(self)
    @player = Player.new(self)
  end

  def update
    if button_down?(Gosu::Button::KbUp)
      @world.translate(0, 1)
    end
    if button_down?(Gosu::Button::KbDown)
      @world.translate(0, -1)
    end
    if button_down?(Gosu::Button::KbRight)
      @world.translate(-1, 0)
    end
    if button_down?(Gosu::Button::KbLeft)
      @world.translate(1, 0)
    end

    @world.update
  end

  def draw
    @world.draw
    @player.draw
  end

  def button_down(id)
    if id == Gosu::Button::KbEscape
      close
    end
  end
end

class Player
  def initialize(window)
    @window = window
    @image = Gosu::Image.new(window, 'media/blurp.png', true)
  end

  def draw
    @image.draw(320-32, 240-32, 2)
  end

  def update
  end
end

class World
  def initialize(window)
    @window = window
    @x = @y = 0.0
    @vx = @vy = 0.0
    @image = Gosu::Image.new(window, 'media/tile.png', true)
    @skullList = []

    1000.times do
      @skullList += [Skull.new(window, rand(3000), rand(3000))]
    end
  end

  def draw
    12.times do |x|
      10.times do |y|
        @image.draw(64*(x-1)+(@x%64), 64*(y-1)+(@y%64), 0)
      end
    end

    @skullList.each do |s|
      s.draw(@x, @y)
    end
  end

  def translate(x, y)
    @vx += x if @vx < 3.0 and @vx > -3.0
    @vy += y if @vy < 3.0 and @vy > -3.0
  end

  def update
    @x += @vx
    @y += @vy

    @vx -= 0.2 if @vx > 0
    @vx += 0.2 if @vx < 0
    @vy -= 0.2 if @vy > 0
    @vy += 0.2 if @vy < 0

    @vx = 0 if @vx > -0.2 and @vx < 0.2
    @vy = 0 if @vy > -0.2 and @vy < 0.2
  end
end

class Skull
  def initialize(window, x, y)
    @image = Gosu::Image.new(window, 'media/skull.png', true)
    @x = x
    @y = y
  end

  def draw(wx, wy)
    @image.draw(@x+wx, @y+wy, if wy + @y > 230 then 3 else 1 end)
  end
end

w = MyWindow.new
w.show

