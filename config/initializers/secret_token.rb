# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.

require 'securerandom'

def secure_token
  token_file = Rails.root.join('.secret')
  if File.exist?(token_file)
    # Use the existing token.
    File.read(token_file).chomp
  else
    # Generate a new token and store it in token_file.
    token = SecureRandom.hex(64)
    File.write(token_file, token)
    token
  end
end
#SampleApp::Application.config.secret_key_base = '29c0d1ca5ebbd9b86cb58e92cab65129fe9ecfc2e0031bb925176d6e0f4ae08266c0a6ed11f1ece4ec08f9de686132fc584335c2322c7e01fdd53fcc9ae94cd6'
SampleApp::Application.config.secret_key_base = secure_token