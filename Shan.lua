repeat wait() until game:IsLoaded()
repeat wait() until game:GetService("Players")
repeat wait() until game:GetService("Players").LocalPlayer
repeat wait() until game:GetService("Players").LocalPlayer.PlayerGui
repeat wait() until game:GetService("ReplicatedStorage").Effect.Container

assert(getrawmetatable)
    grm = getrawmetatable(game)
    setreadonly(grm, false)
    old = grm.__namecall
    grm.__namecall = newcclosure(function(self, ...)
        local args = {...}
        if tostring(args[1]) == "TeleportDetect" then
            return
        elseif tostring(args[1]) == "CHECKER_1" then
            return
        elseif tostring(args[1]) == "CHECKER" then
            return
        elseif tostring(args[1]) == "GUI_CHECK" then
            return
        elseif tostring(args[1]) == "OneMoreTime" then
            return
        elseif tostring(args[1]) == "checkingSPEED" then
            return
        elseif tostring(args[1]) == "BANREMOTE" then
            return
        elseif tostring(args[1]) == "PERMAIDBAN" then
            return
        elseif tostring(args[1]) == "KICKREMOTE" then
            return
        elseif tostring(args[1]) == "BR_KICKPC" then
            return
        elseif tostring(args[1]) == "BR_KICKMOBILE" then
            return
        end
        return old(self, ...)
end)

getgenv().A = require(game:GetService("ReplicatedStorage").CombatFramework.RigLib).wrapAttackAnimationAsync
getgenv().B = require(game.Players.LocalPlayer.PlayerScripts.CombatFramework.Particle).play
_G.setfflag = true
spawn(function()
    while wait() do
        if _G.setfflag then
            setfflag("AbuseReportScreenshot", "False")
            setfflag("AbuseReportScreenshotPercentage", "0")
        end
    end
end)

_G.Settings = {

SelectWeapon = {"Melee"},
FastType = {},
AutoFarm = false,
BringMob = true,
FastAttack = true,
AutoHaki = true

}

function LoadSettings()
	if readfile and writefile and isfile and isfolder then
		if not isfolder("Elzkeyyy") then
			makefolder("Elzkeyyy")
		end
		if not isfolder("Elzkeyyy/Blox Fruits/") then
			makefolder("Elzkeyyy/Blox Fruits/")
		end;
		if not isfile("Elzkeyyy/Blox Fruits/" .. game.Players.LocalPlayer.Name .. ".json") then
			writefile("Elzkeyyy/Blox Fruits/" .. game.Players.LocalPlayer.Name .. ".json", game:GetService("HttpService"):JSONEncode(_G.Settings))
		else
			local x = game:GetService("HttpService"):JSONDecode(readfile("Elzkeyyy/Blox Fruits/" .. game.Players.LocalPlayer.Name .. ".json"))
			for i,v in pairs(x) do
				_G.Settings[i] = v
			end
		end
	else
		return
	end
end

function SaveSettings()
	if readfile and writefile and isfile and isfolder then
		if not isfile("Elzkeyyy/Blox Fruits/" .. game.Players.LocalPlayer.Name .. ".json") then
			LoadSettings()
		else
			local x = game:GetService("HttpService"):JSONDecode(readfile("Elzkeyyy/Blox Fruits/" .. game.Players.LocalPlayer.Name .. ".json"))
			local A = {}
			for i,v in pairs(_G.Settings) do
				A[i] = v
			end
			writefile("Elzkeyyy/Blox Fruits/" .. game.Players.LocalPlayer.Name .. ".json", game:GetService("HttpService"):JSONEncode(A))
		end
	else
		return
	end
end

LoadSettings()

-- [ Tween Functions #1 ]

function Tween(Peach)
	if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health <= 0 or not game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid") then 
        tween:Cancel() 
        repeat task.wait() until game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid") and game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").Health > 0 wait(7) return 
    end
	if (game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.Position - Peach.Position).Magnitude <= 150 then
		pcall(function()
			tween:Cancel()

			game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.CFrame = Peach

			return
		end)
	end

	local tween_s = game:service("TweenService")
	local info = TweenInfo.new((game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.Position - Peach.Position).Magnitude/325,Enum.EasingStyle.Linear)
	tween = tween_s:Create(game.Players.LocalPlayer.Character["HumanoidRootPart"],info,{CFrame = Peach})
	tween:Play()

	local tweenfunc = {}

	function tweenfunc:Stop()
		tween:Cancel()
	end

	return tweenfunc
