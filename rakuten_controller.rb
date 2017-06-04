def search_rakuten_api(keyword)
  items = RakutenWebService::Ichiba::Item.search(keyword: keyword)
  images_arr = []
  items.each do |item|
    puts item['itemName']
    puts item['itemPrice']
    puts item['itemUrl']
  end
end
