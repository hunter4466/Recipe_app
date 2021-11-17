require 'rails_helper'

RSpec.describe 'Foods', type: :request do
  describe 'GET /show' do
    it 'returns http success' do
      get '/food/show'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/food/new'
      expect(response).to have_http_status(:success)
    end
  end
end
