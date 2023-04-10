class ApplicationMailbox < ActionMailbox::Base
  # routing /something/i => :somewhere
  routing /^save@/i     => :inbounds
  routing /@replies\./i => :replies
end
