class ProductsController < ApplicationController
	def index
		@products = Product.all
		render 'show'
	end

	def show
		@products = Product.all
	end

  def new
  	@product = Product.new
  	3.times {@product.pictures.build}
  end

  def create
  	@product = Product.new(product_params)
  	puts product_params
  	@product.save!

  	redirect_to products_path

  end

  def picture_in
    render :picture_in, layout: false
  end

  def save_temp_pic
    @temp_pic = PictureTemp.new()
    @temp_pic.public_id = params[:pic]
  	respond_to do |format|
      if @temp_pic.save!
        format.js
      end
    end
  end

  def destroy_pic
    @temp_pic = PictureTemp.find(params[:id])
    respond_to do |format|
      if @temp_pic.destroy
        format.js {  }
      else
        format.js { }
      end
    end
  end

  def product_params
  	params.required(:product).permit(:pictures_attributes => [:img, :name])
  end

end
