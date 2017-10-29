defmodule TwixlerWeb.TweetController do
  use TwixlerWeb, :controller

  alias Twixler.Tweets
  alias Twixler.Tweets.Tweet

  def index(conn, _params) do
    tweets = Tweets.list_tweets()
    render(conn, "index.html", tweets: tweets)
  end

  def new(conn, _params) do
    changeset = Tweets.change_tweet(%Tweet{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tweet" => tweet_params}) do
    case Tweets.create_tweet(tweet_params) do
      {:ok, tweet} ->
        conn
        |> put_flash(:info, "Tweet created successfully.")
        |> redirect(to: tweet_path(conn, :show, tweet))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tweet = Tweets.get_tweet!(id)
    render(conn, "show.html", tweet: tweet)
  end

  def edit(conn, %{"id" => id}) do
    tweet = Tweets.get_tweet!(id)
    changeset = Tweets.change_tweet(tweet)
    render(conn, "edit.html", tweet: tweet, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tweet" => tweet_params}) do
    tweet = Tweets.get_tweet!(id)

    case Tweets.update_tweet(tweet, tweet_params) do
      {:ok, tweet} ->
        conn
        |> put_flash(:info, "Tweet updated successfully.")
        |> redirect(to: tweet_path(conn, :show, tweet))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", tweet: tweet, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tweet = Tweets.get_tweet!(id)
    {:ok, _tweet} = Tweets.delete_tweet(tweet)

    conn
    |> put_flash(:info, "Tweet deleted successfully.")
    |> redirect(to: tweet_path(conn, :index))
  end
end
