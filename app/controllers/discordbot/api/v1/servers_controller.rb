class Discordbot::Api::V1::ServersController < ApplicationApiController
	def show
		@server = Server.find_by(discord_server_id: params[:id])
		if @server.nil?
			render_status 404
			return
		end
		render_status 200, @server
	end
end
