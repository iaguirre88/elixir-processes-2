
# server_1.ex
defmodule Stack do
  def loop(state) do
    receive do
      message -> handler(message, state)
    end
  end

  def start(init) do
    spawn(Stack, :loop, [init])
  end

  def handler({:push, value}, state) do
    loop([value | state])
  end

  def handler({:pop, caller}, state) do
    [ head | tail ] = state
    send(caller, head)
    loop(tail)
  end
end

# pid = Stack.start([])
