defmodule CTest do
  alias Algae.Either.Right
  alias Algae.Either.Left

  use Witchcraft.Functor
  use Witchcraft.Chain
#  use Witchcraft.Foldable

  def main(args \\ []) do
    ok(2)
    |> flat_map(& twice_throwable(&1))
    |> flat_map(& ng(&1))
    |> IO.inspect

    ok(2) |> flatten
    |> IO.inspect

    ng(3) |> flatten |> twice_throwable
#    |> flat_map(& twice_throwable(&1))
#    |> flat_map(& ng(&1))
    |> IO.inspect


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

  defp flat_map(%Right{right: x}, f), do: f.(x)
  defp flat_map(%Left{left: x}, f), do: x
  defp twice_throwable(x), do: Right.new(x*2)
  defp ok(x), do: Right.new(x)
  defp ng(x), do: Left.new("error_message")
  defp twice(x), do: x*2
end


