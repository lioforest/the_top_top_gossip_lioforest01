class City < ApplicationRecord

	has_many :users

	validates :name, 
	    presence: true,
		length: { in: 2..40 }
	validates :zip_code, 
	    presence: true,
  		length: { is: 5 }
  		
end
