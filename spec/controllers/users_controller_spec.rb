require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  #   context 'GET # index' do
  #     it 'has a 200 status code' do
  #         current_user = {id: 1}
  #         get :index, current_user[:id]
  #         expect(response.status).to eq(200)
  #     end
  #   end

  context 'GET # new' do
    it 'has a 200 status code' do
      get :new
      expect(response.status).to eq(200)
    end
  end

  context 'POST # create' do
    it 'responds to HTML by default' do
      post :create, params: { username: 'Pato', email: 'pato@gmail.com' }
      expect(response.content_type).to eq 'text/html; charset=utf-8'
    end
  end
end
