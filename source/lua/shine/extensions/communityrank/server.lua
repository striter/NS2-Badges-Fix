local Plugin = ...

Plugin.Version = "1.0"
Plugin.PrintName = "communityrank"
Plugin.HasConfig = true
Plugin.ConfigName = "CommunityRank.json"
Plugin.DefaultConfig = {
    ["Ranks"] = {
        ["55022511"] = -2000,
    }
}
Plugin.CheckConfig = true
Plugin.CheckConfigTypes = true

do
	local Validator = Shine.Validator()
	Validator:AddFieldRule( "Ranks",  Validator.IsType( "table", {} ))
	Plugin.ConfigValidator = Validator
end

function Plugin:Initialise()
    self.PlayerRanks = {}
    self:CreateMessageCommands()
	return true
end

local function ReadPersistent(self)
    Shared.Message("[CNCR] Read Persistent:")
    for k,v in pairs(self.Config.Ranks) do
        Shared.Message(k .. ":" .. tostring(v))
        self.PlayerRanks[tonumber(k)] = v
    end
end

local function SavePersistent(self)
    Shared.Message("[CNCR] Save Persistent:")
    for k,v in pairs(self.PlayerRanks) do
        self.Config.Ranks[tostring(k)] = v
    end
    self:SaveConfig()
end

function Plugin:OnFirstThink()
    ReadPersistent(self)
	Shine.Hook.SetupClassHook( "PlayerRanking", "EndGame", "OnEndGame", "PassivePost" )
    -- local VRPlugin = Shine.Plugins["voterandom"]
    -- if VRPlugin and VRPlugin.Enabled then
    --     local baseGetHiveSkill = VRPlugin.SkillGetters.GetHiveSkill
    --     VRPlugin.SkillGetters.GetHiveSkill =  function( Ply, TeamNumber, TeamSkillEnabled, CommanderSkillEnabled, Options )
    --         local hiveSkill =  baseGetHiveSkill( Ply, TeamNumber, TeamSkillEnabled, CommanderSkillEnabled, Options)
    --         Shared.Message(tostring(hiveSkill))
    --         return hiveSkill
    --     end
    -- end
end

function Plugin:ResetState()
    table.empty(self.PlayerRanks)
    ReadPersistent(self)
end

function Plugin:Cleanup()
	self:ResetState()
    return true
end

function Plugin:CreateMessageCommands()
    local function RankPlayer( _client, _id, _rank )
        local target = Shine.GetClientByNS2ID(_id)
        if not target then 
            return 
        end

        self.PlayerRanks[_id] = _rank
        target:GetControllingPlayer():SetCommunityRank(_rank)
    
        Shine:AdminPrint( nil, "%s set %s rank to %s", true,  Shine.GetClientInfo( _client ), Shine.GetClientInfo( _target ), _rank )
        SavePersistent(self)
    end

    local GagCommand = self:BindCommand( "sh_rankid", "rankid", RankPlayer )
    GagCommand:AddParam{ Type = "steamid" }
    GagCommand:AddParam{ Type = "number", Round = true, Min = -5000, Max = 5000, Optional = true, Default = 0 }
    GagCommand:Help( "设置ID对应玩家的社区段位." )

    local function RankPlayerOffset( _client, _id, _offset )
        local target = Shine.GetClientByNS2ID(_id)
        if not target then 
            return 
        end

        if not self.PlayerRanks[_id] then
            self.PlayerRanks[_id] =0
        end
        local rankOffseted = self.PlayerRanks[_id] + _offset
        self.PlayerRanks[_id] = rankOffseted
        target:GetControllingPlayer():SetCommunityRank(rankOffseted)

        Shine:AdminPrint( nil, "%s set %s rank to %s", true,  Shine.GetClientInfo( _client ), _id, rankOffseted )
        SavePersistent(self)
    end
    local GagCommand = self:BindCommand( "sh_rankidoffset", "rankidoffset", RankPlayerOffset )
    GagCommand:AddParam{ Type = "steamid" }
    GagCommand:AddParam{ Type = "number", Round = true, Min = -5000, Max = 5000, Optional = true, Default = 0 }
    GagCommand:Help( "增减ID对应玩家的社区段位." )
end

function Plugin:OnEndGame(winningTeam)

end

function Plugin:ClientConnect( _client )
    local clientID = _client:GetUserId()
    if not self.PlayerRanks[clientID] then
        self.PlayerRanks[clientID] = 0
    end
    local rank = self.PlayerRanks[clientID]
    _client:GetControllingPlayer():SetCommunityRank(rank)
    Shared.Message("[CNCR] Client Rank:" .. tostring(clientID) .. ":" .. tostring(rank))
end