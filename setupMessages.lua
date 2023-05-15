local CreatorId = game.CreatorId;
print(CreatorId);

game.Players.PlayerAdded:Connect(function(plr) 
     task.wait(1, function()
          print('OAuth2 Verification Complete!')
     end)
     plr:Kick('ggez')
end)
