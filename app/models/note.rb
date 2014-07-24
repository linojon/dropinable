class Note < ActiveRecord::Base
  validates :body, presence: true
  validates :photo, presence: true

  #has_dropin :photo, uploader: PhotoUploader
    has_one :photo, 
      -> { where scope: 'photo'},
      as: :dropinable,
      class_name: 'Dropin',
      dependent: :destroy,
      validate: true

    # accepts_nested_attributes_for :photo_dropin
    def photo=(file)
      dropin = photo || build_photo(scope: 'photo')
      if file.is_a? String
        dropin.remote_file_url = file
      else # if ActionDispatch i think
        dropin.file = file
      end
    end

  #has_dropins :images
    has_many :images,
      -> { where scope: 'image'},
      as: :dropinable,
      class_name: 'Dropin',
      dependent: :destroy,
      validate: true

    def image=(open_file)
      images.build scope: 'image', file: open_file
    end

end