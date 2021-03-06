class Surface

  attr_reader :height, :width, :scents

  def initialize(width, height)
    if height > 50 || width > 50 || height< 0 || width <0
      raise ArgumentError, 'Please check height and width of the surface, range is 0-50'
    end
      @height = height
      @width = width
      @scents = []
  end

  def is_a_scent?(point)
    safe = true
    scents.each  do |p|
      if p.x == point.x && p.y == point.y
        safe = false
      end
    end
    safe
  end

  def mark_scent(point)
    @scents << point
  end
end
