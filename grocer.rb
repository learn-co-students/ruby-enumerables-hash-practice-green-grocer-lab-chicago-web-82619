def consolidate_cart(cart)
  # code here
  keyarray= []
  emptyHash = {}
    cart.each do |eachcart|
    eachcart.reduce({}) do |memo, (key, value)|
    keyarray.push(key)
    emptyHash[key] = value
    end
  end
  keyarray.each do |eachkey|
    emptyHash[eachkey][:count] = keyarray.count(eachkey)
  end
  emptyHash
end

def apply_coupons(cart, coupons)
  # code here
  emptyHash2 = cart
  coupons.length.times do |index|
    oldkey = coupons[index][:item]
    if emptyHash2[oldkey]
    itemcount = emptyHash2[oldkey][:count]
    cost_per_item = (coupons[index][:cost])/(coupons[index][:num])
    eligible_item_count = itemcount/coupons[index][:num]
    eligible_item_counts =eligible_item_count* coupons[index][:num]
    ineligible_item_count = itemcount%coupons[index][:num]
    new_key = oldkey + " W/COUPON"
    if eligible_item_count >0 
      emptyHash2[new_key]= {:price => cost_per_item, :clearance => emptyHash2[oldkey][:clearance], :count =>eligible_item_counts }
    end
    emptyHash2[oldkey][:count] = itemcount - eligible_item_counts
      #emptyHash2[oldkey][:count] = ineligible_item_count
    
  end
  end
  emptyHash2
end

def apply_clearance(cart)
  # code here
  emptyHash3 = cart
  emptyHash3.each do |(key,value)|
    if value[:clearance]
      emptyHash3[key][:price] = (emptyHash3[key][:price] * 0.8).round(2)
    end
  end
  emptyHash3
end

def checkout(cart, coupons)
  # code 
  price = 0 
  consolidatedcart = consolidate_cart(cart)
  appliedcoupon = apply_coupons(consolidatedcart,coupons)
  appliedclearance = apply_clearance(appliedcoupon)
  appliedclearance.each do |(key,value)|
    price += appliedclearance[key][:price] * appliedclearance[key][:count]
  end
  if price>100
    price = (price *0.9).round(2)
  end
  price
end










