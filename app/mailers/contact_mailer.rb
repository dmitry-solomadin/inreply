class ContactMailer < ActionMailer::Base
  default to: "dmitry.solomadin@gmail.com"

  def contact(email, message)
    @email_message = message
    mail(from: email,
         subject: "New contact message from #{email}")
  end
end
