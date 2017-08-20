class CommentsController < ApplicationController

  def create
    #投稿に紐付くコメントとしてインスタンスを作成
    @comment = current_user.comments.build(comment_params)
    #コメントの投稿を取得
    @topic = @comment.topic

    #コメントが保存できた場合とできなかった場合でリクエストフォーマットを分ける
    respond_to do |format|
      #コメントを保存した場合
      if @comment.save
        #HTMlリクエストによるメッセージを表示し詳細画面を表示
        format.html{redirect_to topic_path(@topic),notice:'コメントを投稿しました。'}
        #javascriptリクエストでindex画面の表示
        format.js {render :index}
      else
        #新規投稿画面の表示
        format.html {render :new}
      end
    end
  end

  def edit
    #topicの情報を取得
    @topic = Topic.find(params[:topic_id])
    #編集するコメントを取得
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to topic_path(id: @comment.topic_id), notice:"コメントを編集しました"
    else
      render "comments/edit"
    end
  end

  def destroy
    #commentsテーブルから該当番号のコメントデータを取得
    @comment = Comment.find(params[:id])
    #コメントのデータを削除
    @comment.destroy
    #javascriptでのindexビューを呼び出し
    respond_to do |format|
      format.js {render :index}
    end
  end

  private
   #ストロングパラメータの設定（topic_idとcontentのみパラメータとして渡す）
   def comment_params
    params.require(:comment).permit(:topic_id,:content)
   end

end
