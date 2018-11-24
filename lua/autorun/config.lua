
mrp_currency = mrp_currency or {} 
mrp_currency.config = mrp_currency.config or {}

--Change rounds icon
	mrp_currency.config.icon = Material( "gui/bullet.png" )	 

--Modify icon color
mrp_currency.config.col = Color( 255, 255, 255, 255 )

--Set icon width
mrp_currency.config.w = 68*0.8

--Set icon height
mrp_currency.config.h = 70*0.8

--Disable (false) or enable (true) halo around currency 
mrp_currency.config.halo_en = true

--Disable (false) or enable (true) hud rounds icon 
mrp_currency.config.icon_en = true 

--Set model for currency and amount of currency to to which this model will be set
mrp_currency.config.models = {
	{"models/metrorp-by-etos7/currency/riflerounds1.mdl",10},
	{"models/arxweapon/vsvclip.mdl",20},
	{"models/arxweapon/bastardgunclip.mdl",25},
	{"models/arxweapon/akclip.mdl",30},
	{"models/arxweapon/2012clip.mdl",45},
	{"models/metrorp-by-etos7/currency/545x39.mdl",60},
	{"models/metrorp-by-etos7/currency/pkm.mdl",100},
}















































































--[[ DO NOT TOUCH LINES BELOW END OF CONFIG]]--

CreateConVar( "mrp_currency_halo_en", "1")
CreateConVar( "mrp_currency_icon_en", "1")

if mrp_currency.config.halo_en then 
hook.Add( "PreDrawHalos", "AddPropHalos", function()
	if GetConVar("mrp_currency_halo_en"):GetBool() then
	local moneyEnts = ents.FindByClass( "metrorp_currency" )
	local ply = LocalPlayer()

	for k, v in pairs( moneyEnts ) do
		if (ply:GetPos():Distance(v:GetPos()) > 100) then return end
		    halo.Add( {v}, Color( 244, 194, 66), 1, 1, 1 )
		
	end	
	end	
end )
end	


local function DrawMilitaryGradeRounds()						
		local ply = LocalPlayer() 

		if !IsValid(ply) or !mrp_currency.config.icon_en or !GetConVar("mrp_currency_icon_en"):GetBool()  then return end	

		local ent = ply:GetEyeTrace().Entity
	
		if !IsValid(ent) or !ply:Alive() then return end
		if ent:GetClass() != "metrorp_currency" then return end
		if ply:GetPos():Distance(ent:GetPos()) > 100  then return end	
			
			surface.SetDrawColor( mrp_currency.config.col )
			surface.SetMaterial( mrp_currency.config.icon )
			surface.DrawTexturedRect( ScrW()/2 - mrp_currency.config.w/2, ScrH()/2 - mrp_currency.config.h/2, mrp_currency.config.w, mrp_currency.config.h)

	
		
end
if mrp_currency.config.icon_en then 
hook.Add( 'HUDPaint', 'HUD_DRAW_HUD2', function()
	DrawMilitaryGradeRounds()			
end )  
end	

hook.Add( "PopulateToolMenu", "CustomMenuSettings", function()
	spawnmenu.AddToolMenuOption( "Options", "MetroRP by Etos7", "MetroRP_Currency", "Currency", "", "", function( panel )
		local info = {}
		panel:ClearControls()
		info.Text = "Halo/glow makes huge fps drops disable it to gain fps."
		info.Description = "Client side settings"
		panel:AddControl("Label", info )
		panel:CheckBox( "Enable rounds glow", "mrp_currency_halo_en" )
		panel:CheckBox( "Enable rounds display on hud", "mrp_currency_icon_en" )
	end )
end )
