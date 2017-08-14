class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.save

    redirect_to articles_path
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    @article.update(article_params)

    redirect_to articles_path, notice: "厉害了亲！修改文章这么艰巨的任务都被你完成了！"
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end

end
