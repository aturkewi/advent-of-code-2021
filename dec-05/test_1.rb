require 'rspec'
require_relative './code_1.rb'

describe 'Solver' do
  it 'returns the correct number of overlaps' do
    solver = Solver.new('./input_test.txt')
    expect(solver.execute).to eq(5)
  end
end

describe 'Line' do
  it 'creates points from data' do
    data = '0,9 -> 5,9'
    line = Line.create_from_data(data)

    expect(line.starting_point.x).to eq(0)
    expect(line.starting_point.y).to eq(9)

    expect(line.ending_point.x).to eq(5)
    expect(line.ending_point.y).to eq(9)
  end
end
