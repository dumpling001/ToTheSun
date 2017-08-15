class ArticlesController < ApplicationController
 before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
 before_action :find_article_and_check_permission, only: [:edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      redirect_to articles_path
    else
      render :new
    end
  end

  def show
    @article = Article.find(params[:id])
    @comments = @article.comments.recent
    
  end

  def edit

  end

  def update

    if @article.update(article_params)
      redirect_to articles_path, notice: "厉害了亲！修改文章这么艰巨的任务都被你完成了！"
    else
      render :edit
    end
  end

 def destroy

   @article.destroy
   redirect_to articles_path, alert: "文章删掉啦！"
 end

  private

  def find_article_and_check_permission
    @article = Article.find(params[:id])

    if current_user != @article.user
      redirect_to root_path, alert: "您没有编辑权限哦！"
    end

  end

  def article_params
    params.require(:article).permit(:title, :content)
  end

end
