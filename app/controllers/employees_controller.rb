class EmployeesController < ApplicationController

  def index
    @employees = Employee.all
  end

  def show
    @employee = Employee.find(params[:id])
  end

  # ======== Edit Employee =======
  def edit
    @edit_employee = Employee.find_or_initialize_by(params[:id])
  end

  def update
    @edit_employee = Employee.find(params[:id])
    if @edit_employee.update(employee_params)
      redirect_to
    else
      render :edit, status: :unprocessable_entity
    end
    rescue ActiveRecord::StaleObjectError => errors
      flash[:alert] = "You can't update right now"
      render :edit, status: :unprocessable_entity
  end

  # ======= New Employee ========
  def new
    @new_employee = Employee.new
  end

  def create
    @new_employee = Employee.new(employee_params)
    if @new_employee.save
      flash[:notice] = "Successfully registered new Employee named #{@new_employee.first_name}"
      redirect_to employees_path
    else
      flash[:alert] = "Something was wrong"
      render :new, status: :unprocessable_entity
    end
  end

  # ======= Delete Employee =======
  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    redirect_to employees_path
  end

  # ======= Email-Existance =======
  def new_email_existance
  end

  def create_email_existance
    email = Employee.find_by(email: params[:email])
    if email.present?
      flash[:notice] = "yess user-account exist with this email-id "
      redirect_to employee_path(email)
    else
      flash[:alert] = "Oops!user-account doesn't exist with this email-id"
      render :new_email_existance
    end
  end

  # ======= Query-Set =======
  def queryset
    @employees = Employee.all
  end

  # ====== Increase Order ======
  def inc_order
    employee = Employee.find(params[:id])
    employee.no_of_orders = employee.no_of_orders + 1
    employee.save
    redirect_to employee_path(employee)
  end

  # ======= Decrease Order =======
  def dec_order
    employee = Employee.find(params[:id])
    employee.no_of_orders = employee.no_of_orders - 1
    employee.save
    redirect_to employee_path(employee)
  end

  # ========= Condition-Overriding ========
  def overriding
    @reselect = Employee.select(:first_name, :last_name).reselect(:id).where("id = 10")
  end

  # ======= params method =======
  private
  def employee_params
    params.require(:employee).permit(:id, :first_name, :last_name, :email, :age, :no_of_orders, :full_time_available, :salary, :lock_version)
  end

end
