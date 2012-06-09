class RegistrationsController < Devise::RegistrationsController
  layout "public"

  def new
    @account = Account.new
    @account.users<<User.new
    @account.locations<<Location.new

    render 'new'
  end

  # figure out why client_side_validation doesn't want to validate nested forms.
  def create
    account = Account.new
    @user = User.new_with_session params[:account][:user], session
    account.users<<@user

    if params[:location]
      params[:location].each_value do |loc_params|
        loc = Location.new loc_params
        account.locations<<loc
      end
    else
      location = Location.new params[:account][:location]
      account.locations<<location
    end

    @saved_models = Array.new
    @saved_models<<account.locations
    @saved_models<<account.users
    @saved_models.flatten!

    return create_fail unless account.save

    if @user.active_for_authentication?
      set_flash_message :notice, :signed_up if is_navigational_format?
      sign_in(resource_name, resource)
      respond_with @user, :location => after_sign_up_path_for(@user)
    else
      set_flash_message :notice, :"signed_up_but_#{@user.inactive_message}" if is_navigational_format?
      expire_session_data_after_sign_in!
      respond_with @user, :location => after_inactive_sign_up_path_for(@user)
    end
  end

  def create_fail
    clean_up_passwords resource

    respond_to do |format|
      format.html { render 'new' }
      format.js { render layout: false }
    end
  end

end