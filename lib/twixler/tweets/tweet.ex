defmodule Twixler.Tweets.Tweet do
  use Ecto.Schema
  import Ecto.Changeset
  alias Twixler.Tweets.Tweet


  schema "tweets" do
    field :body, :string

    timestamps()
  end

  @doc false
  def changeset(%Tweet{} = tweet, attrs) do
    tweet
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
