RSpec.describe 'GET /api/v1/articles', type: :request do
  let!(:user) { create(:article) }

  describe 'successfully' do
    before do
      get '/api/v1/articles',
          params: {
            article_id: article_1.id
          }
    end

    it 'should respond with 200 status' do
      expect(response).to have_http_status 200
    end

    it 'should respond with article_id' do
      expect(response_json['article']).to have_key 'id'
    end

    it 'should respond with corresponding id' do
      expect(response_json['article']['id']).to eq 'dfghjfghjk'
    end
  end

  describe 'unsuccessfully' do
    before do
      post '/api/v1/articles',
           params: {
             article_id: 'invalid_id'
           }
    end
    it 'should respond with 404 status' do
      expect(response.status).to eq 404
    end

    it 'should respond with error message' do
      expect(response_json['error_message']).to eq 'Sorry we can not find that article'
    end
  end
end
