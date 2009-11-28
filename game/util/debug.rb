class Debug

  $infoList

  def initialize(infos = [])
    @font = Gosu::Font.new($WINDOW, Gosu::default_font_name, 18)
    $infoList = {}
    infos.each{|info|
      $infoList[info] = 0
    }
  end

  def update
    $infoList.each{|name, value|
      $infoList[name] = 0
    }
  end

  def self.count(info)
    $infoList[info] += 1
  end

  def draw
    n = 0
    $infoList.each{|name, value|
      @font.draw(name + ': ' + value.to_s, 10, 10 + n*20, 10, 1, 1, 0xFFFFFFFF)
      n += 1
    }
  end

end

