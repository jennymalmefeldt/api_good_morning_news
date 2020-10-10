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

    it 'is expected to respond with ok status' do
      expect(response).to have_http_status :ok
    end

    it 'is expected to return a specific article title' do
      expect(response_json['articles'].first['title']).to eq 'MyString'
    end

    it 'is expected to return a specific article teaser' do
      expect(response_json['articles'].second['teaser']).to eq 'MyText'
    end

    it 'is expected to return with article category' do
      expect(response_json['articles'].third['category']).to eq 'sports'
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

    it 'is expected to respond with not found status' do
      expect(response).to have_http_status :not_found
    end

    it 'is expected to return with error message' do
      expect(response_json['error_message']).to eq 'Sorry, we can\'t find that category'
    end
  end
end
