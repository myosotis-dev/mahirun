require 'rails_helper'

RSpec.describe "Api::V1::Servers", type: :request do
	describe "show action" do
		it "success 200" do
			# Arrange
			_id = 1.freeze
			s = Server.create!(discord_server_id: _id)

			# Act
			get api_v1_server_path(_id)
			res = JSON.parse(response.body)

			# Assert
			expect(response).to have_http_status(200)
			expect(res["status"]).to eq(200)
			expect(res["status_message"]).to eq("OK")
			expect(res["messages"]).to eq([])
			expect(res["data"].class).to eq(Hash)
		end

		it "not found 404" do
			# Arrange
			_id = 1.freeze
			s = Server.create!(discord_server_id: _id)
			s.destroy!

			# Act
			get api_v1_server_path(_id)
			res = JSON.parse(response.body)

			# Assert
			expect(response).to have_http_status(404)
			expect(res["status"]).to eq(404)
			expect(res["status_message"]).to eq("Not Found")
			expect(res["messages"]).to eq([])
			expect(res["data"]).to eq({})
		end
	end
end
