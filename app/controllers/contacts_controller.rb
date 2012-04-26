class ContactsController < ApplicationController
  def new
    @message = ContactMessage.new
  end

  def create
    @message = ContactMessage.new(params[:message])

    if @message.valid?
      ContactMailer.contact(@message).deliver
      flash.now[:success] = t "contacts.new.flash_success"
      render 'new'
    else
      render 'new'
    end
  end
end

class ContactMessage
  include ActiveModel::Validations

  attr_accessor :email, :message
  validates_presence_of :email, :message

  def initialize(attributes={})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
end
