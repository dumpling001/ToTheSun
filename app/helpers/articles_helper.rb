module ArticlesHelper
 def render_article_description(article)
   simple_format(article.content)
 end
end
