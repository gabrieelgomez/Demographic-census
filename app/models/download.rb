# Download Model
class Download < ActiveRecord::Base
  include ActivityHistory
  include CloneRecord
  mount_uploader :pdf, AttachmentUploader

  # Fields for the search form in the navbar
  def self.search_field
    :pdf_or_title_or_description_cont
  end
end
