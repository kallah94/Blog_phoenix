defmodule Blog.User do
    use Blog.Web, :model

    schema "users" do
        field :name, :string
        field :username, :string
        field :password, :string, virtual: true
        field :password_hash, :string
        has_many :videos, Blog.Video
        timestamps()
    end

    def changeset(model, params \\ %{}) do
        # On definit la maniere de receuillir les donnees
        model
        |> cast(params, ~w(name username), []) # champs non vide dans le formulaire
        |> validate_length(:username, min: 4, max: 20) # longueur minimale
        |> validate_length(:name, min: 4, max: 50)
    end

    def registration_changeset(model, params) do
        model
        |> changeset(params)
        |> cast(params, ~w(password), [])
        |> validate_length(:password, min: 6, max: 100)
        |> put_pass_hash()
    end

    defp put_pass_hash(changeset) do
        case changeset do
            %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
                put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
                _ ->
                    changeset
        end
    end
end