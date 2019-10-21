defmodule CTest do
  @host "http://localhost:4000"
  @path "/personal-assistant/api/"
  @header_csrf "X-CSRF-TOKEN"

  defmodule LoginParam do
    defstruct [:company_code, :email, :password]
  end
  def login do
    client = HttpClient.setup(@host <> @path)
    param = %LoginParam{
      company_code: "testcp_edia",
      email: "ko.sato.exwzd+exa_admin_00@gmail.com",
      password: "my77Strong#paSS"
    }

    HttpClient.post(client, "auth", param)
  end

  def teams do
    client = HttpClient.setup(@host <> @path)
    HttpClient.get(client, "team")
  end
end
