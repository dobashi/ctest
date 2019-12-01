defmodule CTest do
  alias Algae.Either.Right
  alias Algae.Either.Left

  use Witchcraft.Functor

  def main(args \\ []) do
      ok(2)
      |> IO.inspect
      |> map(& twice(&1))
      |> IO.inspect
      |> map(& twice(&1))
      |> IO.inspect

      ng(2)
      |> IO.inspect
      |> map(& twice(&1))
      |> IO.inspect
      |> map(& twice(&1))
      |> IO.inspect
  end

  defp ok(x), do: Right.new(x)
  defp ng(x), do: Left.new(x)
  defp twice(x), do: x*2
end


