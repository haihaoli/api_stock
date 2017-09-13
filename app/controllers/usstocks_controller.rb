class UsstocksController < ApplicationController

  def index
    @usstocks = Usstock.all
  end

  def show
    @usstock = Usstock.find(params[:id])
    response = RestClient.get "http://web.juhe.cn:8080/finance/stock/usa", :params => {:gid => @usstock.juhe_gid, :key => JUHE_CONFIG["api_key"]}
    data = JSON.parse(response.body)
    @lastestpri = data["result"][0]["data"]["lastestpri"]
    @openpri = data["result"][0]["data"]["openpri"]
    @formpri = data["result"][0]["data"]["formpri"]
    @limit = data["result"][0]["data"]["limit"]
    @uppic = data["result"][0]["data"]["uppic"]
    @priearn = data["result"][0]["data"]["priearn"]
    @beta = data["result"][0]["data"]["beta"]
    @ustime = data["result"][0]["data"]["ustime"]
  end

  private

  def usstock_params
    params.require(:usstock).permit(:juhe_gid)
  end
end
