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
  @required_fields ~w(url title description tag)
  @optional_fields ~w()
  def changeset(struct, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_required([:url, :title, :description, :tag])
  end
end
