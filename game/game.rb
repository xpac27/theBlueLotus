#!/usr/bin/env ruby


require 'rubygems'
require 'gosu'
require 'controler/world'


class Game < Gosu::Window

  $WINDOW
  $MEDIA_LIST = [
    'media/image/test_0.0_floor.png',
    'media/image/test_0.5_cube.png',
    'media/image/test_1.0_cube.png'
  ]


  def initialize
    super(640, 480, false)
    self.caption = 'theBlueLotus'

    # Constants
    $WINDOW = self

    # Controlers
    @world = Controler::World.new
  end

  def update
    @world.update
  end

  def draw
    @world.draw
  end

  def button_down(id)
    if id == Gosu::Button::KbEscape
      close
    end
  end

end

g = Game.new
g.show