end

-- [ Body Gyro ]

task.spawn(function()
    game:GetService("RunService").Stepped:Connect(function()
        pcall(function()
            if _G.Settings.AutoFarm then
                 if syn then
                    setfflag("HumanoidParallelRemoveNoPhysics","false")
                    setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2","false")
                    game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
                    if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == true then
                        game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit = false
                    end
                else
                    if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity1") then
                            if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == true then
                                game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit = false
                            end
                            local BodyVelocity = Instance.new("BodyVelocity")
                            BodyVelocity.Name = "BodyVelocity1"
                            BodyVelocity.Parent =  game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
                            BodyVelocity.MaxForce = Vector3.new(10000,10000,10000)
                            BodyVelocity.Velocity = Vector3.new(0,0,0)
                        end
                    end
                    for i,v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
                        if v:IsA("BasePart") then
                            v.CanCollide = false
                        end
                    end
                end
            else
                if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity1") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity1"):Destroy()
                end
            end
        end)
    end)
end)

-- [ Click Functions ]

function ClickCamera()
    pcall(function()
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):ClickButton1(Vector2.new(851,158),game:GetService("Workspace").Camera.CFrame)
    end)
end

function Click()
    pcall(function()
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
    end)
end

-- Place ID

if game.PlaceId == 2753915549 then
        W = true
    elseif game.PlaceId == 4442272183 then
        W2 = true
    elseif game.PlaceId == 7449423635 then
        W3 = true
end

-- Quest [Lv.1 to MAX]

local O = Instance.new("Folder", workspace)
O.Name = "EnemySpawns"
for y, z in pairs(workspace._WorldOrigin.EnemySpawns:GetChildren()) do
    if z:IsA("Part") then
        local P = z:Clone()
        local J = string.gsub(z.Name, "Lv. ", "")
        local K = string.gsub(J, "[%[%]]", "")
        local L = string.gsub(K, "%d+", "")
        local M = string.gsub(L, "%s+", "")
        P.Name = M
        P.Parent = workspace.EnemySpawns
        P.Anchored = true
    end
end
for y, z in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
    if z:IsA("Model") and z:FindFirstChild("HumanoidRootPart") then
        local P = z.HumanoidRootPart:Clone()
        local J = string.gsub(z.Name, "Lv. ", "")
        local K = string.gsub(J, "[%[%]]", "")
        local L = string.gsub(K, "%d+", "")
        local M = string.gsub(L, "%s+", "")
        P.Name = M
        P.Parent = workspace.EnemySpawns
        P.Anchored = true
    end
end
for y, z in pairs(game.ReplicatedStorage:GetChildren()) do
    if z:IsA("Model") and z:FindFirstChild("HumanoidRootPart") then
        local P = z.HumanoidRootPart:Clone()
        local J = string.gsub(z.Name, "Lv. ", "")
        local K = string.gsub(J, "[%[%]]", "")
        local L = string.gsub(K, "%d+", "")
        local M = string.gsub(L, "%s+", "")
        P.Name = M
        P.Parent = workspace.EnemySpawns
        P.Anchored = true
    end
