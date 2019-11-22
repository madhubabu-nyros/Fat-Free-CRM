class Vendor < ApplicationRecord
	belongs_to :user
	sortable by: ["name ASC", "email ASC", "phone ASC", "created_at DESC", "updated_at DESC"], default: "created_at DESC"
	belongs_to :assignee, class_name: "User", foreign_key: :assigned_to
	has_many :product_lists
  has_many :products, through: :product_lists

  validates :name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone,:presence => true,
                 :numericality => true
  uses_user_permissions 
	uses_comment_extensions
  has_fields
  has_one :business_address, -> { where "address_type='Business'" }, dependent: :destroy, as: :addressable, class_name: "Address"
	has_paper_trail class_name: 'Version', ignore: [:subscribed_users]
	
	def save_with_permissions(params)
    self.attributes = params.require(:vendor).permit(:user_id, :name, :email, :phone, :product, { product_ids: [] }, :product_ids)
    save
  end

  def update_vendor(attributes)
    self.attributes = attributes
    save
  end

  def self.tagged_with(name)
    Product.find_by!(name: name).vendors
  end

  def self.tag_counts
    Product.select('products.*, count(product_lists.tag_id) as count').joins(:product_lists).group('product_lists.product_id')
  end

  def tag_list
    products.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.products = names.split(',').map do |n|
      Product.where(name: n.strip).first_or_create!
    end
  end


	ActiveSupport.run_load_hooks(:fat_free_crm_vendor, self)
end