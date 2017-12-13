input = IO.readlines('./05.txt').map(&:to_i)
# p input

def one(input)
  position = 0
  steps = 0
  until position > (input.size - 1) || position < 0
    change = input[position]
    input[position] += 1
    position += change
    steps += 1
  end
  steps
end

def two(input)
  position = 0
  steps = 0
  until position > (input.size - 1) || position < 0
    change = input[position]
    input[position] += (change >= 3) ? -1 : 1
    position += change
    steps += 1
  end
  steps
end

# p one(input)
p two(input)