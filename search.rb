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

    def goto_page(ebay_url)
      visit(ebay_url)
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
   
   ebay_category_xpath = "//*[@id='gh-cat']/option"
   ebay_sort_options = '//*[@id="Center"]/div[1]/ul/li[4]/div/a'
    ebay_url = "http://www.ebay.de/"
    ebay_sale_type = '//*[@id="Center"]/div[1]/ul/li[1]/div'  
    ebay_sale_type_auction= '//*[@id="Center"]/div[1]/ul/li[1]/div/div[2]/ul/li[1]'   
    ebay_most_demanded_auction = '//*[@id="ListViewInner"]/li[0]/div/div/a'
    
    digger = Digger.new
    digger.goto_page(ebay_url)
    digger.select_from_dropdown(ebay_category_xpath, 3)
    digger.hover_over_xpath(ebay_sort_options)
    digger.sort_by_expire_time
    
    digger.hover_over_xpath(ebay_sale_type)
    digger.click_on_xpath(ebay_sale_type_auction)
    digger.click_on_xpath(ebay_most_demanded_auction)

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
