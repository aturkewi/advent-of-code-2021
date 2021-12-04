#!/usr/bin/env ruby

file = File.open("input1.txt")
file_data = file.readlines.map(&:chomp)

forward = 0
depth = 0

file_data.each do | command |
    vector = command.split(' ')
    direction = vector[0]
    magnitude = vector[1].to_i

    case direction
    when 'forward'
        forward += magnitude
    when 'down'
        depth += magnitude
    when 'up'
        depth -= magnitude
    else
        raise "Unknown direction #{direction}"
    end
end

puts "Depth: #{depth}"
puts "Forward #{forward}"
puts "Answer #{depth * forward}"