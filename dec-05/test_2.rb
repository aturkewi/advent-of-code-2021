require 'rspec'
require 'pry'
require_relative './code_2.rb'

describe 'Solver' do
  it 'returns the correct number of overlaps' do
    solver = Solver.new('./input_test.txt')
    expect(solver.execute).to eq(12)
  end
end

describe 'Line' do
  describe '.create_from_data' do
    it 'creates points from data' do
      data = '0,9 -> 5,9'
      line = Line.create_from_data(data)

      expect(line.starting_point.x).to eq(0)
      expect(line.starting_point.y).to eq(9)

      expect(line.ending_point.x).to eq(5)
      expect(line.ending_point.y).to eq(9)
    end
  end

  describe '#points' do
    it 'returns all points on a horizontal line' do
      data = '0,0 -> 2,0'
      line = Line.create_from_data(data)
      expect(line.points.count).to eq(3)
    end
  end
end
