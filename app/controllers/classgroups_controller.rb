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
   end
end
