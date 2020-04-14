load 'enum.rb'

module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    n = 0
    array = to_a
    while n < array.length
      yield(array[n])
      n += 1
    end
  end

  # def my_each
  #   return to_enum(:my_each) unless block_given?

  #   size.times do |n|
  #     yield to_a[n]
  #   end
  # end

# #1. my_each
# puts "my_each"
# puts "-------"
# puts [1, 2, 3].my_each { |elem| print "#{elem + 1} "} 
# # => 2 3 4

def my_each_with_index
  return to_enum(:my_each_wth_index) unless block_given?

  length.times do |index|
    yield(self[index], index)
  end
  self
end

# puts
# #2. my_each_with_index
# puts "my_each_with_index"
# puts "------------------"
# print [1, 2, 3].my_each_with_index { |elem, idx| puts "#{elem} : #{idx}" }
# # => 1 : 0, 2 : 1, 3 : 2
# puts

def my_select
  return to_enum if block_given? == false

  array = []
  my_each { |n| array.push(n) if yield(n) }
  array
end

# #3. my_select
# puts "my_select"
# puts "---------"
# p [1,2,3,8].my_select { |n| n.even? } # => [2, 8]
# p [0, 2018, 1994, -7].my_select { |n| n > 0 } # => [2018, 1994]
# p [6, 11, 13].my_select(&:odd?) # => [11, 13]

  def my_all?(arr = nil)

    condition = true 
    if block_given?
      my_each { |n| condition = false unless yield n }
    else
      my_each { |n| condition = false if n.nil? || n == false }
    end
    condition
  end


# #4. my_all? (example test cases)
# puts "my_all?"
# puts "-------"
# p [3, 5, 7, 11].my_all? { |n| n.odd? } # => true
# p [-8, -9, -6].my_all? { |n| n < 0 } # => true
# p [3, 5, 8, 11].my_all? { |n| n.odd? } # => false
# p [-8, -9, -6, 0].my_all? { |n| n < 0 } # => false

# # test cases required by tse reviewer my_all?
# p [1,2,3,4,5].my_all? # => true
# p [1, 2, 3].my_all?(Integer) # => true
# p ['dog', 'door', 'rod', 'blade'].my_all?(/d/) # => true
# p [1, 1, 1].my_all?(1) # => true
# # puts

#work on it in spare time
# def my_any?(arr = nil)
#   if block_given?
#     my_each { |n| return true unless yield n }
#   elsif arr
#     my_each { |n| return true unless checker(n, arr) }
#   else
#     my_each { |n| return true unless n }
#   end
#   false
# end
  # def my_any?(arr = nil)

  #   condition = false
  #   my_each do |n|
  #     if block_given?
  #       my_each { |n| condition = true if yield n }
  #     elsif arr.nil?
  #       my_each { |n| condition = true unless n }
  #     elsif arr === n
  #       my_each { |n| condition = true }
  #     end
  #   end
  #     condition
  # end

  def my_any?(arr = nil)

    condition = false
    n = 1
    
    if block_given?
      my_each { |n| condition = true if yield n }
    elsif arr.nil?
      my_each { |n| condition = true unless n }
    elsif arr === n
      my_each { |n| condition = true }
    end
    condition
  end

#   #5. my_any? (example test cases)
# puts "my_any?"
# puts "-------"
# p [7, 10, 3, 5].my_any? { |n| n.even? } # => true
# p [7, 10, 4, 5].my_any?() { |n| n.even? } # => true
# p ["q", "r", "s", "i"].my_any? { |char| "aeiou".include?(char) } # => true
# p [7, 11, 3, 5].my_any? { |n| n.even? } # => false
# p ["q", "r", "s", "t"].my_any? { |char| "aeiou".include?(char) } # => false
# # test cases required by tse reviewer
# p [1, nil, false].my_any?(1) # => true
# p [1, nil, false].my_any?(Integer) # => true
# p ['dog', 'door', 'rod', 'blade'].my_any?(/z/) # => false
# p [1, 2 ,3].my_any?(1) # => true
# puts
#original to be fixed 
# def my_none?(arr = nil)
#   if !block_given?
#     my_each { |n| return true unless yield n }
#   elsif arr
#     my_each { |n| return false unless checker(n, arr) }
#   else
#     my_each { |n| return false unless n }
#   end
#   false
# end


def my_none?(arr = nil)

  condition = true
  my_each do |n|

    if block_given?
      my_each { |n| condition = false if yield n }
    elsif arr.nil?
      my_each { |n| condition = false if n }
    elsif arr === n
      my_each { |n| condition = false }
    end
  end
    condition
end

# def my_none?(arr = nil)
#   condition = true
#   my_each do |n|
#     if block_given? 
#       condition = false if yield n
#       elsif arr.nil?
#         condition = false if n
#         elsif arr === n
#           condition = false
#         end
#       end
#       condition
#   end


# #6. my_none? (example test cases)
# puts "my_none?"
# puts "--------"
# p [3, 5, 7, 11].my_none? { |n| n.even? } # => true
# p ["sushi", "pizza", "burrito"].my_none? { |word| word[0] == "a" } # => true
# p [3, 5, 4, 7, 11].my_none? { |n| n.even? } # => false
# p ["asparagus", "sushi", "pizza", "apple", "burrito"].my_none? { |word| word[0] == "a" } # => false
# #test cases required by tse reviewer
# p [nil, false, nil, false].my_none? # => true
# p [1, 2 ,3].my_none? # => false
# p [1, 2 ,3].my_none?(String) # => true
# p [1,2,3,4,5].my_none?(2) # => false
# p [1, 2, 3].my_none?(4) # => true
# puts



def my_count(item = nil)
  counter = 0
  if block_given?
    my_each { |n| counter += 1 if yield(n) }
  elsif item
    my_each { |n| counter += 1 if n == item }
  else
    counter = length
  end
  counter
end

# #7. my_count (example test cases)
# puts "my_count"
# puts "--------"
# p [1,4,3,8].my_count { |n| n.even? } # => 2
# p ["DANIEL", "JIA", "KRITI", "dave"].my_count { |s| s == s.upcase } # => 3
# p ["daniel", "jia", "kriti", "dave"].my_count { |s| s == s.upcase } # => 0
# # # test cases required by tse reviewer
# p [1,2,3].my_count # => 3
# p [1,1,1,2,3].my_count(1) # => 3
# puts



def my_inject(arg = nil)

  my_each { |x| arg = yield(arg, x) }
  arg
end


#9. my_inject
puts "my_inject"
puts "---------"
p [1,2,3,4].my_inject(10) { |accum, elem| accum + elem} # => 20
p [1,2,3,4].my_inject { |accum, elem| accum + elem} # => 10
p [5, 1, 2].my_inject("+") # => 8
p (5..10).my_inject(2, :*) # should return 302400
p (5..10).my_inject(4) {|prod, n| prod * n} # should return 604800
end