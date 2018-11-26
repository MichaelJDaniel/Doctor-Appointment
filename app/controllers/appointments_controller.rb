class AppointmentsController < ApplicationController
  before_action :set_physician
  def index
    @appointments = @physician.appointments.order
  end

  def new
    @users = User.all - @physician.users
    @appointment = @physician.enrollments.new
  end

  def show
    @user = @appointment.user.find(params[:id])
    @physician = @appointment.physician.find(params[:physician_id])
  end

  def create
    @appointment = @physician.appointments.new(appointment_params)
    if @appointment.save
      redirect_to physician_appointments_path
    else
      render :new
    end
  end

  def destroy
    @physician.appointments.find(params[:id]).destroy
    redirect_to physician_appointments_path
  end


  private
    
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    def set_doctor
      @physician = Physician.find(params[:physician_id])
    end

    def set_users
      @users = (User.all.order - @physician.users)
    end

    def appointment_params
      params.require(:appointment).permit(:patient_id)
    end
end


