-- BLΛCKTHRØNE | Premium Compact UI
-- Fixed: no overlap, fully draggable, cleaner & cooler look

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local Tween = game:GetService("TweenService")

local player = Players.LocalPlayer
local pg = player:WaitForChild("PlayerGui")

-- Colors
local ACCENT = Color3.fromRGB(155, 30, 35)
local BG     = Color3.fromRGB(8, 8, 10)
local PANEL  = Color3.fromRGB(13, 13, 15)
local SIDE   = Color3.fromRGB(10, 10, 12)
local TEXT   = Color3.fromRGB(240, 240, 240)
local MUTED  = Color3.fromRGB(135, 135, 140)

local function corner(obj, r)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, r)
	c.Parent = obj
end

local function stroke(obj, col, trans, thick)
	local s = Instance.new("UIStroke")
	s.Color = col or ACCENT
	s.Transparency = trans or 0.4
	s.Thickness = thick or 1
	s.Parent = obj
end

local function label(parent, text, size, color, bold)
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.Text = text
	l.TextColor3 = color or TEXT
	l.TextSize = size or 13
	l.Font = bold and Enum.Font.GothamBold or Enum.Font.GothamMedium
	l.TextXAlignment = Enum.TextXAlignment.Left
	l.TextYAlignment = Enum.TextYAlignment.Center
	l.Parent = parent
	return l
end

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "BlackThrone"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = pg

-- Main Window
local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(520, 355)
main.Position = UDim2.new(0.5, -260, 0.5, -177)
main.BackgroundColor3 = BG
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Parent = gui
corner(main, 10)
stroke(main, Color3.fromRGB(75, 22, 26), 0.25, 1.2)

-- Top Bar (drag handle)
local top = Instance.new("Frame")
top.Size = UDim2.new(1, 0, 0, 40)
top.BackgroundColor3 = Color3.fromRGB(6, 6, 8)
top.BorderSizePixel = 0
top.Active = true
top.Parent = main

local title = label(top, "BLΛCKTHRØNE", 15, TEXT, true)
title.Position = UDim2.fromOffset(14, 4)
title.Size = UDim2.fromOffset(220, 18)

local sub = label(top, "DARK FANTASY", 10, MUTED)
sub.Position = UDim2.fromOffset(14, 22)
sub.Size = UDim2.fromOffset(180, 14)

-- Window buttons
local function winBtn(txt, x, bg)
	local b = Instance.new("TextButton")
	b.Size = UDim2.fromOffset(26, 22)
	b.Position = UDim2.new(1, x, 0, 9)
	b.BackgroundColor3 = bg
	b.Text = txt
	b.TextColor3 = TEXT
	b.TextSize = 15
	b.Font = Enum.Font.GothamBold
	b.BorderSizePixel = 0
	b.AutoButtonColor = false
	b.Parent = top
	corner(b, 5)
	return b
end

local closeBtn = winBtn("×", -36, Color3.fromRGB(70, 16, 20))
local minBtn  = winBtn("−", -66, Color3.fromRGB(28, 28, 32))

closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- Sidebar
local side = Instance.new("Frame")
side.Size = UDim2.new(0, 132, 1, -40)
side.Position = UDim2.fromOffset(0, 40)
side.BackgroundColor3 = SIDE
side.BorderSizePixel = 0
side.Parent = main

-- Tab container (so status never overlaps)
local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1, 0, 1, -58)
tabContainer.BackgroundTransparency = 1
tabContainer.Parent = side

local tabList = Instance.new("UIListLayout")
tabList.Padding = UDim.new(0, 4)
tabList.SortOrder = Enum.SortOrder.LayoutOrder
tabList.Parent = tabContainer

local tabPad = Instance.new("UIPadding")
tabPad.PaddingTop = UDim.new(0, 10)
tabPad.PaddingLeft = UDim.new(0, 8)
tabPad.PaddingRight = UDim.new(0, 8)
tabPad.Parent = tabContainer

-- Content
local content = Instance.new("Frame")
content.Size = UDim2.new(1, -144, 1, -56)
content.Position = UDim2.fromOffset(140, 48)
content.BackgroundColor3 = PANEL
content.BorderSizePixel = 0
content.Parent = main
corner(content, 8)

local cPad = Instance.new("UIPadding")
cPad.PaddingTop = UDim.new(0, 12)
cPad.PaddingLeft = UDim.new(0, 14)
cPad.PaddingRight = UDim.new(0, 14)
cPad.Parent = content

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 34)
header.BackgroundTransparency = 1
header.Parent = content

