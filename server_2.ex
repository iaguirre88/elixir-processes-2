# server_2.ex
defmodule Stack do
  def loop(state) do
    receive do
      {:cast, message} ->
        new_state = handle_cast(message, state)
        loop(new_state)
      {:call, from, message} ->
        {response, new_state} = handle_call(message, state)
        send(from, response)
        loop(new_state)
    end
  end

  def start(init) do
    spawn(Stack, :loop, [init])
  end

  def cast(pid, message) do
    send(pid, {:cast, message})
  end

  def call(pid, message) do
    send(pid, {:call, self(), message})
  end

  def handle_cast({:push, value}, state) do
    [value | state]
  end

  def handle_call(:pop, state) do
    [ head | tail ] = state
    {head, tail}
  end
end

# pid = Stack.start([])
