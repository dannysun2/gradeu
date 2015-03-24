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

     @classrooms = Classgroup.all

     #Assignments Widgets
     @assignments = Assignment.all
     @graded = Assignment.where.not(grade: nil)
     @ungraded = Assignment.where grade: nil
     @progress = (@graded.count/(@graded.count + @ungraded.count)) * 100
     #--------------------
  end

  def show
  end
end
