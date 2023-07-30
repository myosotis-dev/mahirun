module Mineface
	require 'net/http'
	require 'uri'
	require "json"

	class Face
		def initialize options={}
			
		end

		def get_minecraft_uuid name=""
			raise ArgumentError unless name.kind_of? String
			raise ArgumentError if name == ""

			_json = request_json("https://api.mojang.com/users/profiles/minecraft/#{name}")
			raise GetUUIDError, "this user name is not exist." unless _json["errorMessage"].nil?

			return _json["id"]
		end

		def request_json _url=""
			raise ArgumentError unless _url.kind_of? String
			raise ArgumentError if _url == ""

			parsed_uri = URI.parse(_url)

			begin
				data = Net::HTTP.get(parsed_uri)
			rescue SocketError=> e
				raise APIRequestError, e.message
			rescue => e
				warn e.message
				raise APIRequestError, e.message
			end

			begin
				json = JSON.parse(data)
			rescue JSON::ParserError => e
				raise APIRequestError, e.message
			rescue => e
				warn e.message
				raise APIRequestError, e.message
			end

			return json
		end
	end

	class GetUUIDError < StandardError
		def initialize msg="Can't get UUID."
			super msg
		end
	end

	class APIRequestError < StandardError
		def initialize msg="Doesn't success request."
			super msg
		end
	end
end
