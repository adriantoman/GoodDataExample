require "gooddata"

GoodData.connect("username","password")
GoodData.use("l4mn95ag51qpvhs5nz5ujjsvgxjhk6ho")


metrics = GoodData::Metric.all(:full => true)

metrics.each do |m|
  user = GoodData.get(m.meta["contributor"])
  created = DateTime.parse(m.meta["created"])
  if (user["accountSetting"]["login"] == "adrian.toman+deploy_test@gooddata.com" and created > DateTime.now - 2.days)
    m.tags += "new_functionality"
    m.save
  end
end

GoodData::Metric.find_by_tag('new_functionality').each do |m|
  puts m["title"]
end





