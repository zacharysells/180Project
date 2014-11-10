#app/models/profile.rb
Class Profile < ActiveRecord::Base
    belongs_to :user
end
