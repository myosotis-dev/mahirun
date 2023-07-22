class Server < ApplicationRecord

	validate :valid_discord_server_id?
	validate :valid_music_volume?
	validate :valid_is_read_unconnected_user_message?
	validate :valid_is_read_user_name?
	validate :valid_is_read_message?
	validate :valid_is_auto_join?


	# getter
	def discord_server_id
		self[:discord_server_id].to_i
	end

	# setter
	def discord_server_id=(param)
		# MySQL can't save over 20 digits num, so save as string.
		unless param.kind_of?(Integer)
			raise TypeError "must be Integer."
		end
		i = param.to_s
		self[:discord_server_id] = i
	end


	# --- validate ---

	def valid_discord_server_id?
		str = self[:discord_server_id].freeze
		unless str.kind_of?(String)
			errors.add(:discord_server_id, "must be string.")
			return
		end
		unless str == (str.to_i.to_s)
			errors.add(:discord_server_id, "must be convertable to integer.")
		end
	end

	def valid_music_volume?		
		num = self[:music_volume].freeze
		unless num.kind_of?(Integer)
			errors.add(:music_volume, "must be Integer.")
			return
		end
		unless 0 <= num && num <= 100
			errors.add(:music_volume, "must be suitable length, 0 <= num && num <= 100 .")
			return
		end
	end

	def valid_is_read_unconnected_user_message?
		valid_as_boolean?(
			:is_read_unconnected_user_message,
			self[:is_read_unconnected_user_message]
		)
	end

	def valid_is_read_user_name?
		valid_as_boolean?(
			:is_read_user_name,
			self[:is_read_user_name]
		)
	end

	def valid_is_read_message?
		valid_as_boolean?(
			:is_read_message,
			self[:is_read_message]
		)
	end

	def valid_is_auto_join?
		valid_as_boolean?(
			:is_auto_join,
			self[:is_auto_join]
		)
	end
end
