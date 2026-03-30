local speed = settings.startup["custom-multipliers-working-speed"].value

if #speed > 0 then
	local speed_fields = {
		"researching_speed",
		"crafting_speed",
		"mining_speed",
		"pumping_speed",
		"extension_speed",
		"rotation_speed",
	}
	for k, v in string.gmatch(speed, "(%w+)=(%w+)") do
		local mult = tonumber(v)
		local machine = data.raw["assembling-machine"][k]
			or data.raw["furnace"][k]
			or data.raw["mining-drill"][k]
			or data.raw["rocket-silo"][k]
			or data.raw["lab"][k]
			or data.raw["inserter"][k]
			or data.raw["offshore-pump"][k]
			or data.raw["pump"][k]

		if machine ~= nil and mult ~= nil then
			for _, field in pairs(speed_fields) do
				if machine[field] ~= nil then
					machine[field] = machine[field] * mult
				end
			end
		else
			print("Machine `" .. k .. "` does not exist or multiplier `" .. v .. "` is not a valid number")
		end
	end
end
