require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  describe 'ユーザー作成機能' do
    context 'ユーザーを新規作成した場合' do
      it 'マイページに遷移する' do
        visit new_user_path
        fill_in 'user[name]', with: 'new_user_name'
        fill_in 'user[email]', with: 'new_user@xmail.com'
        fill_in 'user[password]', with: 'new_password'
        fill_in 'user[password_confirmation]', with: 'new_password'
        click_on 'Create my account'
        expect(page).to have_content 'user_name_1のページ'
      end
    end
    context 'ユーザーがログインせずにタスク一覧に遷移した場合' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(current_path).to eq(new_session_path)
      end
    end
  end
end