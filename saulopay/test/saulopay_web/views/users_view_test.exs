defmodule SaulopayWeb.UsersViewTest do
  use SaulopayWeb.ConnCase, async: true

  import Phoenix.View
  alias Saulopay.{Account, User}


  test "renders create.json" do
    params = %{
      name: "Saulo",
      password: "123456",
      nickname: "saulo",
      email: "saulo@saulo.com",
      age: 34
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user } = Saulopay.create_user(params)

    response = render(SaulopayWeb.UsersView, "create.json", user: user )

    expected_response = %{
      message: "User created",
      user: %{
        account: %{
          balance: Decimal.new("0.00"),
          id: account_id
        },
        id: user_id,
        name: "Saulo",
        nickname: "saulo"
        }
    }
    assert expected_response == response
  end
end
