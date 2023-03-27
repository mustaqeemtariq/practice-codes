def running_sum(arr)
  sum = 0
  arr.map { |i| sum += i }
end

arr = [2, 4, 5, 3, 6]

puts running_sum(arr)
