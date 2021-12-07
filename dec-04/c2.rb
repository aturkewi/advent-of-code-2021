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

  def get_winning_board_indexes_up_to(number_index)
    indexes = []
    (0..(boards.length - 1)).each do |board_index|
      board = boards[board_index]
      if winning_row?(board, number_index) || winning_column?(board, number_index)
        indexes << board_index
      end
    end
    indexes
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
    index = 4 # You cannot win before 5 numbers have been called, so lets skip checking

    while boards.length != 1
      winning_board_indexes = get_winning_board_indexes_up_to(index)

      if winning_board_indexes.length > 0 && boards.length > 1
        winning_board_indexes.reverse.each do | board_index |
          boards.delete_at(board_index)
        end
      end

      unless winning_board_indexes.length > 0 && boards.length == 1
        index += 1
      end
    end
    index += 1

    score = score_winning_board(boards[0], index)
    puts score
    score
  end
end

Solver.new.execute