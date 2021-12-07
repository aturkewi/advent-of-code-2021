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
    index = 3 # You cannot win before 5 numbers have been called, so lets skip checking
    loosing_board = nil

    while !loosing_board # && index < 110
      index += 1
      winning_board_indexes = get_winning_board_indexes_up_to(index)
      puts "Winning board indexes: #{winning_board_indexes}"
      puts "index: #{index}"
      if winning_board_indexes.length > 0
        index_modifier = 0
        winning_board_indexes.each do | board_index |
          if boards.length == 1
            loosing_board = boards.first
          else
            boards.delete_at(board_index + index_modifier)
            index_modifier -= 1
          end
        end
      end

      # break if index > 20
    end
    # index += 1
    # binding.pry
    score = score_winning_board(loosing_board, index)
    puts score
    score
  end
end

Solver.new.execute