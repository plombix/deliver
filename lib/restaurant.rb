# Restaurant
class Restaurant
  PARAMS = %i[
    id
    cooking_time
    x
    y
  ].freeze

  attr_accessor :id, :cooking_time, :x, :y

  def initialize(args)
    validate(args)
    @id = args[:id]
    @cooking_time = args[:cooking_time]
    @x = args[:x]
    @y = args[:y]
  end

  def check_form
    # check attributes from outside of class
    args = {}
    args[:id] = id
    args[:x] = x
    args[:y] = y
    args[:cooking_time] = cooking_time
    validate(args)
  end

  private

  # basic argument verification (type, parameters..)

  def validate(args)
    if args.keys.sort == PARAMS.sort
      unless Float(args[:x]) &&
             Float(args[:y]) &&
             Float(args[:id]) &&
             Float(args[:cooking_time])
        raise "Wrong Restaurant params type: #{args}"
      end
    else
      raise "Illformed Restaurant params: #{args}"
    end
  end
end
