#!/usr/bin/env ruby

require 'pry'

class Solver
  attr_reader :file_data, :numbers
  attr_accessor :boards

  def initialize(file_path = './input1.txt')
    file = File.open(file_path)
    @file_data = file.readlines.map(&:chomp)
    set_boards
  end

  def set_boards
    @boards = []
    board_num = 0

    file_data.each_with_index do | line, index |
      if index == 0
        @numbers = line.split(",").map(&:to_i)
        next
      end

      if line == ""
        board_num += 1
        next
      end

      if boards[board_num] == nil
        boards[board_num] = []
      end

      boards[board_num] << line.split(" ").map(&:to_i)
    end
    boards.compact!
  end

  def current_numbers(index)
    numbers.slice(0..index)
  end

  def winning_row?(board, index)
    board.any? do | row |
      row.all?{ | number | current_numbers(index).include?(number) }
    end
  end

  def winning_column?(board, index)
    (0..4).any? do | column |      
      board.all?{ | row | current_numbers(index).include?(row[column]) }
    end
  end

  def get_winning_board_up_to(index)
    boards.find do | board |
      winning_row?(board, index) || winning_column?(board, index)
    end
  end

  def score_winning_board(board, index)
    sum = board.flatten.reduce(0) do |sum, number|
      if current_numbers(index).include?(number)
        sum
      else
        sum + number
      end
    end

    sum * numbers[index]
  end

  def execute
    winning_board = false
    index = 4 # You cannot win before 5 numbers have been called, so lets skip checking

    while !winning_board
      winning_board = get_winning_board_up_to(index)
      unless winning_board
        index += 1
      end
    end

    puts score_winning_board(winning_board, index)
  end
end

Solver.new.execute