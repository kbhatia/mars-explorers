class Point
  attr_accessor :orientation, :x, :y

  def initialize(x, y, orientation)
    @x = x
    @y = y
    @orientation = orientation
  end

  def safe?(surface)
    (x > surface.width || x < 0 || y > surface.height || y < 0) ? false : true
  end

 end