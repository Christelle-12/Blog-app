class CommentsController < ApplicationController

  
    def new
      @comment = Comment.new
    end
  
    def create
        @post = Post.find(params[:post_id])
        @comment = Comment.new(text: values[:text], author_id: params[:user_id], post_id: params[:post_id])
    
        if @comment.save
          redirect_to user_post_path(params[:user_id], params[:post_id])
        else
          render :new, alert: 'Error: Could not add comment.'
        end
    end
  
    private
  
    def values
        params.require(:comment).permit(:text)
    end
  end
  