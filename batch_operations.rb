require "gooddata"
require "pp"

GoodData.connect("username","password")
GoodData.use("l4mn95ag51qpvhs5nz5ujjsvgxjhk6ho")

facts = GoodData::Fact.all(:full => true)
datasets_to_use = ["Devs","Repos"]
attributes = []

GoodData.project.datasets.find_all{|d| datasets_to_use.include?(d.json["dataSet"]["meta"]["title"])}.each do |dataset|
  attributes = attributes + dataset.attributes
end

metrics = []
facts.each do |f|
  metric = GoodData::Metric.xcreate(:expression => "SELECT SUM(![#{f.identifier}])", :title => "Sum of #{f.title}")
  metrics << metric
  metric.save
end


reports = []
metrics.each do |m|
  attributes.each do |a|
    report = GoodData::Report.create(:title => "Report #{m.title} by #{a.title}", :left => m, :top => a)
    reports << report
    report.save
  end
end

reports.each do |r|
  pp r.execute
end
