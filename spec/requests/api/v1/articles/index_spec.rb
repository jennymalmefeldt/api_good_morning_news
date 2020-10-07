RSpec.describe "GET /api/v1/articles", type: :request do
  before do
    get "/api/v1/articles"
  end

  it "is expected to return 200 response status" do
    expect(response.status).to eq 200
  end

  it "is expected to return 1 joke" do
    expect(response_json["articles"]["title"]).to eq "This is the first article title."
  end

  it "is expected to return a random joke" do
    expect(response_json["articles"]["lead"]).to "This is the first article lead."
  end
end