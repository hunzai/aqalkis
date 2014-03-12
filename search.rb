require "capybara"

class Artical
  attr_accessor :name, :price, :bets
end

class Digger
  include Capybara::DSL
  def initialize
    Capybara.default_driver = :selenium
    Capybara.javascript_driver = :selenium
    Capybara.ignore_hidden_elements = false
  end

  def loadSite(url)
    visit(url)
  end

  def select_dropdown
      selector = find(:xpath, '//*[@id="gh-cat-box"]')
      selector.click
  end
  
  def select_from_dropdown(index)
    find(:xpath, "//*[@id='gh-cat']/option[#{index}]").click
    find(:xpath, '//*[@id="gh-btn"]').click
  end
  
  def get_catergories
    within("#navigationDF") do
      return all("li")
    end
  end

  def click_on_auction
     find(:xpath, '//*[@id="LeftNavContainer"]/div[1]/div[2]/a[1]').click
  end

  def sort_by_expire_time
    find("#DashSortByContainer").click
    find("a", :text => "Gebotsanzahl: meiste zuerst").click
  end

  def get_all_auction_items
    within("#Results") do
      return all("table")
    end
  end
end

url = "http://www.ebay.de/"
digger = Digger.new
digger.loadSite(url)
digger.select_dropdown()
digger.select_from_dropdown(3)
digger.click_on_auction()
digger.sort_by_expire_time()


#digger.load_category("#gh-cat", "Baby", "#gh-btn")

#out_put = ""
#digger.get_all_auction_items.each do |tboy|
#  first_row = tboy.find("tbody").all("tr")[0]
#  out_put += "\n"
#  out_put += first_row.all("td")[1].text
#  out_put += first_row.all("td")[2].text
#  out_put += first_row.all("td")[3].text
#end

#file = File.open(Time.now, "w+")
#file.write(out_put)
#file.close
