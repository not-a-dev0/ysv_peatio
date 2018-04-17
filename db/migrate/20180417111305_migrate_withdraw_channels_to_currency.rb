class MigrateWithdrawChannelsToCurrency < ActiveRecord::Migration
  def change
    add_column :currencies, :withdraw_fee, :decimal, null: false, default: 0, precision: 7, scale: 6
    if defined?(Currency) && File.file?('config/withdraw_channels.old.yml')
      (YAML.load_file('config/withdraw_channels.old.yml') || []).each do |channel|
        next unless channel.key?('fee')
        Currency.find_by_code!(channel.fetch('currency')).tap do |ccy|
          ccy.update_columns(withdraw_fee: channel.fetch('fee'))
        end
      end
    end
  end
end
