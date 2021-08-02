class ChangeDefaultStatusSubscriptions < ActiveRecord::Migration[6.1]
  def change
    change_column_default :subscriptions, :status, 0
  end
end
