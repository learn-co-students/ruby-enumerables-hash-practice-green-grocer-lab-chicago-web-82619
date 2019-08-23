def consolidate_cart(cart)
  cart.reduce({}) { |hash, item|
    item.reduce(hash) { |hash, (name, value)|
      if hash[name]
        hash[name][:count] += 1
      else
        hash[name] = value
        hash[name][:count] = 1
      end
      hash
    }
  }
end

def apply_coupons(cart, coupons)
  coupons.each { |coupon|
    item = coupon[:item]
    if cart[item]
      num_on_deal = coupon[:num]
      cost_on_deal = coupon[:cost]
      num_in_cart = cart[item][:count]

      if num_on_deal <= num_in_cart
        if cart[item + " W/COUPON"]
          cart[item + " W/COUPON"][:count] += num_on_deal
        else
          cart[item + " W/COUPON"] = {
            price: cost_on_deal / num_on_deal,
            clearance: cart[item][:clearance],
            count: num_on_deal
          }
        end
      cart[item][:count] -= num_on_deal
      end
    end
  }
  return cart
end

def apply_clearance(cart)
  cart.reduce(cart) { |cart, (name, value)|
    if value[:clearance]
      value[:price] = (value[:price] * 0.8).round(2)
    end
    cart
  }
end

def checkout(cart, coupons)
  processed_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  total = processed_cart.reduce(0) {|total, (item, value)|
    total += value[:price] * value[:count]
  }
  total > 100 ? (total * 0.9).round(2) : total
end