end
local function Q()
    local R = game:GetService("Players").LocalPlayer.Data.Level.Value
    if R >= 1 and R <= 9 then
        if tostring(game.Players.LocalPlayer.Team) == "Marines" then
            MobName = "Trainee"
            QuestName = "MarineQuest"
            QuestLevel = 1
            Mon = "Trainee"
            NPCPosition = CFrame.new(-2709.67944, 24.5206585, 2104.24585, -0.744724929, -3.97967455e-08, -0.667371571, 4.32403588e-08, 1, -1.07884304e-07, 0.667371571, -1.09201515e-07, -0.744724929)
        elseif tostring(game.Players.LocalPlayer.Team) == "Pirates" then
            MobName = "Bandit"
            Mon = "Bandit"
            QuestName = "BanditQuest1"
            QuestLevel = 1
            NPCPosition = CFrame.new(1059.99731, 16.9222069, 1549.28162, -0.95466274, 7.29721794e-09, 0.297689587, 1.05190106e-08, 1, 9.22064114e-09, -0.297689587, 1.19340022e-08, -0.95466274)
        end
        return {
            [1] = QuestLevel,
            [2] = NPCPosition,
            [3] = MobName,
            [4] = QuestName,
            [5] = LevelRequire,
            [6] = Mon,
            [7] = MobCFrame
        }
    end
    if R >= 210 and R <= 249 then
        MobName = "Dangerous Prisoner"
        QuestName = "PrisonerQuest"
        QuestLevel = 2
        Mon = "Dangerous Prisoner"
        NPCPosition = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918e-09, -0.995993316, 1.60817859e-09, 1, -5.16744869e-09, 0.995993316, -2.06384709e-09, -0.0894274712)
        local S = {}
        local J = string.gsub(MobName, "Lv. ", "")
        local K = string.gsub(J, "[%[%]]", "")
        local L = string.gsub(K, "%d+", "")
        local M = string.gsub(L, "%s+", "")
        for y, z in pairs(game.workspace.EnemySpawns:GetChildren()) do
            if z.Name == M then
                table.insert(S, z.CFrame)
            end
            MobCFrame = S
        end
        return {
            [1] = QuestLevel,
            [2] = NPCPosition,
            [3] = MobName,
            [4] = QuestName,
            [5] = LevelRequire,
            [6] = Mon,
            [7] = MobCFrame
        }
    end
    local T = require(game:GetService("ReplicatedStorage").GuideModule)
    local U = require(game:GetService("ReplicatedStorage").Quests)
    for y, z in pairs(T["Data"]["NPCList"]) do
        for V, W in pairs(z["Levels"]) do
            if R >= W then
                if not LevelRequire then
                    LevelRequire = 0
                end
                if W > LevelRequire then
                    NPCPosition = y["CFrame"]
                    QuestLevel = V
                    LevelRequire = W
                end
                if #z["Levels"] == 3 and QuestLevel == 3 then
                    NPCPosition = y["CFrame"]
                    QuestLevel = 2
                    LevelRequire = z["Levels"][2]
                end
            end
        end
    end
    if R >= 375 and R <= 399 then
        if _G.Settings.AutoFarm and (NPCPosition.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
        end
    end
    if R >= 400 and R <= 449 then
        if _G.Settings.AutoFarm and (NPCPosition.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
        end
    end
    for y, z in pairs(U) do
        for V, W in pairs(z) do
            if W["LevelReq"] == LevelRequire and y ~= "CitizenQuest" then
                QuestName = y
                for X, Y in pairs(W["Task"]) do
                    MobName = X
                    Mon = string.split(X, " [Lv. " .. W["LevelReq"] .. "]")[1]
                end
            end
        end
    end
    if QuestName == "MarineQuest2" then
        QuestName = "MarineQuest2"
        QuestLevel = 1
        MobName = "Chief Petty Officer"
        Mon = "Chief Petty Officer"
        LevelRequire = 120
    elseif QuestName == "ImpelQuest" then
        QuestName = "PrisonerQuest"
        QuestLevel = 2
        MobName = "Dangerous Prisoner"
        Mon = "Dangerous Prisoner"
        LevelRequire = 210
        NPCPosition = CFrame.new(5310.60547, 0.350014925, 474.946594, 0.0175017118, 0, 0.999846935, 0, 1, 0, -0.999846935, 0, 0.0175017118)
    elseif QuestName == "SkyExp1Quest" then
        if QuestLevel == 1 then
            NPCPosition = CFrame.new(-4721.88867, 843.874695, -1949.96643, 0.996191859, -0, -0.0871884301, 0, 1, -0, 0.0871884301, 0, 0.996191859)
        elseif QuestLevel == 2 then
            NPCPosition = CFrame.new(-7859.09814, 5544.19043, -381.476196, -0.422592998, 0, 0.906319618, 0, 1, 0, -0.906319618, 0, -0.422592998)
        end
    elseif QuestName == "Area2Quest" and QuestLevel == 2 then
        QuestName = "Area2Quest"
        QuestLevel = 1
        MobName = "Swan Pirate"
        Mon = "Swan Pirate"
        LevelRequire = 775
    end
    MobName = MobName:sub(1, #MobName)
    if not MobName:find("Lv") then
        for y, z in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
            MonLV = string.match(z.Name, "%d+")
            if z.Name:find(MobName) and #z.Name > #MobName and tonumber(MonLV) <= R + 50 then
                MobName = z.Name
            end
        end
    end
    if not MobName:find("Lv") then
        for y, z in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
            MonLV = string.match(z.Name, "%d+")
            if z.Name:find(MobName) and #z.Name > #MobName and tonumber(MonLV) <= R + 50 then
                MobName = z.Name
                Mon = a
            end
        end
    end
    local S = {}
    local J = string.gsub(MobName, "Lv. ", "")
    local K = string.gsub(J, "[%[%]]", "")
    local L = string.gsub(K, "%d+", "")
    local M = string.gsub(L, "%s+", "")
    for y, z in pairs(game.workspace.EnemySpawns:GetChildren()) do
        if z.Name == M then
            table.insert(S, z.CFrame)
        else
            table.insert(S, nil)
        end
        MobCFrame = S
    end
    return {
        [1] = QuestLevel,
        [2] = NPCPosition,
        [3] = MobName,
        [4] = QuestName,
        [5] = LevelRequire,
        [6] = Mon,
        [7] = MobCFrame,
        [8] = MonQ,
        [9] = MobCFrameNuber
    }
end

-- Fast Attack

local a1 = require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("CombatFramework"))
local a2 = getupvalues(a1)[2]
local a3 = require(game:GetService("Players")["LocalPlayer"].PlayerScripts.CombatFramework.RigController)
local a4 = getupvalues(a3)[2]
local a5 = require(game.ReplicatedStorage.CombatFramework.RigLib)
local a6 = tick()
function CameraShaker()
	local a7 = require(game.ReplicatedStorage.Util.CameraShaker)
	a7:Stop()
end
function CurrentWeapon()
	local a8 = a2.activeController
	local a9 = a8.blades[1]
	if not a9 then
		return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name
	end;
	pcall(function()
		while a9.Parent ~= game.Players.LocalPlayer.Character do
			a9 = a9.Parent
		end
	end)
	if not a9 then
		return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name
	end;
	return a9
end
function getAllBladeHits(aa)
	local ab = {}
	local Client = game.Players.LocalPlayer;
	local ac = workspace.Characters:GetChildren()
	local ad = game:GetService("Workspace").Enemies:GetChildren()
	for y = 1, #ad do
		local z = ad[y]
		local ae = z:FindFirstChildOfClass("Humanoid")
		if ae and ae.RootPart and ae.Health > 0 and Client:DistanceFromCharacter(ae.RootPart.Position) <= aa + 5 then
			table.insert(ab, ae.RootPart)
		end
	end;
	for y = 1, #ac do
		local z = ac[y]
		if z ~= game.Players.LocalPlayer.Character then
			local ae = z:FindFirstChildOfClass("Humanoid")
			if ae and ae.RootPart and ae.Health > 0 and Client:DistanceFromCharacter(ae.RootPart.Position) <= aa + 5 then
				table.insert(ab, ae.RootPart)
			end
		end
	end;
	return ab
end
function yakmefan()
	local a8 = a2.activeController;
	if a8 and a8.equipped then
		for af = 1, 1 do
			local ag = getAllBladeHits(100)
			if #ag > 0 then
				local ah = debug.getupvalue(a8.attack, 5)
				local ai = debug.getupvalue(a8.attack, 6)
				local aj = debug.getupvalue(a8.attack, 4)
				local ak = debug.getupvalue(a8.attack, 7)
				local al = (ah * 798405 + aj * 727595) % ai;
				local am = aj * 798405
				(function()
					al = (al * ai + am) % 1099511627776;
					ah = math.floor(al / ai)
					aj = al - ah * ai
				end)()
				ak = ak + 1
				debug.setupvalue(a8.attack, 5, ah)
				debug.setupvalue(a8.attack, 6, ai)
				debug.setupvalue(a8.attack, 4, aj)
				debug.setupvalue(a8.attack, 7, ak)
				for k, z in pairs(a8.animator.anims.basic) do
					z:Play(0.01, 0.01, 0.01)
				end
				if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and a8.blades and a8.blades[1] then
					game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange", tostring(CurrentWeapon()))
					game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(al / 1099511627776 * 16777215), ak)
					game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", ag, 1, "")
				end
			end
		end
	end
end

coroutine.wrap(function()
	while wait(0) do
		local a8 = a2.activeController;
		if a8 and a8.equipped then
			task.wait(0.04)
			if _G.Settings.FastAttack then
				yakmefan()
				if _G.Settings.FastType == "Normal" then
					if tick() - a6 > .9 then
						wait(.1)
						a6 = tick()
					end
				elseif _G.Settings.FastType == "Fast" then
					if tick() - a6 > 1.5 then
						wait(.01)
						a6 = tick()
					end
				elseif _G.Settings.FastType == "Slow" then
					if tick() - a6 > .3 then
						wait(.7)
						a6 = tick()
					end
					sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
				end
			end
		end
	end
end)()
local en = game.Players.LocalPlayer.Data.Level.Value;
if en >= 15 and en <= 70 and _G.Settings.AutoFarmFast then
	_G.Settings.FastType = "Slow"
elseif en >= 70 then
	_G.Settings.FastType = "Fast"
end
for y, z in pairs(game.ReplicatedStorage:GetChildren()) do
	if z.Name == "Cake Prince" or z.Name == "Dough King" or z.Name == "Cyborg" or z.Name == "The Gorilla King" or z.Name == "Wysper" or z.Name == "Thunder God" or z.Name == "Mob Leader" or z.Name == "Bobby" or z.Name == "Saber Expert" or z.Name == "Warden" or z.Name == "Chief Warden" or z.Name == "Swan" or z.Name == "Magma Admiral" or z.Name == "Fishman Lord" or z.Name == "Wysper" or z.Name == "Ice Admiral" or z.Name == "Diamond" or z.Name == "Jeremy" or z.Name == "Fajita" or z.Name == "Don Swan" or z.Name == "Smoke Admiral" or z.Name == "Awakened Ice Admiral" or z.Name == "Tide Keeper" or z.Name == "Darkbeard" or z.Name == "Stone" or z.Name == "Island Empress" or z.Name == "Kilo Admiral" or z.Name == "Captain Elephant" or z.Name == "Beautiful Pirate" or z.Name == "Longma" or z.Name == "Cake Queen" or z.Name == "Greybeard" or z.Name == "Order" or z.Name == "Cursed Captain" or z.Name == "Soul Reaper" or z.Name == "Rip indra" or z.Name == "Mihawk Boss" or z.Name == "Cake Prince" or z.Name == "Dough King" or z.Name == "Cursed Skeleton Boss" then
		if (z.HumanoidRootPart.CFrame.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 1000 then
		     _G.Settings.FastType = "Normal"
		end
	end
end

-- Bring Mon

spawn(function()
	game:GetService("RunService").Heartbeat:Connect(function()
		pcall(function()
			if _G.Settings.BringMob then
				for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
					if _G.Settings.AutoFarm and v.Name == Mon and (v.HumanoidRootPart.Position - PosMon.Position).magnitude <= 200 then
						v.HumanoidRootPart.CFrame = PosMon
						v.HumanoidRootPart.CanCollide = false
						v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
						sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
					end
				end
			end
		end)
	end)
end)

task.spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Settings.BringMob then
				for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
					if not string.find(v.Name, "Boss") and (v.HumanoidRootPart.Position - PosMon.Position).magnitude <= 300 then
						v.HumanoidRootPart.CFrame = PosMon
						v.Humanoid.JumpPower = 0
						v.Humanoid.WalkSpeed = 0
						v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
						v.HumanoidRootPart.Transparency = 1
						v.HumanoidRootPart.CanCollide = false
						v.Head.CanCollide = false
						v.Humanoid:ChangeState(11)
						v.Humanoid:ChangeState(14)
						sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
					end
				end
			end
		end)
	end
end)

