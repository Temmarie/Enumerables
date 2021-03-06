# load 'enum.rb'
# #1. my_each
# puts "my_each"
# puts "-------"
# puts [1, 2, 3].my_each { |elem| print "#{elem + 1} "}
# # => 2 3 4
# puts
# #2. my_each_with_index
# puts "my_each_with_index"
# puts "------------------"
# print [1, 2, 3].my_each_with_index { |elem, idx| puts "#{elem} : #{idx}" }
# # => 1 : 0, 2 : 1, 3 : 2
# puts
# # 3. my_select
# puts "my_select"
# puts "---------"
# p [1,2,3,8].my_select { |n| n.even? } # => [2, 8]
# p [0, 2018, 1994, -7].my_select { |n| n > 0 } # => [2018, 1994]
# p [6, 11, 13].my_select(&:odd?) # => [11, 13]
# puts
# # 4. my_all? (example test cases)
# puts "my_all?"
# puts "-------"
# p [3, 5, 7, 11].my_all? { |n| n.odd? } # => true
# p [-8, -9, -6].my_all? { |n| n < 0 } # => true
# p [3, 5, 8, 11].my_all? { |n| n.odd? } # => false
# p [-8, -9, -6, 0].my_all? { |n| n < 0 } # => false
# # test cases required by tse reviewer
# p [1,2,3,4,5].my_all?(3) # => false
# p [1, 2.5,'a', 3].my_all?(Integer)# => false
# p ['dog', 'door', 'rod', 'blade'].my_all?(/o/) # => false
# p [1, 1, 1].my_all?(1) # => true
# puts
# #5. my_any? (example test cases)
# puts "my_any?"
# puts "-------"
# p [7, 10, 3, 5].my_any? { |n| n.even? } # => true
# p [7, 10, 4, 5].my_any?() { |n| n.even? } # => true
# p ["q", "r", "s", "i"].my_any? { |char| "aeiou".include?(char) } # => true
# p [7, 11, 3, 5].my_any? { |n| n.even? } # => false
# p ["q", "r", "s", "t"].my_any? { |char| "aeiou".include?(char) } # => false
# #test cases required by tse reviewer
# p [nil, false, nil, false].my_any? # => false
# p [1, nil, false].my_any?(Integer) # => true
# p ['dog', 'door', 'rod', 'blade'].my_any?(/z/) # => false
# p [1, 2 ,3].my_any?(1) # => true
# puts
# #6. my_none? (example test cases)
# puts "my_none?"
# puts "--------"
# p [3, 5, 7, 11].my_none? { |n| n.even? } # => true
# p ["sushi", "pizza", "burrito"].my_none? { |word| word[0] == "a" } # => true
# p [3, 5, 4, 7, 11].my_none? { |n| n.even? } # => false
# p ["asparagus", "sushi", "pizza", "apple", "burrito"].my_none? { |word| word[0] == "a" } # => false
# # test cases required by tse reviewer
# p [nil, false, nil, false].my_none? # => true
# p [1, 2 ,3].my_none? # => false
# p [1, 2 ,3].my_none?(String) # => true
# p [1,2,3,4,5].my_none?(2) # => false
# p [1, 2, 3].my_none?(4) # => true
# puts
# #7. my_count (example test cases)
# puts "my_count"
# puts "--------"
# p [1,4,3,8].my_count { |n| n.even? } # => 2
# p ["DANIEL", "JIA", "KRITI", "dave"].my_count { |s| s == s.upcase } # => 3
# p ["daniel", "jia", "kriti", "dave"].my_count { |s| s == s.upcase } # => 0
# # test cases required by tse reviewer
# p [1,2,3].my_count # => 3
# p [1,1,1,2,3].my_count(1) # => 3
# puts
# #8. my_map
# puts "my_map"
# puts "------"
# p [1,2,3].my_map { |n| 2 * n } # => [2,4,6]
# p ["Hey", "Jude"].my_map { |word| word + "?" } # => ["Hey?", "Jude?"]
# p [false, true].my_map { |bool| !bool } # => [true, false]
# my_proc = Proc.new {|num| num > 10 }
# p [18, 22, 5, 6].my_map(my_proc) {|num| num < 10 } # => true true false false
# puts
# #9. my_inject
# puts "my_inject"
# puts "---------"
# p [1,2,3,4].my_inject(10) { |accum, elem| accum + elem} # => 20
# p [1,2,3,4].my_inject { |accum, elem| accum + elem} # => 10
# p [5, 1, 2].my_inject("+") # => 8
# p (5..10).my_inject(2, :*) # should return 302400
# p (5..10).my_inject(4) {|prod, n| prod * n} # should return 604800
