class StudentsController < ApplicationController

   before_action :authenticate_user!

  def index
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

  @chart = LazyHighCharts::HighChart.new('graph') do |f|
  f.title(:text => "Population vs GDP For 5 Big Countries [2009]")
  f.xAxis(:categories => ["United States", "Japan", "China", "Germany", "France"])
  f.series(:name => "GDP in Billions", :yAxis => 0, :data => [14119, 5068, 4985, 3339, 2656])
  f.series(:name => "Population in Millions", :yAxis => 1, :data => [310, 127, 1340, 81, 65])

  f.yAxis [
    {:title => {:text => "GDP in Billions", :margin => 70} },
    {:title => {:text => "Population in Millions"}, :opposite => true},
  ]

  f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
  f.chart({:defaultSeriesType=>"column"})
   end

end
