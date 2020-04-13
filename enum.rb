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

  def my_all?(arr = nil)
    if block_given?
      my_each { |n| return false unless yield n }
    elsif arr
      my_each { |n| return false unless checker(n, arr) }
    else
      my_each { |n| return false unless n }
    end
    true
  end

  def my_any?(arr = nil)
    if block_given?
      my_each { |n| return true unless yield n }
    elsif arr
      my_each { |n| return true unless checker(n, arr) }
    else
      my_each { |n| return true unless n }
    end
    false
  end

  def my_none?(arr = nil)
    if !block_given?
      my_each { |n| return true unless yield n }
    elsif arr
      my_each { |n| return false unless checker(n, arr) }
    else
      my_each { |n| return false unless n }
    end
    false
  end

  def my_count(item = nil)
    counter = 0
    if block_given?
      my_each { |n| return counter += 1 if yield(n) }
    elsif item
      my_each { |n| return counter += 1 if n == item }
    else
      counter = size
    end
    counter
  end

  def my_map(proc = nil)
    return to_enum(:my_map) unless block_given?

    mapped = []
    if proc.nil?
      my_each { |n| mapped << yield(n) }
    elsif block_given? && proc
      my_each { |n| mapped << proc.call(n) }
    end
    mapped
  end

  def my_inject(arg = 0)
    return nil unless block_given?

    my_each { |x| arg = yield(arg, x) }
    arg
  end

  def multiply_els(arr)
    arr.my_inject { |multiply, n| multiply * n }
  end
end
