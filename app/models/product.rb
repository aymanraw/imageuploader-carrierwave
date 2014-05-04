class Product < ActiveRecord::Base
	has_many :pictures, dependent: :destroy
	accepts_nested_attributes_for :pictures, :reject_if => lambda{ |a| a["img"].nil? }
end
