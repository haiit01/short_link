class Link < ApplicationRecord
  SHORT_CODE_LENGTH = 6

  def self.generate_short_code
    SecureRandom.urlsafe_base64(SHORT_CODE_LENGTH)
  end
end
