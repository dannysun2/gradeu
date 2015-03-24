class Assignment < ActiveRecord::Base
   belongs_to :user
   belongs_to :classgroup
   belongs_to :student

   validates :name, :weight, presence: true
   # validates :weight, presence: true, :numericality => {:greater_than => 0, :less_than => 100}
end
