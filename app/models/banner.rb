# Banner Model
class Banner < ActiveRecord::Base
  include ActivityHistory
  include CloneRecord

  validates :image, presence: true
  mount_uploader :image, AttachmentUploader

  # Fields for the search form in the navbar
  def self.search_field
    :image_cont
  end
end
