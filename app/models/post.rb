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

  scope :filtered, ->(options) do
    posts = Post.search_for(options[:query])
    if options[:order_by]
      options[:order_type] ||= "desc"
      posts = posts.order("#{Post.table_name}.#{options[:order_by]} #{options[:order_type]}")
    end

    posts
  end
end
