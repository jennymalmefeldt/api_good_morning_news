RSpec.describe "GET /api/v1/articles", type: :request do
  let!(:article) { create(:article) }

  describe "successfully" do
    before do
      get "/api/v1/articles/#{article.id}"
    end

    it "should respond with 200 status" do
      expect(response).to have_http_status 200
    end

    it "should respond with article_id" do
      expect(response_json["article"]["id"]).to eq article.id
    end

    it "is expected to return a specific article title" do
      expect(response_json["article"]["title"]).to eq "MyString"
    end

    it "is expected to return a specific article teaser" do
      expect(response_json["article"]["teaser"]).to eq "MyText"
    end

    it "is expected to return a specific article teaser" do
      expect(response_json["article"]["content"]).to eq "MyContent"
    end
  end

  describe "unsuccessfully" do
    before do
      get "/api/v1/articles/700"
    end

    it "should respond with 404 status" do
      expect(response).to have_http_status :not_found
    end

    it "should respond with error message" do
      expect(response_json["error_message"]).to eq "Sorry we can not find that article"
    end
  end
end
