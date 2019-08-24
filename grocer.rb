def consolidate_cart(cart)
  new_hash = Hash.new
  
  cart.each do |item|
  item_key = item.keys[0]
   if new_hash.key?(item_key)
    count = new_hash[item_key][:count]
    new_hash[item_key][:count] = count + 1


   else
    item_value = item[item_key]
    item_value[:count] = 1
    new_hash[item_key] = item_value
   end

  end
  return new_hash

end  


def apply_coupons(cart, coupons)
  coupons.each do |coupon|

    if cart.has_key?(coupon[:item])
      g_item = coupon[:item]
      g_count = cart[g_item][:count]

      if (g_count % coupon[:num]) == 0
        cart[g_item + " W/COUPON"] = {
          :price => (coupon[:cost] / coupon[:num]).round(2),
          :clearance => cart[g_item][:clearance],
          :count => g_count
        }

        cart[g_item][:count] = 0

      elsif cart[g_item][:count] > coupon[:num]
        extra = g_count % coupon[:num]
        cart[g_item][:count] = extra
        cart[g_item + " W/COUPON"] = {
          :price => (coupon[:cost] / coupon[:num]).round(2),
          :clearance => cart[g_item][:clearance],
          :count => g_count - extra
        }

      end
    end
  end

  return cart
end

def apply_clearance(cart)
  cart.each do |key, value|
    if value[:clearance]
      cart[key][:price] = (cart[key][:price] * 0.8).round(2)
    end
  end

  return cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  coupon_applied_cart = apply_coupons(consolidated_cart, coupons)
  clearance_applied_cart = apply_clearance(coupon_applied_cart)
  
  total = 0.0
  
  clearance_applied_cart.each do |key, value|
    total += (clearance_applied_cart[key][:price] * clearance_applied_cart[key][:count])
  end
  
  if total > 100
    return (total * 0.9).round(2)
  else
    return total.round(2)
  end
end
