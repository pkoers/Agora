class SendMailer < ApplicationMailer
  require 'open-uri'
  require 'uri'

  def send_email(user, file_name, file_data)
    attachments["#{file_name}.pdf"] = file_data

    puts 'Sending email'
    mail(to: user, from: 'loadsheet@mixty.com', subject: 'Full Extended Loadsheet', reply_to: 'patrick.koers@klm.com') do |format|
      format.text { render plain: 'This is an automated e-mail from Altea Flight Management.
        NOT FOR OPERATIONAL USE - TEST
        Please do not reply.
        ' }
    end
  end
end
