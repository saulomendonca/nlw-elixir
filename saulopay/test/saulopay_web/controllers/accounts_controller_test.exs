defmodule SaulopayWeb.AccountsControllerTest do
  use SaulopayWeb.ConnCase, async: true

  alias Saulopay.{Account, User}

  describe "deposit/2" do
    setup %{conn: conn} do
      params = %{
        name: "Saulo",
        password: "123456",
        nickname: "saulo",
        email: "saulo@saulo.com",
        age: 34
      }
      {:ok, %User{account: %Account{id: account_id}}} = Saulopay.create_user(params)

      {:ok, conn: conn, account_id: account_id}
    end

    test "when all params are valid, make the deposit", %{conn: conn, account_id: account_id} do

      params = %{"value" => "50.00"}

      response = conn
      |> post(Routes.accounts_path(conn, :deposit, account_id, params))
      |> json_response(:ok)

      assert %{
        "message" => "Balance changed succesfully",
        "account" => %{
          "balance" => "50.00",
          "id" => _id
        }
      } = response
    end

    test "when the params are invalid, return an error", %{conn: conn, account_id: account_id} do

      params = %{"value" => "NOT_VALID"}

      response = conn
      |> post(Routes.accounts_path(conn, :deposit, account_id, params))
      |> json_response(:bad_request)

      expected_response = %{"message" => "Invalid deposit value"}

      assert expected_response == response
    end

  end

end
