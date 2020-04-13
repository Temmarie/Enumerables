load 'enum.rb'

# include Enumerable

def multiply_els(array)
  array.my_inject(1) { |product, index| product * index }
end

my_proc = proc { |num| num * 2 }

# ARRAY TO TEST CODE
test_array = [4, 5, 6, 3, 7]
puts "Test  Array = #{test_array}"

# my_each method
puts 'my_each:'
test_array.my_each { |i| puts i.to_s + ' ' }

# my_each_with_index method
puts 'my_each_with_index:'
test_array.my_each_with_index { |i, index| p index.to_s + ':' + i.to_s + ' ' }

# rubocop:disable Lint/AmbiguousBlockAssociation

# my_selectmethod
puts 'my_select:'
p test_array.my_select { |i| i < 6 }
# my_all? method
puts 'my_all?:'
p test_array.my_all? { |i| i < 6 }
# my_any? method
puts 'my_any?:'
p test_array.my_any? { |i| i < 6 }
# my_none? method
puts 'my_none?:'
p test_array.my_none? { |i| i < 6 }
# rubocop:enable Lint/AmbiguousBlockAssociation

# my_count method
puts 'my_count:'
p test_array.my_count(3)

# my_map method
puts 'my_map:'
p test_array.my_map(my_proc) { |i| i * 2 }

# my_inject method
puts 'my_inject:'
p test_array.my_inject(10) { |sum, i| sum + i }

# multiply_els method
puts 'multiply_els:'
p multiply_els(test_array)
