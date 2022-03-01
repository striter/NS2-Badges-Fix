    RegisterVoteType( "VoteSwitchServer", { ip = "string (25)", name = "string(20)" } )
    
    if Server then
		SetVoteSuccessfulCallback( "VoteSwitchServer", 3, function( msg )
            -- Shared.Message(msg.name .. " " .. msg.ip)
            Server.SendNetworkMessage("Redirect",{ ip = msg.ip }, true)
		end )
    end

    if Client then
        AddVoteSetupCallback( function( VoteMenu )
            AddVoteStartListener( "VoteSwitchServer", function( msg )
                return "切换服务器至<" .. msg.name ..">?"
            end )
        end )
    end