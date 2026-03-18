LVS:AddWeaponPreset( "GSH23", {
	Icon = Material("lvs/weapons/GSH23_PYLON.png"),
	Ammo = 2000,
	Delay = 0.015,
	HeatRateUp = 0.7,
	HeatRateDown = 0.8,
	Attack = function( ent )
	
		ent.GSH23_POSITIONS = {
			[1] = Vector(93.6529,-81.9388,43.4808),
			[2] = Vector(93.6529,81.9388,43.4808),
			[3] = Vector(93.6529,-85.5708,43.4808),
			[4] = Vector(93.6529,85.5708,43.4808),
		}	
		ent.NumSec = ent.NumSec and ent.NumSec + 1 or 1
		if ent.NumSec > 4 then ent.NumSec = 1 end
		local Pos = ent:LocalToWorld(ent.GSH23_POSITIONS[ent.NumSec])
		local bullet = {}
		bullet.Src 	= Pos
		bullet.Dir 	= ent:LocalToWorldAngles( Angle(0,0,0) ):Forward()
		bullet.Spread 	= Vector( 0.03,  0.03, 0 )
		bullet.TracerName = "lvs_tracer_orange"
		bullet.Force	= 50
		bullet.HullSize 	= 15
		bullet.Damage	= 25
		bullet.Velocity = 20000
		bullet.SplashDamage = 100
		bullet.SplashDamageRadius = 100
		bullet.Attacker 	= ent:GetDriver()
		bullet.Callback = function(att, tr, dmginfo)
		end

		ent:LVSFireBullet( bullet )
		local num = 0.3
		local pos = Pos
		local ang = (ent:GetAngles() + Angle(math.Rand(-num,num), math.Rand(-num,num), math.Rand(-num,num)))
		local effectdata = EffectData()
		effectdata:SetOrigin(pos)
		effectdata:SetAngles(ang)
		effectdata:SetEntity(ent)
		util.Effect("gred_particle_aircraft_muzzle",effectdata)

		ent:TakeAmmo( 2 )
	end,
	StartAttack = function( ent )
		if not IsValid( ent.SoundEmitter3 ) then
			ent.SoundEmitter3 = ent:AddSoundEmitter( Vector(109.29,0,92.85), "GSH23_LOOP", "GSH23_LOOP" )
			ent.SoundEmitter3:SetSoundLevel( 95 )
		end

		ent.SoundEmitter3:Play()
	end,
	FinishAttack = function( ent )
		if IsValid( ent.SoundEmitter3 ) then
			ent.SoundEmitter3:Stop()
			ent:EmitSound("GSH23_LASTSHOT")
		end
	end,
	HudPaint = function( ent, X, Y, ply )
	end,
	OnSelect = function( ent ) ent:EmitSound("physics/metal/weapon_impact_soft2.wav") end,
	OnOverheat = function( ent ) ent:EmitSound("lvs/overheat.wav") end,
} )

