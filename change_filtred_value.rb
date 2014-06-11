require "gooddata"

GoodData.connect("username","password")
GoodData.use("l4mn95ag51qpvhs5nz5ujjsvgxjhk6ho")


metrics = GoodData::Metric.all(:full => true)

attribute_to_change = GoodData::Attribute.find_by_title("Dev").first
label = attribute_to_change.primary_label

metrics.each do |m|
  if (m.contain_value?(label,"petr@gooddata.com"))
    m.replace_value(label,"petr@gooddata.com",label,"jirka@gooddata.com")
    m.save
  end
end


