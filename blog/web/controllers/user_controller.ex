defmodule Blog.UserController do
    use Blog.Web, :controller

    # definir les alias
    alias Blog.User

    # Plug
    plug :authenticate_user when action in [:index, :show, :new]

    def index(conn, _params) do
      users = Repo.all(Blog.User)
      render conn, "index.html", users: users
    end

    def new(conn, _params) do
        changeset = User.changeset(%User{})
        render conn, "new.html", changeset: changeset
    end

    def create(conn, %{"user" => user_params}) do
        changeset = User.registration_changeset(%User{}, user_params)
        case Repo.insert(changeset) do
            {:ok, user} ->
                conn
                |> Blog.Auth.login(user)
                |> put_flash(:info, "#{user.name} a ete creer avec succes!")
                |> redirect(to: user_path(conn, :index))
            {:error, changeset} ->
                render conn, "new.html", changeset: changeset
        end
    end

    def show(conn, %{"id" => id}) do
        user = Repo.get(Blog.User, id)
        render conn, "show.html", user: user
    end

   
end
