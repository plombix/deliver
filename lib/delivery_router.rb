# Delivery router ensure basic behavior of order assignment  to riders.
# The class has been construct with a micro-service type of design 
# to ensure reliance and stability over scaling .
# However some refactorisation over those multiples select methods
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
    customer = @customers.select { |x| x.id == param[:customer] }[0]
    restaurant = @restaurants.select { |x| x.id == param[:restaurant] }[0]
    rider = @riders.select { |x| x.id == nearest_rider(restaurant) }[0]
    # create route
    @routes << Hash['rider'.to_sym, rider.id,
                    'route'.to_sym, [restaurant, customer]]
  end

  def clear_orders(param)
    # clear elem
    @routes.delete_if { |x| x[:route][1].id == param[:customer] }
  end

  def route(param)
    # return empty array or specified route
    route = @routes.select { |x| x[:rider] == param[:rider] }
    route.empty? ? [] : route[0][:route]
  end

  def delivery_time(param)
    # get time for rider to get to restaurant
    # get time for restaurant to cook
    # and determine who will be the longest
    # then sum that up with time needed to reach customer
    time_to_meal(param) + time_to_customer(param)
  end

  def time_to_meal(param)
    rider = @riders.select { |x| x.id == rider_for(param) }[0]
    restau = restau_for(param)
    t_rider = distance(rider, restau) * 1 / rider.speed
    t_cook = restau.cooking_time
    t_cook > t_rider ? t_cook : t_rider
  end

  def rider_for(param)
    # find rider assigned to client
    route = @routes.select { |x| x[:route][1].id == param[:customer] }
    route.empty? ? [] : route[0][:rider]
  end

  def restau_for(param)
    # find restaurant of customer's order
     @routes.select { |x| x[:route][1].id == param[:customer] }[0][:route][0]
  end

  def time_to_customer(param)
    # return time to customer from restaurant
    rider = @riders.select { |x| x.id == rider_for(param) }[0]
    restau = restau_for(param)
    customer = @customers.select { |x| x.id == param[:customer] }[0]
    distance(restau, customer) * 1 / rider.speed
  end

  def distance(orig, dest)
    # only basic math to return straight line distance
    Math.sqrt((dest.x - orig.x)**2 + (dest.y - orig.y)**2)
  end

  def nearest_rider(restau)
    # find the right rider at this time
    distances = @riders.map { |x| [x.id, distance(x, restau)] }
    distances.sort_by { |a| a[1] }.first[0]
  end

  private

  # basic argument verification (type, parameters..)

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
      raise "Wrong type of params during creation of #{self.class}"
    end
  end
end
