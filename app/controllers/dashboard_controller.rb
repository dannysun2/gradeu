class DashboardController < ApplicationController

   before_action :authenticate_user!

  def index
     classes = Classgroup.all
  end

  def show
  end
end
