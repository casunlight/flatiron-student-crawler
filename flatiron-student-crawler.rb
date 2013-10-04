#get list of links to crawl

require 'nokogiri'
require 'open-uri'
require 'pry'
main_page = Nokogiri::HTML(open('http://students.flatironschool.com/'))
students_list = main_page.css('.home-blog ul')
student_list_item = students_list.css('.blog-thumb a')
links_to_crawl = student_list_item.map { |i| i.attributes["href"].value  }
urlmap = links_to_crawl.map { |link| "http://students.flatironschool.com/" + link  }


#Methods to make:
#1. Student Image returns a string like 
#=> "../img/students/vivian_icon.png"
#=> Use a Regex or build a method to make this a relative URL

#2. Normalize Student Quote. Quote curreny looks like: 
# => "\"It is the age of Data Mining. Embrace it with all heart.\" -- Vivian Zhang Said this."
# Need some sort of Regex or build a method to strip the \

def crawl_page(student_page)
  url = Nokogiri::HTML(open(student_page))

  #Add things in here that you want to find
  #All paths should have a url.css() call in them to work properly

  #get name, image, quote
  name = url.css('.ib_main_header').children[0].text
  image = url.css('.student_pic').first.attributes["src"].value
  quote = url.css('.textwidget h3')[0].children.text

  #RETURN VALUE, FOR TESTING PURPOSES
  [name,image,quote]

end
#binding.pry

#For Testing purposes, run this function on Vivian and see what comes back
puts crawl_page(urlmap[0]).inspect