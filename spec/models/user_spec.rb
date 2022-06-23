require 'rails_helper'

RSpec.describe User, type: :model do
  context "validation tests" do
    it "ensures firstName is valid" do
      user = User.new(lastName: "pai", email: "sp@gmail.com").save
      expect(user).to eq(false)
    end

    it "ensures lastName is valid" do
      user = User.new(firstName: "suraj", email: "sp@gmail.com").save
      expect(user).to eq(false)
    end

    it "ensures email is valid" do
      user = User.new(firstName: "suraj", lastName: "pai").save
      expect(user).to eq(false)
    end

    it "saved successfully" do
      user = User.new(firstName: "suraj", lastName: "pai", email: "sp@gmail.com").save
      expect(user).to eq(true)
    end
  end
end
