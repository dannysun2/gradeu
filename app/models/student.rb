class Student < ActiveRecord::Base
   belongs_to :user
   belongs_to :classgroup

   def average
      @assignment = Assignment.where student_id: self.id
      tpercent = 0
      sum = 0
      @assignment.each do |a|
         if a.grade != nil && a.weight != nil
            sum = sum + (a.grade * (a.weight / 100.00))
            tpercent = tpercent + a.weight
         end
      end
      return (sum * 100.00/tpercent).round(1)
   end

end
