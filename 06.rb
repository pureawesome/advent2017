input = File.read('./06.txt').split(' ').map(&:to_i)

def one(input)
  versions = Hash.new(0)
  input_size = input.size
  loop do |i|
    p i
    high = input.max
    index = input.index(high)
    input[index] = 0
    high.times do |i|
      new_index = (index + i + 1) % input_size
      input[new_index] += 1
    end
    break if versions[input] != 0
    combo = { input => 1 }
    versions.merge!combo
  end
  versions.size + 1
end

def two(input)
  versions = Hash.new(0)
  input_size = input.size
  ans = 0
  loop.with_index do |_, i|
    high = input.max
    index = input.index(high)
    input[index] = 0
    high.times do |n|
      new_index = (index + n + 1) % input_size
      input[new_index] += 1
    end
    if versions[input] != 0
      ans = i - versions[input]
      break
    end
    combo = { input => i }
    versions.merge!combo
  end
  ans
end


p two(input)