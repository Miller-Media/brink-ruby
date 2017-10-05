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
		if args.key?('request_method')
			request_method = args['request_method']
		end
		data = {}
		if args.key?('data')
			args['data'].each do |key, value|
				data[key] = value
			end
		end
		headers = {
			:content_type => 'application/json'
		}
		if args.key?('headers')
			args['headers'].each do |key, value|
				headers[key] = value
			end
		end
		response = RestClient::Request.execute(
			method: request_method,
			url: args['url'],
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
			'url' => @api_baseurl+"users",
			'request_method' => 'PUT',
			'data' => data
		};
		response = send(args)
		return response
	end
	
	# Login
	def login(data)
		args = {
			'url' => @api_baseurl+"login",
			'request_method' => 'POST',
			'data' => data,
		}
		response = send(args)
		return response
	end
	
	# Get Flight
	def get_flight(data)
		args = {
			'url' => @api_baseurl+"flights/"+data['flight_id'],
			'headers' => {
				:authorization => 'JWT '+@access_token
			}
		}
		response = send(args)
		return response
	end
	
end

