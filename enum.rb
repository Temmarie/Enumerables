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

    condition = true 
    if block_given?
      my_each { |n| condition = false unless yield n }
    else
      my_each { |n| condition = false if n.nil? || n == false }
    end
    condition
  end

  def my_any?(arr = nil)

    condition = false
    my_each do |n|
      if block_given?
        my_each { |n| condition = true if yield n }
      elsif arr.nil?
        my_each { |n| condition = true unless n }
      elsif arr === n
        my_each { |n| condition = true }
      end
    end
      condition
  end

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

  def my_inject(init = nil, symbol = nil)
    array = to_a
    if init.nil?
      result = array[0]
      array[1..-1].my_each { |n| result = yield(result, n) }
    elsif block_given?
        result = init
        array.my_each { |n| result = yield(result, n) }
    elsif init && symbol
      result = init
      array.my_each { |n| result = result.send(symbol, n) }
    elsif init.is_a? Integer
      result = init
      array.my_each { |n| result += n }
    else
      result = array[0]
      array[1..-1].my_each { |n| result = result.send(init, n) }
    end
    result
  end

  def multiply_els(arr)
    arr.my_inject { |multiply, n| multiply * n }
  end
end
