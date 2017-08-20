class Relationship < ActiveRecord::Base

  #relationshipsはuserとfollower_id及びfollowed_idを外部キーとして関連性をもつ
  #class_nameとしてuserを指定しないと、relationshipモデルはfollowerモデル、
  #followedモデルを関連先と判断する
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

end
