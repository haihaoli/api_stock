namespace :dev do
  # 抓美股
  task :fetch_us_stock_list => :environment do
    puts "Fetch stock data..."
    total = 0
    for i in 1..135 do

      response = RestClient.get "http://web.juhe.cn:8080/finance/stock/usaall", :params => {:key => ENV["API_KEY"], :page => "#{i}", :type => "3"}
      data = JSON.parse(response.body)
      data["result"]["data"].each do |s|
        existing_stock = Usstock.find_by_juhe_gid(s["symbol"])
        if existing_stock.nil?
          Usstock.create!(:juhe_gid => s["symbol"], :name => s["cname"], :stock_type => "美股")
          total += 1
        end
      end

    end
    puts "#{total} data is fetched"
  end

  # 抓港股
  task :fetch_hk_stock_list => :environment do
    puts "Fetch stock data..."
    total = 0
    for i in 1..4 do

      response = RestClient.get "http://web.juhe.cn:8080/finance/stock/hkall", :params => {:key => ENV["API_KEY"], :page => "#{i}", :type => "4"}
      data = JSON.parse(response.body)
      data["result"]["data"].each do |s|
        existing_stock = Usstock.find_by_juhe_gid(s["symbol"])
        if existing_stock.nil?
          Usstock.create!(:juhe_gid => s["symbol"], :name => s["name"], :stock_type => "港股")
          total += 1
        end
      end

    end
    puts "#{total} data is fetched"
  end

  # 抓深市
  task :fetch_sz_stock_list => :environment do
    puts "Fetch stock data..."
    total = 0
    for i in 1..26 do

      response = RestClient.get "http://web.juhe.cn:8080/finance/stock/szall", :params => {:key => ENV["API_KEY"], :page => "#{i}", :type => "4"}
      data = JSON.parse(response.body)
      data["result"]["data"].each do |s|
        existing_stock = Usstock.find_by_juhe_gid(s["symbol"])
        if existing_stock.nil?
          Usstock.create!(:juhe_gid => s["symbol"], :name => s["name"], :stock_type => "深市")
          total += 1
        end
      end

    end
    puts "#{total} data is fetched"
  end

  # 抓沪市
  task :fetch_sh_stock_list => :environment do
    puts "Fetch stock data..."
    total = 0
    for i in 1..17 do

      response = RestClient.get "http://web.juhe.cn:8080/finance/stock/shall", :params => {:key => ENV["API_KEY"], :page => "#{i}", :type => "4"}
      data = JSON.parse(response.body)
      data["result"]["data"].each do |s|
        existing_stock = Usstock.find_by_juhe_gid(s["symbol"])
        if existing_stock.nil?
          Usstock.create!(:juhe_gid => s["symbol"], :name => s["name"], :stock_type => "沪市")
          total += 1
        end
      end

    end
    puts "#{total} data is fetched"
  end

end
