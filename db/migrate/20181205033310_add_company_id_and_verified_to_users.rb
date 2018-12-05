class AddCompanyIdAndVerifiedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :company_id, :integer
    add_index :users, :company_id
    add_column :users, :verified, :boolean, default: true
  end
end
