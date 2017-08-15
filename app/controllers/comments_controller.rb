class CommentsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create]

  def new
    @article = Article.find(params[:article_id])
    @comment = Comment.new
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = Comment.new(comment_params)
    @comment.article = @article
    @comment.user = current_user

    if @comment.save
      redirect_to article_path(@article)
    else
      render :new
    end

  end

  def show
    @article = Article.find(params[:id])
    @comments = @article.comments
  end

  private

  def comment_params
    params.require(:comment).permit(:say)
  end
end
