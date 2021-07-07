require 'pry'

# cart = [
#   {"AVOCADO" => {:price => 3.00, :clearance => true }},
#   {"AVOCADO" => {:price => 3.00, :clearance => true }},
#   {"KALE"    => {:price => 3.00, :clearance => false}}
# ]

def consolidate_cart(cart)
  new_cart = Hash.new
  cart.each do |item| #{"TEMPEH"=>{:price=>3.0, :clearance=>true}
    item.each do |name, properties|
      if new_cart.include?(name)
        new_cart[name][:count] += 1
      else
        new_cart[name]=
          {
            price: properties[:price],
            clearance: properties[:clearance],
            count: 1
          }
          # binding.pry
      end
    end
# binding.pry
  end
  new_cart
end

def apply_coupons(cart, coupons)
  # binding.pry
  coupons.each do |coupon|
    coupon_item = coupon[:item]
    if cart.keys.include? coupon_item
# binding.pry
        if cart[coupon_item][:count] >= coupon[:num]
          discounted_item = "#{coupon_item} W/COUPON"
          if cart[discounted_item]
            cart[discounted_item][:count] += coupon[:num]
          else
            # binding.pry
            cart[discounted_item] = {
              count: coupon[:num],
              price:  coupon[:cost]/coupon[:num],
              clearance: cart[coupon_item][:clearance]
            }
          end
          cart[coupon_item][:count] -= coupon[:num]
      end
    end
  end
  cart
end


def apply_clearance(cart)
  cart.each do |item, properties|
      if properties[:clearance]
        properties[:price] = properties[:price] - (properties[:price] * 0.2)
      end
  end
  cart
end

def checkout(cart, coupons)
    # binding.pry
  new_cart = consolidate_cart(cart)
  new_cart_w_coupons = apply_coupons(new_cart, coupons)
  # binding.pry
  final_cart = apply_clearance(new_cart_w_coupons)
  
  total = 0
  
  final_cart.each do |item, properties|
    total = total + (properties[:price] * properties[:count])
  end

  if total >= 100
     total = total - (total * 0.1)
  end
  
total
end

