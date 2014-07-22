class Note < ActiveRecord::Base
  validates :body, presence: true
  validates :photo, presence: true

  #has_dropin :photo, uploader: PhotoUploader
    has_one :photo_dropin, 
      -> { where scope: 'photo'},
      as: :dropinable,
      class_name: 'Dropin',
      dependent: :destroy

    # accepts_nested_attributes_for :photo_dropin

    def photo=(open_file)
      # todo: also allow url string (what else?)
      if photo_dropin
        photo_dropin.file = open_file
      else
        build_photo_dropin scope: 'photo', file: open_file
      end
    end

    def photo
      # byebug
      photo_dropin && photo_dropin.file
    end

  #has_dropins :images
    has_many :image_dropins,
      -> { where scope: 'image'},
      as: :dropinable,
      class_name: 'Dropin',
      dependent: :destroy
    # def image=(open_file)
    #   # todo: also allow url string (what else?)
    #   if images?
    #     image.file = open_file
    #   else
    #     build_image scope: 'image', file: open_file
    #   end
    # end

    def images
      image_dropins
    end

end