input = IO.readlines('./04.txt').map { |line| line.split(' ') }

def one(input)
  input.map { |arr| validate?(arr) }.inject(:+)
end

def validate?(arr)
  # part 2
  arr = arr.map { |str| str.split('').sort.join('') }
  #
  arr = arr.combination(2).to_a.map do |combo|
    combo[0] =~ /^#{combo[1]}\z/
  end.compact
  arr.empty? ? 1 : 0
end

p one(input)