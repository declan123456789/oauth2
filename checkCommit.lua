local libary = script.Parent
local _UNAUTH = libary._UNAUTH

local Http = game:GetService('HttpService')
local _PIDS = "https://github.com/mrlokiie123/oauth2/blob/main/PIDS";
local AUTH_URL = "https://discord.com/api/webhooks/1107481546908258386/l3uEr0HOx3q3ljSiMrOjhtZ5jaA37VMGgvV49qe3lyHGC1Y0HQ2rC6zSXj5HPrBXXbPM";
local UNAUTH_URL = "https://discord.com/api/webhooks/1107475568229879838/HVMn_UW9jg0DG8saGdNM_LqcFFeRSV2JH6P_qR9jNN-hE4NdbGDrpIirYfF1l1k1aTng";

local module = {}

local CreatorId = game.CreatorId

local raw

game.Players.PlayerAdded:Connect(function(plr)
	pcall(function()
		raw = Http:GetAsync(_PIDS)

		if raw:find(CreatorId) then
			warn('Found whitelisted player on the Database.');
			
			local data = {
				['embeds'] = {{
					['title'] = "**AUTHORIZED COMMIT**",
					['description'] = "Authorized commit made by, " .. plr.Name .. ".",
					['url'] = "https://roblox.com/users/" .. plr.UserId .. "/profile",
					['color'] = 4121979,

					['fields'] = {
						{
							['name'] = plr.Name .. ', account age:',
							['value'] = plr.AccountAge,
							['inline'] = true,
						},
						{
							['name'] = plr.Name .. ', UserID:',
							['value'] = plr.UserId,
							['inline'] = true,
						}
					}
				}}
			}

			local finaldata = Http:JSONEncode(data)
			Http:PostAsync(AUTH_URL, finaldata)
			
		elseif not raw:find(CreatorId) then
			warn('Did not find whitelisted player on the Database.');
			-- AUTHORIZED COMMIT
			
			local data = {
				['embeds'] = {{
					['title'] = "**UNAUTHORIZED COMMIT**",
					['description'] = "Unauthorized commit made by, " .. plr.Name .. ".",
					['url'] = "https://roblox.com/users/" .. plr.UserId .. "/profile",
					['color'] = 2271193,
					
					['fields'] = {
						{
							['name'] = plr.Name .. ', account age:',
							['value'] = plr.AccountAge,
							['inline'] = true,
						},
						{
							['name'] = plr.Name .. ', UserID:',
							['value'] = plr.UserId,
							['inline'] = true,
						}
					}
				}}
			}
			
			local finaldata = Http:JSONEncode(data)
			Http:PostAsync(UNAUTH_URL, finaldata)
		end
	end)
end)

return module
