# frozen_string_literal: true

xml.Worksheet 'ss:Name' => I18n.t(:tab_vendors) do
  xml.Table do
    unless @vendors.empty?
      # Header.
      xml.Row do
        heads = [I18n.t('id'),
                 I18n.t('name'),
                 I18n.t('email'),
                 I18n.t('phone'),
                 I18n.t('products')]

        # Append custom field labels to header
        Vendor.fields.each do |field|
          heads << field.label
        end

        heads.each do |head|
          xml.Cell do
            xml.Data head,
                     'ss:Type' => 'String'
          end
        end
      end

      # vendor rows.
      @vendors.each do |vendor|
        xml.Row do
          address = vendor.business_address
          data    = [vendor.id,
                     vendor.name,
                     vendor.email,
                     vendor.phone,
                     vendor.product_lists.map do |v|
                      v.product.name.gsub('["','').gsub('"]','')
                     end 
                    ]

          # Append custom field values.
          Vendor.fields.each do |field|
            data << vendor.send(field.name)
          end

          data.each do |value|
            xml.Cell do
              xml.Data value,
                       'ss:Type' => (value.respond_to?(:abs) ? 'Number' : 'String').to_s
            end
          end
        end
      end
    end
  end
end
