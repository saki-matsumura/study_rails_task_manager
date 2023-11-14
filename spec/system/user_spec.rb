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
        expect(page).to have_content 'new_user_nameのページ'
      end
    end
    context 'ユーザーがログインせずにタスク一覧に遷移した場合' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(current_path).to eq(new_session_path)
      end
    end
    context 'ログイン画面からemailとパスワードを入力した場合' do
      it 'ログインしてマイページに遷移する' do
        FactoryBot.create(
        :user, 
          name: 'user1',
          email: 'user1@xmail.com',
          password: 'password1'
        )
        visit new_session_path
        fill_in 'session[email]', with: 'user1@xmail.com'
        fill_in 'session[password]', with: 'password1'
        click_on 'Log in'
        expect(page).to have_content 'user1のページ'
      end
    end
  end

  describe 'ログイン機能' do
    before do
      FactoryBot.create(
        :user, 
          name: 'user1',
          email: 'user1@xmail.com',
          password: 'password1'
        )
      FactoryBot.create(
        :user, 
          name: 'user2',
          email: 'user2@xmail.com',
          password: 'password2'
        )
      # user1でログインする
      visit new_session_path
        fill_in 'session[email]', with: 'user1@xmail.com'
        fill_in 'session[password]', with: 'password1'
        click_on 'Log in'
    end
    context 'ログインした状態でマイページボタンを押した場合' do
      it 'マイページに遷移する' do
        visit tasks_path
        click_on 'マイページ'
        expect(current_path).to eq(user_path(User.first))
      end
    end
    context 'ログインした状態で、自分以外のユーザー詳細にアクセスした場合' do
      it '一覧画面に遷移する' do
        visit user_path(User.last)
        expect(current_path).to eq(tasks_path)
      end
    end
    context 'ログアウトボタンを押した場合' do
      it 'ログアウトする' do
        visit tasks_path
        click_on 'ログアウト'
        expect(current_path).to eq(new_session_path) 
      end
    end
  end
end