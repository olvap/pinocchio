require "rails_helper"

describe UserMailer do
  describe "password_reset" do

    let(:user) { create(:user) }
    let(:mail) { UserMailer.password_reset(user) }

    it "renders the headers" do
      user.send_password_reset 
      expect(mail.subject).to eq("Password Reset")
      expect(mail.to).to eq(["#{user.email}"])
      expect(mail.from).to eq(["pinocchio@pinocchio.com"])
    end

    it "renders the body" do
      user.send_password_reset 
      expect(mail.body.encoded).to match("To reset your password, click the URL below." +
        "http://localhost:3000/password_resets/#{user.password_reset_token}/edit " + 
        "If you did not request your password to be reset, just ignore " +
        "this email and your password will continue to stay the same.")
    end
  end

end
