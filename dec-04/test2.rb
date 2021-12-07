require 'rspec'
require_relative './c2.rb'

describe 'execute' do
  it 'returns the score of the last board to win' do
    solver = Solver.new('./test.txt')
    expect(solver.execute).to eq(1924)
  end
end