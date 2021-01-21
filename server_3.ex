
# server_3.ex
defmodule Stack do
  use GenServer

  def init(list) do
    {:ok, list}
  end

  def handle_cast({:push, value}, state) do
    {:noreply, [value | state]}
  end

  def handle_call(:pop, _from, state) do
    [ head | tail ] = state
    {:reply, head, tail}
  end
end

# {:ok, pid} = GenServer.start(Stack, [1])
