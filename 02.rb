input = IO.readlines('./02.txt').map{|line| line.split(' ').map(&:to_i)}

def one(input)
  input.map { |arr| [arr.max, arr.min] }
       .map { |arr| arr[0] - arr[1] }
       .inject(:+)
end

def two(input)
  input.map(&:sort)
       .map { |arr| get_part_two(arr) }
       .inject(:+)
end

def get_part_two(input)
  current = []
  input.sort.combination(2).to_a.each do |pair|
    current = pair
    break if pair[1] % pair[0] == 0
  end
  current[1] / current[0]
end

# p one(input)

p two(input)