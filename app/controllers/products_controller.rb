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
    puts product_params
    session[:products_params].deep_merge!(without_images) if params[:product]
    puts session[:products_session]
  	
    #@product = Product.new(product_params)
  	#puts product_params
  	#@product.save!
  	#redirect_to products_path

  end

  def without_images
    car_params_without_pictures = product_params
    car_params_without_pictures.delete(:pictures_attributes) if params[:car][:pictures_attributes]
    car_params_without_pictures
  end

  def product_params
  	params.required(:product).permit(:pictures_attributes => [:img, :name])
  end

end
