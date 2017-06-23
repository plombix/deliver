require_relative './lib/delivery_router'
require_relative './lib/customer'
require_relative './lib/restaurant'
require_relative './lib/rider'
require 'pry'

@customers = [
  Customer.new(id: 1, x: 1, y: 1),
  Customer.new(id: 2, x: 5, y: 1)
]

@restaurants = [
  Restaurant.new(id: 3, cooking_time: 15, x: 0, y: 0),
  Restaurant.new(id: 4, cooking_time: 35, x: 5, y: 5)
]

@riders = [
  Rider.new(id: 1, speed: 10, x: 2, y: 0),
  Rider.new(id: 2, speed: 10, x: 1, y: 0)
]
@delivery_router = DeliveryRouter.new(@restaurants, @customers, @riders)
@delivery_router.add_order(customer: 1, restaurant: 3)
@delivery_router.clear_orders(customer: 2)
 route = @delivery_router.route(rider: 2)
puts @delivery_router.inspect
puts @customers.inspect
puts @riders.inspect
puts @restaurants.inspect