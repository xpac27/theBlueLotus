class Fps

  def initialize(type)
    @current_fps = 0
    @time = 0
    @count = 0
    @type = type
    @font = Gosu::Font.new($WINDOW, Gosu::default_font_name, 22)
  end

  def draw
    case @type
      when :periodic then count_periodic
      when :realtime then count_realtime
    end

    message = @current_fps.to_s + ' fps'
    @font.draw(message, $WINDOW.width - @font.text_width(message) - 10, 10, 10, 1, 1, 0xFFFFFFFF)
  end

  def count_periodic
    if @time < Gosu::milliseconds - 1000
      @current_fps = @count
      @count = 0
      @time = Gosu::milliseconds
    end
    @count += 1
  end

  def count_realtime
    fps = 1000 / (Gosu::milliseconds - @time)
    @time = Gosu::milliseconds
    @current_fps = ((@current_fps * 9) + fps) / 10
  end

end

