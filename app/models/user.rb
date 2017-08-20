class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  #devise機能の設定
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  #userは複数のtopicsを保持し、userが削除されるとそれに紐付くtopicsも削除される
  has_many :topics, dependent: :destroy
  #userは複数のcommentsを保持し、userが削除されるとそれに紐付くtopicsも削除される
  has_many :comments, dependent: :destroy
  #userはuser_idとrelationshipsのfollower_idをキーとして関連性を持ち、
  #（relationshipsにはuser_idカラムが存在しないので外部キーを指定しないと紐付けが行えない）
  #userが削除されるとそれに紐付くrelationshipも削除される
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  #userはrelationshipモデルとfollowed_idを外部キーとして、reverse_relationshipsの関連性を保持
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  #userがフォローしているユーザーデータを取得
  has_many :followed_users, through: :relationships, source: :followed
  #userをフォローしているユーザーデータを取得
  has_many :followers, through: :reverse_relationships, source: :follower

  #アップローダーの設定
  mount_uploader :avatar, AvatarUploader

  #クラスメソッドであるfind_for_facebook_oauthを設定
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    #usersテーブルからプロバイダーとユーザーidの条件に合う最初の１件を取り出し
    user = User.find_by(provider: auth.provider, uid: auth.uid)

    #該当のユーザーが存在しない場合、新規ユーザー登録
    unless user
      user = User.new(
        user_name: auth.extra.raw_info.name,
        provider: auth.provider,
        uid: auth.uid,
        email: auth.info.email ||= "#{auth.uid}-#{auth.provider}@example.com",
        image_url: auth.info.image,
        password: Devise.friendly_token[0,20]
      )
      #メール認証をスキップしてユーザー登録
      user.skip_confirmation!
      #ユーザー情報の保存
      user.save(validate: false)
    end
    user
  end

  #クラスメソッドであるfind_for_twitter_oauthを設定
  def self.find_for_twitter_oauth(auth,signed_in_resource=nil)
    user = User.find_by(provider: auth.provider, uid: auth.uid)

    unless user
      user = User.new(
      user_name: auth.info.nickname,
      provider: auth.provider,
      uid: auth.uid,
      email: auth.info.enail ||= "#{auth.uid}-#{auth.provider}@ecample.com",
      image_url: auth.info.image,
      password: Devise.friendly_token[0,20]
      )
      user.skip_confirmation!
      user.save(validate: false)
    end
    user
  end

  #クラスメソッドとして、ランダムなユーザーidを作成
  def self.create_unique_string
   SecureRandom.uuid
  end

  #パスワードの更新
  def update_with_password(params, *options)
    if provider.blank?
      super
    else
      params.delete :current_password
      update_without_password(params, *options)
    end
  end

  #フォロー
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  #フォローしているかの確認
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  #フォロー解除
  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

end
