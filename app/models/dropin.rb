class Dropin < ActiveRecord::Base
  belongs_to :dropinable, polymorphic: true
  mount_uploader :file, PhotoUploader
  store_in_background :file

  validate :file_must_be_present

  def file_must_be_present
    unless file.path.present? || file_tmp.present?
      errors.add(:file, "can't be blank")
    end
  end

  def filename
    File.basename(file.path) if file && file.path
  end

  def processing?
    file_tmp.present?
  end
  
  def method_missing(m, *args, &block)
    if file.respond_to? m
      file.send m, *args
    else
      super
    end
  end

  before_save :debug
  def debug
    logger.info "Dropin: before_save #{self.inspect}"
  end
end
