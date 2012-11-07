# Load the rails application
require File.expand_path('../application', __FILE__)
FlickRaw.api_key = 'af42c39b1fd78be9616ff0ffb22415a1'
FlickRaw.shared_secret = 'c05d9dbc678673f3'

# Initialize the rails application
Catarse::Application.initialize!

ActiveMerchant::Billing::PaypalExpressGateway.default_currency = 'USD'

require 'flickraw'