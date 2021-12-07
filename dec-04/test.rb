require 'rspec'
require_relative './c1.rb'

describe 'some test' do
  it 'returns true' do
    solver = Solver.new('./test.txt')
    expect(solver.execute).to eq(4512)
  end

  it 'solves for a column win' do
    solver = Solver.new('./test2.txt')
    expect(solver.execute).to eq(518)
  end
end