require "rails_helper"

describe PullRequestsController do
  before do
    user = create_user
    allow(controller).to receive(:current_user).and_return(user)
  end

  def create_user()
    return User.create!({
      username: "me",
      email: "me@me.com",
      password: "1234",
      bio: "",
    })
  end

  describe "#index" do
    it "returns something" do
      get :index
      expect(response).not_to be_empty
    end
  end
end
