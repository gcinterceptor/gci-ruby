class Gci
	def initialize app
		@app = app
		GC.disable
		puts "==< Automatic GC Disabled <=="	
	end	

	def call env
		case env["HTTP_GCI"]
			when "ch"
				# Some references.
				# http://tmm1.net/
				# https://www.speedshop.co/2017/03/09/a-guide-to-gc-stat.html
				old_objects = GC.stat[:old_objects]
				live_slots = GC.stat[:heap_live_slots]
				gen1 = (live_slots - old_objects) * GC::INTERNAL_CONSTANTS[:RVALUE_SIZE]
				gen2 = old_objects * GC::INTERNAL_CONSTANTS[:RVALUE_SIZE] 
				[200, {}, [gen1.to_s+"|"+gen2.to_s]]

			when "gen1"
				GC.enable
				GC.start(full_mark:false)
				GC.disable
				[200, {}, []]

			when "gen2"
				GC.enable
				GC.start(full_mark:true)
				GC.disable
				[200, {}, []]

			else
				@app.call env
		end  
	end
end