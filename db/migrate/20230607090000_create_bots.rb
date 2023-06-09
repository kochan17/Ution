class CreateBots < ActiveRecord::Migration[6.0]
  def change
    create_table :bots do |t|
      t.string :botname
      t.text :description

      t.timestamps
    end
  end
end
