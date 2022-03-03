--Server Switch
RegisterVoteType( "VoteSwitchServer", { ip = "string (25)", name = "string(20)" } )
RegisterVoteType("VoteMutePlayer", { targetClient = "integer" })
RegisterVoteType("VoteForceSpectator", { targetClient = "integer" })
RegisterVoteType("VoteKillPlayer", { targetClient = "integer" })
    
if Client then
    local function GetPlayerList()

        local playerList = Scoreboard_GetPlayerList()
        local menuItems = { }
        for p = 1, #playerList do

            local name = Scoreboard_GetPlayerData(Client.GetLocalClientIndex(), "Name")
            local steamId = Scoreboard_GetPlayerRecord(playerList[p].client_index).SteamId
            if  steamId ~= 0 and playerList[p].name ~= name then
                table.insert(menuItems, { text = playerList[p].name, extraData = { targetClient = playerList[p].client_index } })
            end

        end
        return menuItems

    end

    local function SetupAdditionalVotes(voteMenu)

        AddVoteStartListener( "VoteSwitchServer", function( msg )
            return string.format("SWITCH_SERVER_TO",msg.name)
        end )

        voteMenu:AddMainMenuOption(Locale.ResolveString("VOTE_MUTE_PLAYER"), GetPlayerList, function( msg )
            AttemptToStartVote("VoteMutePlayer", { targetClient = msg.targetClient })
        end)
        
        AddVoteStartListener("VoteMutePlayer", function(msg)
            return string.format(Locale.ResolveString("VOTE_MUTE_PLAYER_QUERY"), Scoreboard_GetPlayerName(msg.targetClient))
        end)

        voteMenu:AddMainMenuOption(Locale.ResolveString("VOTE_FORCE_SPECTATE"), GetPlayerList, function( msg )
            AttemptToStartVote("VoteForceSpectator", { targetClient = msg.targetClient })
        end)

        AddVoteStartListener("VoteForceSpectator", function(msg)
            return string.format(Locale.ResolveString("VOTE_FORCE_SPECTATE_QUERY"), Scoreboard_GetPlayerName(msg.targetClient))
        end)

        
        voteMenu:AddMainMenuOption(Locale.ResolveString("VOTE_KILL_PLAYER"), GetPlayerList, function( msg )
            AttemptToStartVote("VoteKillPlayer", { targetClient = msg.targetClient })
        end)

        AddVoteStartListener("VoteKillPlayer", function(msg)
            return string.format(Locale.ResolveString("VOTE_KILL_PLAYER_QUERY"), Scoreboard_GetPlayerName(msg.targetClient))
        end)
    end
    AddVoteSetupCallback(SetupAdditionalVotes)
    
end

if Server then
    SetVoteSuccessfulCallback( "VoteSwitchServer", 3, function( msg )
        -- Shared.Message(msg.name .. " " .. msg.ip)
        Server.SendNetworkMessage("Redirect",{ ip = msg.ip }, true)
    end )

    SetVoteSuccessfulCallback("VoteMutePlayer", 3, function( msg )
        local client = Server.GetClientById(msg.targetClient)
        if client then
            Shared.ConsoleCommand(string.format("sh_gag %s %s", client:GetUserId(), 30 * 60))
        end
    end)

    SetVoteSuccessfulCallback("VoteForceSpectator", 3, function( msg )
        local client = Server.GetClientById(msg.targetClient)
        if client then
			local Player = client:GetControllingPlayer()
			if Player then
                GetGamerules():JoinTeam( Player, kSpectatorIndex, true, true )
            end
        end
    end)

    SetVoteSuccessfulCallback("VoteKillPlayer", 3, function( msg )
        local client = Server.GetClientById(msg.targetClient)
        if client then
			local Player = client:GetControllingPlayer()
			if Player then
				Player:Kill( nil, nil, Player:GetOrigin() )
			end
        end
    end)
end