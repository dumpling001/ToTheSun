class Account::ArticlesController < ApplicationController
 before_action :authenticate_user!

 def index
   @articles =current_user.participated_articles
 end
 
end
