require "gooddata"
require "pp"

GoodData.connect("username","password")
GoodData.use("l4mn95ag51qpvhs5nz5ujjsvgxjhk6ho")

def create_div_metrics(metric,date_attibute)
  this = GoodData::Metric.xcreate(:expression => "SELECT ![#{metric.identifier}] WHERE ![#{date_attibute.identifier}] = THIS", :title => "SUM this #{date_attibute.title}")
  this.save

  previous = GoodData::Metric.xcreate(:expression => "SELECT ![#{metric.identifier}] WHERE ![#{date_attibute.identifier}] = THIS - 1", :title => "SUM previous #{date_attibute.title}")
  previous.save

  div = GoodData::Metric.xcreate(:expression => "SELECT ![#{this.identifier}]/![#{previous.identifier}] - 1", :title => "Div by #{date_attibute.title}")
  div.save
end

facts = GoodData::Fact.all(:full => true)
fact = facts.first
metric = GoodData::Metric.xcreate(:expression => "SELECT SUM(![#{fact.identifier}])", :title => "Simple sum")
metric.save

attributes = GoodData::Attribute.all(:full => true)

attribute_month_year = attributes.find{|a| a.title == "Month/Year (Committed on)"}
attribute_quarter_year = attributes.find{|a| a.title == "Quarter/Year (Committed on)"}

create_div_metrics(metric,attribute_month_year)
create_div_metrics(metric,attribute_quarter_year)




