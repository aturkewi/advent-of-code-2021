require 'rspec'
require_relative './code_1.rb'

describe 'Solver' do
  let(:solver) { Solver.new('./input_test.txt') }
  it 'returns the correct number for 18 days' do
    expect(solver.run_for_days(18)).to eq(26)
  end

  it 'returns the correct number for 80 days' do
    expect(solver.run_for_days(80)).to eq(5934)
  end
end
