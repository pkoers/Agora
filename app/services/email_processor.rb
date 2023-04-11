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
              pdfprocess(email)
            end
            # puts registration_code
            break
          end
        end
      end
    end
  end

  def pdfprocess(email)
    email.attachments.each do |attachment|
      next unless attachment.content_type == 'text/plain'

      file_name = File.basename(attachment.original_filename, '.*') # get name without extension
      pdf_file = Tempfile.new([file_name, '.pdf']) # create PDF file with same name

      Prawn::Document.generate(pdf_file.path) do
        text attachment.read
      end

      # Do something with the PDF file, e.g. send it as an attachment
      # email.attachments['converted_pdf.pdf'] = File.read(pdf_file.path)
      # ...
      puts 'Converted PDF'
    end
  end


  private

  attr_reader :email
end
