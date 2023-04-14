class ChangeActiveFlagDefaultOnCustomers < ActiveRecord::Migration[7.0]
  def change
    change_column_default :customers, :active_flag, true
  end
end
