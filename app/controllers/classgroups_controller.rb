class ClassgroupsController < ApplicationController

   before_action :authenticate_user!

  def new
     @classgroup = Classgroup.new
  end

  def index
  end

  def create
     @classgroup = Classgroup.new params.require(:classgroup).permit(:name)
     @classgroup.user_id = @current_user.id

       if @classgroup.save
            redirect_to dashboard_path,  :notice => "Your Class was saved"
       else
            render "new"
       end
   end

   def show
      @classes = Classgroup.where(user_id: params[:user_id])
      @classgroup = Classgroup.find params[:id]
      @students = Student.where classgroup_id: params[:id]
      @assignments = Assignment.where classgroup: @classgroup

      @grades = {a: 0, b: 0, c: 0, d: 0, f: 0, other: 0}

      @students.each do |s|

         if (s.average >= 90 && s.average.is_a?(Numeric))
            @grades[:a] += 1
         elsif (s.average >= 80 && s.average < 90 && s.average.is_a?(Numeric))
            @grades[:b] += 1
         elsif (s.average >= 70 && s.average < 80 && s.average.is_a?(Numeric))
            @grades[:c] += 1
         elsif (s.average >= 60 && s.average < 70 && s.average.is_a?(Numeric))
            @grades[:d] += 1
         elsif (s.average < 60 && s.average.is_a?(Numeric))
            @grades[:f] += 1
         elsif (s.average.nan?)
            @grades[:other] += 1
         end
      end

   end
end
