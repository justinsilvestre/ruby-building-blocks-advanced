def bubble_sort(numbers)
	final = numbers.length-1
	until final == 1
		numbers.each_with_index do |number, i|
			break if i == final
			if numbers[i] > numbers[i+1]
				numbers[i], numbers[i+1] = numbers[i+1], numbers[i]
			end
		end
		final -= 1
	end
	return numbers
end

def bubble_sort_by(array)
	final = array.length-1
	until final == 1
		array.each_with_index do |item, i|
			break if i == final
			if yield(array[i],array[i+1]) < 0
				array[i], array[i+1] = array[i+1], array[i]
			end
		end
		final -= 1
	end
	return array
end


p bubble_sort([4,3,78,2,0,2])
p bubble_sort_by(["hi","hello","hey"]) { |left,right| right.length - left.length }


module Enumerable

	def my_each
		for i in 0...self.length
			yield(self[i])
		end
		return self
	end

	def my_each_with_index
		for i in 0...self.length
			yield(self[i],i)
		end
		return self
	end

	def my_select
		result = []
		self.my_each do |item|
			push item if yield(item)
		end
		return result
	end

	def my_all?
		self.my_each do |item|
			return false unless yield(item)
		end
		return true
	end

	def my_any?
		self.my_each do |item|
			return true if yield(item)
		end
		return false
	end

	def my_none?
		self.my_each do |item|
			return false if yield(item)
		end
		return true
	end

	def my_count
		n = 0
		self.my_each do
			n += 1
		end
		return n
	end

	def my_map(proc)
		result = []
		self.my_each do |item|
			result.push(proc.call(item))
			result.push(yield(item)) if block_given?
		end
		return result
	end


	def my_inject(memo=nil)
		memo = yield(memo,self[0]) if memo
		memo ||= self[0]
		for i in 1...self.length
			memo = yield(memo,self[i])
		end
		return memo
	end

end

def multiply_els(numbers)
	numbers.my_inject do |product, item|
		item * product
	end
end


aroo = [4,3,78,2,1,2]
aroo.my_each_with_index{ |num, i| p i.to_s + num.to_s }
p aroo.select {|num| num>2}
p aroo.all? {|num| num<79}
p aroo.all? {|num| num % 2 == 0}
p aroo.my_inject {|sum, n| sum*n }
p multiply_els([2,4,5])

my_proc = Proc.new do |num|
	num * 2
end
p aroo.my_map(my_proc)
p aroo.my_map(my_proc) { |x| x / 2}