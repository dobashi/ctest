defmodule CTest do
  alias Http.HttpClient
  alias Algae.Either
  alias Algae.Either.Right
  alias Algae.Either.Left
  @host "https://yahoo.co.jp"

  use Witchcraft.Functor

  def main(args \\ []) do
    args
    |> IO.puts()

    login

  end

  def login do
    #get(@host)
    #|> HttpClient.get_response_header("location")
    #|> get

    either("https://yahoo.co.jp")
#    |> IO.inspect
    |> map(fn x -> IO.puts"1st: #{inspect x}" end)

    either("https://www.yahoo.co.jp")
#    |> IO.inspect
    |> map(fn x -> IO.puts"2nd: #{inspect x}" end)
    :eof
  end

  defp get(url) do
    client = HttpClient.setup(url)
    |> HttpClient.get("/")
    IO.puts "status_code:#{client.response.status_code}"
    IO.puts "body:" <> Enum.join(for <<c::utf8 <- client.response.body>>, do: <<c::utf8>>)
    client
  end

  defp either(url) do
    client = HttpClient.setup(url)
    |> HttpClient.get("/")
    case client.response.status_code do
      200 -> Either.Right.new(client.response.body)
      _ -> Either.Left.new(client.response.status_code)
    end
  end

#  def map(%Right{}=e) do
#    e.Right
#  end
end


