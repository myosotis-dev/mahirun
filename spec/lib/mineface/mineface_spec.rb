require 'rails_helper'
require './lib/mineface/face.rb'

RSpec.describe Mineface::Face do
	it "is object of Mineface::Face class" do
		face = Mineface::Face.new
		expect(face.class).to eq(Mineface::Face)
	end

	describe "methods" do
		describe "get_minecraft_uuid()" do
			context "give correct name" do
				it "returns currect uuid" do
					face = Mineface::Face.new
					# KrisJelbring is developer of minecraft
					uuid = face.get_minecraft_uuid 'KrisJelbring'
					expect(uuid).to eq "7125ba8b1c864508b92bb5c042ccfe2b"
				end
			end

			context "give none-existent user name" do
				it "raise GetUUIDError" do
					face = Mineface::Face.new
					# Can't get '!!!' as user name of minecraft.
					expect{face.get_minecraft_uuid '!!!'}.to raise_error(Mineface::GetUUIDError)
				end
			end

			context "give nothing" do
				it "raise ArgumentError" do
					face = Mineface::Face.new
					expect{face.get_minecraft_uuid}.to raise_error(ArgumentError)
				end
			end

			context "give argument which is not String" do
				it "raise ArgumentError" do
					face = Mineface::Face.new
					expect{face.get_minecraft_uuid -1}.to raise_error(ArgumentError)
				end
			end

			context "give empty String" do
				it "raise ArgumentError" do
					face = Mineface::Face.new
					expect{face.get_minecraft_uuid ""}.to raise_error(ArgumentError)
				end
			end

			context "give nil" do
				it "raise ArgumentError" do
					face = Mineface::Face.new
					expect{face.get_minecraft_uuid nil}.to raise_error(ArgumentError)
				end
			end
		end

		describe "request_json()" do
			context "give correct url" do
				it "returns hash object" do
					face = Mineface::Face.new
					# TODO : change mock api...
					json = face.request_json "https://api.github.com/status"
					expect(json.class).to eq Hash
				end
			end

			context "give nothing" do
				it "raise ArgumentError" do
					face = Mineface::Face.new
					expect{face.request_json}.to raise_error(ArgumentError)
				end
			end

			context "give argument which is not String" do
				it "raise ArgumentError" do
					face = Mineface::Face.new
					expect{face.request_json -1}.to raise_error(ArgumentError)
				end
			end

			context "give empty String" do
				it "raise ArgumentError" do
					face = Mineface::Face.new
					expect{face.request_json ""}.to raise_error(ArgumentError)
				end
			end

			context "give nil" do
				it "raise ArgumentError" do
					face = Mineface::Face.new
					expect{face.request_json nil}.to raise_error(ArgumentError)
				end
			end

			context "give url which is non-exists site" do
				it "raise ArgumentError" do
					face = Mineface::Face.new
					expect{face.request_json "https://example.example.com/"}.to raise_error(Mineface::APIRequestError)
				end
			end

			context "give url which is not able to parse json" do
				it "raise ArgumentError" do
					face = Mineface::Face.new
					expect{face.request_json "https://example.com/"}.to raise_error(Mineface::APIRequestError)
				end
			end
		end

		describe "get_minecraft_profile()" do
			context "give correct uuid" do
				it "returns correct profile" do
					face = Mineface::Face.new
					# This is uuid of KrisJelbring, he is developer of minecraft.
					uuid = "7125ba8b1c864508b92bb5c042ccfe2b"
					profile = face.get_minecraft_profile uuid
					
					expect(profile["id"]).to eq uuid
					expect(profile["name"]).to eq "KrisJelbring"
					expect(profile["properties"]).to be_present

					expect(profile["properties"].first["name"]).to eq "textures"
					expect(profile["properties"].first["value"]).to be_present
					expect(profile["properties"].first["value"]["profileId"]).to eq uuid
					expect(profile["properties"].first["value"]["profileName"]).to eq "KrisJelbring"

					textures = profile["properties"].first["value"]["textures"]
					expect(textures).to be_present
					expect(textures["SKIN"]).to be_present
					expect(textures["SKIN"]["url"]).to be_present
					expect(textures["CAPE"]).to be_present
					expect(textures["CAPE"]["url"]).to be_present
				end
			end

			context "give none-existent uuid" do
				it "raise GetProfileError" do
					face = Mineface::Face.new
					expect{face.get_minecraft_profile "foo"}.to raise_error(Mineface::GetProfileError)
				end
			end

			context "give nothing" do
				it "raise ArgumentError" do
					face = Mineface::Face.new
					expect{face.get_minecraft_profile}.to raise_error(ArgumentError)
				end
			end

			context "give argument which is not String" do
				it "raise ArgumentError" do
					face = Mineface::Face.new
					expect{face.get_minecraft_profile -1}.to raise_error(ArgumentError)
				end
			end

			context "give empty String" do
				it "raise ArgumentError" do
					face = Mineface::Face.new
					expect{face.get_minecraft_profile ""}.to raise_error(ArgumentError)
				end
			end

			context "give nil" do
				it "raise ArgumentError" do
					face = Mineface::Face.new
					expect{face.get_minecraft_profile}.to raise_error(ArgumentError)
				end
			end
		end

		describe "get_skin_image_url()" do
			context "give correct uuid" do
				it "returns correct url" do
					face = Mineface::Face.new
					# This is uuid of KrisJelbring, he is developer of minecraft.
					uuid = "7125ba8b1c864508b92bb5c042ccfe2b"
					image_url = face.get_skin_image_url uuid
					expect(image_url).to eq "http://textures.minecraft.net/texture/b47b21bb3e7f79bdf2a5e8e041f7ff9e178dc15645f6449b8e55f906604c07f9"
				end
			end

			context "give none-existent uuid" do
				it "raise GetProfileError" do
					face = Mineface::Face.new
					expect{face.get_minecraft_profile "foo"}.to raise_error(Mineface::GetProfileError)
				end
			end

			context "give nothing" do
				it "raise ArgumentError" do
					face = Mineface::Face.new
					expect{face.get_minecraft_profile}.to raise_error(ArgumentError)
				end
			end

			context "give argument which is not String" do
				it "raise ArgumentError" do
					face = Mineface::Face.new
					expect{face.get_minecraft_profile -1}.to raise_error(ArgumentError)
				end
			end

			context "give empty String" do
				it "raise ArgumentError" do
					face = Mineface::Face.new
					expect{face.get_minecraft_profile ""}.to raise_error(ArgumentError)
				end
			end

			context "give nil" do
				it "raise ArgumentError" do
					face = Mineface::Face.new
					expect{face.get_minecraft_profile}.to raise_error(ArgumentError)
				end
			end

			# TODO: add case of GetSkinUrlError
		end

		describe "get_face_image()"
		describe "request!()"
	end

	describe "instance variables" do
		
	end

	describe "error class" do
		describe "GetUUIDError" do
			it "raise GetUUIDError" do
				expect{
					raise Mineface::GetUUIDError
				}.to raise_error(Mineface::GetUUIDError)
			end
		end

		describe "GetProfileError" do
			it "raise GetProfileError" do
				expect{
					raise Mineface::GetProfileError
				}.to raise_error(Mineface::GetProfileError)
			end
		end

		describe "GetSkinUrlError" do
			it "raise GetSkinUrlError" do
				expect{
					raise Mineface::GetSkinUrlError
				}.to raise_error(Mineface::GetSkinUrlError)
			end
		end

		describe "FaceRequestError" do
			it "raise FaceRequestError" do
				expect{
					raise Mineface::FaceRequestError
				}.to raise_error(Mineface::FaceRequestError)
			end
		end

		describe "APIRequestError" do
			it "raise APIRequestError" do
				expect{
					raise Mineface::APIRequestError
				}.to raise_error(Mineface::APIRequestError)
			end
		end
		# TODO: check message of Errors
	end
end
