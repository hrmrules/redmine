module OpenIdAuthentication
  class Nonce < ActiveRecord::Base
    self.table_name = :open_id_auth_nonces
  end
end
