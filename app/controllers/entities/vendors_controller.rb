class VendorsController < EntitiesController

  def index
    @vendors = Vendor.order(created_at: :desc)

    respond_with @vendors do |format|
      format.xls { render layout: 'header' }
      format.csv { render csv: @vendors }
      format.pdf do
        pdf = VendorPdf.new(@vendors)
        send_data pdf.render, filename: 'vendors.pdf', type: 'application/pdf', disposition: 'inline'
      end
    end
  end

  def show
    respond_with(@vendor)
  end

  def new
    @vendor.attributes = { user: current_user, access: Setting.default_access, assigned_to: nil }
    if params[:related]
      model, id = params[:related].split('_')
      if related = model.classify.constantize.my(current_user).find_by_id(id)
        instance_variable_set("@#{model}", related)
      else
        respond_to_related_not_found(model) && return
      end
    end

    respond_with(@vendor)
  end

  def create
    @comment_body = params[:comment_body]
    respond_with(@vendor) do |_format|
      if @vendor.save_with_permissions(params.permit!)
        @vendor.add_comment_by_user(@comment_body, current_user)
      end
    end
  end

  def edit
    if params[:previous].to_s =~ /(\d+)\z/
      @previous = Vendor.my(current_user).find_by_id(Regexp.last_match[1]) || Regexp.last_match[1].to_i
    end
    
    respond_with(@vendor)
  end

  def update
    respond_with(@vendor) do |_format|
      # Must set access before user_ids, because user_ids= method depends on access value.
      @vendor.access = resource_params[:access] if resource_params[:access]
      @vendor.update_vendor(resource_params)
      # if @vendor.update_with_lead_counters(resource_params)
      #   update_sidebar
      # else
      #   @campaigns = Campaign.my(current_user).order('name')
      # end
    end
  end

  def destroy
    @vendor.destroy  
    respond_with(@vendor) 
  end
end


