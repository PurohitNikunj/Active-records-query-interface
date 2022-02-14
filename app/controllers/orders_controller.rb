class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders or /orders.json
  def index
    @orders = Order.all
    flash.clear
  end

  def search
      @product = Product.unscoped.select(:id).find_by(title: params[:search])
      if Product.unscoped.select(:id).find_by(title: params[:search]).nil?
        @orders = Order.all
        flash[:alert] = "Sorry!Product with this name doesn't exist"
        render :index
      else
        @orders = Order.where(product_id: @product.id)
      end
  end

  def filter
    flash.clear
  end

  def post_filter 
    
    if params[:max_price].present?
      if params[:max_price] < '0'
        flash[:alert] = "Price can't be negative"
        render :filter
      end
      if params[:min_price].present?
        if params[:min_price] > params[:max_price]
          flash[:alert] = "Min-Price can't be greater than Max-Price"
          render :filter
        end
        @orders = Order.where(status: params[:status]).where("total_price < ?", params[:max_price]).where("total_price > ?", params[:min_price])
      else
        @orders = Order.where(status: params[:status]).where("total_price < ?", params[:max_price])
      end
    
    elsif params[:min_price].present?
      if params[:min_price] < '0'
        flash[:alert] = "Price can't be negative"
        render :filter
      end
      if params[:max_price].present?
        @orders = Order.where(status: params[:status]).where("total_price < ?", params[:max_price]).where("total_price > ?", params[:min_price])
      else
        @orders = Order.where(status: params[:status]).where("total_price > ?", params[:min_price])
      end
    
    else
      @orders = Order.where(status: params[:status])
    end

  end

  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    @p_ids = Array.new {Hash.new}
    @c_ids = Array.new {Hash.new}
    Product.unscoped.select(:id, :title).each do |p|
      @p_ids.push(p.id => p.title)
    end

    Customer.unscoped.select(:id, :fname).each do |c|
      @c_ids.push(c.id => c.fname)
    end
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)
    price = Product.unscoped.select(:price).where("id = #{@order.product_id}")
    @order.total_price = @order.quantity * price[0].price
    respond_to do |format|
      if @order.save
        format.html { redirect_to order_url(@order), notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:quantity, :status, :product_id, :customer_id)
    end
end
