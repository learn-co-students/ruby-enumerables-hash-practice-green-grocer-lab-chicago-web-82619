def consolidate_cart(cart)
  consolidated_cart = {}
  # if cart.length
    cart.each do |item|
        if !consolidated_cart[item.keys[0]]
            consolidated_cart[item.keys[0]] = {
                price: item.values[0][:price],
                clearance: item.values[0][:clearance],
                count: 1
            }
        else
            consolidated_cart[item.keys[0]][:count] += 1
        end
    end
# else
#     p "Nothing is in the cart"
# end
consolidated_cart
end

{
  "AVOCADO" => {:price => 3.00, :clearance => true, :count => 3},
  "KALE"    => {:price => 3.00, :clearance => false, :count => 1}
}
cpn = [
  {:item => "AVOCADO", :num => 2, :cost => 5.00},
  {:item => "BEER", :num => 2, :cost => 20.00},
  {:item => "CHEESE", :num => 3, :cost => 15.00}
]

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include?(coupon[:item])
        if cart[coupon[:item]][:count] >= coupon[:num]
            coupon_name = "#{coupon[:item]} W/COUPON"
            if cart[coupon_name]
              cart[coupon_name][:count] += coupon[:num]
            else
              cart[coupon_name] = {
                price: coupon[:cost]/coupon[:num],
                clearance: cart[coupon[:item]][:clearance],
                count: coupon[:num]
              }
            end
            cart[coupon[:item]][:count] -= coupon[:num]
        end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.keys.each do |item|
    if cart[item][:clearance]
      cart[item][:price] = (cart[item][:price] * 0.80).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  sum = 0

  consolidated_cart = consolidate_cart(cart)
  applied_coupons = apply_coupons(consolidated_cart, coupons)
  applied_clearance = apply_clearance(applied_coupons)

  applied_clearance.keys.each do |item|
    sum += applied_clearance[item][:price] * applied_clearance[item][:count]
  end
  
  if sum > 100
    sum = (sum * 0.90).round
  else
    sum 
  end
end

