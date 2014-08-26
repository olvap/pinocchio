class AddApiAuthenticationTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :api_auth_token, :string, unique: true
    add_index  :users, :api_auth_token, unique: true
  end
end
