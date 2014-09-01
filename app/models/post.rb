class Post < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :title, :body, :user_id

  scoped_search :on => [:title, :body]
  scoped_search :in => :user, :on => :first_name
  scoped_search :in => :user, :on => :last_name
  scoped_search :in => :user, :on => :email
end
