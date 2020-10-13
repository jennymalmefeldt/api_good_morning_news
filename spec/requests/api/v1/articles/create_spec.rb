RSpec.describe 'POST /api/v1/articles', type: :request do
  let!(:journalist){create(:user, journalist: true)}
  let!(:credentials){journalist.create_new_auth_token}
  let(:headers) {{HTTP_ACCEPT: 'application/json'}.merge!(credentails)}

  describe 'successfully' do
    before do
      post '/api/v1/articles',
      params: {
        title: "My title"
        teaser: "My teaser"
        content: "My content"
      },
      headers: headers
    end

    it 'is expected to respond with create status' do
      expect(response).to have_http_status :create
    end

    it 'is expected to return success message' do
      expect(response_json['message']).to eq 'successfully saved'
    end
  end
end