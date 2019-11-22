class ContactPdf < Prawn::Document
	def initialize(contacts)
		super()
		@contacts = contacts
		contact_list
	end

	def contact_list
		move_down 20
		table contact_list_rows do
			row(0).font_style = :bold
		end
	end

	def contact_list_rows
		[["Name", "Email", "Phone"]] + 
		@contacts.map do |contact|
			[contact.name, contact.email, contact.phone]
		end
	end
end