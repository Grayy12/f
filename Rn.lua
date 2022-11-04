getgenv().ToggleValue = false
getgenv().autoAFKVal = false

getgenv().getgenv().DistanceValue = 10
getgenv().getgenv().PingValue = 4

local ball = false

function AutoDeflect()
	task.spawn(function()
		local function getBall()
			while getgenv().ToggleValue do
				if not getgenv().ToggleValue then
					break
				end
				game:GetService("RunService").Stepped:Wait()
				if workspace:FindFirstChild("Ball") ~= nil then
					ball = workspace.Ball
				end
			end
		end

		task.spawn(getBall)

		local plr = game.Players.LocalPlayer

		while getgenv().ToggleValue do
			if not getgenv().ToggleValue then
				break
			end
			game:GetService("RunService").PreRender:Wait()
			if ball and ball:FindFirstChild("Main") and plr.Character ~= nil then
				local distance = (ball.Main.Position - plr.Character.HumanoidRootPart.Position).Magnitude
				local BallDirection = workspace.CurrentCamera.CFrame.LookVector
				if
					distance
					<= getgenv().DistanceValue
						+ math.abs(
							(
								(game.Players.LocalPlayer:GetNetworkPing() * 1000)
								/ (game.Players.LocalPlayer:GetNetworkPing() * 1000)
								/ getgenv().PingValue
							)
						)
						+ math.abs(
							(
								ball.Main.AssemblyLinearVelocity.Magnitude
								/ (ball.Main.AssemblyLinearVelocity.Magnitude / getgenv().PingValue)
							)
						)
				then
					plr.Character:WaitForChild("Deflection").Remote:FireServer("Deflect", BallDirection)
				end
				if not getgenv().ToggleValue then
					break
				end
			end
		end
	end)
end

local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

local Window = Rayfield:CreateWindow({
	Name = "Fortnite Battlepass",
	LoadingTitle = "Fortnite Battlepass",
	LoadingSubtitle = "by Grayy#6068",
	ConfigurationSaving = {
		Enabled = false,
		FolderName = "Fortnite Battlepass",
		FileName = "Big Hub",
	},
	KeySystem = true,
	KeySettings = {
		Title = "Fortnite Battlepass",
		Subtitle = "by Grayy#6068",
		Note = "Join the discord (discord.gg/sulfate)",
		SaveKey = false,
		Key = "Daddy Grayy",
	},
})
Rayfield:Notify("WARNING!", "Executing the script more than one time may break it!", 4483362458)
local Tab = Window:CreateTab("Auto Deflect", 4483362458)
local Tab3 = Window:CreateTab("Keybinds", 4483362458)
local Tab2 = Window:CreateTab("Other", 4483362458)

local DeflectToggle = Tab:CreateToggle({
	Name = "Auto Deflect",
	CurrentValue = false,
	Flag = "AutoDeflect",
	Callback = function(Value)
		getgenv().ToggleValue = Value
		AutoDeflect()
	end,
})

local Keybind = Tab3:CreateKeybind({
	Name = "Auto Deflect Keybind",
	CurrentKeybind = "F",
	HoldToInteract = false,
	Flag = "AutoDeflectKeybind",
	Callback = function(Keybind)
		getgenv().ToggleValue = not getgenv().ToggleValue
		Rayfield:Notify("Auto Deflect", "Auto Deflect is now " .. tostring(getgenv().ToggleValue) .. "!", 4483362458)
		DeflectToggle:Set(getgenv().ToggleValue)
	end,
})




local DistanceSlider = Tab:CreateSlider({
	Name = "Distance",
	Range = { 5, 30 },
	Increment = 1,
	Suffix = "Distance",
	CurrentValue = 10,
	Flag = "Distance",
	Callback = function(Value)
		getgenv().DistanceValue = Value
	end,
})

local PingSlider = Tab:CreateSlider({
	Name = "Ping / Speed Intensity",
	Range = { 1, 30 },
	Increment = 1,
	Suffix = "Intensity",
	CurrentValue = 4,
	Flag = "PingSpeedIntensity",
	Callback = function(Value)
		getgenv().PingValue = Value
	end,
})

local Paragraph = Tab:CreateParagraph({
	Title = "Ping / Speed Intensity",
	Content = "This is used to regulate the amount of ur ping, and the ball's speed will control the deflect distance, which is added to the original distance.",
})

local Button = Tab2:CreateButton({
	Name = "Teleport to arena",
	Callback = function()
		local first = true
		repeat
			if first and game.Workspace:FindFirstChild("Ball") ~= nil then
				first = false
				Rayfield:Notify("Notification", "Waiting for someone to die!", 4483362458)
			end
			task.wait()
		until game.Workspace:FindFirstChild("Ball") == nil

		first = true

		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").ballSpawn.CFrame
	end,
})

local autoAFKToggle = Tab2:CreateToggle({
	Name = "Auto AFK",
	CurrentValue = false,
	Flag = "AutoAFK",
	Callback = function(Value)
		getgenv().autoAFKVal = Value
	end,
})

local Keybind2 = Tab3:CreateKeybind({
	Name = "Auto AFK Keybind",
	CurrentKeybind = "R",
	HoldToInteract = false,
	Flag = "AutoAFKKeybind",
	Callback = function(Keybind)
		getgenv().autoAFKVal = not getgenv().autoAFKVal
		Rayfield:Notify("Auto AFK", "Auto AFK is now " .. tostring(getgenv().autoAFKVal) .. "!", 4483362458)
		autoAFKToggle:Set(getgenv().autoAFKVal)
	end,
})


local UIS = game:GetService("UserInputService")

UIS.WindowFocused:Connect(function()
	if getgenv().autoAFKVal then
		local stringident = string.split(
			game:GetService("Players").LocalPlayer.PlayerGui.MainGui.LeftIcons.Spectator.TextLabel.Text,
			" "
		)[3]
		if string.lower(stringident) ~= "off" then
			for _, v in
				next,
				getconnections(
					game:GetService("Players").LocalPlayer.PlayerGui.MainGui.LeftIcons.Spectator.Button.MouseButton1Click
				)
			do
				v:Fire()
			end
		end
	end
end)

UIS.WindowFocusReleased:Connect(function()
	if getgenv().autoAFKVal then
		local stringident = string.split(
			game:GetService("Players").LocalPlayer.PlayerGui.MainGui.LeftIcons.Spectator.TextLabel.Text,
			" "
		)[3]
		if string.lower(stringident) ~= "on" then
			for _, v in
				next,
				getconnections(
					game:GetService("Players").LocalPlayer.PlayerGui.MainGui.LeftIcons.Spectator.Button.MouseButton1Click
				)
			do
				v:Fire()
			end
		end
	end
end)
