class AddHeaderColorToUser < ActiveRecord::Migration
  def change
    add_column :users, :header_color, :string
  end
end
