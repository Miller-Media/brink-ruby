class Brink_API
	attr_accessor :user_id
	attr_accessor :access_token
	
	# Create the object
	def initialize()
		@api_baseurl = "http://api.joinbrink.com/v1/"
	end
	
	# Send request
	def send(args)
		request_method = 'GET'
		if args.key?(:request_method)
			request_method = args[:request_method]
		end
		data = {}
		if args.key?(:data)
			args[:data].each do |key, value|
				data[key] = value
			end
		end
		headers = {
			:content_type => 'application/json'
		}
		if args.key?(:headers)
			args[:headers].each do |key, value|
				headers[key] = value
			end
		end
		#puts data.to_json
		#abort()
		response = RestClient::Request.execute(
			method: request_method,
			url: args[:url],
			payload: data.to_json,
			headers: headers
		)
		return response
	end

	# Create User
	def create_user(data)
		# data (array) attributes:
		# first_name,
		# last_name,
		# email,
		# username,
		# password
		args = {
			:url => @api_baseurl+"users",
			:request_method => 'PUT',
			:data => data
		};
		response = send(args)
		return response
	end

	# Get User
	def get_user() 
		args = {
			:url => @api_baseurl+"users/"+@user_id.to_s,
			:headers => {
				:authorization => 'JWT '+@access_token
			}
		}
		response = send(args)
		return response
	end
	
	# Login
	def login(data)
		# data (array) attributes:
		# username,
		# password
		args = {
			:url => @api_baseurl+"login",
			:request_method => 'POST',
			:data => data,
		}
		response = send(args)
		return response
	end

	# Get all flights
	def get_all_flights()
		args = {
			:url => @api_baseurl+"flights",
			:headers => {
				:authorization => 'JWT '+@access_token
			}
		}
		response = send(args)
		return response
	end
	
	# Get Flight
	def get_flight(data)
		# data (array) attributes:
		# flight_id
		args = {
			:url => @api_baseurl+"flights/"+data[:flight_id],
			:headers => {
				:authorization => 'JWT '+@access_token
			}
		}
		response = send(args)
		return response
	end
	
	# Create flight
	def create_flight()
		args = {
			:url => @api_baseurl+"flights",
			:request_method => 'PUT',
			:headers => {
				:authorization => 'JWT '+@access_token
			}
		}
		response = send(args)
		return response
	end
	
	# Get flight data
	def get_flight_data(data)
		# data (array) attributes:
		# flight_id,
		# prop (array) attributes:
			# page,
			# per_page
		args = {
			:url => @api_baseurl+"flights/"+data[:flight_id]+"/data",
			:request_method => 'POST',
			:data => data[:prop],
			:headers => {
				:authorization => 'JWT '+@access_token
			}
		}
		response = send(args)
		return response
	end
	
	# Create flight data
	def create_flight_data(data)
		# data (array) attributes:
		# flight_id,
		# prop (array) attributes:
			# timestamp,
			# altitude,
			# barometricPressure,
			# coordinateX,
			# coordinateY,
			# temperature
		args = {
			:url => @api_baseurl+"flights/"+data[:flight_id]+"/data",
			:request_method => 'PUT',
			:data => data[:prop],
			:headers => {
				:authorization => 'JWT '+@access_token
			}
		}
		response = send(args)
		return response
	end
	
end