input = IO.readlines('./07.txt').map { |line| line.gsub(/\s+/, '') }

def one(input)
  lower = []
  upper = []
  input.map { |line| line =~ /->/ ? line : nil }.compact
       .map { |line| line.split(/\(\d+\)+->/) }
       .each do |line|
         lower.push(line[0])
         upper.push(line[1].split(','))
       end
  upper.flatten!(1)
  lower - upper
end

def two(input)
  hash = Hash.new()
  input.each do |line|
    key, value = (line =~ /->/) ? parent_hash(line) : top_hash(line)
    hash[key] = value
  end

  all = Marshal.load(Marshal.dump(hash))

  loop do
    hash.select { |_k, v| v[:children].nil? }
        .each { |k, v| hash = update_children(hash, k, v) }
    hash.select { |_k, v| v[:children].all? { |i| i.is_a?(Integer) } }
        .each { |k, v| hash = update_weight(hash, k, v) }
    break if hash[:answer] == TRUE
  end

  hash.delete(:answer)
  ans = hash.select { |_k, v| v[:children].nil? }
            .select { |_k, v| v.values.uniq.size == 3 }
  children = ans.values[0]
  children.delete(:weight)
  child = children.values.sort
  childs = child.find { |item| child.count(item) == 1 }
  diff = child[0] - child[-1]
  otehr = ans.values[0].select { |_k, v| v == childs }.keys[0]
  all[otehr][:weight] + diff
end

def update_children(hash, key, val)
  hash.delete(key)
  hash.select { |_k, v| !v[:children].nil? && v[:children].include?(key) }
      .map { |_k, v| v[:children].delete(key) && v[:children].push(val[:weight]) && v[key] = val[:weight] }
  hash
end

def update_weight(hash, key, val)
  hash[:answer] = TRUE if val[:children].uniq.size > 1
  hash[key][:weight] = val[:weight] + val[:children].inject(:+)
  hash[key].delete(:children)
  hash
end

def parent_hash(line)
  arr = line.split('->')
  key, value = top_hash(arr[0])
  value[:children] = arr[1].split(',')
  [key, value]
end

def top_hash(line)
  key = ''
  value = {}
  /([a-z]+)\((\d+)/.match(line) do
    key = $1
    value = { weight: $2.to_i }
  end
  [key, value]
end

# p one(input)
p two(input)
