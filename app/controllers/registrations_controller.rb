class RegistrationsController < Devise::RegistrationsController
    
    def new
      super
    end

    def create
        @user = User.new(users_params)
        if @user.save
            # session[:id] = @user.id
            redirect_to new_user_session_path
        else
            render :new
        end
    end

    private
    def users_params
        params.require(:user).permit(:email, :password, :password_confirmation, :admin)
    end
end
