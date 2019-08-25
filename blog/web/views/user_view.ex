defmodule Blog.UserView do
    use Blog.Web, :view

    # alias 
    alias Blog.User

    def first_name(%User{name: name}) do
        name
        |> String.split(" ")
        |> Enum.at(0)
    end
end