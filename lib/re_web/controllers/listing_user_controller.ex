defmodule ReWeb.ListingUserController do
  use ReWeb, :controller

  alias ReWeb.User

  def create(conn, %{"user" => user_params, "listing" => listing_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset, on_conflict: :replace_all, conflict_target: :email) do
      {:ok, user} ->
        SendGrid.Email.build()
        |> SendGrid.Email.add_to("gustavo.saiani@emcasa.com")
        |> SendGrid.Email.put_from("gustavo.saiani@emcasa.com")
        |> SendGrid.Email.put_subject("Hello from Elixir")
        |> SendGrid.Email.put_text("Sent with Elixir")
        |> SendGrid.Mailer.send()

        conn
        |> put_status(:created)
        |> put_resp_header("location", user_path(conn, :show, user))
        |> render("show.json", user: user)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ReWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
