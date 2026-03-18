
ENT.Base = "lvs_base_dark_heli"

ENT.PrintName = "KA-50(S8,Vihr)"
ENT.Author = "darklord"
ENT.Information = "RUS Helicopter"
ENT.Category = "[LVS] - RUS Heli"

ENT.Spawnable			= true
ENT.AdminSpawnable		= false

ENT.MDL = "models/heli/rus/ka50/ka50.mdl"

ENT.AITEAM = 2

ENT.MaxHealth = 2600

ENT.MaxVelocity = 1700

ENT.ThrustUp = 1
ENT.ThrustDown = 0.8
ENT.ThrustRate = 1

ENT.ThrottleRateUp = 0.05
ENT.ThrottleRateDown = 0.05

ENT.TurnRatePitch = 1
ENT.TurnRateYaw = 1
ENT.TurnRateRoll = 1

ENT.ForceLinearDampingMultiplier = 1.5

ENT.ForceAngleMultiplier = 1
ENT.ForceAngleDampingMultiplier = 1

function ENT:InitWeapons()

	local cannon = {}
	cannon.Icon = Material("lvs/weapons/2A42.png")
	cannon.Ammo = 460
	cannon.Delay = 0.1
	cannon.HeatRateUp = 0.2
	cannon.HeatRateDown = 0.25
	cannon.Attack = function( ent )
		local ID2 = self:LookupAttachment( "muzzle" )
		local Attachment2 = self:GetAttachment( ID2 )
		
		if not Attachment2 then return end
		
		local Pos = Attachment2.Pos
		local Dir = Attachment2.Ang:Forward()

		local bullet = {}
		bullet.Src 	= Pos
		bullet.Dir 	= Dir
		bullet.Spread 	= Vector( 0.02,  0.02, 0 )
		bullet.TracerName = "lvs_tracer_orange"
		bullet.Force	= 50
		bullet.HullSize 	= 15
		bullet.Damage	= 45
		bullet.Velocity = 15000
		bullet.SplashDamage = 100
		bullet.SplashDamageRadius = 200
		bullet.Attacker 	= self:GetDriver()
		bullet.Callback = function(att, tr, dmginfo)
		end

		self:LVSFireBullet( bullet )
		local num = 0.3
		local pos = Pos
		local ang = (Attachment2.Ang + Angle(math.Rand(-num,num), math.Rand(-num,num), math.Rand(-num,num)))
		local effectdata = EffectData()
		effectdata:SetOrigin(pos)
		effectdata:SetAngles(ang)
		effectdata:SetEntity(self)
		util.Effect("gred_particle_aircraft_muzzle",effectdata)

		ent:TakeAmmo()
	end
	cannon.StartAttack = function( ent )
		if not IsValid( self.SoundEmitter ) then
			local ID = self:LookupAttachment( "muzzle" )
			local Attachment = self:GetAttachment( ID )
			self.SoundEmitter = self:AddSoundEmitter( self:WorldToLocal( Attachment.Pos ), "2А42_1_LOOP", "2А42_LOOP_IN" )
			self.SoundEmitter:SetSoundLevel( 95 )
			self.SoundEmitter:SetParent( self, ID )
		end

		self.SoundEmitter:Play()
	end
	cannon.FinishAttack = function( ent)
		if IsValid( self.SoundEmitter ) then
			self.SoundEmitter:Stop()
			self.SND2A42:PlayOnce()
		end
	end
	cannon.OnSelect = function( ent ) end
	cannon.OnDeselect = function( ent ) end
	cannon.OnThink = function( ent, active ) 
		local veh = ent:GetVehicle()

		local EyeAngles = self:WorldToLocalAngles( ent:GetAimVector():Angle() )
		EyeAngles:RotateAroundAxis( EyeAngles:Up(), 0 )
		
		local Yaw = math.Clamp( EyeAngles.y,-9,2)
		local Pitch = math.Clamp( EyeAngles.p,-3,37 )

		veh:SetPoseParameter("mg_aim_yaw", Yaw)
		veh:SetPoseParameter("mg_aim_pitch", Pitch)	
	end
	cannon.HudPaint = function( ent, X, Y, ply )
		local base = self:GetVehicle()
		
		local Col2 = Color(0,255,0)
		local Pos3D = base:TraceTurret().HitPos:ToScreen()
		base:PaintCrosshairCenter( Pos3D, Col2)
		base:PaintCrosshairOuter( Pos3D, Col2)
		base:LVSPaintHitMarker( Pos3D )
	end
	cannon.OnOverheat = function( ent ) ent:EmitSound("lvs/overheat.wav") end
	cannon.OnRemove = function( ent ) end
	self:AddWeapon( cannon )
	
	self:AddWeapon( LVS:GetWeaponPreset( "S8COM_3" ) )
	self:AddWeapon( LVS:GetWeaponPreset( "VIHR" ) )
	self:AddWeapon( LVS:GetWeaponPreset( "Flares" ) )
end

function ENT:TraceTurret()
	local ID = self:LookupAttachment( "muzzle" )
	local Muzzle = self:GetAttachment( ID )

	if not Muzzle then return end

	local dir = Muzzle.Ang:Forward()
	local pos = Muzzle.Pos

	local trace = util.TraceLine( {
		start = pos,
		endpos = (pos + dir * 50000),
	} )

	return trace
end

ENT.EngineSounds = {
	{
		sound = "^lvs_darklord/rotors/rotor_loop_close.wav",
		sound_int = "lvs_darklord/rotors/int_engine.wav",
		Pitch = 0,
		PitchMin = 0,
		PitchMax = 255,
		PitchMul = 100,
		Volume = 1,
		VolumeMin = 0,
		VolumeMax = 1,
		SoundLevel = 125,
		UseDoppler = true,
	},
	{
		sound = "^lvs_darklord/rotors/rotor_loop_dist.wav",
		sound_int = "lvs_darklord/rotors/rotor_loop_int.wav",
		Pitch = 0,
		PitchMin = 0,
		PitchMax = 255,
		PitchMul = 100,
		Volume = 1,
		VolumeMin = 0,
		VolumeMax = 1,
		SoundLevel = 125,
		UseDoppler = true,
	},
}

function ENT:OnSetupDataTables()
end
