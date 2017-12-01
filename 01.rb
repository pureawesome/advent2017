data = File.read('01.txt')
# data = '91212129' # one test data
# data = '123123' # two test data

def one(str)
  arr = str.split('')
  total = 0
  arr.size.times do
    total += arr[0].to_i if arr[0] == arr[1]
    arr.rotate!
  end
  total
end

def two(str)
  arr = str.split('')
  total = 0
  mid = arr.size / 2
  arr.size.times do
    total += arr[0].to_i if arr[0] == arr[mid]
    arr.rotate!
  end
  total
end

# p one(data)
p two(data)