local avatar = Instance.new("Frame")
avatar.Size = UDim2.fromOffset(30, 30)
avatar.BackgroundColor3 = Color3.fromRGB(30, 10, 12)
avatar.BorderSizePixel = 0
avatar.Parent = header
corner(avatar, 15)
stroke(avatar, ACCENT, 0.3)

local avIcon = label(avatar, "⚔", 13, ACCENT)
avIcon.Size = UDim2.fromScale(1, 1)
avIcon.TextXAlignment = Enum.TextXAlignment.Center

local hTitle = label(header, "MAIN", 14, TEXT, true)
hTitle.Position = UDim2.fromOffset(38, 0)
hTitle.Size = UDim2.fromOffset(140, 17)

local hSub = label(header, "OVERVIEW", 10, MUTED)
hSub.Position = UDim2.fromOffset(38, 17)
hSub.Size = UDim2.fromOffset(140, 14)

-- Tabs
local tabs = {}
local function makeTab(name, icon, order)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1, 0, 0, 30)
	b.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
	b.BackgroundTransparency = 0.35
	b.Text = ""
	b.BorderSizePixel = 0
	b.AutoButtonColor = false
	b.LayoutOrder = order
	b.Parent = tabContainer
	corner(b, 6)

	local i = label(b, icon, 12, MUTED)
	i.Position = UDim2.fromOffset(8, 0)
	i.Size = UDim2.fromOffset(18, 30)
	i.TextXAlignment = Enum.TextXAlignment.Center

	local n = label(b, name, 12, MUTED)
	n.Position = UDim2.fromOffset(28, 0)
	n.Size = UDim2.new(1, -34, 1, 0)

	b.MouseEnter:Connect(function()
		if b.BackgroundTransparency > 0.2 then
			Tween:Create(b, TweenInfo.new(0.15), {BackgroundTransparency = 0.15}):Play()
		end
	end)
	b.MouseLeave:Connect(function()
		if b.BackgroundColor3 \~= ACCENT then
			Tween:Create(b, TweenInfo.new(0.15), {BackgroundTransparency = 0.35}):Play()
		end
	end)

	b.MouseButton1Click:Connect(function()
		for _, t in pairs(tabs) do
			t.b.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
			t.b.BackgroundTransparency = 0.35
			t.i.TextColor3 = MUTED
			t.n.TextColor3 = MUTED
		end
		b.BackgroundColor3 = ACCENT
		b.BackgroundTransparency = 0.05
		i.TextColor3 = TEXT
		n.TextColor3 = TEXT
		hTitle.Text = string.upper(name)
	end)

	table.insert(tabs, {b = b, i = i, n = n})
end

makeTab("Main", "⌂", 1)
makeTab("Visuals", "◉", 2)
makeTab("Combat", "⚔", 3)
makeTab("Misc", "▦", 4)
makeTab("Player", "☺", 5)
makeTab("Settings", "⚙", 6)
makeTab("About", "ℹ", 7)

-- Activate first tab
tabs[1].b.BackgroundColor3 = ACCENT
tabs[1].b.BackgroundTransparency = 0.05
tabs[1].i.TextColor3 = TEXT
tabs[1].n.TextColor3 = TEXT

-- Status box (fixed at bottom, never overlaps)
local status = Instance.new("Frame")
status.Size = UDim2.new(1, -16, 0, 42)
status.Position = UDim2.new(0, 8, 1, -50)
status.BackgroundColor3 = Color3.fromRGB(15, 8, 10)
status.BorderSizePixel = 0
status.Parent = side
corner(status, 7)
stroke(status, ACCENT, 0.5)

label(status, "♛  STATUS", 10, MUTED).Position = UDim2.fromOffset(10, 5)
label(status, "IN PROGRESS", 11, ACCENT, true).Position = UDim2.fromOffset(10, 21)

local dot = Instance.new("Frame")
dot.Size = UDim2.fromOffset(7, 7)
dot.Position = UDim2.new(1, -16, 0.5, -3.5)
dot.BackgroundColor3 = ACCENT
dot.BorderSizePixel = 0
dot.Parent = status
corner(dot, 4)

