def consolidate_cart(cart)
  # code here
  hash = {}
  cart.each do |el|
    hash[:el][:count] += 1
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
