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
        click_on '登録する'
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
      admin_user = FactoryBot.create(
        :user, 
          name: 'user1',
          email: 'user1@xmail.com',
          password: 'password1'
        )
      general_user = FactoryBot.create(
        :user, 
          name: 'user2',
          email: 'user2@xmail.com',
          password: 'password2'
        )
      # 一般ユーザーでログインする
      visit new_session_path
      login(general_user)
    end
    context 'ログインした状態でマイページボタンを押した場合' do
      it 'マイページに遷移する' do
        visit tasks_path
        click_on 'マイページ'
        expect(current_path).to eq(user_path(User.last))
      end
    end
    context 'ログインした状態で、自分以外のユーザー詳細にアクセスした場合' do
      it '一覧画面に遷移する' do
        visit user_path(User.first)
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
    context '一般ユーザーが管理ページadimn_users_pathにアクセスした場合' do
      it 'アクセスできない' do
        visit admin_users_path
        expect(current_path).not_to eq admin_users_path
      end
    end
  end

  describe '管理機能' do
    before do
      admin_user = FactoryBot.create(
        :user, 
          name: 'user1',
          email: 'user1@xmail.com',
          password: 'password1',
          roll: 'admin'
        )
      general_user = FactoryBot.create(
        :user, 
          name: 'user2',
          email: 'user2@xmail.com',
          password: 'password2'
        )
      # 管理ユーザーでログイン
      visit new_session_path
      login(admin_user)
    end

    context '管理ユーザーがadimn_users_pathにアクセスした場合' do
      it 'アクセスできる' do
        visit admin_users_path
        expect(current_path).to eq admin_users_path
      end
    end
    context '管理ユーザーが新規ユーザーを作成した場合' do
      it 'ユーザーを作成できる' do
        visit new_admin_user_path
        fill_in 'user[name]', with: 'new_user_name'
        fill_in 'user[email]', with: 'new_user@xmail.com'
        fill_in 'user[password]', with: 'new_password'
        fill_in 'user[password_confirmation]', with: 'new_password'
        click_on '登録する'
        expect(User.count).to eq 3
      end
    end
    context '管理ユーザーが、他のユーザーの詳細画面にアクセスした場合' do
      it 'アクセスできる' do
        visit user_path(User.last)
        expect(current_path).to eq user_path(User.last)
      end
    end
    context '管理ユーザーがユーザー情報を編集した場合' do
      it '編集した内容が反映される' do
        visit edit_admin_user_path(User.last)
        fill_in 'user[name]', with: 'change_user_name'
        fill_in 'user[email]', with: 'change_user@xmail.com'
        select '管理者', from: '権限'
        click_on '更新する'
        expect(User.last.name).to eq 'change_user_name'
        expect(User.last.email).to eq 'change_user@xmail.com'
        expect(User.last.roll).to eq 'admin'
      end
    end
    context '管理ユーザーがユーザーを削除した場合' do
      it '削除できる' do
        visit admin_users_path
        all('.task_row')[1].click_link '削除'
        page.driver.browser.switch_to.alert.accept
        sleep 1
        expect(User.count).to eq 1
      end
    end
  end
end