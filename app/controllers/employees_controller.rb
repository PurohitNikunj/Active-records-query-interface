class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[ show edit update destroy ]

  # GET /employees or /employees.json
  def index
    @employees = Employee.all
  end

  # GET /employees/1 or /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
    @employee.employee_addresses.build
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees or /employees.json
  def create
    @employee = Employee.new(employee_params)
    @employee.document = params[:employee][:document].original_filename
    cricket = params[:employee][:cricket]
    volley = params[:employee][:volleyball]
    tt = params[:employee][:table_tennis]
    if cricket == "1"
      @employee.hobbies.push('cricket')
    end
    if volley == "1" 
      @employee.hobbies.push('volleyball')
    end
    if tt == "1"
      @employee.hobbies.push('table-tennis')
    end
    # @employee.employee_addresses.build
    # binding.pry

    respond_to do |format|
      if @employee.save
        format.html { redirect_to employee_url(@employee), notice: "Employee was successfully created." }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1 or /employees/1.json
  def update
    @employee.skip = false
    cricket = params[:employee][:cricket]
    volley = params[:employee][:volleyball]
    tt = params[:employee][:table_tennis]
    if cricket == "1"
      if @employee.hobbies.exclude? "cricket"
        @employee.hobbies.push('cricket')
      end
    end
    if volley == "1" 
      if @employee.hobbies.exclude? "volleyball"
        @employee.hobbies.push('volleyball')
      end
    end
    if tt == "1"
      if @employee.hobbies.exclude? "table-tennis"
        @employee.hobbies.push('table-tennis')
      end
    end
    respond_to do |format|
      if @employee.update(edit_employee_params)
        format.html { redirect_to employee_url(@employee), notice: "Employee was successfully updated." }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1 or /employees/1.json
  def destroy
    @employee.destroy

    respond_to do |format|
      format.html { redirect_to employees_url, notice: "Employee was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def get_search
    if flash[:alert]
      flash[:alert].clear
    end
  end

  def post_search
    if params[:query].empty?
      flash[:alert] = "Please enter something!!"
      render :get_search
    end
    @employees = Employee.where("employee_name LIKE '%#{params[:query]}%'")
    if @employees.empty?
      flash[:alert] = "No result found"
      render :get_search
    end
  end

  # private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def employee_params
      params.require(:employee).permit(:employee_name, :email, :password, :password_confirmation, :gender, :hobbies, :mobile_number, :birth_date, :document, employee_addresses_attributes: [:house_name, :street_name, :road])
    end

    def edit_employee_params
      params.require(:employee).permit(:employee_name, :email, :gender, :hobbies, :mobile_number, :birth_date, employee_addresses_attributes: [:id, :house_name, :street_name, :road])
    end
end
