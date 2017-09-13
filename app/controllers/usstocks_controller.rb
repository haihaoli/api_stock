class UsstocksController < ApplicationController

  def index
    @usstocks = Usstock.all
  end

  def new
    @usstock = Usstock.new
  end

  def create
    @usstock = Usstock.new(usstock_params)
    @usstock.save
    response = RestClient.get "http://web.juhe.cn:8080/finance/stock/usa", :params => {:gid => @usstock.juhe_gid, :key => JUHE_CONFIG["api_key"]}
    data = JSON.parse(response.body)

      @usstock.update(:name => data["result"][0]["data"]["name"],
                      :lastestpri => data["result"][0]["data"]["lastestpri"], :openpri => data["result"][0]["data"]["openpri"],
                      :formpri => data["result"][0]["data"]["formpri"], :limit => data["result"][0]["data"]["limit"],
                      :uppic => data["result"][0]["data"]["uppic"], :priearn => data["result"][0]["data"]["priearn"],
                      :beta => data["result"][0]["data"]["beta"])

    redirect_to usstock_path(@usstock)
  end


  def show
    @usstock = Usstock.find(params[:id])
  end

  private

  def usstock_params
    params.require(:usstock).permit(:juhe_gid)
  end
end
