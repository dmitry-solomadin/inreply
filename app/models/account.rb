class Account < ActiveRecord::Base

  has_many :users, autosave: true
  has_many :locations, autosave: true

  accepts_nested_attributes_for :users, :locations

end
