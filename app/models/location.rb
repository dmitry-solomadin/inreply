class Location < ActiveRecord::Base
  attr_accessible :address, :city, :name
  belongs_to :account
end
