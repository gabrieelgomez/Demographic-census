class NewsletterController < ApplicationController
  def create
  	gibbon = Gibbon::Request.new(api_key: Rails.application.secrets.mailchimp_api_key)
  	gibbon.timeout = 10
  	@newsletter = Newsletter.new(newsletter_params)
  	respond_to do |format|
	  	if @newsletter.save
	  		gibbon.lists("e3dd9218f0").members.create(body:{email_address: @newsletter.email, status: "subscribed"})
	      format.html { redirect_to root_path, notice: "Gracias por suscribirse a nuestro boletín de noticias." }
	      format.json { render action: 'show', status: :created, location: @user }
	    else
	      format.html { redirect_to root_path(anchor: "footer"), alert: @newsletter.errors[:email].first }
	      format.json { render json: @newsletter.errors, status: :unprocessable_entity }
	    end
	  end
  end

  private

  def newsletter_params
    params.require(:newsletter).permit(:email)
  end
end
