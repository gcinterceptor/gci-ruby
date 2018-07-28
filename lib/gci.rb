class Gci
	def initialize app
		@app = app
		GC.disable	
	end	

	def call env
		case env["HTTP_GCI"]
			when "ch"
				@s = GC.stat
				[200, {}, [@s[:malloc_increase_bytes].to_s+"|"+@s[:oldmalloc_increase_bytes].to_s]]

			when "gen1"
				GC.start(full_mark:false)
				[200, {}, []]

			when "gen2"
				GC.start(full_mark:true)
				[200, {}, []]

			else
				@app.call env
		end  
	end
end