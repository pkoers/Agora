class PagesController < ApplicationController
  def home
  end

  def post
    user = 'pkoers75@gmail.com'
    SendMailer.send_email(user).deliver_now
    redirect_to root_path
  end
end
