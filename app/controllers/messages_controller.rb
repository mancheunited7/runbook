class MessagesController < ApplicationController

  #該当の会話データを取得
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    #会話に紐付くメッセージを取得
    @messages = @conversation.messages
    #メッセージの数が１０より大きい場合
    if @messages.length > 10
      #１０以上フラグON
      @over_ten = true
      #最新の１０件のみ取得
      @messages = @messages[-10..-1]
    end

    #メッセージの数が１０以下なら
    if params[:m]
      #１０以上フラグをOFF
      @over_ten = false
      #会話に紐付くメッセージを取得
      @messages = @conversation.messages
    end

    #メッセージの最後のデータを取得
    if @messages.last
      #メッセージの最後のデータのユーザーと現在のユーザーが違う場合
      if @messages.last.user_id != current_user.id
        #メッセージの既読フラグをON
        @messages.last.read = true
      end
    end

    #conversation_idが設定されたオブジェクトを新規に作成
    @message = @conversation.messages.build
  end

  def create
    #メッセージの内容、ユーザー情報を引き継いだデータオブジェクトを作成
    @message = @conversation.messages.build(message_params)
    #メッセージが保存された場合
    if @message.save
      #メッセージ一覧画面へ遷移
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private
    def message_params
      params.require(:message).permit(:body,:user_id)
    end

end
