class Rider
	PARAMS= [
		:id ,
		 :speed ,
		 :x ,
		 :y
	]

	def initialize(args)
		validate(args)
		@id  = args[:id ]
		@speed  = args[:speed ]
		@x  = args[:x ]
		@y = args[:y]	
	end

	private:

	def validate(args)
		if args.keys == PARAMS
			unless Float(args[:x]) && 
				   Float(args[:y]) &&
				   Float(args[:id]) &&
				   Float(args[:speed])
				raise "Wrong Rider params type: #{args}"
			end
		else
			raise "Illformed Rider params: #{args}"
		end
	end
	
end