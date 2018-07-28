class Gci
	def initialize app
		@app = app
		GC.disable	
	end	

	def call(env)
		case env["gci"]	
			when nil
				@app.call env

			when "ch"
				@s = GC.stat
				[200, [], s[:malloc_increase].to_s+"|"+s[:oldmalloc_increase]]

			when "gen1"
				GC.start(full_mark:false)
				head 200

			when "gen2"
				GC.start(full_mark:true)
				head 200

			else
				head 400
		end  
	end
end