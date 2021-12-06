#!/usr/bin/env ruby

require 'pry'

class Solver
  attr_accessor :ox_gen_indexes, :c02_scrub_indexes
  attr_reader :file_data

  def initialize
    file = File.open("1input.txt")
    @file_data = file.readlines.map(&:chomp)
    @ox_gen_indexes = (0..(file_data.length-1)).to_a
    @c02_scrub_indexes = (0..(file_data.length-1)).to_a
  end

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

  def find_most_common(indexes, digit)
    commonality_score = indexes.reduce(0) do | sum, index |
      sum + get_val(file_data[index].split('')[digit])
    end
    (commonality_score >= 0) ? 1 : 0
  end

  def find_least_common(indexes, digit)
    # puts "length: #{indexes.length}"
    commonality_score = indexes.reduce(0) do | sum, index |
      sum + get_val(file_data[index].split('')[digit])
    end

    # puts "Comm score: #{commonality_score}"
    if commonality_score >= 0
      0
    else
      1
    end
  end

  def keep_the_good_ones(indexes, digit, most_common)
    indexes.filter do | index |
      file_data[index].split('')[digit].to_i == most_common.to_i
    end
  end

  def level(indexes, digit = 0, least_common: false)
    selected_digit = if least_common
      find_least_common(indexes, digit)
    else
      find_most_common(indexes, digit)
    end
    remainder = keep_the_good_ones(indexes, digit, selected_digit)

    # puts "Selected digit was: #{selected_digit}"
    # remainder.each do |rem|
    #   puts file_data[rem]
    # end
    # puts "==="
    if remainder.length == 1
      return file_data[remainder[0]]
    else
      return level(remainder, digit + 1, least_common: least_common)
    end
  end

  def execute
    ox_bin = level(ox_gen_indexes)
    c02_bin = level(c02_scrub_indexes, least_common: true)

    ox_val = ox_bin.to_i(2)
    c02_val = c02_bin.to_i(2)
    puts ox_val * c02_val
  end

  # ox_gen_val = ox_gen_rating.to_i(2)
  # c02_scrub_val = c02_scrub_rating.to_i(2)

  # puts "Oxygen '#{ox_gen_rating}' (#{ox_gen_val})"
  # puts "C02 '#{c02_scrub_rating}' (#{c02_scrub_val})"
  # puts "Answer #{ox_gen_val * c02_scrub_val}"
end

Solver.new.execute