#!/usr/bin/env ruby

require 'rubygems'
require 'gosu'
require 'test/try2/fps'
require 'test/try2/world'
require 'test/try2/player'
require 'test/try2/enemy'
require 'test/try2/tile'


class MyWindow < Gosu::Window

  def initialize
    super(640, 480, false)
    self.caption = 'Try2'

    @fps = Fps.new(self, :periodic)
    @world = World.new(self)
  end

  def update
    x = 0
    y = 0

    y = -1 if button_down?(Gosu::Button::KbUp)
    y = 1 if button_down?(Gosu::Button::KbDown)
    x = -1 if button_down?(Gosu::Button::KbLeft)
    x = 1 if button_down?(Gosu::Button::KbRight)

    @world.player.translate(x, y) if x != 0 or y != 0

    @world.update
  end

  def draw
    @world.draw
    @fps.draw
  end

  def button_down(id)
    close if id == Gosu::Button::KbEscape
  end

end


w = MyWindow.new
w.show

