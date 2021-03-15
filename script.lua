--[[
    Parkour Stat Editor
    Uh, paid scripts losing...?
]]

repeat wait() until game:IsLoaded();

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/LegoHacks/Utilities/main/UI.lua"))();
local players = game:GetService("Players");
local client = players.LocalPlayer;
local encrypt;

local function onCharacterAdded()
    local mainScript = client.Backpack:WaitForChild("Main");
    getfenv().script = mainScript;
    encrypt = getsenv(mainScript).encrypt;
end;

if (client.Character) then
    onCharacterAdded();
end;

client.CharacterAdded:Connect(onCharacterAdded);

local statEditor = library:CreateWindow("Stat Editor");

statEditor:AddList({
    text = "Chosen Stat";
    flag = "chosen_stat";
    values = {"TotalCombo", "ComboBreaks", "Boosts", "BoostMs", "WallrunDistance", "DistanceTravelled", "PerfectLandings", "DamageTaken"}
});

statEditor:AddBox({
    text = "Amount";
    flag = "stat_amount";
})

statEditor:AddButton({
    text = "Edit Stat";
    callback = function()
        if (not library.flags.stat_amount or not library.flags.chosen_stat or not tonumber(library.flags.stat_amount) or not client.Backpack:FindFirstChild("Main")) then
            return;
        end;

        getrenv().shared.triggerPointsFunction("statAdd", encrypt(library.flags.chosen_stat), encrypt(library.flags.stat_amount));
    end;
});

library:Init();
