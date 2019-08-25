defmodule Blog.User do
    use Blog.Web, :model

    schema "users" do
        field :name, :string
        field :username, :string
        field :password, :string, virtual: true
        field :password_hash, :string

        timestamps()
    end

    def changeset(model, params \\ %{}) do
        # On definit la maniere de receuillir les donnees
        model
        |> cast(params, ~w(name username), []) # champs non vide dans le formulaire
        |> validate_length(:username, min: 4, max: 20) # longueur minimale
        |> validate_length(:name, min: 4, max: 50)
    end
end