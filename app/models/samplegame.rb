class Samplegame < ActiveRecord::Base
  
  has_many :warps
  has_many :users, :through => :warps
  
end
