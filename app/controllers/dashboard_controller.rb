class DashboardController < ApplicationController

   before_action :authenticate_user!

  def index
     @classes = Classgroup.all
     @students = Student.all

     #top 5 students
     @filteredstudents = []
     @students.each do |s|
        unless s.average.nan?
           @filteredstudents << s
        end
     end


     #Assignments Widgets
     @graded = Assignment.where.not(grade: nil)
     @ungraded = Assignment.where grade: nil
     #--------------------
  end

  def show
  end
end
