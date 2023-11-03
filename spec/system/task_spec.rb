require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        # タスクを新規作成する
        visit new_task_path
        fill_in 'task[title]', with: 'task_title'
        fill_in 'task[summary]', with: 'task_summary'
        fill_in 'task[deadline]', with: '002023-11-01'
        click_on '登録する'
        # ページにタスク名と概要が表示されるか確認
        expect(page).to have_content 'task_title'
        expect(page).to have_content 'task_summary'
        expect(page).to have_content '2023-11-01'
      end
    end
  end
  describe '一覧表示機能' do
    before do
      FactoryBot.create(:task, title: 'task_title1', summary: 'task_summary1', deadline: '002023-11-10')
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        # 表示内容を確認
        expect(page).to have_content 'task_title1'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '一番上に新しいタスクが表示される' do
        FactoryBot.create(:task, title: 'task_title2', summary: 'task_summary2', deadline: '002023-11-10')
        visit tasks_path
        task_list = all('.task_row')
        # 1行目のタスクが、最後に作成したタスクと一致しているか？
        expect(task_list[0]).to have_content 'task_title2'
      end
    end
    context '「終了期限でソート」ボタンを押した場合' do
      it '終了期限の降順に並び替えられる' do
        FactoryBot.create(:task, title: 'task_title2', summary: 'task_summary2', deadline: '002023-11-08')
        FactoryBot.create(:task, title: 'task_title3', summary: 'task_summary3', deadline: '002023-11-07')
        visit tasks_path
        click_link '終了期限でソートする'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'task_title1'
      end
    end
  end
  describe '詳細表示機能' do
    before do
      # テスト用のタスクを作成
      FactoryBot.create(:task, title: 'task_title', summary: 'task_summary')
    end
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        # タスク一覧画面へ遷移
        task_id = Task.last.id
        visit task_path(task_id)
        # 内容を確認する
        expect(page).to have_content 'task_title'
        expect(page).to have_content 'task_summary'
      end
    end
  end
end