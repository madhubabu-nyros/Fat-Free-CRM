class LeadPdf < Prawn::Document
	def initialize(leads)
		super()
		@leads = leads
		lead_list
	end

	def lead_list
		move_down 20
		table lead_list_rows do
			row(0).font_style = :bold
		end
	end

	def lead_list_rows
		[["Name", "Email", "Phone"]] + 
		@leads.map do |lead|
			[lead.name, lead.email, lead.phone]
		end
	end
end