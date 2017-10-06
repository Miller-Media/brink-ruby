Ruby Brink API Wrapper
----------------------

.. code-block:: javascript

	// Modules that need to be installed via 'gem install' for using Brink API
	require 'rubygems' if RUBY_VERSION < '1.9'
	require 'rest_client'
	require 'json'
	
	//Creating the instance of API class
	require_relative 'Brink_API'
	Brink = Brink_API.new
	
	// Login to the api to receive a jwt token that can be used in future requests without the need to reauthenticate
	user_data = {
		"username" => "admin",
		"password" => "br!nkAdm1n"
	}
	response = Brink.login(user_data)
	Brink.access_token = JSON.parse(response)['jwt_token']
	
	// After logging in using the Brink.login() method, the token is already set 
	// so additional requests can be handled correctly
	
	response = Brink.get_all_flights()
	puts response

	data = {:flight_id => '12'}
	response = Brink.get_flight(data)
	puts response

	data = {
		:flight_id => '12',
		:prop => {
			:page => 1,
			:per_page => 5
		}
	}
	response = Brink.get_flight_data(data)
	puts response