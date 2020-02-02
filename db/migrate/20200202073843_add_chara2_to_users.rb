class AddChara2ToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :chara2, :string
  end
end
