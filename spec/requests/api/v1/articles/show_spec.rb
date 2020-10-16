RSpec.describe "GET /api/v1/articles", type: :request do
  let!(:journalist) { create(:user, role: "journalist") }
  let!(:article) { create(:article, journalist_id: journalist.id) }
  let!(:premium_article) {
    create(:article, premium: true, journalist_id: journalist.id, 
                     content: "We are all mad here. That quote from the Mad Hatter in Alice in Wonderland has never been more true than now. We are experiencing a wave of maddness as the quarentine continues for people across the globe. People in Italy have been reported to actually talk to their neighbors, playing music for the street and even group calisthenics on the patio. These are indeed scary times. As we move forward into an uncertain future, we have got to wonder, what will the Italians do next.")
  }

  describe "successfully" do
    before do
      get "/api/v1/articles/#{article.id}"
    end

    it "is expected to respond with ok status" do
      expect(response).to have_http_status :ok
    end

    it "is expected to respond with article_id" do
      expect(response_json["article"]["id"]).to eq article.id
    end

    it "is expected to return a specific article title" do
      expect(response_json["article"]["title"]).to eq "MyString"
    end

    it "is expected to return a specific article teaser" do
      expect(response_json["article"]["teaser"]).to eq "MyText"
    end

    it "is expected to return a specific article content" do
      expect(response_json["article"]["content"]).to eq "MyContent"
    end
  end

  describe "unsuccessfully" do
    before do
      get "/api/v1/articles/700"
    end

    it "is expected to respond with not found status" do
      expect(response).to have_http_status :not_found
    end

    it "is expected to return with error message" do
      expect(response_json["error_message"]).to eq "Sorry we can not find that article"
    end
  end

  describe "Visitor can only see part of premium content" do
    before do
      get "/api/v1/articles/#{premium_article.id}"
    end
    it "Visitor can only see 20 characters" do
      expect(response_json["article"]["content"].length).to eq 20
    end
  end
end
