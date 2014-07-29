require 'rails_helper'

describe "Posts" do

  let!(:user) { create(:user) }
  let!(:post1) { create(:post, user: user) }
  let!(:post2) { create(:post) }
  let!(:post3) { create(:post) }  

  context "when user is not logged in" do
    
    it "lists all posts" do
      visit root_path
      expect(page.all("tr").count).to eq(4) #one row for the title
      within 'table' do
        expect(page).to have_content(post1.title)
        expect(page).to have_content(post1.body)
        expect(page).to have_content(post2.title)
        expect(page).to have_content(post2.body)
        expect(page).to have_content(post3.title)
        expect(page).to have_content(post3.body)
      end
    end

    it "show a post" do
      visit post_path(post1)
      expect(find(:css, "#title").text).to eq(post1.title)
      expect(find(:css, "#body").text).to eq(post1.body)
      expect(find(:css, "#owner").text).to eq(post1.user.full_name)
    end
  end

  context "when user logged in" do
    
    before(:each) do
      sign_in_user(user)
    end

    it "creates a new post" do
      expect {
        visit root_path
        click_link "New Post"
        fill_in 'post_title', with: 'New Post' 
        fill_in 'post_body', with: 'This is an awesome post body'        
        click_button "Save"
      }.to change(Post, :count).by(1) 
    end

    it "creates a post with invalid attributes" do
      expect {
        visit root_path
        click_link "New Post"
        fill_in 'post_title', with: 'New Post' 
        click_button "Save"
      }.to_not change(Post, :count)     
      expect(page.all(".has-error .help-block").count).to eq(1)
      p_elem = find(:css, ".has-error").find(".help-block")
      expect(p_elem.text).to eq("can't be blank")
    end

    it "show edit only on own posts" do
        visit root_path   
        expect(page.all(".edit_post").count).to eq(1)
    end

    it "edits a post if owner" do 
      expect {
        visit root_path   
        page.first(:xpath, "//a[@class='edit_post']").click  
        expect(find(:css, "#post_title").value).to eq(post1.title)
        fill_in :post_title, with: 'New Post Title'
        click_button "Save"
        post1.reload
      }.to change(post1, :title).to('New Post Title')
    end

    it "show destroy only on own posts" do
        visit root_path   
        expect(page.all(".destroy_post").count).to eq(1)
    end

    it "destroys a post if owner" do
      visit root_path
      expect {
        click_link "Destroy"
      }.to change(Post, :count).by(-1)
    end
  end
end