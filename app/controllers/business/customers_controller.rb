class Business::CustomersController < ApplicationController
  before_action :set_customer, only: %i[ edit update ]

  # GET /customers or /customers.json
  def index
    @customers = Customer.all
    if flash[:alert]
      flash[:alert].clear
    end
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers or /customers.json
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to customers_path, notice: "Customer was successfully created." }
        format.json { render :index, status: :created, location: @customer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1 or /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to customers_path, notice: "Customer was successfully updated." }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def search
    if params[:search].length < 3
      flash[:notice] = "enter atleast 3 characters to search!"
      redirect_to(:action => :index) and return
    end
    
    @customers = Customer.where("customer_name LIKE '%#{params[:search]}%'")
    if @customers.empty?
      redirect_to customers_path, alert: "No result found"
    end
  end

  def get_destroy
    @customers = Customer.select(:customer_name)
    @cus = Array.new
    @customers.each do |c|
      @cus.push(c.customer_name)
    end
  end

  def post_destroy
    @customer = Customer.find_by(customer_name: params[:customer_name])
    @customer.destroy
    redirect_to customers_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def customer_params
      params.require(:customer).permit(:customer_name)
    end
end
