class UsersController < ApplicationController

    def index
        @users = User.all
    end

    def show
        @user = User.unscoped.where(is_active: true)
        @address = Address.select(:address).find_by(user_id: @user[0].id)
        # if EventUser.select(:event_id).where(user_id:@user[0].id, status: 1).present?
            event_user = EventUser.select(:event_id).where(user_id:@user[0].id, status: 1)
            event_ids = Array.new
            event_user.each do |e|
                event_ids.push(e.event_id)
            end
            @joinedevents = Event.find(event_ids)
        # end
    end

    def get_login
        if flash[:alert]
            flash[:alert].clear
        end
    end

    def leave
        @user = User.unscoped.where(is_active: true)
        event_user = EventUser.where(user_id: @user[0].id, event_id: params[:id], status: 1)
        event_user[0].destroy
        event_user[0].save
        redirect_to user_path(@user[0].id)
    end

    def post_login
        user = User.unscoped.find_by(email: params[:username])
        if user.present? && user.authenticate(params[:password])
            User.unscoped.update_all(is_active: false)
            user.update_attribute(:is_active, true)
            redirect_to home_path
        else
            flash[:alert] = "Invalid username OR password"
            render :get_login
        end
    end

    def logout
        user = User.unscoped.find(params[:id])
        user.update_attribute(:is_active, false)
        redirect_to home_path
    end

    def new
        @user = User.new
        @address = Address.new
    end

    def create
        
        @user = User.new(user_params)
        if @user.save
            @address = Address.new(address: params[:address][:address], user_id: @user.id)
            if @address.save
                redirect_to home_path
            else
                render :new, status: :unprocessable_entity
            end
        else
            render :new, status: :unprocessable_entity
        end

    end

    private
    def user_params
        params.require(:user).permit(:fname, :lname, :email, :password, :password_confirmation )
    end

end
