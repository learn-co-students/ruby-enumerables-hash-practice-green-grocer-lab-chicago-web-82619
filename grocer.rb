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
  #cart is defined => {"AVOCADO"=>{:price=>3.0, :clearance=>true, :count=>2}}
  #coupons => [{:item=>"AVOCADO", :num=>2, :cost=>5.0}]
  math=nil
  cart.each do |item| 
    item.each do |name, properties|    
      if coupons.include?(name)
        cart[name + "W/COUPON"]=
          {
            price: properties[:price],
            clearance: properties[:clearance],
            count: 1        }
      end
    end
  end
  # binding.pry
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
