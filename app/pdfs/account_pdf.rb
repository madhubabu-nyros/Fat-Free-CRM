class AccountPdf < Prawn::Document
	def initialize(accounts)
		super()
		@accounts = accounts
		account_list
	end

	def account_list
		move_down 20
		table account_list_rows do
			row(0).font_style = :bold
		end
	end

	def account_list_rows
		[["Name", "Email", "Phone"]] + 
		@accounts.map do |account|
			[account.name, account.email, account.phone]
		end
	end
end