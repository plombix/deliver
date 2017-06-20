class Restaurant
	PARAMS = [
		:id,
		:cooking_time,
		:x,
		:y
	]

	def initialize(args)
		validate(args)
		@id = args[:id]
		@cooking_time =args[:cooking_time]
		@x =args[:x]
		@y =args[:y]
	end

		private:
		def validate(args)
		if args.keys == PARAMS
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