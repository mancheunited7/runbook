class TopicsController < ApplicationController

  #ログイン済の場合のみアクセス許可
  before_action :authenticate_user!
  #投稿内容の引き継ぎ 共通化
  before_action :set_topic,only:[:edit,:destroy]

  def index
    #Topicモデル（Topicsテーブル）から全データを取得し
    #データをviewに引き渡すためインスタンス変数に格納
    @topics = Topic.all
    #HTMLとjson、アクセスパターンによって使い分ける
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    #Topicオブジェクトを新規に生成
    @topic = Topic.new
  end

  def create
    #投稿内容をパラメータとして引き継ぎ
    @topic = Topic.new(topic_params)
    #ユーザーIDの引き継ぎ
    @topic.user_id=current_user.id
    #ユーザー名の引き継ぎ
    @topic.user_name=current_user.user_name
    #topicの保存ができた場合
    if @topic.save
      #メッセージを表示し、投稿一覧画面へ遷移
      redirect_to topics_path,notice:"新規練習記録を投稿しました!"
      #投稿内容をメールで通知
      NoticeMailer.sendmail_topic(@topic).deliver
    else
      #保存できなかった場合は、投稿画面を表示
      render 'new'
    end
  end

  def show
    @topic = Topic.find(params[:id])
    #入力フォーム用のインスタンス変数作成（topicと関連づいた状態）
    @comment = @topic.comments.build
    #コメント情報取得
    @comments = @topic.comments
  end

  def edit
  end

  def update
    @topic = Topic.find(params[:id])
    #更新できた場合はメッセージを表示し一覧画面へ
    if @topic.update(topic_params)
      redirect_to topics_path,notice:"練習内容を編集しました"
    else
    #更新できなかった場合は、再度編集画面へ
      render 'edit'
    end
  end

  def destroy
    #投稿を削除
    @topic.destroy
    #メッセージを表示し投稿一覧を表示
    redirect_to topics_path,notice:"練習記録を削除しました"
  end

private
 #ストロングパラメータの設定（title、contentのみ有効）
 def topic_params
   params.require(:topic).permit(:title,:content)
 end

#投稿内容の引き継ぎ 共通化
 def set_topic
    @topic = Topic.find(params[:id])
 end

end
