RSpec.describe "GET /api/v1/articles", type: :request do
  let!(:article) {
    create(:article, premium: false,
                     content: "On Wednesday of last we, we here at Newsroom 1 were informed that Thomas Ochman had bought a new car. And not just any car but a Berlingo. His son, Oliver, was reported to have shaken his head in sadness when he heard the news, questioning why his father needed another car. And yet, later that same day we also learned that Mr. Ochman wants a third car. And not just any car, but a blank that he found on Blocket. The big questions now are: will he get it and how will Oliver react?")
  }
  let!(:premium_article) {
    create(:article, premium: true,
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

    it "is expected see full content of a free article" do
      expect(response_json["article"]["content"]).to eq "On Wednesday of last we, we here at Newsroom 1 were informed that Thomas Ochman had bought a new car. And not just any car but a Berlingo. His son, Oliver, was reported to have shaken his head in sadness when he heard the news, questioning why his father needed another car. And yet, later that same day we also learned that Mr. Ochman wants a third car. And not just any car, but a blank that he found on Blocket. The big questions now are: will he get it and how will Oliver react?"
    end
  end

  describe "unsuccessfully" do
    before do
      get "/api/v1/articles/abc"
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
    it "Visitor can only see 299 characters of a premium article" do
      expect(response_json["article"]["content"].length).to eq 299
    end
  end
end
