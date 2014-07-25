require 'rails_helper'

describe PostPolicy do

  let!(:post) { create(:post) }

  describe "#edit" do

    it "returns true when the user is the owner" do
      policy = PostPolicy.new(post.user, post)
      expect(policy.edit?).to be(true)
    end

    it "returns false when the user is not the owner" do
      policy = PostPolicy.new(instance_double('User'), post)
      expect(policy.edit?).to be(false)
    end
  end

  describe "#update" do
    it "returns true when the user is the owner" do
      policy = PostPolicy.new(post.user, post)
      expect(policy.update?).to be(true)
    end

    it "returns false when the user is not the owner" do
      policy = PostPolicy.new(instance_double('User'), post)
      expect(policy.update?).to be(false)
    end
  end

  describe "#destroy" do
    it "returns true when the user is the owner" do
      policy = PostPolicy.new(post.user, post)
      expect(policy.destroy?).to be(true)
    end

    it "returns false when the user is not the owner" do
      policy = PostPolicy.new(instance_double('User'), post)
      expect(policy.destroy?).to be(false)
    end
  end
end