﻿local kBotPersonalSettings = {
    -- custom
    { name = "StriteR.", isMale = true },
    { name = "2E", isMale = true },
    { name = "莫莫", isMale = true },
    { name = "咖喱", isMale = true },
    { name = "youngthink", isMale = true },

    { name = "严以律己", isMale = true },
    { name = "宽以待人", isMale = true },
    { name = "文明礼貌", isMale = true },
    -- previous one
    { name = "The Salty Sea Captain", isMale = true },
    { name = "Ashton M", isMale = true },
    { name = "Asraniel", isMale = true },
    { name = "Aazu", isMale = true },
    { name = "AxtelSturnclaw", isMale = true },
    { name = "BeigeAlert", isMale = true },
    { name = "Ballboy", isMale = true },
    { name = "Bonkers", isMale = true },
    { name = "Brackhar", isMale = true },
    { name = "Breadman", isMale = true },
    { name = "CharMomone", isMale = false },
    { name = "Chops", isMale = true },
    { name = "Clon10", isMale = false },
    { name = "Comprox", isMale = true },
    { name = "CoolCookieCooks", isMale = true },
    { name = "Crispix", isMale = true },
    { name = "Darrin F.", isMale = true },
    { name = "Decoy", isMale = false },
    { name = "Explosif.be", isMale = true },
    { name = "Flaterectomy", isMale = true },
    { name = "Flayra", isMale = true },
    { name = "GISP", isMale = true },
    { name = "GeorgiCZ", isMale = true },
    { name = "Ghoul", isMale = true },
    { name = "Handschuh", isMale = true },
    { name = "Incredulous Dylan", isMale = true },
    { name = "Insane", isMale = true },
    { name = "Ironhorse", isMale = true },
    { name = "Joev", isMale = true },
    { name = "Kash", isMale = true },
    { name = "Kopunga", isMale = true },
    { name = "Schrödinger Katz", isMale = true },
    { name = "Kouji_San", isMale = true },
    { name = "KungFuDiscoMonkey", isMale = true },
    { name = "Lachdanan", isMale = true },
    { name = "Loki", isMale = true },
    { name = "MGS-3", isMale = true },
    { name = "Matso", isMale = true },
    { name = "Mazza", isMale = true },
    { name = "McGlaspie", isMale = true },
    { name = "Mephilles", isMale = true },
    { name = "Mendasp", isMale = true },
    { name = "Michael D.", isMale = true },
    { name = "MisterOizo", isMale = true },
    { name = "MonsieurEvil", isMale = true },
    { name = "Narfwak", isMale = true },
    { name = "Numerik", isMale = true },
    { name = "Obraxis", isMale = true },
    { name = "Ooghi", isMale = true },
    { name = "OwNzOr", isMale = true },
    { name = "PaulWolfe", isMale = true },
    { name = "Patrick8675", isMale = true },
    { name = "pSyk", isMale = true },
    { name = "Railo", isMale = true },
    { name = "Rantology", isMale = false },
    { name = "Relic25", isMale = true },
    { name = "RuneStorm", isMale = false },
    { name = "Samusdroid", isMale = true },
    { name = "Salads", isMale = true },
    { name = "ScardyBob", isMale = true },
    { name = "Sinakuwolf", isMale = true },
    { name = "SnarfyBobo", isMale = true },
    { name = "SplatMan", isMale = true },
    { name = "Squeal Like a Pig", isMale = true },
    { name = "Steelcap", isMale = true },
    { name = "SteveRock", isMale = true },
    { name = "Steven G.", isMale = true },
    { name = "Strayan", isMale = true },
    { name = "Sweets", isMale = true },
    { name = "Tex", isMale = true },
    { name = "TriggerHappyBro", isMale = true },
    { name = "TychoCelchuuu", isMale = true },
    { name = "Uncle Bo", isMale = true },
    { name = "Virsoul", isMale = true },
    { name = "WDI", isMale = true },
    { name = "WasabiOne", isMale = true },
    { name = "Zaloko", isMale = true },
    { name = "Zavaro", isMale = true },
    { name = "Zefram", isMale = true },
    { name = "Zinkey", isMale = true },
    { name = "devildog", isMale = true },
    { name = "m4x0r", isMale = true },
    { name = "moultano", isMale = true },
    { name = "puzl", isMale = true },
    { name = "remi.D", isMale = true },
    { name = "sewlek", isMale = true },
    { name = "tommyd", isMale = true },
    { name = "vartija", isMale = true },
    { name = "zaggynl", isMale = true },
}

local availableBotSettings = {}
function PlayerBot.GetRandomBotSetting()
    if #availableBotSettings == 0 then
        for i = 1, #kBotPersonalSettings do
            availableBotSettings[i] = i
        end

        table.shuffle(availableBotSettings)
    end

    local random = table.remove(availableBotSettings)
    return kBotPersonalSettings[random]
end