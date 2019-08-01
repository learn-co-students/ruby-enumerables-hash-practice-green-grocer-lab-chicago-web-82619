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
  # code here
end

def checkout(cart, coupons)
  # code here
end


