require "spec_helper"

describe "first testing" do
	it "adds to database" do
		@product = FactoryGirl.create(:product)
		visit root_path
		attach_file "file", File.join(Rails.root, "/spec/support/example.jpg")
		click_link "Add More"
		#click_button "Save"
	end
end