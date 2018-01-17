defmodule ReWeb.AuthController do
  use ReWeb, :controller

  alias Re.Accounts.{
    Auth,
    Users
  }
  alias ReWeb.{
    Guardian,
    Mailer,
    UserEmail
  }

  action_fallback ReWeb.FallbackController

  def login(conn, %{"user" => %{"email" => email, "password" => password}}) do
    with {:ok, user} <- Auth.find_user(email),
         :ok <- Auth.check_password(password, user),
         {:ok, jwt, _full_claims} <- Guardian.encode_and_sign(user)
      do
        conn
        |> put_status(:created)
        |> render(ReWeb.UserView, "login.json", jwt: jwt, user: user)
    end
  end

  def register(conn, %{"user" => params}) do
    with {:ok, user} <- Users.create(params)
      do
        user
        |> UserEmail.welcome()
        |> Mailer.deliver()

        conn
        |> put_status(:created)
        |> render(ReWeb.UserView, "register.json", user: user)
      end
  end
end
