defmodule Rand do
  def main(args \\ []) do
    choices = [1, 2, 3, 4, 5, 6, 7]

    start_c = Time.utc_now()
    1..1000000
    |> Enum.map(fn _ -> choose(choices) end)
    time_c = Time.diff(Time.utc_now(), start_c, :microseconds)

    start_s = Time.utc_now()
    1..1000000
    |> Enum.map(fn _ -> shift(choices) end)
    time_s = Time.diff(Time.utc_now(), start_s, :microseconds)

    IO.puts("choose: #{time_c}ms, shift: #{time_s}ms")
  end

  defp choose(choices) do
    %{"checkbox_answer" => 1..length(choices) |> Enum.filter(fn _ -> :rand.uniform(2) == 1 end)}
  end

  defp shift(choices) do
    import Bitwise
    rand = :rand.uniform( 1 <<< length(choices) ) - 1
    %{
      "checkbox_answer" =>
        Enum.reduce( rand..0, [], fn curr, acc -> case rand
          >>> curr &&& 1 do
            0 -> acc
            1 -> [curr | acc]
          end
        end
      )
    }
  end
end


