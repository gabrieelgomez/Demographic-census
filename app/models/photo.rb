# Photo Model
class Photo < ActiveRecord::Base
  include ActivityHistory
  include CloneRecord
  mount_uploader :picture, AttachmentUploader
  belongs_to :album

  # validates :picture, presence: {message: "El campo no puede estar vacío"}

  # Fields for the search form in the navbar
  def self.search_field
    :picture_or_album_id_cont
  end
end
