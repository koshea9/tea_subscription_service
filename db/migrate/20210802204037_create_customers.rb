class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :phone

      t.timestamps
    end
  end
end
