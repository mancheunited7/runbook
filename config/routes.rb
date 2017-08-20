Rails.application.routes.draw do

   #１つの投稿に複数のコメントがくるので、commentsを
   #topicsに紐付けるルーティングを生成する
   resources :topics do
     resources :comments
   end

   #１つのconversationに対して複数のmessagesがくるので
   #messageをconversationに紐付ける
   resources :conversations do
     resources :messages
   end

   #トップ画面のルーティング設定
   root "top#index"

   #ユーザーに対する認証機能
   #controllers:以下は、ルーティング先をusersへ変更
   #コントローラーをカスタマイズするため
   devise_for :users, controllers: {
     registrations: "users/registrations",
     omniauth_callbacks: "users/omniauth_callbacks"
   }

   #usersテーブルのデータに対してindexアクションのみルーティングを生成する
   resources :users, only:[:index,:show]

   #relationshipsテーブルのデータに対して、create/destroyアクションのみ
   #ルーティングを生成する
   resources :relationships, only: [:create, :destroy]

   #web上でletter_openerを確認するための設定
   if Rails.env.development?
     mount LetterOpenerWeb::Engine, at: "/letter_opener"
   end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
