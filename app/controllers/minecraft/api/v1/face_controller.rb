class Minecraft::Api::V1::FaceController < ApplicationController
	def show
		@face = face = Mineface::Face.new name: params[:id]
		@face.request!
		image_bin = @face.image.to_blob do
			self.format = "PNG"
		end
		response.content_type = "image/png"
		send_data image_bin
	end
end
