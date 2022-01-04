if Client then
  ModLoader.SetupFileHook("lua/Badges_Client.lua", "lua/CNBadgesFix/Badges_Client.lua", "replace")
  ModLoader.SetupFileHook("lua/GUIUnitStatus.lua", "lua/CNBadgesFix/GUIUnitStatus.lua", "replace")
end

if Server then
  ModLoader.SetupFileHook("lua/Badges_Server.lua", "lua/CNBadgesFix/Badges_Server.lua", "replace")
end
