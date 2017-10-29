defmodule Twixler.Repo.Migrations.CreateTweets do
  use Ecto.Migration

  def change do
    create table(:tweets) do
      add :body, :text

      timestamps()
    end

  end
end
