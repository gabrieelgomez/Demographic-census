# Shop Model
class Shop < ActiveRecord::Base
  include ActivityHistory
  include CloneRecord
  mount_uploader :brand, AttachmentUploader
  mount_uploader :header, AttachmentUploader
  belongs_to :category
  validate :validate_phones

  validates :name, presence: {message: "El campo no puede estar vacío"}

  # Fields for the search form in the navbar
  def self.search_field
    :brand_or_header_or_name_or_category_id_or_address_or_description_or_email_or_phone_one_or_phone_two_or_facebook_or_instagram_or_twitter_cont
  end

  private

  def validate_phones
    if !self.phone_one.blank?
      errors.add(:phone_one, "Entre 7 y 15 caracteres") if !validate_size
    end
  end

  def validate_size
    self.phone_one.size > 7 && self.phone_one.size < 15
  end
end
