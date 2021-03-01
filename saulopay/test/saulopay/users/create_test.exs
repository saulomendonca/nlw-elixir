defmodule Saulopay.Users.CreateTest do
  use Saulopay.DataCase, async: true

  alias Saulopay.User
  alias Saulopay.Users.Create

  describe "call/1" do
    test "when all params are valid, return an user" do
      params = %{
        name: "Saulo",
        password: "123456",
        nickname: "saulo",
        email: "saulo@saulo.com",
        age: 34
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Saulo", age: 34, id: ^user_id} = user
    end

    test "when there are invalid params, return an error" do
      params = %{
        name: "Saulo",
        password: "123",
        nickname: "saulo",
        email: "saulo@saulo.com",
        age: 12
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["should be at least 6 character(s)"]
      }

      assert expected_response == errors_on(changeset)
    end
  end

end
