GoodData::Model::ProjectBuilder.create("Gooddata BI Automation Training") do |p|
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
        d.add_date("committed_on_new", :dataset => "committed_on_new")
        d.add_reference("dev_id", :dataset => 'devs', :reference => 'dev_id')
        d.add_reference("repo_id", :dataset => 'repos', :reference => 'repo_id')
    end

end