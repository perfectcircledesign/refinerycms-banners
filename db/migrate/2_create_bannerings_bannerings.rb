class CreateBanneringsBannerings < ActiveRecord::Migration

  def up
    create_table :refinery_bannerings do |t|
      t.integer :banner_id
      t.references :bannerable, :polymorphic => true

      t.timestamps
    end
  end

  def down
    drop_table :refinery_bannerings
  end

end
