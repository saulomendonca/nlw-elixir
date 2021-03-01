defmodule SaulopayWeb.AccountsController do
  use SaulopayWeb, :controller

  alias Saulopay.Account
  alias Saulopay.Accounts.Transactions.Response, as: TransactionResponse

  action_fallback SaulopayWeb.FallbackController

  def deposit(conn, params) do
    with {:ok, %Account{} = account} <- Saulopay.deposit(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def withdraw(conn, params) do
    with {:ok, %Account{} = transaction} <- Saulopay.withdraw(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", transaction: transaction)
    end
  end

  def transaction(conn, params) do
    task = Task.async(fn -> Saulopay.transaction(params) end)

    with {:ok, %TransactionResponse{} = transaction} <- Task.await(task) do
      conn
      |> put_status(:created)
      |> render("transaction.json", transaction: transaction)
    end
  end
end
