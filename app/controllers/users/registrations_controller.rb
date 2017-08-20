class Users::RegistrationsController < Devise::RegistrationsController

  #ユーザーidをフォームから登録ではなく自動的に生成
  def build_resource(hash=nil)
    #ランダムなユーザーidを作成
    hash[:uid] = User.create_unique_string
    super
  end

end
