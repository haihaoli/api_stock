class UsstocksController < ApplicationController

  def index
    @q = Usstock.ransack(params[:q])
    @usstocks = @q.result.page(params[:page]).per(100)
  end

  def show
    @usstock = Usstock.find_by_juhe_gid!(params[:id])
    if @usstock.usstock?
      response = RestClient.get "http://web.juhe.cn:8080/finance/stock/usa", :params => {:gid => @usstock.juhe_gid, :key => JUHE_CONFIG["api_key"]}
    elsif @usstock.hkstock?
      response = RestClient.get "http://web.juhe.cn:8080/finance/stock/hk", :params => {:num => @usstock.juhe_gid, :key => JUHE_CONFIG["api_key"]}
    end
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
  end

  # def destroy
  #   @usstock = Usstock.find(params[:id])
  #   if @usstock.destroy
  #     redirect_to usstocks_path
  #   end
  # end

  private

  def usstock_params
    params.require(:usstock).permit(:juhe_gid)
  end
end
