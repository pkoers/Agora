class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    email.attachments.each do |attachment|
      if attachment.content_type.start_with?('text/plain')
        attachment_text = attachment.read
        puts "Received email from #{email.from} with subject '#{email.subject}' and attachment '#{attachment.original_filename}'"
        full_subject = "#{email.subject}"
        # reading the origin and destination
        puts "Origin #{full_subject[17, 3]}"
        origin = "#{full_subject[17, 3]}"
        puts "Destination #{full_subject[20, 3]}"
        # Read the registration code from the first two lines of the attachment
        lines = attachment_text.split("\n")
        lines.each do |line|
          if line.start_with?('AN')
            registration_code = line[3, 5]
            rego_email = read_regos(registration_code)
            if rego_email != "UNK"
              replyto = station_array(origin).join(", ")
              pdfprocess(attachment_text, full_subject.gsub('/', ''), full_subject, rego_email, replyto)
            else
              puts "Unknown Aircraft #{registration_code}"
            end

            # if registration_code == 'DAZFA' || registration_code == 'DAPRI' || registration_code == 'DAGMP'
            #   puts station_array(origin)
            #   pdfprocess(attachment_text, full_subject.gsub('/', ''), full_subject)
            # end
            break
          end
        end
      end
    end
  end

  # origin is the iata station code found in the inbound email
  # this def searches the table for the reply-to email adresses
  def station_array(origin)
    station = Station.find_by(iata_station_code: origin).try(:id)
    # station 99999 is assigned when the station is not known in the table
    station ||= 99999
    output = Email.where(station_id: station).pluck(:email_address)
    # Add the addresses that always have to be used as a reply-to
    output << "andreas.kornatz@germanairways.com"
    return output
  end

  # rego is the registration of the aircraft
  def read_regos(rego)
    # look for a registration and return the associated email address
    returned_rego = Registration.find_by(registration: rego)
    # when no rego found in the table, return UNK otherwise return the rego
    returned_rego.nil? ? returned_rego = "UNK" : returned_rego = returned_rego.email_address
    return returned_rego
  end

  def pdfprocess(attachment_text, file_name, full_subject, email_user, replyto)
    # Store the text attachment in a temporary file
    text_file = Tempfile.new('text_attachment')
    text_file.write(attachment_text)
    text_file.rewind

    # Convert the text file to a PDF file and store it in another temporary file
    # file_name = 'KLM Loadsheet' # Set a default file name
    pdf_file = Tempfile.new([file_name, '.pdf']) # Create PDF file with the same name

    Prawn::Document.generate(pdf_file.path) do
      text File.read(text_file.path)
    end

    # email_user = 'mail.alteafm.database@klm.com'

    # Attach the stored PDF file to the email and send it
    SendMailer.send_email(email_user, file_name, File.read(pdf_file.path), full_subject, replyto).deliver_now

    # Close and unlink the temporary files
    text_file.close
    text_file.unlink
    pdf_file.close
    pdf_file.unlink

  end



 # def post(user)
 #   SendMailer.send_email(user).deliver_now
 # end

  private

  attr_reader :email
end
