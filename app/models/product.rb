class Product < ActiveRecord::Base
	has_many :pictures, dependent: :destroy
	accepts_nested_attributes_for :pictures, allow_destroy: true,  :reject_if => lambda{ |a| a["img"].nil? }
end
