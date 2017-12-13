input = 361_527

# input = 23 #= 2
# input = 1024 #= 31
# input = 12 #= 3
# input = 26

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

# 1
# 2, 9 = 8 total 3, 3
# 10, 25 = 16 total 5, 5
# 
# 17  16  15  14  13
# 18   5   4   3  12
# 19   6   1   2  11  28
# 20   7   8   9  10  27
# 21  22  23  24  25  26

#           6 
# 4 3 2 3 4 5
# 3 2 1 2 3 4 
# 2 1 0 1 2 3
# 3 2 1 2 3 4
# 4 3 2 3 4 5
# 
# 
# 14 / 16 = 0   1/8
# 6 / 16 = 0    3/8
# 10 / 16 = 0  5/8
# 2/16 = 0    7/8
# 
# 2, 6, 10, 14
#   4  4   4
#   
#   
#   
#                           2344
# 147  142  133  122   59   2285
# 304    5    4    2   57   2169
# 330   10    1    1   54   1999
# 351   11   23   25   26   1862
# 362  747  806  854  905   931
# 
# 
# 806+23+25+26
#  N  N  N  N  Y        
#  N  Y  N  Y  Y  N
#  N  N  1  Y  N  Y
#  N  Y  Y  N  N  N
#  N  N  N  N  N  N
#  2169+57+59
#  [0,0] 
#  
#  [1,0] 
#  [1,1] 
#  [0,1] 
#  [-1, 1] 
#  [-1,0] 
#  [-1, -1] 
#  [0, -1] 
#  [1, -1] 
#  
#  [2, -1]
#  [2, 0]
#  [2, 1]
#  [2, 2]
#  [1,2]
#  [0,2]
#  [-1,2]
#  [-2,2]
#  
#  
#  
#  
#  2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 
#  79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 
#  167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 


#  1, 1, 2, 2*2, 5, 5*2, 11, 23, 5*5, 13*2, 2*3*3*3, 19*3, 59, 61*2, 19*7, 71*2,
#  1, 1, 2,  4,  5, 10,  11, 12,  23, 26,     54,     57,  59, 122,   133,  142,  
#  
#   7*7*3, 19*2*2*2*2, 2*5*3*11, 3*3*3*13, 181*2, 3*3*83, 31*13*2, 2*6*61, 5*181, 7*7*19, 2*7*7*19
#  147,     304,          330,    351,      362,   747,     806,    854,    905,   931,     1862
#  
#                                                    2**3*293
# 7*7*3      71*2      19*7      61*2     59*1       5*457
# 19*2**4     5*1       2*2       2*1     57*1       3**2*241
# 2*3*5*11    5*2        1        1*1     3**3*2     1999*1
# 3**3*13    11*1      23*1       5**2     13*2      2*7**2*19
# 181*2     3**2*83    2*13*31   2*7*61   5*181     7**2*17
# 
# 
# 17         16          15       14       13P
# 18          5P          4       3P        12P
# 19          6           1       2P        11            28P
# 20          7P          8P      9         10            27
# 21          22          23      24        25            26
# 
# -2,2      -1,2        0,2       1,2       2,2P
# -2,1      -1,1P       0,1       1,1P      2,1P
# -2,0      -1,0        0,0       1,0P      2,0     3,0P
# -2,1      -1,1P       0,1P      1,1       2,1
# -2,2      -1,2        0,2       1,2       2,2
# 