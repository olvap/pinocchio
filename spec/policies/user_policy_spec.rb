require 'rails_helper'

describe UserPolicy do

  let!(:user) { create(:user) }

  describe "#edit" do

    it "returns true when the user is the same as current_user" do
      policy = UserPolicy.new(user, user)
      expect(policy.edit?).to be(true)
    end

    it "returns false when the user is not the same as current_user" do      
      policy = UserPolicy.new(instance_double('User'), user)
      expect(policy.edit?).to be(false)
    end
  end

  describe "#update" do
    it "returns true when the user is the same as current_user" do
      policy = UserPolicy.new(user, user)
      expect(policy.update?).to be(true)
    end

    it "returns false when the user is not the same as current_user" do
      policy = UserPolicy.new(instance_double('User'), user)
      expect(policy.update?).to be(false)
    end
  end

  describe "#destroy" do
    it "returns true when the user is the same as current_user" do
      policy = UserPolicy.new(user, user)
      expect(policy.destroy?).to be(true)
    end

    it "returns false when the user is not the same as current_user" do
      policy = UserPolicy.new(instance_double('User'), user)
      expect(policy.destroy?).to be(false)
    end
  end
end