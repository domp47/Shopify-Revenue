class Shopify

  require 'net/http'
  require 'json'

  i = 1

  url = 'https://shopicruit.myshopify.com/admin/orders.json?page='+i.to_s+'&access_token=c32313df0d0ef512ca64d5b336a0d7c6'
  uri = URI(url)
  response = Net::HTTP.get(uri)
  data =JSON.parse(response)

  if data['orders'].empty?
    empty = true
  else
    empty = false
  end


  until empty do

    i+=1

    url = 'https://shopicruit.myshopify.com/admin/orders.json?page='+i.to_s+'&access_token=c32313df0d0ef512ca64d5b336a0d7c6'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    page = JSON.parse(response)
    if page['orders'].empty?
      empty = true
    end

    data['orders'].concat page['orders']

  end

  orders =data['orders']

  revenue = 0

  orders.each do |order|
     revenue += order['total_price'].to_i
  end

  puts revenue

end