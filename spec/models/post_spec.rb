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
end
