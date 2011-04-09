# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_cancer_session',
  :secret      => 'ae2176dcf2f365105e4d60ff2c4497adcbc5dcc6d3366897dc6abcd674decde95e32283ff5758d80ceb8b61eb0b96ead119bd21ce82e11c874c246a6d15bde48'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
