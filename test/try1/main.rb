#!/usr/bin/env ruby

require 'rubygems'
require 'gosu'
require 'test/try1/world'
require 'test/try1/player'
require 'test/try1/tile'


class MyWindow < Gosu::Window
  def initialize
    super(640, 480, false)
    self.caption = 'Try1'

    @world = World.new(self)
  end

  def update
    if button_down?(Gosu::Button::KbUp)
      @world.player.translate(0, -1)
    end
    if button_down?(Gosu::Button::KbDown)
      @world.player.translate(0, 1)
    end
    if button_down?(Gosu::Button::KbLeft)
      @world.player.translate(-1, 0)
    end
    if button_down?(Gosu::Button::KbRight)
      @world.player.translate(1, 0)
    end

    @world.update(self)
  end

  def draw
    @world.draw(self)
  end

  def button_down(id)
    close if id == Gosu::Button::KbEscape
  end
end


w = MyWindow.new
w.show

