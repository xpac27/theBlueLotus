#!/usr/bin/env ruby -rubygems

require 'rubygems'
require 'gosu'

# import de classes.
require 'test/curseur'

class MyWindow < Gosu::Window
  def initialize
    super(640, 480, false)
    self.caption = 'The blue lotus'

    @text = Gosu::Font.new(self, Gosu::default_font_name , 24)
#    Instance de mon sprite
    @truc = Curseur.new(self)
    @truc.teleportation(rand(640), rand(480))
  end

  def update
    if button_down? Gosu::Button::KbEscape
     w.close
    end

    $mouseX = Integer(mouse_x)
    $mouseY = Integer(mouse_y)

    @truc.teleportation($mouseX, $mouseY)

  end

  def draw
    @truc.draw
    @text.draw($mouseX.to_s+ "/" + $mouseY.to_s, 10, 10,0, 1.0, 1.0, 0xffffff00)
  end
end

w = MyWindow.new
w.show
