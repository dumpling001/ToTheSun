class WelcomeController < ApplicationController
 def index
   flash[:warning] = "欢迎来到我的网站！"
 end

end
