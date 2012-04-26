class ContactMailer < ActionMailer::Base
  default to: "dmitry.solomadin@gmail.com"

  def contact(message)
    @email_message = message.message
    mail(from: message.email,
         subject: "New contact message from #{message.email}")
  end
end
