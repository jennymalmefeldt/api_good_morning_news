# frozen_string_literal: true

RSpec.describe 'GET /api/v1/articles', type: :request do
  let!(:sports_articles) do
    3.times do
      create(:article, category: 'sports')
    end
  end
  let!(:non_sports_articles) do
    3.times do
      create(:article, category: 'business')
    end
  end

  describe 'successfully' do
    before do
      get '/api/v1/articles',
          params: {
            category: 'sports'
          }
    end

    it 'is expected to respond with 200 status' do
      expect(response).to have_http_status :ok
    end

    it 'is expected to respond with article category' do
      expect(response_json['articles'].first['category']).to eq 'sports'
    end

    it 'is expected to return 3 articles' do
      expect(response_json['articles'].count).to eq 3
    end
  end

  describe 'unsuccessfully' do
    before do
      get '/api/v1/articles/',
          params: {
            category: 'invalid_category'
          }
    end

    it 'is expected to respond with 404 status' do
      expect(response).to have_http_status :not_found
    end

    it 'is expected to respond with error message' do
      expect(response_json['error_message']).to eq 'Sorry, we can\'t find that category'
    end
  end
end
