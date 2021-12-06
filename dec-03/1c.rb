#!/usr/bin/env ruby

require 'pry'

file = File.open("1input.txt")
file_data = file.readlines.map(&:chomp)

index_score = [
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0
]

def get_val(num)
  case num
  when '1'
    1
  when '0'
    -1
  else
    raise 'unexpected value #{num}'
  end
end

file_data.each do | line |
  line.split('').each_with_index do | num, index |
    value = get_val(num)
    index_score[index] += value
  end
end

gamma = []
epsilon = []
puts index_score
index_score.each do | value |
  if value > 0
    gamma << 1
    epsilon << 0
  else
    gamma << 0
    epsilon << 1
  end
end

gamma_val = gamma.join().to_i(2)
epsilon_val = epsilon.join().to_i(2)

puts "Gamma '#{gamma.join()}' (#{gamma_val})"
puts "Episilon '#{epsilon.join()}' (#{epsilon_val})"
puts "Answer #{gamma_val * epsilon_val}"