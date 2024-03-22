class SendMailer < ApplicationMailer
  require 'open-uri'
  require 'uri'

  def send_email(user, file_name, file_data, full_subject, replyto, from_domain)
    attachments["#{file_name}.pdf"] = file_data

    puts 'Sending email'
    mail(to: user, from: from_domain, subject: full_subject, reply_to: replyto) do |format|
      format.text { render plain: 'This is an automated e-mail from Altea Flight Management & Agora.
        Do not forget to validate and sign the Load Sheet with your 3-letter-code/staff number and signature!
        Please use Reply-All to automatically send the signed Load Sheet to all applicable departments.
        ' }
    end
  end
end
