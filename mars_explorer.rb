require_relative 'robot.rb'
require_relative 'surface.rb'

def prepare_surface(coordinates)
  Surface.new(coordinates[0], coordinates[1])
end

def prepare_robots(details, surface)
  robots = []
  details.each {|i| robots << Robot.new(surface,i[0],i[1])}
  robots
end

def explore_mars(instructions, surface)
  robots = prepare_robots(instructions,surface)
  x=''
  robots.each do |robo|
    x << robo.move + "\n"
  end
  File.open('output.txt','w') {|f| f.write(x)}
end

ARGV.empty? ? file='input.txt': file = ARGV[0]

input = File.open(file,'r') {|f| f.read}.split("\n\n").collect {|k| k.split("\n")}
coordinates = input[0].shift.split(' ').collect {|c| c.to_i}
instructions = input
surface = prepare_surface(coordinates)
explore_mars(instructions, surface)