class AddAsnToIotData < ActiveRecord::Migration
  def change
    add_column :iot_data, :site, :string
    add_column :iot_data, :location, :string
    add_column :iot_data, :asn_code, :string
    add_column :iot_data, :bar_code, :string
  end
end
