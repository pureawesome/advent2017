input = 361_527

def one(input)
  root = Math.sqrt(input)
  return root - 1 if root % 1 == 0
  root = root.floor
  root -= 1 if root.even?
  leftover = input - (root**2)
  answer = root - 1
  offset = leftover % (2**(root + 1) - answer)
  answer + offset
end

def two(input)
  spiral = Hash.new(0)
  start = { [0, 0] => 1 }
  spiral.merge!start
  size = 1
  current = [0, 0]
  order = [[0, -1], [-1, 0], [0, 1], [1, 0]]

  loop do
    current = [current, [1, 0]].transpose.map { |x| x.inject(:+) }
    value = get_neighbors(current, spiral)
    return if value > input
    hash = { current => value }
    spiral.merge!hash
    order.each.with_index do |change, i|
      sides = size * 2
      sides -= 1 if i == 0
      sides.times do
        current = [current, change].transpose.map { |x| x.inject(:+) }
        value = get_neighbors(current, spiral)
        break if value > input
        hash = { current => value }
        spiral.merge!hash
      end
      break if value > input
    end
    return value if value > input
    size += 1
  end
end

def get_neighbors(coord, hash)
  hash[[coord[0] + 1, coord[1] + 1]] + hash[[coord[0], coord[1] + 1]] +
    hash[[coord[0] - 1, coord[1] + 1]] + hash[[coord[0] - 1, coord[1]]] +
    hash[[coord[0] - 1, coord[1] - 1]] + hash[[coord[0], coord[1] - 1]] +
    hash[[coord[0] + 1, coord[1] - 1]] + hash[[coord[0] + 1, coord[1]]]
end

p one(input)
p two(input)