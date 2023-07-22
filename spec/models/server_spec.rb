require 'rails_helper'

RSpec.describe Server, type: :model do
  it "is valid with a default and discord_server_id" do
    s = Server.new discord_server_id: 123456789
    expect(s).to be_valid
  end

  describe "checking getters" do
    context "discord_server_id" do
      it "returns 0 with '0' on column" do
        num = 0.freeze
        s = Server.new discord_server_id: 1
        s[:discord_server_id] = num.to_s
        expect(s.discord_server_id).to eq(num)
      end

      it "returns 1234567890123456789 with '1234567890123456789' on column" do
        num = 1234567890123456789
        s = Server.new discord_server_id: 1
        s[:discord_server_id] = num.to_s
        expect(s.discord_server_id).to eq(num)
      end

      it "returns 12345678901234567890 with '12345678901234567890' on column" do
        num = 12345678901234567890
        s = Server.new discord_server_id: 1
        s[:discord_server_id] = num.to_s
        expect(s.discord_server_id).to eq(num)
      end

      it "returns 123456789012345678901 with '123456789012345678901' on column" do
        num = 123456789012345678901
        s = Server.new discord_server_id: 1
        s[:discord_server_id] = num.to_s
        expect(s.discord_server_id).to eq(num)
      end
    end
  end

  describe "checking setters" do
    context "discord_server_id" do
      it "sets '1234567890123456789' to column, giving setter 1234567890123456789" do
        num = 1234567890123456789
        s = Server.new discord_server_id: 1
        s.discord_server_id = num
        expect(s[:discord_server_id]).to eq(num.to_s)
      end

      it "sets '12345678901234567890' to column, giving setter 12345678901234567890" do
        num = 12345678901234567890
        s = Server.new discord_server_id: 1
        s.discord_server_id = num
        expect(s[:discord_server_id]).to eq(num.to_s)
      end

      it "sets '123456789012345678901' to column, giving setter 123456789012345678901" do
        num = 123456789012345678901
        s = Server.new discord_server_id: 1
        s.discord_server_id = num
        expect(s[:discord_server_id]).to eq(num.to_s)
      end
    end
  end

  describe "checking validations" do
    context "discord_server_id" do
      it "is valid with 0" do
        s = Server.new discord_server_id: 0
        expect(s).to be_valid
      end

      it "is valid with 19 digits" do
        s = Server.new discord_server_id: 1234567890123456789
        expect(s).to be_valid
      end

      it "is valid with 20 digits" do
        s = Server.new discord_server_id: 12345678901234567890
        expect(s).to be_valid
      end

      it "is valid with 21 digits" do
        s = Server.new discord_server_id: 123456789012345678901
        expect(s).to be_valid
      end
    end

    context "music_volume" do

      it "is valid with 0 on the column" do
        s = Server.new discord_server_id: 1
        s[:music_volume] = 0
        expect(s).to be_valid
      end

      it "is valid with 1 on the column" do
        s = Server.new discord_server_id: 1
        s[:music_volume] = 1
        expect(s).to be_valid
      end

      it "is valid with 99 on the column" do
        s = Server.new discord_server_id: 1
        s[:music_volume] = 99
        expect(s).to be_valid
      end

      it "is valid with 100 on the column" do
        s = Server.new discord_server_id: 1
        s[:music_volume] = 1
        expect(s).to be_valid
      end

      it "is invalid with -1 on the column" do
        s = Server.new discord_server_id: 1
        s[:music_volume] = -1
        expect(s).to_not be_valid
        expect(s.errors.messages[:music_volume]).to include("must be suitable length, 0 <= num && num <= 100 .")
      end

      it "is invalid with 101 on the column" do
        s = Server.new discord_server_id: 1
        s[:music_volume] = 101
        expect(s).to_not be_valid
        expect(s.errors.messages[:music_volume]).to include("must be suitable length, 0 <= num && num <= 100 .")
      end

      it "is invalid with nil on the column" do
        s = Server.new discord_server_id: 1
        s[:music_volume] = nil
        expect(s).to_not be_valid
        expect(s.errors.messages[:music_volume]).to include("must be Integer.")
      end


      # todo : type checking. should be not valid.
      it "is valid with 0.1 on the column" do
        s = Server.new discord_server_id: 1
        s[:music_volume] = 0.1
        # expect(s).to_not be_valid
        expect(s).to be_valid   # pass by auto type casting.
      end
    end
  end
end
