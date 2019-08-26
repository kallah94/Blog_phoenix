defmodule Blog.UserController do
    use Blog.Web, :controller

    # definir les alias
    alias Blog.User

    # Plug
    plug :authenticate when action in [:index, :show]

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

    def authenticate(conn, _opts) do
        if conn.assigns.current_user do
            conn
        else
            conn
            |> put_flash(:error, "Il faut se connecter pour acceder à cette page")
            |> redirect(to: page_path(conn, :index))
            |> halt()
        end
    end
end
