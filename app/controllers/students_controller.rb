class StudentsController < ApplicationController

   before_action :authenticate_user!

  def index
  end

  def show
     @student = Student.find params[:student_id]
     @classes = Classgroup.where(user_id: params[:user_id])
     @classgroup = params[:classgroup_id]
     @assignment = Assignment.where(student_id: params[:student_id]).sort_by("created_at" desc)
  end

  def create
     @student = Student.new params.require(:student).permit(:firstname, :lastname)
     @student.user_id = @current_user.id
     @student.classgroup_id = params[:classgroup_id]

      if @student.save
            redirect_to user_classgroup_path(id: @student.classgroup_id),  :notice => "Your Class was saved"
      else
            render "new"
      end
  end

  def new
     @student = params[:user_id]
     @classgroup = params[:classgroup_id]
  end
end
