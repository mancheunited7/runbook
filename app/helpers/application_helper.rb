module ApplicationHelper

  #プロフィール画像の設定
  def profile_img(user)

    #アップロードした画像の表示設定　アップロード画像が存在した場合 alt:画像の変わりとなる説明
    return image_tag(user.avatar, alt: user.user_name) if user.avatar.present?

    #providerが空白でない場合
    unless user.provider.blank?
      #snsから取得したフロフィール画像を設定
      img_url = user.image_url
    else
      #provider設定がない場合は「no_image」画像を設定
      img_url = 'images.png'
    end
    #画像表示設定
    image_tag(img_url, width: "10%", alt: user.user_name)
  end

end
