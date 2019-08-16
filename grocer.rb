def consolidate_cart(cart)
  # code here
  hash = Hash[*cart.collect{|h| h.to_a}.flatten]
  hash.each do |el,key|
    key[:count] = 0
  end

  cart.each do |el|
    puts hash
    hash[el][:count] += 1 
  end
  
  hash
end

def apply_coupons(cart, coupons)
  # code here
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
