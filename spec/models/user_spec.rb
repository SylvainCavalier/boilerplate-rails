require "rails_helper"

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "is invalid without an email" do
    expect(build(:user, email: "")).not_to be_valid
  end

  it "is not an admin by default" do
    expect(build(:user).admin).to be(false)
  end

  it "builds an admin via the :admin trait" do
    expect(build(:user, :admin).admin).to be(true)
  end
end
