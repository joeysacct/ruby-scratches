results = []
N=20
iter = 10000

def explard(n)
  total = 0
  r = rand(1..n)
  
  if r <= n/4
    return r + explard(n)
  else
    return r
  end
end

iter.times do
  results << explard(N)
end
# puts results
exp_val = results.sum.to_f/iter
puts exp_val

