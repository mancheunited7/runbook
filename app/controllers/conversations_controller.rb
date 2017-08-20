class ConversationsController < ApplicationController

  #ログイン済ユーザーのみ利用可能
  before_action :authenticate_user!

  def index
    #全ての会話データを取得
    @conversations = Conversation.all
    #全てのユーザーデータを取得
    @user = User.all
  end

  def create
    #会話データが送り主と受取人の間にあるか確認
    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      #会話データがあれば最初のデータを取得
      @conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
    else
      #会話データがなければ会話を作成
      @conversation = Conversation.create!(conversation_params)
    end
    #会話に紐付くメッセージの詳細画面へ
    redirect_to conversation_messages_path(@conversation)
  end

  #ストロングパラメータの設定
  private
    def conversation_params
      params.permit(:sender_id,:recipient_id)
    end

end
