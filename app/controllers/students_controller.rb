class StudentsController < ApplicationController

   before_action :authenticate_user!

  def index
  end

  def edit
     @student = Student.find params[:id]
  end

  def show
     @student = Student.find params[:id]
     @classes = Classgroup.where(user_id: params[:user_id])
     @classgroup = params[:classgroup_id]
     @assignment = Assignment.where(student_id: @student.id).order(created_at: :asc)

     # getting the min and max values in an array to prep for highcharts
     @assignments = @assignment.pluck(:name)
     @min = []
     @max = []
     for i in 0..@assignment.count-1
        @c = Assignment.where user_id: @current_user.id, name: @assignments[i], classgroup_id: @classgroup
        @min << @c.minimum(:grade)
        @max << @c.maximum(:grade)
     end
  end

  def create
     @student = Student.new params.require(:student).permit(:firstname, :lastname, :age, :gender)
     @student.user_id = @current_user.id
     @student.classgroup_id = params[:classgroup_id]

      if @student.save
            redirect_to user_classgroup_path(id: @student.classgroup_id),  :notice => "Your Class was saved"
      else
            render "new"
      end
  end

  def new
     @student = Student.new
     @classgroup = params[:classgroup_id]
  end

  def update
     @student = Student.find params[:id]
        if @student.update params.require(:student).permit(:firstname,:lastname,:age,:gender)
           redirect_to user_classgroup_student_path(user_id: @current_user.id, student_id: params[:student_id] )
        else
           render :edit
        end
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    redirect_to user_classgroup_path(id: params[:classgroup_id])
  end

end
