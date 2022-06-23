require 'rails_helper'

RSpec.describe "/users", type: :request do
  let(:valid_attributes) { 
    {
      'id' => 1,
      'firstName' => 'suraj',
      'lastName' => 'pai',
      'email' => 'sp@gmail.com'
    }
  }

  let(:invalid_attributes) {
    {
      'lastName' => 'pai',
      'email' => 'sp@gmail.com'
    }
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      User.create! valid_attributes
      get "/api/users/", headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      user = User.create! valid_attributes
      get "/api/user/1", as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new User" do
        User.create! valid_attributes
        expect {
          post "/api/user",
               params: { user: valid_attributes }, headers: valid_headers, as: :json
        }.to change(User, :count).by(1)
      end

      it "renders a JSON response with the new user" do
        User.create! valid_attributes
        post "/api/user",
             params: { user: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new User" do
        User.create! valid_attributes
        expect {
          post "/api/user",
               params: { user: invalid_attributes }, as: :json
        }.to change(User, :count).by(0)
      end

      it "renders a JSON response with errors for the new user" do
        User.create! valid_attributes
        post "/api/user",
             params: { user: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PUT /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          'lastName' => 'pai k',
          'email' => 'spk@gmail.com'
        }
      }

      it "updates the requested user" do
        user = User.create! valid_attributes
        put "/api/user/1",
              params: { user: new_attributes }, headers: valid_headers, as: :json
        user.reload
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end

      it "renders a JSON response with the user" do
        user = User.create! valid_attributes
        put "/api/user/1",
              params: { user: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested user" do
      user = User.create! valid_attributes
      expect {
        delete "/api/user/1", headers: valid_headers, as: :json
      }.to change(User, :count).by(-1)
    end
  end

  # Rspec for search operation
  describe "GET /typeahead" do
    it "searched data exist" do
      user = User.create! valid_attributes
      get "/api/typeahead/ura", headers: valid_headers, as: :json
      expect(response.content_type).to match(a_string_including("application/json"))
    end

    it "searched data donot exist" do
      user = User.create! valid_attributes
      get "/api/typeahead/iss", headers: valid_headers, as: :json
      expect(response.content_type).to match(a_string_including("application/json"))
    end
  end
end