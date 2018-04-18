defmodule CryptotrackerWeb.PageController do
  use CryptotrackerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end


  def home(conn, _params) do
    render conn, "home.html"
  end

  def fetchAPI(conn, _params) do
    resp = HTTPoison.get!("https://min-api.cryptocompare.com/data/pricemulti?fsyms=ETH,DASH,LTC&tsyms=BTC,USD,EUR")
    IO.inspect(resp)
    data = Poison.decode!(resp.body)
    IO.inspect(data)
    IO.inspect(data["DASH"]["BTC"])
    render conn, "home.html"
  
  end

  def fetchpricefromAPI() do
    resp = HTTPoison.get!("https://min-api.cryptocompare.com/data/pricemulti?fsyms=ETH,DASH,LTC&tsyms=BTC,USD,EUR")
    IO.inspect(resp)
    data = Poison.decode!(resp.body)
    IO.inspect(data)
    IO.inspect(data["DASH"]["BTC"])
    data
    
  end
end
