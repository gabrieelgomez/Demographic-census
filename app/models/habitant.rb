# Habitant Model
class Habitant < ActiveRecord::Base
  include ActivityHistory
  include CloneRecord

  # Fields for the search form in the navbar
  def self.search_field
    :identification_or_full_name_or_phone_or_email_or_address_cont
  end
end
