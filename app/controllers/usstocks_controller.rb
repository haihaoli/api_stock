class UsstocksController < ApplicationController

  def index
    @q = Usstock.ransack(params[:q])
    @usstocks = @q.result.includes(:liked_users).page(params[:page]).per(10)
  end

  def show
    @usstock = Usstock.find_by_juhe_gid!(params[:id])
    if @usstock.usstock?
      response = RestClient.get "http://web.juhe.cn:8080/finance/stock/usa", :params => {:gid => @usstock.juhe_gid, :key => ENV["API_KEY"]}
      data = JSON.parse(response.body)
      s = data["result"][0]["data"]
      @lastestpri = s["lastestpri"]
      @openpri = s["openpri"]
      @formpri = s["formpri"]
      @limit = s["limit"]
      @uppic = s["uppic"]
      @priearn = s["priearn"]
      @ustime = s["ustime"]
      @time = s["time"]
    elsif @usstock.hkstock?
      response = RestClient.get "http://web.juhe.cn:8080/finance/stock/hk", :params => {:num => @usstock.juhe_gid, :key => ENV["API_KEY"]}
      data = JSON.parse(response.body)
      s = data["result"][0]["data"]
      @lastestpri = s["lastestpri"]
      @openpri = s["openpri"]
      @formpri = s["formpri"]
      @limit = s["limit"]
      @uppic = s["uppic"]
      @priearn = s["priearn"]
      @ustime = s["time"]
    elsif @usstock.cnstock?
      response = RestClient.get "http://web.juhe.cn:8080/finance/stock/hs", :params => {:gid => @usstock.juhe_gid, :key => ENV["API_KEY"]}
      data = JSON.parse(response.body)
      s = data["result"][0]["data"]
      response1 = RestClient.get "http://qt.gtimg.cn/", :params => { :q => @usstock.juhe_gid }  # 腾讯股票API
      @lastestpri = s["nowPri"]
      @openpri = s["todayStartPri"]
      @formpri = s["yestodEndPri"]
      @limit = s["increPer"]
      @uppic = s["increase"]
      @priearn = response1.body.split("~")[39]
      @ustime = s["time"]
      @stock_num = @usstock.juhe_gid.scan(/\d+/)[0]
    end

  end

  # def destroy
  #   @usstock = Usstock.find(params[:id])
  #   if @usstock.destroy
  #     redirect_to usstocks_path
  #   end
  # end

  def like
    @usstock = Usstock.find_by_juhe_gid!(params[:id])
    unless @usstock.find_like(current_user)
      if @usstock.usstock?
        response = RestClient.get "http://web.juhe.cn:8080/finance/stock/usa", :params => {:gid => @usstock.juhe_gid, :key => ENV["API_KEY"]}
        data = JSON.parse(response.body)
        priearn = data["result"][0]["data"]["priearn"]
      elsif @usstock.hkstock?
        response = RestClient.get "http://web.juhe.cn:8080/finance/stock/hk", :params => {:num => @usstock.juhe_gid, :key => ENV["API_KEY"]}
        data = JSON.parse(response.body)
        priearn = data["result"][0]["data"]["priearn"]
      elsif @usstock.cnstock?
        response1 = RestClient.get "http://qt.gtimg.cn/", :params => { :q => @usstock.juhe_gid }  # 腾讯股票API
        priearn = response1.body.split("~")[39]
      end
      Like.create!(:user => current_user, :usstock => @usstock, :priearn => "#{priearn}")
    end
    redirect_to :back
  end

  def unlike
    @usstock = Usstock.find_by_juhe_gid!(params[:id])
    like = @usstock.find_like(current_user)
    like.destroy

    redirect_to :back
  end

  private

  def usstock_params
    params.require(:usstock).permit(:juhe_gid)
  end
end
