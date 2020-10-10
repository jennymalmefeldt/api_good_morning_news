RSpec.describe "GET /api/v1/articles", type: :request do
  let!(:article) do
    3.times do
      create(:article)
    end
  end

  describe "successfully" do
    before do
      get "/api/v1/articles",
          params: {
            category: "sports",
          }
    end

    it "should respond with 200 status" do
      expect(response).to have_http_status 200
    end

    it "should respond with article category" do
      expect(response_json["articles"].first["category"]).to eq "sports"
    end

    it "is expected to return 3 articles" do
      expect(response_json["articles"].count).to eq 3
    end
  end

  describe "unsuccessfully" do
    before do
      get "/api/v1/articles/",
          params: {
            category: "invalid"
          }
    end

    it "should respond with 404 status" do
      expect(response).to have_http_status :not_found
    end

    it "should respond with error message" do
      expect(response_json["error_message"]).to eq "Sorry we can not find that article"
    end
  end
end
