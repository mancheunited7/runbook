class Topic < ActiveRecord::Base

  #topic対userは多対1の関係
  belongs_to :user
  #topicは複数のcommentsを保持し、topicが削除されるとそれに紐付くcommentsも削除される
  has_many :comments, dependent: :destroy

  #標題と練習記録が空白の場合、エラー表示
  validates:title, presence:true
  validates:content,presence:true

end
