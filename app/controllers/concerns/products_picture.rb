module ProductsPicture
	extend ActiveSupport::Concern

	def picture_in
	    render :picture_in, layout: false
	end

	def save_temp_pic
		@temp_pic = PictureTemp.new()
		@temp_pic.public_id = params[:pic]
			respond_to do |format|
		  if @temp_pic.save!
		    format.js {render :template => "shared/save_temp_pic"}
		  end
		end
	end

	def destroy_pic
		@temp_pic = PictureTemp.find(params[:id])
		Cloudinary::Uploader.destroy(@temp_pic.public_id)
		respond_to do |format|
		  if @temp_pic.destroy
		    format.js {render :template => "shared/destroy_pic"}
		  else
		    render new
		  end
		end
	end


end