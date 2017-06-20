class Rider
  PARAMS = [
    :id,
    :speed,
    :x,
    :y
  ].freeze

  attr_accessor :id, :speed, :x, :y

  def initialize(args)
    validate(args)
    @id = args[:id]
    @speed = args[:speed]
    @x = args[:x]
    @y = args[:y]
  end

  def check_form
    args = {}
    args[:id] = id
    args[:x] = x
    args[:y] = y
    args[:speed] = speed
    validate(args)
  end

  private

  def validate(args)
    if args.keys.sort == PARAMS.sort
      unless Float(args[:x]) &&
             Float(args[:y]) &&
             Float(args[:id]) &&
             Float(args[:speed])
        fail "Wrong Rider params type: #{args}"
      end
    else
      fail "Illformed Rider params: #{args}"
    end
  end
end