LVS:AddWeaponPreset( "S8COM", {
	Icon = Material("lvs/weapons/S8_PYLON.png"),
	Ammo = 80,
	Delay = 0.1,
	HeatRateUp = 0,
	HeatRateDown = 0,
	UseableByAI = false,
	Attack = function( ent )
		ent.MISSILE_POSITIONS = {
			[1] = Vector(57.2884,-84.4957,40.1254),
			[2] = Vector(57.2884,84.4957,40.1254),
			[3] = Vector(57.2884,-111.33,40.1254),
			[4] = Vector(57.2884,111.33,40.1254),
		}	
	
		ent.NumSec = ent.NumSec and ent.NumSec + 1 or 1
		if ent.NumSec > 4 then ent.NumSec = 1 end
		local Pos = ent:LocalToWorld(ent.MISSILE_POSITIONS[ent.NumSec])		
		local rocket = ents.Create("gb_s8kom_rocket")	
		rocket:SetPos(Pos)
		rocket:SetAngles(ent:GetAngles())
		rocket.IsOnPlane = true
		rocket:SetOwner(ent:GetDriver())
		rocket:Spawn()
		rocket:Activate()
		rocket:Launch()
		rocket:SetCollisionGroup(20)
		
		local num = 0.3
		local pos = ent:LocalToWorld(ent.MISSILE_POSITIONS[ent.NumSec])
		local ang = (ent:GetAngles() + Angle(math.Rand(-num,num), math.Rand(-num,num), math.Rand(-num,num)))
		local effectdata = EffectData()
		effectdata:SetOrigin(pos)
		effectdata:SetAngles(ang)
		effectdata:SetEntity(ent)
		util.Effect("gred_particle_aircraft_muzzle",effectdata)

		ent:TakeAmmo( 1 )
	end,
	StartAttack = function( ent )
	end,
	FinishAttack = function( ent )
	end,
	HudPaint = function( ent, X, Y, ply )
	end,
	OnSelect = function( ent ) ent:EmitSound("physics/metal/weapon_impact_soft2.wav") end,
} )

LVS:AddWeaponPreset( "S13", {
	Icon = Material("lvs/weapons/S13_PYLON.png"),
	Ammo = 10,
	Delay = 0.2,
	HeatRateUp = 0,
	HeatRateDown = 0,
	UseableByAI = false,
	Attack = function( ent )
		ent.MISSILE_POSITIONS = {
			[1] = Vector(82.5405,-111.688,41.9868),
			[2] = Vector(82.5405,111.688,41.9868),
		}	
	
		ent.NumSec = ent.NumSec and ent.NumSec + 1 or 1
		if ent.NumSec > 2 then ent.NumSec = 1 end
		local Pos = ent:LocalToWorld(ent.MISSILE_POSITIONS[ent.NumSec])		
		local rocket = ents.Create("gb_s13_rocket")	
		rocket:SetPos(Pos)
		rocket:SetAngles(ent:GetAngles())
		rocket.IsOnPlane = true
		rocket:SetOwner(ent:GetDriver())
		rocket:Spawn()
		rocket:Activate()
		rocket:Launch()
		rocket:SetCollisionGroup(20)
		
		local num = 0.3
		local pos = ent:LocalToWorld(ent.MISSILE_POSITIONS[ent.NumSec])
		local ang = (ent:GetAngles() + Angle(math.Rand(-num,num), math.Rand(-num,num), math.Rand(-num,num)))
		local effectdata = EffectData()
		effectdata:SetOrigin(pos)
		effectdata:SetAngles(ang)
		effectdata:SetEntity(ent)
		util.Effect("gred_particle_aircraft_muzzle",effectdata)

		ent:TakeAmmo( 1 )
	end,
	StartAttack = function( ent )
	end,
	FinishAttack = function( ent )
	end,
	HudPaint = function( ent, X, Y, ply )
	end,
	OnSelect = function( ent ) ent:EmitSound("physics/metal/weapon_impact_soft2.wav") end,
} )

