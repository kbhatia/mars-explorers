require 'spec_helper'

describe Robot, 'new' do
  context 'all params are passed' do
    it 'should create a new robot with passed surface and start point, surface, instruction' do
      s = Surface.new(5,3)
      inst = %w[F L R R R]
      data_inst = 'FLRRR'
      start_point = '1 1 N'
      data_point = Point.new(1,1,'N')
      robo = Robot.new(s,start_point,data_inst)
      expect(robo.point.x).to eq data_point.x
      expect(robo.point.y).to eq data_point.y
      expect(robo.point.orientation).to eq data_point.orientation
      expect(robo.instructions).to eq inst
      expect(robo.surface).to eq s
    end
  end
end

describe Robot, 'move forward' do
  context 'is able to move in x or y direction given the orientation' do
    it 'should decrement x coordinate if orientation is West' do
      robot = Robot.new(Surface.new(5,3),'3 0 W','F')
      robot.move
      expect(robot.point.x).to eq 2
    end

    it 'should decrement y coordinate if orientation is South' do
      robot = Robot.new(Surface.new(5,3),'3 2 S','F')
      robot.move
      expect(robot.point.y).to eq 1
    end

    it 'should increment y coordinate if orientation is North' do
      robot = Robot.new(Surface.new(5,3),'1 2 N','F')
      robot.move
      expect(robot.point.y).to eq 3
    end

    it 'should increment x coordinate if orientation is East' do
      robot = Robot.new(Surface.new(5,3),'1 2 E','F')
      robot.move
      expect(robot.point.x).to eq 2
    end
  end
end

describe Robot, 'change orientation' do
  context 'is able to change orientation for turn type right' do
    it 'should return North if orientation is West' do
      robot = Robot.new(Surface.new(5,3),'1 1 W','R')
      robot.move
      expect(robot.point.orientation).to eq 'N'
    end

    it 'should return East if orientation is North' do
      robot = Robot.new(Surface.new(5,3),'1 1 N','R')
      robot.move
      expect(robot.point.orientation).to eq 'E'
    end

    it 'should return West if orientation is South' do
      robot = Robot.new(Surface.new(5,3),'1 1 S','R')
      robot.move
      expect(robot.point.orientation).to eq 'W'
    end

    it 'should return South if orientation is East' do
      robot = Robot.new(Surface.new(5,3),'1 1 E','R')
      robot.move
      expect(robot.point.orientation).to eq 'S'
    end
  end

  context 'is able to change orientation for turn type left' do
    it 'should return South if orientation is West' do
      robot = Robot.new(Surface.new(5,3),'1 1 W','L')
      robot.move
      expect(robot.point.orientation).to eq 'S'
    end

    it 'should return West if orientation is North' do
      robot = Robot.new(Surface.new(5,3),'1 1 N','L')
      robot.move
      expect(robot.point.orientation).to eq 'W'
    end

    it 'should return East if orientation is South' do
      robot = Robot.new(Surface.new(5,3),'1 1 S','L')
      robot.move
      expect(robot.point.orientation).to eq 'E'
    end

    it 'should return North if orientation is East' do
      robot = Robot.new(Surface.new(5,3),'1 1 E','L')
      robot.move
      expect(robot.point.orientation).to eq 'N'
    end
  end
end

describe Robot, 'falls off the surface' do
  context 'Robot is able to leave scent behind when it falls off the surface' do
    it 'should leave scent behind if the point is off the surface' do
      robot = Robot.new(Surface.new(2,1),'3 2 N','FRRFLLFFRRFLL')
      robot.move
      expect(robot.surface.scents.length).to be  > 0
    end

    it 'should detect it is lost' do
      robot = Robot.new(Surface.new(2,1),'3 2 N','FRRFLLFFRRFLL')
      robot.move
      expect(robot.lost?).to eq  true
    end
  end

end

describe Robot, 'ignore unsafe point' do
  context 'Robot is able to detect unsafe point via scents' do
    it 'should ignore a point previously added to scents' do
      s = Surface.new(2,2)
      p = Point.new(1,3,'N')
      s.scents << p
      robot = Robot.new(s,'1 2 N','F')
      robot.move
      expect(robot.point.y).to eq  2
      expect(robot.point.x).to eq  1
      expect(robot.lost?).to eq  false
    end
  end
end