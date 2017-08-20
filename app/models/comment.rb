class Comment < ActiveRecord::Base

  #commentはuserモデル、topicモデルと関連づけ
  belongs_to :user
  belongs_to :topic

end
