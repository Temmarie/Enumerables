module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    length.times { |n| yield(self[n]) }
    self
  end

  def my_each_with_index
    return to_enum(:my_each_wth_index) unless block_given?

    length.times do |index|
      yield(self[index], index)
    end
    self
  end

  def my_select
    return to_enum if block_given? == false

    array = []
    my_each { |n| array.push(n) if yield(n) }
    array
  end


end
