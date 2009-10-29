class Fps

  def initialize(window, type)
    @current_fps = 0
    @time = 0
    @count = 0
    @type = type
    @text = Gosu::Font.new(window, Gosu::default_font_name, 20)
  end

  def draw(window)
    case @type
      when :periodic then count_periodic
      when :realtime then count_realtime
    end

    @text.draw(@current_fps.to_s + ' fps', 10, 10, 5, 1.0, 1.0, 0xFFFFFFFF)
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

