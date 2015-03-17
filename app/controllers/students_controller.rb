class StudentsController < ApplicationController

   before_action :authenticate_user!

  def index
  end

  def show
  end

  def create
     @Student = Student.new params.require(:student).permit(:firstname, :lastname)
     @Student.user_id = @current_user.id
     @Student.classgroup_id = params[:classgroup_id]

      if @Student.save
            redirect_to user_classgroup_path(id: @Student.classgroup_id),  :notice => "Your Class was saved"
      else
            render "new"
      end
  end

  def new
     @student = params[:user_id]
     @classgroup = params[:classgroup_id]
  end
end
