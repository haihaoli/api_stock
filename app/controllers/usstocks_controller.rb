class UsstocksController < ApplicationController

  def index
    @q = Usstock.ransack(params[:q])
    @usstocks = @q.result.page(params[:page]).per(100)
  end

  def show
    @usstock = Usstock.find_by_juhe_gid!(params[:id])
    if @usstock.usstock?
      response = RestClient.get "http://web.juhe.cn:8080/finance/stock/usa", :params => {:gid => @usstock.juhe_gid, :key => JUHE_CONFIG["api_key"]}
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
      response = RestClient.get "http://web.juhe.cn:8080/finance/stock/hk", :params => {:num => @usstock.juhe_gid, :key => JUHE_CONFIG["api_key"]}
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
      response = RestClient.get "http://web.juhe.cn:8080/finance/stock/hs", :params => {:gid => @usstock.juhe_gid, :key => JUHE_CONFIG["api_key"]}
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
      Like.create(:user => current_user, :usstock => @usstock, :priearn => 0)
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
