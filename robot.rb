require_relative 'point.rb'
require_relative 'surface.rb'

class Robot

  COMPASS = %w(N E S W)
  attr_reader :surface, :instructions
  attr_accessor :point

  def initialize(surface, start_location, instructions)
    @surface = surface
    @point = Point.new(start_location.split(' ')[0].to_i, start_location.split(' ')[1].to_i, start_location.split(' ')[2])
    @instructions = instructions.split('')
    @lost = false
  end

  def move
    self.instructions.each do |i|
      unless lost?
        move_forward if i == 'F'
        move_left if i == 'L'
        move_right if i == 'R'
      end
    end
    final_point
  end

  def move_left
    point.orientation = COMPASS[(COMPASS.index(point.orientation) - 1) % 4]
  end

  def move_right
    point.orientation = COMPASS[(COMPASS.index(point.orientation) + 1) % 4]
  end

  def check_point(point)
    surface.is_a_scent?(point) ? true : false
  end

  def move?(point)
    (check_point(point) == false) ? false : true
  end

  def move_forward
    last_point = Point.new(point.x, point.y, point.orientation)
    new_point = send_command_forward
    if move?(new_point)
      @point = new_point
      unless point.safe?(surface)
        surface.mark_scent(new_point)
        lost
        @point = last_point
      end
    end
  end

  def send_command_forward
    unless lost?
      p = Point.new(point.x, point.y, point.orientation)
      p.y = p.y + 1 if point.orientation == 'N'
      p.y = p.y - 1 if point.orientation == 'S'
      p.x = p.x - 1 if point.orientation == 'W'
      p.x = p.x + 1 if point.orientation == 'E'
    end
    p
  end

  def lost?
     @lost
  end

  def lost
    @lost = true
  end

  def final_point
    "#{point.x} #{point.y}  #{point.orientation} #{(lost? ? 'LOST' : '')}"
  end
end