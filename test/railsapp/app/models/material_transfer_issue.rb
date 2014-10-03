class MaterialTransferIssue < ActiveRecord::Base
  attr_accessible(:create_badge, :create_shift_code, :in_time, :out_time)
  audited
  attr_accessible(:profile_check, :update_badge, :update_shift_code)
end
