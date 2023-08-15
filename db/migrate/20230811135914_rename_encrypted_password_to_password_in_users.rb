class RenameEncryptedPasswordToPasswordInUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :encrypted_password, :password
  end
end