LVS:AddWeaponPreset( "S8COM_2", {
	Icon = Material("lvs/weapons/S8_PYLON.png"),
	Ammo = 40,
	Delay = 0.1,
	HeatRateUp = 0,
	HeatRateDown = 0,
	UseableByAI = false,
	Attack = function( ent )
		ent.MISSILE_POSITIONS = {
			[1] = Vector(57.2884,-111.33,40.1254),
			[2] = Vector(57.2884,111.33,40.1254),
		}	
	
		ent.NumSec = ent.NumSec and ent.NumSec + 1 or 1
		if ent.NumSec > 2 then ent.NumSec = 1 end
		local Pos = ent:LocalToWorld(ent.MISSILE_POSITIONS[ent.NumSec])		
		local rocket = ents.Create("gb_s8kom_rocket")	
		rocket:SetPos(Pos)
		rocket:SetAngles(ent:GetAngles())
		rocket.IsOnPlane = true
		rocket:SetOwner(ent:GetDriver())
		rocket:Spawn()
		rocket:Activate()
		rocket:Launch()
		rocket:SetCollisionGroup(20)
		
		local num = 0.3
		local pos = ent:LocalToWorld(ent.MISSILE_POSITIONS[ent.NumSec])
		local ang = (ent:GetAngles() + Angle(math.Rand(-num,num), math.Rand(-num,num), math.Rand(-num,num)))
		local effectdata = EffectData()
		effectdata:SetOrigin(pos)
		effectdata:SetAngles(ang)
		effectdata:SetEntity(ent)
		util.Effect("gred_particle_aircraft_muzzle",effectdata)

		ent:TakeAmmo( 1 )
	end,
	StartAttack = function( ent )
	end,
	FinishAttack = function( ent )
	end,
	HudPaint = function( ent, X, Y, ply )
	end,
	OnSelect = function( ent ) ent:EmitSound("physics/metal/weapon_impact_soft2.wav") end,
} )

LVS:AddWeaponPreset( "S8COM_3", {
	Icon = Material("lvs/weapons/S8_PYLON.png"),
	Ammo = 40,
	Delay = 0.1,
	HeatRateUp = 0,
	HeatRateDown = 0,
	UseableByAI = false,
	Attack = function( ent )
		ent.MISSILE_POSITIONS = {
			[1] = Vector(57.2884,-84.4957,40.1254),
			[2] = Vector(57.2884,84.4957,40.1254),
		}	
	
		ent.NumSec = ent.NumSec and ent.NumSec + 1 or 1
		if ent.NumSec > 2 then ent.NumSec = 1 end
		local Pos = ent:LocalToWorld(ent.MISSILE_POSITIONS[ent.NumSec])		
		local rocket = ents.Create("gb_s8kom_rocket")	
		rocket:SetPos(Pos)
		rocket:SetAngles(ent:GetAngles())
		rocket.IsOnPlane = true
		rocket:SetOwner(ent:GetDriver())
		rocket:Spawn()
		rocket:Activate()
		rocket:Launch()
		rocket:SetCollisionGroup(20)
		
		local num = 0.3
		local pos = ent:LocalToWorld(ent.MISSILE_POSITIONS[ent.NumSec])
		local ang = (ent:GetAngles() + Angle(math.Rand(-num,num), math.Rand(-num,num), math.Rand(-num,num)))
		local effectdata = EffectData()
		effectdata:SetOrigin(pos)
		effectdata:SetAngles(ang)
		effectdata:SetEntity(ent)
		util.Effect("gred_particle_aircraft_muzzle",effectdata)

		ent:TakeAmmo( 1 )
	end,
	StartAttack = function( ent )
	end,
	FinishAttack = function( ent )
	end,
	HudPaint = function( ent, X, Y, ply )
	end,
	OnSelect = function( ent ) ent:EmitSound("physics/metal/weapon_impact_soft2.wav") end,
} )

