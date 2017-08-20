class RelationshipsController < ApplicationController

  #ログイン済の場合のみ利用可能
  before_action :authenticate_user!
  #jsonフォーマット設定
  respond_to :js

  def create
    #フォローしたいユーザーデータを取得
    @user = User.find(params[:relationship][:followed_id])
    #そのユーザーをフォロー
    current_user.follow!(@user)
    #@userを引数にjsフォーマトを呼び出し
    respond_with @user
  end

  def destroy
    #フォローしているユーザーデータを取得
    @user = Relationship.find(params[:id]).followed
    #そのユーザーのフォローを解除
    current_user.unfollow!(@user)
    #@userを引数にjsフォーマットを呼び出し
    respond_with @user
  end
end
