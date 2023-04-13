class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    email.attachments.each do |attachment|
      if attachment.content_type.start_with?('text/plain')
        attachment_text = attachment.read
        puts "Received email from #{email.from} with subject '#{email.subject}' and attachment '#{attachment.original_filename}'"

        # Print the registration code from the first two lines of the attachment
        lines = attachment_text.split("\n")
        lines.each do |line|
          if line.start_with?('AN')
            registration_code = line[3, 5]
            if registration_code == 'DDROB'
              pdfprocess(attachment_text)
            end
            # puts registration_code
            break
          end
        end
      end
    end
  end

  def pdfprocess(attachment_text)
    # Store the text attachment in a temporary file
    text_file = Tempfile.new('text_attachment')
    text_file.write(attachment_text)
    text_file.rewind

    # Convert the text file to a PDF file and store it in another temporary file
    file_name = 'converted_pdf' # Set a default file name
    pdf_file = Tempfile.new([file_name, '.pdf']) # Create PDF file with the same name

    Prawn::Document.generate(pdf_file.path) do
      text File.read(text_file.path)
    end

    # Attach the stored PDF file to the email and send it
    SendMailer.send_email('pkoers75@gmail.com', file_name, File.read(pdf_file.path)).deliver_now

    # Close and unlink the temporary files
    text_file.close
    text_file.unlink
    pdf_file.close
    pdf_file.unlink

    puts 'Converted PDF'
  end



 # def post(user)
 #   SendMailer.send_email(user).deliver_now
 # end

  private

  attr_reader :email
end
