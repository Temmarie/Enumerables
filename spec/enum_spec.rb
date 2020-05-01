require './enum.rb'

RSpec.describe Enumerable do
  let(:array1) { [0, 1, 2, 3, 4, 5, 6, 7, 8, 9] }
  let(:array2) { %w[hello hey hi holla yea good] }
  let(:array3) { [1, 2, 3, 4] }
  let(:array4) { [2, 4, 6, 8] }
  let(:array5) { [2, 4, 6, 8, 'jersey', %w[why me cr7 oa7]] }
  let(:array6) { [4, 2, 3, 4, 4, 3, 5, 4, 4] }
  let(:new_array) { [] }

  describe '#my_each' do
    it 'Passes each element to a new array based on some operation' do
      array1.my_each { |ele| new_array << ele * 1 }

      expect(new_array).to eql(array1)
    end

    it 'Returns a new array based on some arguments passed' do
      array1.my_each { |ele| new_array << ele if ele.even? && ele > 0 }

      expect(new_array).to eql(array4)
    end

    it 'Returns the Enumerator when no block is given' do
      expect(array1.my_each).to be_kind_of(Enumerator)
    end
  end

  describe '#my_each_with_index' do
    it 'Returns the Enumerator when no block is given' do
      expect(array1.my_each_with_index).to be_kind_of(Enumerator)
    end

    it 'Returns element plus index when argument is passed' do
      array3.my_each_with_index { |ele, index| new_array << "#{index} : #{ele}" }

      expect(new_array).to eql(['0 : 1', '1 : 2', '2 : 3', '3 : 4'])
    end

    it 'Return the index position and element when specific results are wanted' do
      array3.my_each_with_index { |ele, index| new_array << "#{index} : #{ele}" if ele.even? }

      expect(new_array).to eql(['1 : 2', '3 : 4'])
    end
  end

  describe '#my_select' do
    it 'Returns specific data from the array based on the argument passed' do
      array2.my_select { |ele| new_array << ele if ele.include?('h') }
      expect(new_array).to eq(%w[hello hey hi holla])
    end

    it 'Returns new array with specific data based on arguments' do
      array1.my_select { |ele| new_array << ele if ele.odd? && ele > 0 }

      expect(new_array). to eq([1, 3, 5, 7, 9])
    end

    it 'Returns the Enumerator when no block is given' do
      expect(array1.my_select).to be_kind_of(Enumerator)
    end
  end

  describe '#my_all?' do
    it "Returns false when all elements of the array don\'t\ have an \'h'\ in them" do
      expect(array2.my_all?(/[h]/)).to be false
    end

    it 'Returns true if all elements of the array contain vowels(aeiou)' do
      expect(array2.my_all?(/[aeiou]/)).to be true
    end

    it 'Returns false if all elements of the array are not Integers' do
      expect(array5.my_all?(Integer)).to be false
    end
  end

  describe '#my_any?' do
    it "Returns false when none of the elements in the array contains a \'t'\ " do
      expect(array2.my_any?(/[t]/)).to be false
    end

    it "Returns true if any of the elements in the array contains the string \'ello'\ " do
      expect(array2.my_any? { |ele| ele.include?('ello') }).to be true
    end

    it 'Returns true if any of the elements is an Array' do
      expect(array5.my_any?(Array)).to be true
    end
  end

  describe '#my_none?' do
    it "Returns true when none of the elements in the array contains a \'t'\ " do
      expect(array2.my_none?(/[t]/)).to be true
    end

    it 'Returns true if none of the elements in the array is an Integer' do
      expect(array2.my_none?(Integer)).to be true
    end

    it 'Returns false if none of the elements in the array is greater than 7' do
      expect(array1.my_none? { |ele| ele > 7 }).to be false
    end
  end

  describe '#my_count' do
    it 'Returns the number of elements in the array(array size)' do
      expect(array1.my_count).to eql(10)
    end

    it 'Returns the number of times an element appears in an array when argument is given' do
      expect(array6.my_count(4)).to eql(5)
    end

    it 'Returns the number elements that match the condition in a given block' do
      expect(array6.my_count { |ele| ele if ele.even? }).to eql(6)
    end
  end

  describe '#my_map' do
    it 'Creates a new array containing the values returned after executing the code in the given block' do
      expect(array3.my_map { |x| x + 1 }).to eql([2, 3, 4, 5])
    end

    it 'Returns an array of elements where even numbers have 100 added to them and odd numbers 200 added to them' do
      expect(array3.my_map { |ele| ele.even? ? ele + 100 : ele + 200 }).to eq([201, 102, 203, 104])
    end

    it 'Returns the Enumerator when no block is given' do
      expect(array1.my_map).to be_kind_of(Enumerator)
    end
  end

  describe '#my_inject' do
    it 'Returns the sum of all elements in an array when block is given' do
      expect(array1.my_inject { |a, b| a + b }).to eql(45)
    end

    it 'Returns the sum of all elements in an array plus the accumulator value when it is passed as an argument' do
      expect(array1.my_inject(10) { |a, b| a + b }).to eql(55)
    end

    it 'Returns the product of all elements if argument is passed as a String' do
      expect(array3.my_inject('*')).to eq(24)
    end

    it 'Returns the product of all elements if argument is passed as a Symbol' do
      expect(array3.my_inject(:*)).to eq(24)
    end

    it 'Returns the product of all elements multiplied by the accumulator value given' do
      expect(array3.my_inject(10, :*)).to eq(240)
    end
  end
end
