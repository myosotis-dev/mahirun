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
	end

	describe "error class" do
		describe "GetUUIDError" do
			it "raise GetUUIDError" do
				expect{
					raise Mineface::GetUUIDError
				}.to raise_error(Mineface::GetUUIDError)
			end
		end

		describe "APIRequestError" do
			it "raise APIRequestError" do
				expect{
					raise Mineface::APIRequestError
				}.to raise_error(Mineface::APIRequestError)
			end
		end
	end
end
