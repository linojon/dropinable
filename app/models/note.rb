class Note < ActiveRecord::Base
  # validates :body, presence: true

  # #has_dropin :photo, uploader: PhotoUploader
  #   has_one :photo, 
  #     # -> { where scope: 'photo'},
  #     as: :dropinable,
  #     class_name: 'DropinFile',
  #     dependent: :destroy
  #   # accepts_nested_attributes_for :photo
  #   def photo=(open_file)
  #     # todo: also allow url string (what else?)
  #     if photo?
  #       photo.item = open_file
  #     else
  #       build_photo scope: 'photo', item: open_file
  #     end
  #   end


  #   def photo?
  #     photo.present?
  #   end

  # #has_dropins :images

end