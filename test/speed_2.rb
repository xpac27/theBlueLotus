#!/usr/bin/env ruby

require 'rubygems'
require 'opengl'

class Gears

  POS = [5.0, 5.0, 10.0, 0.0]

  def draw
    GL.Clear(GL::COLOR_BUFFER_BIT | GL::DEPTH_BUFFER_BIT);

    GL.ShadeModel(GL::FLAT)

    # ITEMS
    @items.each {|item|
      item.draw
    }

    GLUT.SwapBuffers()

    @frames = 0 if not defined? @frames
    @t0 = 0 if not defined? @t0

    @frames += 1
    t = GLUT.Get(GLUT::ELAPSED_TIME)
    if t - @t0 >= 5000
      seconds = (t - @t0) / 1000.0
      fps = @frames / seconds
      printf("%d frames in %6.3f seconds = %6.3f FPS\n",
        @frames, seconds, fps)
      @t0, @frames = t, 0
      exit if defined? @autoexit and t >= 999.0 * @autoexit
    end
  end

  def idle
    t = GLUT.Get(GLUT::ELAPSED_TIME) / 1000.0
    @t0_idle = t if !defined? @t0_idle
    @t0_idle = t

    # ITEMS
    @items.each {|item|
      item.update
    }

    GLUT.PostRedisplay()
  end

  # Change view angle, exit upon ESC
  def key(k, x, y)
    case k
      when 27 # Escape
        exit
    end
    GLUT.PostRedisplay()
  end

  # Change view angle
  def special(k, x, y)
    GLUT.PostRedisplay()
  end

  # New window size or exposure
  def reshape(width, height)
    h = height.to_f / width.to_f
    GL.Viewport(0, 0, width, height)
    GL.MatrixMode(GL::PROJECTION)
    GL.LoadIdentity()
    GL.Frustum(-100.0, 100.0, -h*100, h*100, 5.0, 60.0)
    GL.MatrixMode(GL::MODELVIEW)
    GL.LoadIdentity()
    GL.Translate(0.0, 0.0, -40.0)
  end

  def init
    GL.Lightfv(GL::LIGHT0, GL::POSITION, POS)
    GL.Enable(GL::CULL_FACE)
    GL.Enable(GL::LIGHTING)
    GL.Enable(GL::LIGHT0)
    GL.Enable(GL::DEPTH_TEST)

    # ITEMS
    @items = []
    1000.times {
      @items += [Square.new]
    }

    GL.Enable(GL::NORMALIZE)

    ARGV.each do |arg|
      case arg
        when '-info'
          printf("GL_RENDERER   = %s\n", GL.GetString(GL::RENDERER))
          printf("GL_VERSION    = %s\n", GL.GetString(GL::VERSION))
          printf("GL_VENDOR     = %s\n", GL.GetString(GL::VENDOR))
          printf("GL_EXTENSIONS = %s\n", GL.GetString(GL::EXTENSIONS))
        when '-exit'
          @autoexit = 30
          printf("Auto Exit after %i seconds.\n", @autoexit);
      end
    end
  end

  def visible(vis)
    GLUT.IdleFunc((vis == GLUT::VISIBLE ? method(:idle).to_proc : nil))
  end

  def mouse(button, state, x, y)
  end

  def motion(x, y)
  end

  def initialize
    GLUT.Init()
    GLUT.InitDisplayMode(GLUT::RGB | GLUT::DEPTH | GLUT::DOUBLE)

    GLUT.InitWindowPosition(0, 0)
    GLUT.InitWindowSize(640, 480)
    GLUT.CreateWindow('Test')
    init()

    GLUT.DisplayFunc(method(:draw).to_proc)
    GLUT.ReshapeFunc(method(:reshape).to_proc)
    GLUT.KeyboardFunc(method(:key).to_proc)
    GLUT.SpecialFunc(method(:special).to_proc)
    GLUT.VisibilityFunc(method(:visible).to_proc)
    GLUT.MouseFunc(method(:mouse).to_proc)
    GLUT.MotionFunc(method(:motion).to_proc)
  end

  def start
    GLUT.MainLoop()
  end

end


class Square

  RED = [0.8, 0.1, 0.0, 1.0]

  def initialize
    @size = 12
    @speed = 0.5
    @x = 0.0
    @y = 0.0
    @direction = 0
  end

  def draw
    GL.Material(GL::FRONT, GL::AMBIENT_AND_DIFFUSE, RED)
    GL.PushMatrix()
    GL.Translate(@x, @y, 0.0)
    GL.Begin(GL::QUADS)
    GL.Vertex3f(0 - @size, 0 - @size, 0.0)
    GL.Vertex3f(0 + @size, 0 - @size, 0.0)
    GL.Vertex3f(0 + @size, 0 + @size, 0.0)
    GL.Vertex3f(0 - @size, 0 + @size, 0.0)
    GL.End()
    GL.PopMatrix()
  end

  def update
    @direction = rand(7) if rand(30/@speed) == 1
    case @direction
      when 0 then translate(0, -1)
      when 1 then translate(1, -1)
      when 2 then translate(1, 0)
      when 3 then translate(1, 1)
      when 4 then translate(0, 1)
      when 5 then translate(-1, 1)
      when 6 then translate(-1, 0)
      when 7 then translate(-1, -1)
    end
  end

  def translate(x, y)
    nx = @x + x * @speed
    ny = @y + y * @speed

    @x = nx
    @y = ny
  end

end


Gears.new.start

