class DashboardController < ApplicationController

   before_action :authenticate_user!

  def index
     @classes = Classgroup.where user_id: @current_user.id
     @students = Student.where user_id: @current_user.id

     #top 5 students
     @filteredstudents = []
     @students.each do |s|
        unless s.average.nan?
           @filteredstudents << s
        end
     end

     #Assignments Widgets
     @assignments = Assignment.where user_id: @current_user.id
     @graded = @assignments.where.not(grade: nil)
     @ungraded = @assignments.where grade: nil
     @progress = @graded.count/(@graded.count + @ungraded.count).to_f
     #--------------------
  end

  def show
  end
end
