class Attachment < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true

  mount_uploader :file, AttachmentUploader

  ## Validations
  validates :file, presence: true
end
