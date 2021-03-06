require "nokogiri"
require "pry"

def create_project_hash

  #below code was to grab data and use binding.pry to find within html
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html) #grabbing data with nokogiri

  projects = {}

  #Iterate through the projects

  kickstarter.css("li.project.grid_4")
  .each do |project|
    #below code makes it so each project title is a key and the value
    #is another hash with each of our other data points as keys
    title =
    project.css("h2.bbcard_name strong a").text
    #to_sym method converts the title into a symbol because symbols
    #make better hash keys than strings
    projects[title.to_sym] = {
      :image_link =>
      project.css("div.project-thumbnail a img").attribute("src").value,
      :description =>
      project.css("p.bbcard_blurb").text,
      :location =>
      project.css("ul.project-meta span.location-name").text,
      :percent_funded =>
      project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
      }

  end

  #returns the project hash
  projects
end

create_project_hash
# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta span.location-name").text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
