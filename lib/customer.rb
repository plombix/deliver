class Customer


	PARAMS= [:id,
			:x,
			:y]

	def initialize(args)
		validate(args)
		@x = args[:x]
		@y = args[:y]
		@id = args[:id]
	end

	private:

	def validate(args)
		if args.keys == PARAMS
			unless Float(args[:x]) && Float(args[:y]) && Float(args[:id])
				raise "Wrong Customer params type: #{args}"
			end
		else
			raise "Illformed Customer params: #{args}"
		end
	end
	
end