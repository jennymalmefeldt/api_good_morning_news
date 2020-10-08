RSpec.describe "GET /api/v1/articles", type: :request do
  let!(:article) do
    3.times do
      create(:article)
    end
  end
  describe "GET /api/v1/articles " do
    before do
      get "/api/v1/articles"
    end

    it "is expected to return 200 response status" do
      expect(response.status).to eq 200
    end

    it "is expected to return a list of 3 articles" do
      expect(response_json["articles"].count).to eq 3
    end
  end
end
