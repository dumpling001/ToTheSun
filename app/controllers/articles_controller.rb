class ArticlesController < ApplicationController
 before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy, :join, :quit]
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
    @comments = @article.comments.recent.paginate(:page => params[:page], :per_page => 5)

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

  def join
   @article = Article.find(params[:id])

    if !current_user.is_member_of?(@article)
      current_user.join!(@article)
      flash[:notice] = "关注成功！"
    else
      flash[:warning] = "你已经关注了本文章！"
    end

    redirect_to article_path(@article)
  end

  def quit
    @article = Article.find(params[:id])

    if current_user.is_member_of?(@article)
      current_user.quit!(@article)
      flash[:alert] = "已取消关注！"
    else
      flash[:warning] = "你没有关注本文章，无法取消关注。"
    end

    redirect_to article_path(@article)
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
