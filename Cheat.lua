local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
Name = "Toddy's hub v2",
Icon = 0,
LoadingTitle = "Back for more lol",
LoadingSubtitle = "by mushroom0162",
Theme = "Default",
DisableRayfieldPrompts = false,
DisableBuildWarnings = false,
ConfigurationSaving = {
Enabled = false,
FolderName = nil,
FileName = "Big Hub"
},
Discord = {
Enabled = false,
Invite = "noinvitelink",
RememberJoins = false
},
KeySystem = false,
KeySettings = {
Title = "Untitled",
Subtitle = "Key System",
Note = "No method of obtaining the key is provided",
FileName = "Key",
SaveKey = true,
GrabKeyFromSite = false,
Key = {"Hello"}
}
})
local MainTab = Window:CreateTab("Main", 4483362458)
local MiscTab = Window:CreateTab("Misc", 4483362458)
MainTab:CreateSection("Toddys rewrite")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local teleporting = false
local targetPart = nil
local detectionRange = 50
local function runAwayFromTarget(speaker, targetPart)
local character = speaker.Character
if character then
local humanoid = character:FindFirstChildOfClass("Humanoid")
if humanoid then
humanoid.WalkSpeed = humanoid.WalkSpeed * 2
end
end
while teleporting do
if speaker.Character and speaker.Character:FindFirstChild("HumanoidRootPart") then
local humanoidRootPart = speaker.Character.HumanoidRootPart
local humanoid = speaker.Character:FindFirstChildOfClass("Humanoid")
if humanoid and humanoid.SeatPart then
humanoid.Sit = false
task.wait(0.0001)
end
if targetPart and targetPart:IsDescendantOf(workspace) then
local targetPosition = targetPart.Position
local distance = (targetPosition - humanoidRootPart.Position).Magnitude
if distance <= detectionRange then
local runDistance = math.min(40, math.max(20, distance
