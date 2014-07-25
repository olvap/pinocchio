require 'rails_helper'

describe User, :type => :model do

  let(:user) { build(:user) }

  %w(first_name last_name).each do |attribute|
    it "is not valid without a #{attribute}" do
      user.send("#{attribute}=", nil)        
      expect(user.valid?).to be false        
      expect(user.errors.get(attribute.to_sym)).to eq(["can't be blank"])
    end
  end

  it "is not valid without a valid email" do
    user.email = "thisisaninvalidemail"
    expect(user.valid?).to be false        
    expect(user.errors.get(:email)).to eq(["is invalid"])

    user.email = "another.invalidemail"
    expect(user.valid?).to be false        
    expect(user.errors.get(:email)).to eq(["is invalid"])

    user.email = "yet@anotherinvalidemail"
    expect(user.valid?).to be false        
    expect(user.errors.get(:email)).to eq(["is invalid"])
  end

  it "is not valid without a unique email" do
    sofi = create(:user)
    invalid_user = build(:user, email: sofi.email)

    expect(invalid_user.valid?).to be false        
    expect(invalid_user.errors.get(:email)).to eq(['has already been taken'])
  end
end
