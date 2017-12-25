defmodule Dand.Repo.Migrations.TicketBelongsToOwner do
  use Ecto.Migration

  def change do
  	alter table(:tickets) do
      add :owner_id, references(:users)
    end
  end
end
