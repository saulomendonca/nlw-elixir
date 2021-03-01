defmodule Saulopay.Accounts.Deposit do
  alias Saulopay.Repo
  alias Saulopay.Accounts.Operation

  def call(params) do
    params
    |> Operation.call(:deposit)
    |> run_transaction()
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{deposit: account }} -> {:ok, account}
    end
  end
end
