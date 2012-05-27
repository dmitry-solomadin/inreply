class Location < ActiveRecord::Base
  attr_accessible :address, :city, :name

  validates_presence_of :address, :city, :name

  belongs_to :account
end
