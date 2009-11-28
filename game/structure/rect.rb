class Rect

  attr_reader :x, :y, :top, :right, :bottom, :left

  def initialize(window, x, y, width, height)
    @window = window
    @x = x
    @y = y
    set_size(width, height)
  end

  def draw(color=0xFFFFFFFF)
    @window.draw_quad(@left, @top, color, @right, @top, color, @left, @bottom, color, @right, @bottom, color)
  end

  def outline(color=0xFFFFFFFF)
    @window.draw_line(@left, @top, color, @right, @top, color, 8)
    @window.draw_line(@left, @bottom, color, @right, @bottom, color, 8)
    @window.draw_line(@left, @top, color, @left, @bottom, color, 8)
    @window.draw_line(@right, @top, color, @right, @bottom, color, 8)
  end

  def set_size(width, height)
    set_width(width)
    set_height(height)
  end

  def set_width(value)
    @width = value
    @alf_width = @width / 2
    @left = @x - @alf_width
    @right = @x + @alf_width
  end

  def set_height(value)
    @height = value
    @alf_height = @height / 2
    @top = @y - @alf_height
    @bottom = @y + @alf_height
  end

  def x=(value)
    @x = value
    @left = @x - @alf_width
    @right = @x + @alf_width
  end

  def y=(value)
    @y = value
    @top = @y - @alf_height
    @bottom = @y + @alf_height
  end

  def union!(rect)
    @top = rect.top if rect.top < @top
    @left = rect.left if rect.left < @left
    @bottom = rect.bottom if rect.bottom > @bottom
    @right = rect.right if rect.right > @right
    @x = (@left + @right) * 0.5
    @y = (@top + @bottom) * 0.5
    set_width(@right - @left)
    set_height(@bottom - @top)
  end

  def overlaps?(rect)
    Debug::count('test')
    (rect.right >= @left and rect.left <= @right and rect.bottom >= @top and rect.top <= @bottom)
  end

  def nw_quadrant
    Rect.new(@window, @x - @alf_width/2, @y - @alf_height/2, @width/2, @height/2)
  end

  def ne_quadrant
    Rect.new(@window, @x + @alf_width/2, @y - @alf_height/2, @width/2, @height/2)
  end

  def se_quadrant
    Rect.new(@window, @x + @alf_width/2, @y + @alf_height/2, @width/2, @height/2)
  end

  def sw_quadrant
    Rect.new(@window, @x - @alf_width/2, @y + @alf_height/2, @width/2, @height/2)
  end

end
