class RegistrationsController < Devise::RegistrationsController
  layout "public"

  def new
    render 'new'
  end

  def create
    user = User.new_with_session params[:account][:user], session
    location = Location.new params[:account][:location]

    @saved_models = Array.new
    @saved_models.push user
    @saved_models.push location

    return create_fail unless user.save & location.save

    if user.active_for_authentication?
      set_flash_message :notice, :signed_up if is_navigational_format?
      sign_in(resource_name, resource)
      respond_with user, :location => after_sign_up_path_for(user)
    else
      set_flash_message :notice, :"signed_up_but_#{user.inactive_message}" if is_navigational_format?
      expire_session_data_after_sign_in!
      respond_with user, :location => after_inactive_sign_up_path_for(user)
    end
  end

  def create_fail
    clean_up_passwords resource
    render 'new'
  end

end