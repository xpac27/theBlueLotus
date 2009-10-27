#!/usr/bin/env ruby

require 'rubygems'
require 'gosu'

class MyWindow < Gosu::Window
  def initialize
    super(640, 480, false)
    self.caption = 'Hello World!'

    @image = Gosu::Image.new(self, 'media/tile.png', true)
    @angle = 0.0
  end

  def update
    @angle += 0.8
  end

  def draw
    @image.draw_rot(320, 240, 0, @angle)
  end
end

w = MyWindow.new
w.show

