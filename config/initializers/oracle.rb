ActiveSupport.on_load(:active_record) do
 ActiveRecord::ConnectionAdapters::OracleEnhancedAdapter.class_eval do
    self.emulate_dates_by_column_name = true
  end
end
