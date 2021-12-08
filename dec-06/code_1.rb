#!/usr/bin/env ruby

require 'pry'

class Solver
  attr_reader :file_data, :lines, :board

  def initialize(file_path = './input.txt')
    file = File.open(file_path)
    file_data = file.readlines.map(&:chomp)
    @fish = file_data[0].split(',').map(&:to_i)
  end

  def run_for_days(number_of_days)
    number_of_days.to_i.times do | num |
      new_fish = []

      updated_fish_count = @fish.map do | fish |
        if fish == 0
          new_fish << 8
          6
        else
          fish - 1
        end
      end

      @fish = updated_fish_count + new_fish
      puts "Day #{num + 1}: #{@fish.length}"
    end

    @fish.length
  end
end