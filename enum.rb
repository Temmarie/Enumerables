# rubocop:disable Metrics/ModuleLength
module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    index = 0
    array = to_a
    while index < array.length
      yield(array[index])
      index += 1
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
    my_each { |index| array.push(index) if yield(index) }
    array
  end

  def my_all?(arr = nil)
    condition = true
    my_each do |index|
      if block_given?
        condition = false unless yield(index)
      elsif arr.nil?
        condition = false unless index
      else
        condition = false unless arr === index
      end
    end
    condition
  end

  def my_any?(arr = nil)
    condition = false
    my_each do |index|
      if block_given?
        condition = true if yield(index)
      elsif arr.nil?
        condition = true if index
      elsif arr === index
        condition = true
      end
    end
    condition
  end

  def my_none?(arr = nil)
    condition = true
    my_each do |index|
      if block_given?
        condition = false if yield index
      elsif arr.nil?
        condition = false if index
      elsif arr === index
        my_each { |_index| condition = false }
      end
    end
    condition
  end

  def my_count(item = nil)
    counter = 0
    if block_given?
      my_each { |index| counter += 1 if yield(index) }
    elsif item
      my_each { |index| counter += 1 if index == item }
    else
      counter = length
    end
    counter
  end

  def my_map(proc = nil)
    return to_enum(:my_map) unless block_given?

    mapped = []
    if proc.nil?
      my_each { |index| mapped << yield(index) }
    elsif block_given? && proc
      my_each { |index| mapped << proc.call(index) }
    end
    mapped
  end

  def my_inject(init = nil, symbol = nil)
    array = to_a
    if init.nil?
      result = array[0]
      array[1..-1].my_each { |index| result = yield(result, index) }
    elsif block_given?
      result = init
      array.my_each { |index| result = yield(result, index) }
    elsif init && symbol
      result = init
      array.my_each { |index| result = result.send(symbol, index) }
    elsif init.is_a? Integer
      result = init
      array.my_each { |index| result += index }
    else
      result = array[0]
      array[1..-1].my_each { |index| result = result.send(init, index) }
    end
    result
  end
end

def multiply_els(arr)
  arr.my_inject { |multiply, index| multiply * index }
end
# rubocop:enable Metrics/ModuleLength
