class AddChara1ToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :chara1, :string
  end
end
