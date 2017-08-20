class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #devise関連の画面に行った時にはconfigure_permited_parametersを呼び出し
  before_action :configure_permited_parameters, if: :devise_controller?

  #ユーザー名と画像が新規登録、ユーザー編集が行われた際パラメータに含まれるように設定
  PERMISSIBLE_ATTRIBUTES = %i(user_name avatar avatar_cache)

  protected
   def configure_permited_parameters
     devise_parameter_sanitizer.permit(:sign_up,keys: PERMISSIBLE_ATTRIBUTES)
     devise_parameter_sanitizer.permit(:account_update,keys: PERMISSIBLE_ATTRIBUTES)
  end

end
