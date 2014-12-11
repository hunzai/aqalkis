module Agent
  require "capybara"
  
  class Artical
    attr_accessor :name, :price, :bets
  end

  class Digger
    include Capybara::DSL
    def initialize
      Capybara.configure do |config|
        config.match = :one
        config.exact_options = true
        config.default_driver = :selenium
        config.javascript_driver = :chrome
        config.ignore_hidden_elements = false
      end

    end

    def goto_page(url)
      visit(url)
    end

    def select_dropdown
      selector = find(:xpath, "//*[@id='gh-cat-box']")
      selector.click
    end
    
    def hover_over_xpath(xpath)
     element = find(:xpath , xpath).hover  
    end
    
    def click_on_xpath(xpath)
        find(:xpath, xpath, :visible=>false).click
    end
    
    def select_from_dropdown(xpath, index)
      find(:xpath, "#{xpath}[#{index}]").click
      find(:xpath, '//*[@id="gh-btn"]').click
    end

    def get_catergories
      within("#navigationDF") do
        return all("li")
      end
    end

    def click_on_auction(xpath)
      find(:xpath, xpath).click
    end

    def sort_by_expire_time
      find(:xpath, '//*[@id="Center"]/div[1]/ul/li[4]/div/div[2]/ul/li[7]/a').click
    end

    def get_all_auction_items
      within("#ListViewInner") do
        return all("li")
      end
    end
  end

  def self.ebay
   
   categories_options = "//*[@id='gh-cat']/option"
   sort_options = '//*[@id="Center"]/div[1]/ul/li[4]/div/a'
    url = "http://www.ebay.de/"
    digger = Digger.new
    digger.goto_page(url)
    digger.select_from_dropdown(categories_options, 3)
    digger.hover_over_xpath(sort_options)
    digger.sort_by_expire_time

  #out_put = ""
  puts digger.get_all_auction_items
  
  #.each do |tboy|
  #  first_row = tboy.find("tbody").all("tr")[0]
  #  out_put += "\n"
  #  out_put += first_row.all("td")[1].text
  #  out_put += first_row.all("td")[2].text
  #  out_put += first_row.all("td")[3].text
  #end

  #file = File.open(Time.now, "w+")
  #file.write(out_put)
  #file.close
  end

end

Agent.ebay
