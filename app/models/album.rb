# Album Model
class Album < ActiveRecord::Base
  include ActivityHistory
  include CloneRecord
  mount_uploader :cover, AttachmentUploader
  has_many :photos, :dependent => :delete_all

  validates :title, :cover, presence: {message: "El campo no puede estar vacío"}

  # Fields for the search form in the navbar
  def self.search_field
    :cover_or_title_cont
  end
end
