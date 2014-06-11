require "gooddata"
require "pp"

builder = GoodData::Model::ProjectBuilder.create("Gooddata BI Automation Training") do |p|
  p.add_date_dimension("committed_on")
  p.add_date_dimension("committed_on_new")

  p.add_dataset("repos") do |d|
    d.add_anchor("repo_id")
    d.add_label("name", :reference => "repo_id")
  end

  p.add_dataset("devs") do |d|
    d.add_anchor("dev_id")
    d.add_label("email", :reference => "dev_id")
  end

  p.add_dataset("commits") do |d|
    d.add_fact("lines_changed")
    d.add_fact("another_fact")
    d.add_date("committed_on", :dataset => "committed_on")
    d.add_reference("dev_id", :dataset => 'devs', :reference => 'dev_id')
    d.add_reference("repo_id", :dataset => 'repos', :reference => 'repo_id')
  end

end


blueprint = builder.to_blueprint

GoodData.connect("username","password")
GoodData.use("l4mn95ag51qpvhs5nz5ujjsvgxjhk6ho")

devs = blueprint.find_dataset("devs")
devs.upload("my_test_project/data/devs.csv")

repos = blueprint.find_dataset("repos")
repos.upload("my_test_project/data/repos.csv")

commits = blueprint.find_dataset("commits")
commits.upload("my_test_project/data/commits.csv")