-- Click & Effects

game:GetService("Players").LocalPlayer.Idled:connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

spawn(function()
    while task.wait() do
        for i,v in pairs(game:GetService("Workspace")["_WorldOrigin"]:GetChildren()) do
            pcall(function()
                if v.Name == ("CurvedRing") or v.Name == ("SlashHit") or v.Name == ("SwordSlash") or v.Name == ("SlashTail") or v.Name == ("Sounds") then
                    v:Destroy()
                end
            end)
        end
    end
end)

-- Weapon

function EquipWeapon(B)
	pcall(function()
		if game.Players.LocalPlayer.Backpack:FindFirstChild(B) then
			local C = game.Players.LocalPlayer.Backpack:FindFirstChild(B)
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(C)
		end
	end)
end;

-- gags

local QuartyzLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/xDestinyyx/Scripts/main/Mukuro.lua"))()

local win = QuartyzLib:Window("nelzkie gwapo")
local serv = win:Server("Blox Fruits", "")

local AutoFarm = serv:Channel("Main", "http://www.roblox.com/asset/?id=7040391851")

Weapon = {
	"Melee",
	"Fruit",
	"Sword",
        "Gun"
}
AutoFarm:Dropdown("Select Weapon", Weapon, function(value)
    _G.Settings.SelectWeapon = value
    SaveSettings()
end)

