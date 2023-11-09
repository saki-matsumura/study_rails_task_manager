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
        select '未対応', from: 'ステータス'
        click_on '登録する'
        # ページにタスク名と概要が表示されるか確認
        expect(page).to have_content 'task_title'
        expect(page).to have_content 'task_summary'
        expect(page).to have_content '2023-11-01'
        expect(page).to have_content '未対応'
      end
    end
  end
  describe '一覧表示機能' do
    before do
      FactoryBot.create(
        :task, 
          title: 'task_title1',
          summary: 'task_summary',
          deadline: '002023-11-10',
          status: 'untouched'
        )
      FactoryBot.create(
        :task,
        title: 'task_title2', 
        summary: 'task_summary', 
        deadline: '002023-11-08',
        status: 'in_progress'
        )
      FactoryBot.create(
        :task, 
          title: 'task_title_search1', 
          summary: 'task_summary', 
          deadline: '002023-11-07',
          status: 'in_progress'
        )
      FactoryBot.create(
        :task, 
          title: 'task_title_search2', 
          summary: 'task_summary', 
          deadline: '002023-11-07',
          status: 'done'
        )
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
        FactoryBot.create(:task, title: 'new_task', summary: 'task_summary', deadline: '002023-11-10')
        visit tasks_path
        task_list = all('.task_row')
        # 1行目のタスクが、最後に作成したタスクと一致しているか？
        expect(task_list[0]).to have_content 'new_task'
      end
    end
    context '「終了期限でソート」ボタンを押した場合' do
      it '終了期限の降順に並び替えられる' do
        visit tasks_path
        click_link '終了期限でソートする'
        sleep 1
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'task_title1'
      end
    end
    context '検索ワードを入力し、「検索」ボタンを押した場合' do
      it 'タスク名に検索ワードを含んだタスクのみ表示される' do
        visit tasks_path
        fill_in 'title_like', with: 'search'
        click_on '検索'
        sleep 1
        task_list = all('.task_row')
        task_list.each do |task|
          expect(task).to have_content 'search'
        end
      end
    end
    context '特定のステータスを選択し、「検索」ボタンを押した場合' do
      it '特定のステータスのタスクのみ表示される' do
        visit tasks_path
        select '進行中', from: 'status'
        click_on '検索'
        sleep 1
        task_list = all('.task_row')
        task_list.each do |task|
          expect(task).to have_content '進行中'
        end
      end
    end
    context '検索ワードを入力し、特定のステータスを選択して「検索」ボタンを押した場合' do
      it '検索ワードとステータスに一致するタスクのみ表示される' do
        visit tasks_path
        fill_in 'title_like', with: 'search'
        select '進行中', from: 'status'
        click_on '検索'
        sleep 1
        task_list = all('.task_row')
        task_list.each do |task|
          expect(task).to have_content 'search'
          expect(task).to have_content '進行中'
        end
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