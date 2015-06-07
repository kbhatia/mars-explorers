require 'spec_helper'

describe 'new surface' do
  context 'width and height are within the range of 0 - 50' do
    it 'should create a new surface with height and width' do
      surface = Surface.new(5,3)
      expect(surface.width).to eq 5
      expect(surface.height).to eq 3
    end
  end

  context 'width or height is greater than 50' do
    it 'should raise an error when width > 50' do
      expect { Surface.new(52,3) }.to raise_error(ArgumentError)
    end

    it 'should raise an error when height > 50' do
      expect { Surface.new(3,52) }.to raise_error(ArgumentError)
    end
  end
end