spawn(function()
    while task.wait() do
        pcall(function()
            for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                if v:IsA("Tool") then
                    if v.ToolTip == _G.Settings.SelectWeapon then
                        _G.SelectWeapon = v.Name
                    end
                end
            end
        end)
    end
end)

local CodeApi = loadstring(game:HttpGet("https://pastebin.com/raw/pWSTb80J"))()

local Codess = AutoFarm:Button("Redeem x2 Codes",function()
    function RedeemCode(value)
        game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(value)
    end
    for i,v in pairs(CodeApi) do
        RedeemCode(v)
    end
end)

AutoFarm:Toggle("Auto Farm Level",_G.Settings.AutoFarm,function(value)
   _G.Settings.AutoFarm = value
SaveSettings()
if value == false then
        wait()
        Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        wait()
    end
end)
AttackRandomType_MonCFrame = 1
spawn(function()
	while wait() do
		AttackRandomType_MonCFrame = math.random(1, 5)
		wait(0.3)
	end
end)
local dK = 1

spawn(function()
    while task.wait() do
        local dL = game.Players.LocalPlayer.Data.Level.Value
        local dM = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest
        pcall(function()
            if _G.Settings.AutoFarm then
                if dM.Visible == true then
                    if game:GetService("Workspace").Enemies:FindFirstChild(Q()[3]) then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v.Name == Q()[3] then
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                        if _G.Settings.AutoFarm then
                                            dK = 1
                                        end
                                        if not string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, Q()[6]) then
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                                        else
                                            PosMon = v.HumanoidRootPart.CFrame
                                            v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.Humanoid.WalkSpeed = 0
                                            v.Head.CanCollide = false
                                            EquipWeapon(_G.SelectWeapon)
                                            v.HumanoidRootPart.Transparency = 1
                                            if AttackRandomType_MonCFrame == 1 then
                                                Tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 20))
                                            elseif AttackRandomType_MonCFrame == 2 then
                                                Tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, -20))
                                            elseif AttackRandomType_MonCFrame == 3 then
                                                Tween(v.HumanoidRootPart.CFrame * CFrame.new(20, 30, 0))
                                            elseif AttackRandomType_MonCFrame == 4 then
                                                Tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, -20))
                                            elseif AttackRandomType_MonCFrame == 5 then
                                                Tween(v.HumanoidRootPart.CFrame * CFrame.new(-20, 30, 0))
                                            else
                                                Tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 20))
                                            end
                                            if not _G.Settings.AutoFarm then
                                                _G.Settings.FastAttack = true
                                            end
                                        end
                                    until not _G.Settings.AutoFarm or not v.Parent or v.Humanoid.Health <= 0 or dM.Visible == false or not v:FindFirstChild("HumanoidRootPart")
                                end
                            end
                        end
                    else
                        if _G.Settings.AutoFarm then
                            Tween(Q()[7][dK] * CFrame.new(0,30,0))
                            if (Q()[7][dK].Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 50 then
                                if dK == nil or dK == '' then
                                    dK = 1
                                elseif dK >= #Q()[7] then
                                    dK = 1
                                end
                                dK = dK + 1
                                wait(0.5)
                            end
                        end
                    end
                else
                    Tween(Q()[2])
                    if (Q()[2].Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1 then
                        BringMob = false
                        wait(0.2)
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer("StartQuest",Q()[4],Q()[1])
								wait(0.5)
								if dM.Visible == true then
									Tween(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
								end
                        return
                    end
                end
            end
        end)
    end
end)

AutoFarm:Toggle("Bring Mob",_G.Settings.BringMob,function(value)
    _G.Settings.BringMob = value
SaveSettings()
end)

AutoFarm:Toggle("Fast Attack",_G.Settings.FastAttack,function(value)
    _G.Settings.FastAttack = value
SaveSettings()
end)

AutoFarm:Toggle("Auto Haki",_G.Settings.AutoHaki,function(value)
    _G.Settings.AutoHaki = value
SaveSettings()
end)

task.spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Settings.AutoHaki then
				if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
				end
			end
		end)
	end
end)
