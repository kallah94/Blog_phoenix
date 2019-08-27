defmodule Blog.Video do
  use Blog.Web, :model

  schema "videos" do
    field :url, :string
    field :title, :string
    field :description, :string
    field :tag, :string
    belongs_to :user, Blog.User, foreign_key: :user_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:url, :title, :description, :tag])
    |> validate_required([:url, :title, :description, :tag])
  end
end