LVS:AddWeaponPreset( "VIHR", {
	Icon = Material("lvs/weapons/VIHR_x6_PYLON.png"),
	Ammo = 12,
	Delay = 0.6,
	HeatRateUp = 0,
	HeatRateDown = 0,
	UseableByAI = false,
	Attack = function( ent )
		ent.MISSILE_POSITIONS = {
			[1] = Vector(87.338,-111.551,37.3904),
			[2] = Vector(87.338,111.551,37.3904),
		}	
	
		ent.NumSec = ent.NumSec and ent.NumSec + 1 or 1
		if ent.NumSec > 2 then ent.NumSec = 1 end
		local Pos = ent:LocalToWorld(ent.MISSILE_POSITIONS[ent.NumSec])		
		local rocket = ents.Create("gb_9k121_rocket")	
		rocket.IsOnPlane = true
		rocket:SetPos(Pos)
		rocket:SetAngles(ent:GetAngles())
		rocket:Spawn()
		rocket:Activate()
		rocket:SetCollisionGroup(20)
		rocket.phys = rocket:GetPhysicsObject()
		if IsValid(rocket) then
			rocket.ShouldExplodeOnImpact = true
			local startpos = ent:LocalToWorld( ent:OBBCenter() )
			local tr = util.TraceHull( {
				start = startpos,
				endpos = (startpos + ent:GetAimVector() * 500000000),
				mins = Vector( -25, -25, -25 ),
				maxs = Vector( 25, 25, 25 ),
				filter = ent,
			} )
			local p = ent:GetPhysicsObject()
			if IsValid(p) then rocket.phys:AddVelocity(p:GetVelocity()) end
			constraint.NoCollide(rocket,ent,0,0)
			timer.Simple(0.25, function()
				if IsValid(rocket) then
					if tr.Hit then
						rocket.JDAM = true
						rocket.target = tr.Entity
						rocket.targetOffset = tr.Entity:WorldToLocal(tr.HitPos)
						rocket.dropping = true
						rocket.Armed = true
						rocket:Launch()
						rocket:SetCollisionGroup(0)
					end
				end
			end)
		end

		ent:TakeAmmo( 1 )
	end,
	StartAttack = function( ent )
	end,
	FinishAttack = function( ent )
	end,
	HudPaint = function( ent, X, Y, ply )
	end,
	OnSelect = function( ent ) ent:EmitSound("physics/metal/weapon_impact_soft2.wav") end,
} )

LVS:AddWeaponPreset( "Flares", {
	Icon = Material("lvs/weapons/flares.png"),
	Ammo = 128,
	Delay = 0.15,
	HeatRateUp = 3,
	HeatRateDown = 0.3,
	UseableByAI = false,
	Attack = function( ent )
		ent.FlARE_POSITIONS = {
			[1] = Vector(16.0008,149.701,71.7432),
		}
		ent.FlARE2_POSITIONS = {
			[1] = Vector(16.0008,-149.701,71.7432),
		}
		
		local veh = ent:GetVehicle()
		veh.SNDFlare:PlayOnce( 100 + math.Rand(-3,3), 1 )

		if p == nil or p >  table.Count(ent.FlARE_POSITIONS) or p == 0 then p = 1 end
		local mpos = ent:LocalToWorld(ent.FlARE_POSITIONS[p])
		local Ang = ent:WorldToLocal( mpos ).y > 0 and -1 or 1
		local flare = ents.Create("dark_flare")
		flare:SetPos(mpos)
		flare:SetAngles(ent:GetAngles()-Angle(2,90,0))
		flare:Spawn()
		flare:Activate()
		flare:SetCollisionGroup(20)
		p = p + 1
		if p == nil or p >  table.Count(ent.FlARE2_POSITIONS) or p == 0 then p = 1 end
		local mpos2 = ent:LocalToWorld(ent.FlARE2_POSITIONS[p])
		local Ang = ent:WorldToLocal( mpos2 ).y > 0 and -1 or 1
		flare.phys = flare:GetPhysicsObject():ApplyForceCenter( flare:GetForward() * -800)
		local flare2 = ents.Create("dark_flare")
		flare2:SetPos(mpos2)
		flare2:SetAngles(ent:GetAngles()-Angle(2,-90,0))
		flare2:Spawn()
		flare2:Activate()
		flare2:SetCollisionGroup(20)
		flare2.phys = flare2:GetPhysicsObject():ApplyForceCenter( flare2:GetForward() * -800)
		local p = ent:GetPhysicsObject()		

		ent:TakeAmmo( 2 )
	end,
	StartAttack = function( ent )
	end,
	FinishAttack = function( ent )
	end,
	HudPaint = function( ent, X, Y, ply )
	end,
	OnSelect = function( ent ) ent:EmitSound("physics/metal/weapon_impact_soft2.wav") end,
} )