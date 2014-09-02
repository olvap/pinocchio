require 'rails_helper'

describe Post, :type => :model do

  let(:post) { build(:post) }

  %w(title body user_id).each do |attribute|
    it "is not valid without a #{attribute}" do
      post.send("#{attribute}=", nil)
      expect(post.valid?).to be false
      expect(post.errors.get(attribute.to_sym)).to eq(["can't be blank"])
    end
  end

  describe "Scopes" do

    describe "Paging" do

      it "paginate posts" do
        Post.delete_all
        10.times do
          create(:post)
        end
        posts = Post.paginated(1, 3)
        expect(posts.count).to eq(3)
      end

      it "paginate posts with order" do
        Post.delete_all
        10.times do |i|
          create(:post, title: "A#{i}")
        end
        options = {order_by: "title", order_type: "desc"}
        posts = Post.filtered(options).paginated(1, 2)

        expect(posts.count).to eq(2)
        expect(posts.first.title).to eq("A9")
        expect(posts.second.title).to eq("A8")

        posts = Post.filtered(options).paginated(2, 2)

        expect(posts.count).to eq(2)
        expect(posts.first.title).to eq("A7")
        expect(posts.second.title).to eq("A6")
      end

    end

    describe "Filtering" do

      it "filter items with simple query" do
        Post.delete_all
        post_to_search = create(:post, title: "To Search")
        posts = Post.filtered(query: post_to_search.title)
        expect(posts.count).to eq(1)
      end

      it "filter items by any attribute with simple query" do
        Post.delete_all
        post_to_search = create(:post, title: "To Search", body: "Not")
        post_to_search_2 = create(:post, title: "Not", body: "Testing To Search by attributes")
        post_not_to_search = create(:post, body: "Not to be found")
        posts = Post.filtered(query: "Searc")

        expect(posts.count).to eq(2)
        expect(posts).to include(post_to_search)
        expect(posts).to include(post_to_search_2)
      end

      it "filter items with simple query and order by title" do
        Post.delete_all
        post_to_search = create(:post, title: "To Search", body: "Not to match")
        post_to_search_2 = create(:post, title: "AAA", body: "To Search 2")
        posts = Post.filtered(query: "Searc", order_by: "title", order_type: "asc")

        expect(posts.count).to eq(2)
        expect(posts.first).to eq(post_to_search_2)
        expect(posts.second).to eq(post_to_search)
      end

      it "filter items with simple query and order by title" do
        Post.delete_all
        post_to_search = create(:post, title: "To Search", body: "Not to be found")
        post_to_search_2 = create(:post, title: "AAA", body: "To Search 2")
        posts = Post.filtered(query: "Searc", order_by: "title", order_type: "desc")

        expect(posts.count).to eq(2)
        expect(posts.first).to eq(post_to_search)
        expect(posts.second).to eq(post_to_search_2)
      end

      it "filter posts using user attributes" do
        Post.delete_all
        user_to_search = create(:user, email: "test_email_search@test.com")
        post_to_search = create(:post, title: "To Search", user: user_to_search)
        user_not_to_search = create(:user, email: "test_email_not_search@test.com")
        post_not_to_search = create(:post, title: "To Search", user: user_not_to_search)
        posts = Post.filtered(query: user_to_search.email)

        expect(posts.count).to eq(1)
        expect(posts.first).to eq(post_to_search)
      end

    end

  end
end
