class Message < ActiveRecord::Base
  #messageはconversationとuserに紐付く
  belongs_to :conversation
  belongs_to :user

  #メッセージの内容、紐付く会話、ユーザーの値が空出ないか確認
  validates_presence_of :conversation_id,:user_id
  #時刻の表示を指定
  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end
end
