class Post < ActiveRecord::Base
  belongs_to :user
  paginates_per 20
end