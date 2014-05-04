# encoding: utf-8

class PictureUploader < CarrierWave::Uploader::Base


  include Cloudinary::CarrierWave
  
  process :convert => "jpg"

  version :thumbnail do
    eager
    resize_to_fit(150, 150)
    cloudinary_transformation :quality => 80          
  end  

  # For more options, see
  # http://cloudinary.com/documentation/rails_integration#carrierwave


end
