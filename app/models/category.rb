# Category Model
class Category < ActiveRecord::Base
  include ActivityHistory
  include CloneRecord
  has_many :shops, :dependent => :delete_all

  validates :name, presence: {message: "El campo no puede estar vacío"},
                   uniqueness: {case_sensitive: false, message: "La categoría ya ha sido registrada"}

  validates :icon, presence: true

  def url
    name.downcase.split(' ').join('-')
  end

  def self.search_field
    :icon_or_name_cont
  end
end
