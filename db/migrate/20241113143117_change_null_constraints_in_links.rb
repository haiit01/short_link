class ChangeNullConstraintsInLinks < ActiveRecord::Migration[8.0]
  def change
    change_column_null :links, :original_url, false
    change_column_null :links, :short_url, false
  end
end
