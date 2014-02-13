class Application < ActiveRecord::Base
	mount_uploader :file, FileUploader # Tells rails to use this uploader for this model.
  validates :purchaser_name, presence: true # Make sure the owner's name is present.
end
