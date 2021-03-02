# The first 7 characters will either be F or B; these specify exactly one of the 128 rows on the plane (numbered 0 through 127).
# Each letter tells you which half of a region the given seat is in. Start with the whole list of rows;
# the first letter indicates whether the seat is in the front (0 through 63) or the back (64 through 127).
# The next letter indicates which half of that region the seat is in, and so on until you're left with exactly one row
# The last three characters will be either L or R; these specify exactly one of the 8 columns of seats on the plane (numbered 0 through 7).
# The same process as above proceeds again, this time with only three steps. L means to keep the lower half, while R means to keep the upper half
# Every seat also has a unique seat ID: multiply the row by 8, then add the column
# As a sanity check, look through your list of boarding passes. What is the highest seat ID on a boarding pass?

require 'csv'
require_relative './lib/passes_scan.rb'

puts('Binary Boarding')

file = File.read('./../data/boarding_passes.txt')
csv = CSV.parse(file)

passes = PassesScan.new(csv)

puts("O maior ID de um assento é: #{passes.highest_id}")
puts("O menor ID de um assento é: #{passes.lowest_id}")

puts ("o assento não listado, que é o seu é o de ID: #{passes.missing_id}")