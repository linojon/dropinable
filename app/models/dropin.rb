class Dropin < ActiveRecord::Base
  belongs_to :dropinable, polymorphic: true
  mount_uploader :file, PhotoUploader

  # def method_missing(m, *args)
  #   send :file, m, *args
  # end
end
