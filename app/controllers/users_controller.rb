class UsersController < ApplicationController

  #showアクションの場合のみ
  before_action :set_user, only:[:show]

  def index
    @users = User.all
  end

  def show
    @users = User.all
  end

  #該当ユーザーデータを取得
  private
    def set_user
      @user = User.find(params[:id])
    end

end
