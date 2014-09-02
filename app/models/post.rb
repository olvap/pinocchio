class Post < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :title, :body, :user_id

  scoped_search :on => [:title, :body]
  scoped_search :in => :user, :on => :first_name
  scoped_search :in => :user, :on => :last_name
  scoped_search :in => :user, :on => :email

  scope :paginated, ->(page, per_page) do
    page(page).per(per_page || 15)
  end

  scope :filtered, ->(query, order_by=nil, order_type=nil) do
    posts = Post.search_for(query)
    if order_by
      order_type ||= "desc"
      posts = posts.order("#{Post.table_name}.#{order_by} #{order_type}")
    end

    posts
  end
end
