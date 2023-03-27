def freq(array)
  hash = Hash.new(0)
  array.each { |key| hash[key] += 1 }
  hash
end

arr = Array.new(10) { rand(1...9) }
hash = freq arr
puts hash
