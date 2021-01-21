# stack.ex

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

  def handle_cast({:push, value}, state) do
      [value | state]
  end

  def handler_call({:pop, caller}, state) do
      [ head | tail ] = state
      {head, tail}
  end
end

# pid = spawn(Stack, :stack, [[]])
