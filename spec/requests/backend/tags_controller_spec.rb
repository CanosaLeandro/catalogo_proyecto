require "rails_helper"

RSpec.describe "Backend::TagsController Requests", type: :request do
  let(:admin) { create(:admin) }
  
  describe 'with user logged in' do
    describe 'index' do
      it 'ok request' do
        sign_in admin

        get backend_tags_path
        expect(response).to render_template(:index)
        expect(response).to have_http_status(:ok)
      end
    end
    describe 'new' do
        it 'ok request' do
          sign_in admin
  
          get new_backend_tag_path(format: :js), xhr: true
          expect(response.content_type).to eq('text/javascript')
          expect(response).to render_template(:modal)
          expect(response).to have_http_status(:ok)
        end
      end
      describe 'edit' do
        subject { create(:tag) }
        it 'ok request' do
          sign_in admin
  
          get edit_backend_tag_path(subject, format: :js), xhr: true
          expect(response.content_type).to eq('text/javascript')
          expect(response).to render_template(:modal)
          expect(response).to have_http_status(:ok)
        end
      end
      describe 'create' do
        it 'ok request' do
          sign_in admin
  
          params = {
            tag: {
              name: Faker::Name.unique.name
            }
          }
          post backend_tags_path(params: params, format: :js), xhr: true
          expect(response.content_type).to eq('text/javascript')
          expect(response).to render_template(:create)
          expect(response).to have_http_status(:ok)
        end
        it 'fail validation' do
          sign_in admin
  
          params = {
            tag: {
              name: ''
            }
          }
          post backend_tags_path(params: params, format: :js), xhr: true
          expect(response.content_type).to eq('text/javascript')
          expect(response).to render_template(:modal)
          expect(response).to have_http_status(:ok)
        end
      end
      describe 'update' do
        subject { create(:tag) }
        it 'ok request' do
          sign_in admin
  
          params = {
            tag: {
              name: Faker::Name.unique.name
            }
          }
          patch backend_tag_path(subject, params: params, format: :js), xhr: true
          expect(response.content_type).to eq('text/javascript')
          expect(response).to render_template(:update)
          expect(response).to have_http_status(:ok)
        end
        it 'fail validation' do
          sign_in admin
  
          params = {
            tag: {
              name: ''
            }
          }
          patch backend_tag_path(subject, params: params, format: :js), xhr: true
          expect(response.content_type).to eq('text/javascript')
          expect(response).to render_template(:modal)
          expect(response).to have_http_status(:ok)
        end
      end
      describe 'destroy' do
        subject { create(:tag) }
        it 'ok request' do
          sign_in admin
  
          params = {
            tag: {
              name: Faker::Name.unique.name
            }
          }
          delete backend_tag_path(subject, format: :js), xhr: true
          expect(response.content_type).to eq('text/javascript')
          expect(response).to render_template(:destroy)
          expect(response).to have_http_status(:ok)
        end
      end
    end
    describe 'without user logged in' do
      describe 'index' do
        it 'fail request redirecto to sign_in' do
          get backend_tags_path
          expect(response).to redirect_to(user_session_path)
          expect(response).to have_http_status(:found)
        end
      end
    end
  end
  