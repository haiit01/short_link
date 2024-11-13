# spec/factories/links.rb
FactoryBot.define do
  factory :link do
    original_url { "https://codesubmit.io/library/react" }
    short_url { SecureRandom.urlsafe_base64(6) }
  end
end
