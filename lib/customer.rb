# Customer
class Customer
  PARAMS = %i[id
              x
              y].freeze

  attr_accessor :id, :x, :y

  def initialize(args)
    validate(args)
    @x = args[:x]
    @y = args[:y]
    @id = args[:id]
  end

  def check_form
    # check attributes from outside of class
    args = {}
    args[:id] = id
    args[:x] = x
    args[:y] = y
    validate(args)
  end

  private

  # basic argument verification (type, parameters..)

  def validate(args)
    if args.keys.sort == PARAMS.sort
      unless Float(args[:x]) && Float(args[:y]) && Float(args[:id])
        raise "Wrong Customer params type: #{args}"
      end
    else
      raise "Illformed Customer params: #{args}"
    end
  end
end
