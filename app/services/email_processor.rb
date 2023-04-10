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
            registration_code = line[3,5]
            puts registration_code
            break
          end
        end
      end
    end
  end

#  def process
    # Check if email has attachments
#    has_attachments = email.attachments.any?

    # Print the name and first two lines of the first attachment (if there is one)
#    if has_attachments && email.attachments.first.content_type =~ /^text\//
#      attachment = email.attachments.first.read
      # attachment_name = email.attachments.first.filename
#      attachment_lines = attachment.lines.first(2)

 #     puts "Received email from #{email.from} with subject '#{email.subject}' and has_attachments? #{has_attachments}"
      # puts "Attachment name: #{attachment_name}"
 #     puts "Attachment content (first 2 lines):\n#{attachment_lines.join}"
 #   else
 #     puts "Received email from #{email.from} with subject '#{email.subject}' and has_attachments? #{has_attachments}"
 #   end
 # end

  private

  attr_reader :email
end
