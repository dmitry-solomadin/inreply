class PasswordsController < Devise::PasswordsController
  layout "public"

  def create
    self.resource = resource_class.send_reset_password_instructions(params[resource_name])

    if successfully_sent?(resource)
      flash.now[:success] = t "passwords.reset_success"
      respond_to do |format|
        format.html { render :location => after_sending_reset_password_instructions_path_for(resource_name) }
        format.js { render layout: false }
      end
    else
      flash.now[:failure] = t "passwords.no_such_user"
      respond_to do |format|
        format.html { redirect_to new_user_session_path }
        format.js { render layout: false }
      end
    end
  end

end