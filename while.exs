defmodule Loop do
    defmacro while(expression, do: block) do
        quote do
            try do
                for _ <- Stream.sycle([:ok]) do
                    if unquote(expression) do
                        unquote(block)
                    else
                        Loop.break
                    end
                end
            catch
                :break -> :ok
            end
        end
    end

    def break, do: throw :break
end

# Example
# c "while.exs"
# import Loop
# run_loop = fn ->
# pid = spawn(fn -> :timer.sleep(4000) end)
# while Process.alive?(pid) do
# IO.puts "Alive!"
# :timer.sleep 1000
# end
# end