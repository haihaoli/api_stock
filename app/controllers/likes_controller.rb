class LikesController < ApplicationController
  before_action :authenticate_user!

  def index
    @likes = Like.where(:user => current_user).includes(:usstock).order("priearn ASC")
  end

  def update
    @like = Like.find(params[:id])
  end

  def priearn_update
    @likes = current_user.likes
    @likes.each do |like|
      if like.usstock.usstock?
        response = RestClient.get "http://web.juhe.cn:8080/finance/stock/usa", :params => {:gid => like.usstock.juhe_gid, :key => JUHE_CONFIG["api_key"]}
        data = JSON.parse(response.body)
        priearn = data["result"][0]["data"]["priearn"]
      elsif like.usstock.hkstock?
        response = RestClient.get "http://web.juhe.cn:8080/finance/stock/hk", :params => {:num => like.usstock.juhe_gid, :key => JUHE_CONFIG["api_key"]}
        data = JSON.parse(response.body)
        priearn = data["result"][0]["data"]["priearn"]
      elsif like.usstock.cnstock?
        response1 = RestClient.get "http://qt.gtimg.cn/", :params => { :q => like.usstock.juhe_gid }  # 腾讯股票API
        priearn = response1.body.split("~")[39]
      end
      like.update(:priearn => "#{priearn}")
    end
    flash[:notice] = "实时抓取数据成功"
    redirect_to likes_path
  end

end
