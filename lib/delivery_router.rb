class DeliveryRouter
  require_relative 'customer'
  require_relative 'restaurant'
  require_relative 'rider'

  

  def initialize(restaurants, customers, riders)
    curated_params(restaurants, customers, riders)
    @restaurants = restaurants
    @customers = customers
    @riders = riders
    @routes = @routes ||= []
  end

  def add_order(param)
    # re-assign arguments to actual objects
    customer = @customers.select{|x| x.id == param[:customer] }[0]
    restaurant = @restaurants.select{|x| x.id == param[:restaurant] }[0]
    rider =  @riders.select{|x| x.id ==  nearest_rider(restaurant)}[0]
    @routes <<  Hash['rider'.to_sym, rider.id ,
                      'route'.to_sym,  [restaurant, customer ]] 
  end

  def clear_orders(param)
    @routes.delete_if { |x|  x[:route][1].id == param[:customer]}  
  end

  def route(param)
  	route = @routes.select{|x| x[:rider] == param[:rider]}
  	route.empty? ? [] : route[0][:route]
  end

  def delivery_time(param)
  	[]
  end
  
  def distance(orig, dest)
    # only basic math to return straight line distance 
    Math.sqrt((dest.x - orig.x)**2 + (dest.y - orig.y)**2 )
  end

  def nearest_rider (restau)
   # find the right rider at this time 
   distances = @riders.map{|x| [x.id, distance(x, restau)]}
   distances.sort{|x, y| x[1] <=> y[1]}.first[0]
  end



  private

  def chk_riders?(opt)
    opt.each do |x|
      x.check_form if x.instance_of?(Rider)
    end
  end

  def chk_customers?(opt)
    opt.each do |x|
      x.check_form if x.instance_of?(Customer)
    end
  end

  def chk_restaurants?(opt)
    opt.each do |x|
      x.check_form if x.instance_of?(Restaurant)
    end
  end

  def curated_params(restaurants, customers, riders)
    chk_restos = chk_restaurants?(restaurants)
    chk_riders = chk_riders?(riders)
    chk_customers = chk_customers?(customers)
    unless chk_restos && chk_riders && chk_customers
      fail "Wrong type of params during creation of #{self.class}"
    end
  end
end
