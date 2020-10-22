RSpec.describe "POST /api/v1/admin/sign_up", type: :request do
  let(:headers) { { HTTP_ACCEPT: "application/json" } }

  describe "with valid credentials" do
    before do
      post "/api/v1/auth",
           params: {
             email: "registered@mail.com",
             password: "password",
             password_cofirmation: "password",
           },
           headers: headers
    end

    it "is expected to respond with ok status" do
      expect(response).to have_http_status :ok
    end

    it "returns a succesfully message" do
      expect(response_json["status"]).to eq "success"
    end
  end

  describe "Unsuccessfully register" do
    context "with wrong password"
    before do
      post "/api/v1/auth",
           params: {
             email: "registered@mail.com",
             password: "password",
             password_confirmation: "wrongpassword",
           },
           headers: headers
    end

    it "is expected to respond with 422 status" do
      expect(response).to have_http_status :unprocessable_entity
    end

    it "returns a unsuccesfully message" do
      expect(response_json["errors"]["full_messages"][0]).to eq "Password confirmation doesn't match Password"
    end
  end

end
