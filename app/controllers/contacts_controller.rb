class ContactsController < ApplicationController
  def new
  end

  def create
    ContactMailer.contact(params[:email], params[:message]).deliver
    flash.now[:success] = "Email has been successfully sent."
    render 'new'
  end
end