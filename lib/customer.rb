class Customer
  PARAMS = [:id,
            :x,
            :y].freeze

  attr_accessor :id, :x, :y

  def initialize(args)
    validate(args)
    @x = args[:x]
    @y = args[:y]
    @id = args[:id]
  end

  def check_form
    args = {}
    args[:id] = id
    args[:x] = x
    args[:y] = y
    validate(args)
  end

  private

  def validate(args)
    if args.keys.sort == PARAMS.sort
      unless Float(args[:x]) && Float(args[:y]) && Float(args[:id])
        fail "Wrong Customer params type: #{args}"
      end
    else
      fail "Illformed Customer params: #{args}"
    end
  end
end
