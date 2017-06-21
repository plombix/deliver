class DeliveryRouter
  require_relative 'customer'
  require_relative 'restaurant'
  require_relative 'rider'

  

  def initialize(restaurants, customers, riders)
    curated_params(restaurants, customers, riders)
    @restaurants = restaurants
    @customers = customers
    @riders = riders
  end

  def add_order(param)
  	
  end

  def clear_orders(param)
  	[]
  end

  def route(param)
  	[]
  end

  def delivery_time(param)
  	[]
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
