RSpec.describe "POST /api/v1/admin/articles", type: :request do
  let!(:journalist) { create(:user, role: "journalist") }
  let(:journalist_credentials) { journalist.create_new_auth_token }
  let(:journalist_headers) { { HTTP_ACCEPT: "application/json" }.merge!(journalist_credentials) }

  describe "successfully" do
    before do
      post "/api/v1/admin/articles",
           params: { article: {
             title: "My title",
             teaser: "My teaser",
             content: "My content",
             category: "sports",
           } },
           headers: journalist_headers
    end

    it "is expected to respond with create status" do
      expect(response).to have_http_status :ok
    end

    it "is expected to return success message" do
      expect(response_json["message"]).to eq "successfully saved"
    end

    it "is expected to create an article" do
      article = Article.last
      expect(article.title).to eq "My title"
    end

    it "an article to be linked to a journalist" do
      expect(journalist.articles.first.teaser).to eq "My teaser"
    end
  end

  describe "unsuccessfully, missing article content" do
    before do
      post "/api/v1/admin/articles",
           params: {
             article: {
               title: "My title",
               teaser: "My teaser",
               content: "",
                category: "sports"
             },
           },
           headers: journalist_headers
    end

    it "is expected to reurn a response status" do
      expect(response).to have_http_status 422
    end

    it "is expected to return an error message" do
      expect(response_json["message"]).to eq "Content can't be blank"
    end
  end
end
