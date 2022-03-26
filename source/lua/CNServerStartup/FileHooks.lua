
-- workaround because Las is lazy
if AddHintModPanel then return end


kModPanels = {}
kModPanelsLoaded = false
function AddHintModPanel(material, url,hint)
    if not kModPanelsLoaded then
        local panel = {["material"]= material,[ "url"]= url,["hint"]=hint}
        table.insert(kModPanels, panel)
    else
        Log("AddModPanel was called too late")
    end
end

ModLoader.SetupFileHook( "lua/NS2Gamerules.lua", "lua/CNServerStartup/NS2Gamerules.lua", "post" )
ModLoader.SetupFileHook( "lua/Shared.lua", "lua/CNServerStartup/Shared.lua", "post" )
ModLoader.SetupFileHook( "lua/Player.lua", "lua/CNServerStartup/Player.lua", "post" )
ModLoader.SetupFileHook( "lua/Utility.lua", "lua/CNServerStartup/Utility.lua", "post" )
ModLoader.SetupFileHook( "lua/ReadyRoomPlayer.lua", "lua/CNServerStartup/ReadyRoomPlayer.lua", "post" )
ModLoader.SetupFileHook( "lua/ServerAdminCommands.lua", "lua/CNServerStartup/ServerAdminCommands.lua", "post" )
ModLoader.SetupFileHook( "lua/GUIWebView.lua", "lua/CNServerStartup/GUIWebView.lua", "replace" )
ModLoader.SetupFileHook( "lua/Badges_Shared.lua", "lua/CNServerStartup/Badges_Shared.lua", "replace")
ModLoader.SetupFileHook( "lua/Badges_Client.lua", "lua/CNServerStartup/Badges_Client.lua", "replace")
ModLoader.SetupFileHook( "lua/GUIScoreboard.lua", "lua/CNServerStartup/GUIScoreboard.lua", "replace")
ModLoader.SetupFileHook( "lua/Voting.lua", "lua/CNServerStartup/Voting.lua", "post")