-- Toggles
local function createToggle(name, y)
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, 0, 0, 28)
	row.Position = UDim2.fromOffset(0, y)
	row.BackgroundTransparency = 1
	row.Parent = content

	label(row, name, 13, TEXT).Size = UDim2.fromOffset(130, 28)

	local statusLbl = label(row, "* IN PROGRESS *", 10, ACCENT)
	statusLbl.Position = UDim2.fromOffset(140, 0)
	statusLbl.Size = UDim2.fromOffset(110, 28)

	local t = Instance.new("TextButton")
	t.Size = UDim2.fromOffset(38, 19)
	t.Position = UDim2.new(1, -38, 0.5, -9.5)
	t.BackgroundColor3 = Color3.fromRGB(38, 38, 42)
	t.Text = ""
	t.BorderSizePixel = 0
	t.AutoButtonColor = false
	t.Parent = row
	corner(t, 10)

	local k = Instance.new("Frame")
	k.Size = UDim2.fromOffset(15, 15)
	k.Position = UDim2.fromOffset(2, 2)
	k.BackgroundColor3 = Color3.fromRGB(215, 215, 220)
	k.BorderSizePixel = 0
	k.Parent = t
	corner(k, 8)

	local on = false
	t.MouseButton1Click:Connect(function()
		on = not on
		Tween:Create(k, TweenInfo.new(0.16, Enum.EasingStyle.Quad), {
			Position = on and UDim2.new(1, -17, 0, 2) or UDim2.fromOffset(2, 2)
		}):Play()
		Tween:Create(t, TweenInfo.new(0.16), {
			BackgroundColor3 = on and ACCENT or Color3.fromRGB(38, 38, 42)
		}):Play()
	end)
end

createToggle("Example Toggle", 48)
createToggle("Dark Mode", 82)
createToggle("Notifications", 116)

-- Sliders
local function createSlider(name, y, def)
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, 0, 0, 40)
	row.Position = UDim2.fromOffset(0, y)
	row.BackgroundTransparency = 1
	row.Parent = content

	label(row, name, 13, TEXT).Size = UDim2.fromOffset(100, 16)

	local prog = label(row, "* IN PROGRESS *", 10, ACCENT)
	prog.Position = UDim2.fromOffset(110, 0)
	prog.Size = UDim2.fromOffset(100, 16)

	local val = label(row, math.floor(def * 100) .. "%", 12, TEXT)
	val.Position = UDim2.new(1, -40, 0, 0)
	val.Size = UDim2.fromOffset(40, 16)
	val.TextXAlignment = Enum.TextXAlignment.Right

	local bar = Instance.new("Frame")
	bar.Size = UDim2.new(1, 0, 0, 5)
	bar.Position = UDim2.fromOffset(0, 24)
	bar.BackgroundColor3 = Color3.fromRGB(32, 32, 36)
	bar.BorderSizePixel = 0
	bar.Parent = row
	corner(bar, 3)

	local fill = Instance.new("Frame")
	fill.Size = UDim2.new(def, 0, 1, 0)
	fill.BackgroundColor3 = ACCENT
	fill.BorderSizePixel = 0
	fill.Parent = bar
	corner(fill, 3)

	local knob = Instance.new("TextButton")
	knob.Size = UDim2.fromOffset(13, 13)
	knob.Position = UDim2.new(def, -6.5, 0.5, -6.5)
	knob.BackgroundColor3 = TEXT
	knob.Text = ""
	knob.BorderSizePixel = 0
	knob.AutoButtonColor = false
	knob.Parent = bar
	corner(knob, 7)
	stroke(knob, ACCENT, 0.25, 1)

	local dragging = false
	knob.MouseButton1Down:Connect(function()
		dragging = true
	end)

	UIS.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local x = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
			fill.Size = UDim2.new(x, 0, 1, 0)
			knob.Position = UDim2.new(x, -6.5, 0.5, -6.5)
			val.Text = math.floor(x * 100) .. "%"
		end
	end)
end

createSlider("Intensity", 158, 0.60)
createSlider("Opacity", 205, 0.45)
createSlider("Brightness", 252, 0.75)

-- Footer
local foot = label(main, "♛  POWER. CONTROL. THRØNE.", 10, MUTED)
foot.Size = UDim2.new(1, 0, 0, 18)
foot.Position = UDim2.new(0, 0, 1, -20)
foot.TextXAlignment = Enum.TextXAlignment.Center

-- ========== DRAGGING (reliable) ==========
local dragging = false
local dragStart, startPos

top.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = main.Position

		local conn
		conn = input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
				conn:Disconnect()
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

-- Minimize
local minimized = false
minBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	side.Visible = not minimized
	content.Visible = not minimized
	foot.Visible = not minimized
	main.Size = minimized and UDim2.fromOffset(520, 40) or UDim2.fromOffset(520, 355)
end)
