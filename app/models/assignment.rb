class Assignment < ActiveRecord::Base
   belongs_to :user
   belongs_to :classgroup
   belongs_to :student
end
