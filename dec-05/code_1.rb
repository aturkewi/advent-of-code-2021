#!/usr/bin/env ruby

require 'pry'

class Line
  attr_reader :starting_point, :ending_point

  Point = Struct.new(:x, :y)

  def initialize(first_point, second_point)
    @starting_point = first_point
    @ending_point = second_point
  end

  def self.create_from_data(data)
    points_data = data.split(' -> ')

    new(create_point(points_data[0]), create_point(points_data[1]))
  end

  def self.create_point(point_data)
    point_data_array = point_data.split(',')
    Point.new(point_data_array[0].to_i, point_data_array[1].to_i)
  end

  def to_s
    "#{starting_point.x},#{starting_point.y} -> #{ending_point.x},#{ending_point.y}"
  end

  def horizontal?
    starting_point.y == ending_point.y
  end

  def vertical?
    starting_point.x == ending_point.x
  end

  def smaller_x_point
    if starting_point.x < ending_point.x
      starting_point.x
    else
      ending_point.x
    end
  end

  def larger_x_point
    if starting_point.x > ending_point.x
      starting_point.x
    else
      ending_point.x
    end
  end

  def smaller_y_point
    if starting_point.y < ending_point.y
      starting_point.y
    else
      ending_point.y
    end
  end

  def larger_y_point
    if starting_point.y > ending_point.y
      starting_point.y
    else
      ending_point.y
    end
  end
end

class Solver
  attr_reader :file_data, :lines, :board

  def initialize(file_path = './input.txt')
    file = File.open(file_path)
    @file_data = file.readlines.map(&:chomp)
    @max_x = 0
    @max_y = 0
    @lines = []
  end

  def execute
    process_lines_and_set_board_size(file_data)
    generate_board
    process_lines
    score
  end

  def print_board
    board.each do | line |
      puts line.join()
    end
  end

  def score
    answer = board.flatten.reduce(0) do | sum, value |
      if value > 1
        sum + 1
      else
        sum
      end
    end
    puts answer
    answer
  end

  def process_lines
    lines.each do | line |
      if line.horizontal?
        process_horizontal_line(line)
      else
        process_vertical_line(line)
      end
      # puts line
      # print_board
    end
  end

  def process_horizontal_line(line)
    y_location = line.starting_point.y
    (line.smaller_x_point..line.larger_x_point).to_a.each do |x_location|
      board[y_location][x_location] += 1
    end
  end

  def process_vertical_line(line)
    x_location = line.starting_point.x

    (line.smaller_y_point..line.larger_y_point).to_a.each do |y_location|
      board[y_location][x_location] += 1
    end
  end

  def generate_board
    @board = (0..(@max_y)).map{ |_num| Array.new(@max_x + 1, 0) }
  end

  def update_max_values(point)
    if point.x > @max_x
      @max_x = point.x
    end
    
    if point.y > @max_y
      @max_y = point.y
    end
  end

  def process_lines_and_set_board_size(file_data)
    file_data.each do | data |
      line = Line.create_from_data(data)
      
      if line.vertical? || line.horizontal?
        update_max_values(line.starting_point)
        update_max_values(line.ending_point)
        lines << line
      end
    end
  end
end