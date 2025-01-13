class AddCompanyDataToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :ar_users, :sector_id, :integer
    add_column :ar_users, :cost_center_id, :integer
    add_column :ar_users, :job, :string
    add_column :ar_users, :sign, :string
  end
end
