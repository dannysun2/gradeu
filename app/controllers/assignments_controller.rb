class AssignmentsController < ApplicationController

   before_action :authenticate_user!

  def new
     @assignment = Assignment.new
  end

  def edit
     @student = Student.find params[:student_id]
     @assignment = Assignment.find params[:assignment_id]
  end

  def create
     @students = Student.where classgroup_id: params[:classgroup_id]

     @students.each do |s|
        @assignment = Assignment.new params.require(:assignment).permit(:name, :weight)
        @assignment.user_id = @current_user.id
        @assignment.classgroup_id = params[:classgroup_id]
        @assignment.student_id = s.id
        @assignment.save
     end
         redirect_to user_classgroup_path(id: @assignment.classgroup_id),  :notice => "Your Class was saved"
  end

  def update
     @assignment = Assignment.find params[:assignment_id]
        if @assignment.update params.require(:assignment).permit(:grade)
           redirect_to user_classgroup_path(student_id: @student)
        else
           render :edit
        end
  end

end
