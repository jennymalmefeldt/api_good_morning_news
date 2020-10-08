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

    it "is expected to return 3 articles" do
      expect(response_json["articles"].count).to eq 3
    end

    it "is expected to return a specific article title" do
      expect(response_json["articles"].first["title"]).to eq "MyString"
    end

    it "is expected to return a specific article teaser" do
      expect(response_json["articles"].second["teaser"]).to eq "MyText"
    end

    it "is expected not to return an articles text" do
      expect(response_json["articles"].second["text"]).to eq nil
    end
  end
end
