# 利用聚合数据API和腾讯API实时查询股票

支持大陆沪深AB股、港股、美股
![](https://ws3.sinaimg.cn/large/006tKfTcly1fkl2xe9togj318l0nd0wt.jpg)

注册登陆后能收藏自己喜欢的股票，并且支持一键更新市盈率，选出优质公司中最被低估的股票
![](https://ws3.sinaimg.cn/large/006tKfTcly1fkl2z2b879j31880xgdmp.jpg)

所有数据均为实时拉取，并显示新浪日线图
![](https://ws3.sinaimg.cn/large/006tNc79gy1fkn5q9j75qj318c0e8gq8.jpg)

使用方法：
1、请到 聚合数据api 申请 API_KEY， 放在 applicaiton.yml.example 上，记得要把后缀 example 删除。
链接：https://www.juhe.cn/docs/api/id/21

2、完成第一步后请以此执行以下命令
bundle
rake db:migrate
bundle exec rake dev:fetch_us_stock_list  #抓取美股
bundle exec rake dev:fetch_hk_stock_list  #抓取港股
bundle exec rake dev:fetch_sz_stock_list  #抓取深市
bundle exec rake dev:fetch_sh_stock_list  #抓取沪市


如有其他改进需求或意见，欢迎加微信或发邮件至 mashy1024@gmail.com 反馈
![](https://ws2.sinaimg.cn/large/006tKfTcly1fkl36jo7tkj30by0bygmf.jpg)
