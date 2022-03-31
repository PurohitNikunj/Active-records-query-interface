class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy profile post_profile password post_password]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params) 
    if params[:user][:subscription] == "1"
      @user.checked = true
    end
    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def profile
  end

  def post_profile
    if @user.present? && @user.password == params[:user][:password]
      if @user.update(email:params[:user][:email])
        respond_to do |format|
          format.js
        end
      end
    else
      @user.errors.add(:pwd, "Password doesn't match")
      respond_to do |format|
        format.js
      end
    end

    if params[:user][:subscription_email].present?
      if @user.update(subscription: "1", subscription_email:params[:user][:subscription_email])
        respond_to do |format|
          format.js
        end
      end
    end
  end

  def password
  end

  def post_password
    if @user.password == params[:user][:old_pwd]
      if @user.update(password:params[:user][:new_pwd])
        respond_to do |format|
          format.js 
        end
      end
    else
      @user.errors.add(:old_pwd, "Please enter your correct old password")
      respond_to do |format|
        format.js 
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :subscription, :subscription_email)
    end
end
