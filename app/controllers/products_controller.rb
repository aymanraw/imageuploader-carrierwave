class ProductsController < ApplicationController

  include ProductsPicture

	def index
		@products = Product.all
		render 'show'
	end

	def show
		@products = Product.all
	end

  def new
    session[:products_params] ||= {} 
  	@product = Product.new
  	@product.pictures.build
  end

  def create
    session[:products_params].deep_merge!(without_images) if params[:product]

    submitted_hash = {}
    submitted_hash = product_params
    submitted_hash.deep_merge!(session[:products_params])

    pics = product_params[:pictures_attributes].values
    pics.each do |p|
      pid = p["img"]
      unless pid.blank?
        preloaded = Cloudinary::PreloadedFile.new(pid)
        PictureTemp.where(public_id: preloaded.public_id).first.destroy
      end
    end

    @product = Product.new(product_params)
  	@product.save!
  	redirect_to products_path

  end

  def without_images
    car_params_without_pictures = product_params
    car_params_without_pictures.delete(:pictures_attributes) if params[:product][:pictures_attributes]
    car_params_without_pictures
  end

  def product_params
  	params.required(:product).permit(:pictures_attributes => [:img, :name])
  end

end
