class Newsletter < ActiveRecord::Base
	validates :email, uniqueness: {case_sensitive: false, message: "El e-mail ya ha sido registrado"},
	 									presence: {message: "El campo no puede estar vacío"}
	validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create, message: "No es un email valido" }
end
