defmodule HttpClient do
  defstruct [:headers, :base_url]
  def setup(url) do
    %HttpClient{base_url: url, headers: init_headers()}
  end

  defp init_headers() do
    %{
      #      "accept" => "application/json",
      # secure_browser_headers
      "x-frame-options" => "SAMEORIGIN",
      "x-content-type-options" => "nosniff",
      "x-xss-protection" => "1; mode=block",
      "x-download-options" => "noopen",
      "x-permitted-cross-domain-policies" => "none",
      "cross-origin-window-policy" => "deny",
      # inspected from real header
      "Accept" => "*/*",
      "Accept-Encoding" => "gzip, deflate, br",
      "Accept-Language" => "ja,en-US;q=0.9,en;q=0.8",
      "Connection" => "keep-alive",
      "Content-Type" => "application/json",
      "Host" => "localhost:4000",
      "Origin" => "http://localhost:4000",
      "Referer" => "http://localhost:4000/personal-assistant/",
      "Sec-Fetch-Mode" => "cors",
      "Sec-Fetch-Site" => "same-origin",
      "User-Agent" =>
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36",


      #"Content-Length" => "106"
      #                                                                                                                                                                                                          "Cookie" => ": _hrkun_key=QTEyOEdDTQ.y-klfAwjvDz-GSXPiMSTdAAyYOMBQPn2WqQFp9XDKszLDIrqUAJja_wcl-A.fMVoiRc5bJ_s83rR.mXyopvasu1wVSIbbuJ-5vUqiaz-0uJuJFlmgFnlsfg.b49S756gJlPBInufttIaqw",
    }
  end

  def add_header(%HttpClient{} = client, header) do
    headers = %{client.headers | header.key => header.value}
    %{client | headers: headers}
  end
  defp to_param_string(params) when is_map(params) do
    to_string_map = fn map -> for {k, v} <- map, into: %{}, do: {Atom.to_string(k), v} end

    Map.to_list(params)
    |> Enum.filter(fn entry -> elem(entry, 0) != :__struct__ end)
    |> to_string_map.()
    |> Enum.reduce("?", fn header, acc -> acc <> elem(header, 0) <> "=" <> elem(header, 1) <> "&" end)
  end
  defp to_param_string(params) when is_binary(params) do
    params
  end
  def get(client, path, params \\ "") do
    HTTPoison.get(client.base_url <> path <> to_param_string(params))
  end
  def post(client, path, params \\ "") do
    HTTPoison.post(client.base_url <> path, to_param_string(params))
  end
end