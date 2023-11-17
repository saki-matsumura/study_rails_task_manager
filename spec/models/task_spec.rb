require "rails_helper"

RSpec.describe Task, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: '', summary: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '失敗テスト', summary: '')
        expect(task).not_to be_valid
        
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: '成功テスト', summary: '成功テスト', user_id: @user.id)
        expect(task).to be_valid
      end
    end
  end
  describe '検索機能のテスト' do
    let!(:task) { FactoryBot.create(:task, title: 'task', status: 'in_progress', user_id: @user.id ) }
    let!(:second_task) { FactoryBot.create(:second_task, title: 'sample', status: 'done', user_id: @user.id )}
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.title_like('task')).to include(task)
        expect(Task.title_like('task')).not_to include(second_task)
        expect(Task.title_like('task').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.status('in_progress')).to include(task)
        expect(Task.status('in_progress')).not_to include(second_task)
        expect(Task.status('in_progress').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.title_like('task').status('in_progress')).to include(task)
        expect(Task.title_like('task').status('in_progress')).not_to include(second_task)
        expect(Task.title_like('task').status('in_progress').count).to eq 1
      end
    end
    #  - - - - - - - - - - - - - - - - - - - - - - - 
    context 'scopeメソッドでラベル検索をした場合' do
      it "条件に完全一致するタスク絞り込まれる" do
        target_id = task.labels.ids
        expect(Task.label_id(target_id)).to include(task)
        expect(Task.label_id(target_id)).not_to include(second_task)
        expect(Task.label_id(target_id).count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とラベル検索をした場合' do
      it "条件に完全一致するタスク絞り込まれる" do
        target_id = task.labels.ids
        expect(Task.title_like('task').label_id(target_id)).to include(task)
        expect(Task.title_like('task').label_id(target_id)).not_to include(second_task)
        expect(Task.title_like('task').label_id(target_id).count).to eq 1
        
        
        # label_id = Label.find_by(title: "label-1").id
        # target_id = task.labels.ids
        # expect(Task.title_like('task').label_id(target_id)).to include(task)


        # target_id = Label.find_by(title: "label-1")
        # binding.irb
        # expect(Task.title_like('task').label_id(Label.find_by(title: "label-1").id)).to include(task)
        # label_id = Label.find_by(title: "label-1").id
        # target_id = task.labels.id
        # expect(Task.title_like('task').label_id(target_id)).not_to include(second_task)
        # expect(Task.title_like('task').label_id(target_id).count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索とラベル検索をした場合' do
      it "条件に完全一致するタスク絞り込まれる" do
        target_id = task.labels.ids
        expect(Task.status('in_progress').label_id(target_id)).to include(task)
        expect(Task.status('in_progress').label_id(target_id)).not_to include(second_task)
        expect(Task.status('in_progress').label_id(target_id).count).to eq 1
      end
    end
    context 'scopeメソッドでタイトル、ステータス、ラベル検索をした場合' do
      it "条件に完全一致するタスク絞り込まれる" do
        target_id = task.labels.ids
        expect(Task.title_like('task').status('in_progress').label_id(target_id)).to include(task)
        expect(Task.title_like('task').status('in_progress').label_id(target_id)).not_to include(second_task)
        expect(Task.title_like('task').status('in_progress').label_id(target_id).count).to eq 1
      end
    end
    #  - - - - - - - - - - - - - - - - - - - - - - - 


  end
end
