defmodule Dand.Requests.Ticket do
  use Ecto.Schema
  import Ecto.Changeset
  alias Dand.Requests.Ticket


  schema "tickets" do
    field :message, :string
    field :subject, :string

    belongs_to :owner, Dand.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(%Ticket{} = ticket, attrs) do
    ticket
    |> cast(attrs, [:subject, :message, :owner_id])
    |> validate_required([:subject, :message, :owner_id])
  end
end
