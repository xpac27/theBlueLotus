#!/usr/bin/env ruby -rubygems

require 'rubygems'
require 'gosu'

# import de classes.
require 'test/hiswe.class.curseur'
require 'test/hiswe.class.fond'

class MyWindow < Gosu::Window
  def initialize
    super(640, 480, false)
    self.caption = 'The blue lotus'

    @text = Gosu::Font.new(self, Gosu::default_font_name , 24)

#    Instance du curseur
    @monCurseur = Curseur.new(self)
#   Instance du monde
    @world = Fond.new(self, 640, 480)
  end

  def update
    close if button_down? Gosu::Button::KbEscape

    $mouseX = Integer(mouse_x)
    $mouseY = Integer(mouse_y)

    @monCurseur.teleportation($mouseX, $mouseY)

#   MaJ du monde
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
    @monCurseur.draw
    @text.draw($mouseX.to_s+ "/" + $mouseY.to_s, 10, 10,0, 1.0, 1.0, 0xffffff00)
    @world.draw
  end
end

w = MyWindow.new
w.show
