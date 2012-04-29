class ContactsController < ApplicationController
  layout 'public'

  def new
    @message = ContactMessage.new
  end

  def create
    @message = ContactMessage.new(params[:contact_message])

    if @message.valid?
      ContactMailer.contact(@message).deliver
      flash.now[:success] = t "contacts.new.flash_success"
    end

    respond_to do |format|
      format.html { render 'new' }
      format.js { render layout: false }
    end
  end
end

class ContactMessage
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :email, :message
  validates_presence_of :email, :message
  validates :email, email_format: true

  def initialize(attributes={})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
end


