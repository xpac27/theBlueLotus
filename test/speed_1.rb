#!/usr/bin/env ruby

require 'rubygems'
require 'test/try2/fps'
require 'gosu'

class MyWindow < Gosu::Window
  def initialize
    super(640, 480, false)
    self.caption = 'World'

    @fps = Fps.new(self, :periodic)
    @items = []
    1000.times {
      @items += [Square.new(self)]
    }
  end

  def update
    @items.each {|item|
      item.update
    }
  end

  def draw
    @items.each {|item|
      item.draw
    }
    @fps.draw
  end

  def button_down(id)
    if id == Gosu::Button::KbEscape
      close
    end
  end
end


class Square
  def initialize(window)
    @window = window
    @size = 5
    @speed = 0.5
    @color = 0xAACCCCCC
    @x = @window.width/2
    @y = @window.height/2
    @direction = 0
  end

  def draw
    @window.draw_quad(@x - @size, @y - @size, @color, @x + @size, @y - @size, @color, @x + @size, @y + @size, @color, @x - @size, @y + @size, @color)
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

    @x = nx if (nx < @window.width - 16/2 and nx > 16/2)
    @y = ny if (ny < @window.height - 16/2 and ny > 16/2)
  end
end


w = MyWindow.new
w.show

