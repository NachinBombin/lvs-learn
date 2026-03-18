AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

ENT.WheelSteerAngle = 20

function ENT:OnSpawn( PObj )
	local DriverSeat = self:AddDriverSeat( Vector(119.976,0,50.4411), Angle(0,-90,10) )
	DriverSeat:SetCameraDistance( 0.1 )
	DriverSeat.ExitPos = Vector(119.976,80,0)

	self:AddEngineSound( Vector(24.7685,0,132.891) )

	--self:AddRotor( pos, angle, radius, turn_speed_and_direction )
	self.Rotor = self:AddRotor( Vector(24.7685,0,132.891), Angle(0,0,0), 294.387, -4000 )
	self.Rotor:SetHP( 50 )
	function self.Rotor:OnDestroyed( base )
		base:SetBodygroup( 4, 2 )
		base:SetBodygroup( 3, 2 )
		base:DestroyEngine()

		self:EmitSound( "physics/metal/metal_box_break2.wav" )
	end

	self.TailRotor = self:AddRotor( Vector(24.7685,0,191.433), Angle(0,0,0), 294.387, -6000 )
	self.TailRotor:SetHP( 50 )
	function self.TailRotor:OnDestroyed( base )
		base:SetBodygroup( 3, 2 ) 
		base:DestroySteering( 2.5 )

		self:EmitSound( "physics/metal/metal_box_break2.wav" )
	end
	
	self:AddWheel( Vector(-24.1096,-52.0438,4.32579), 18.5, 200, LVS.WHEEL_BRAKE)
	self:AddWheel( Vector(-24.1096,52.0438,4.32579), 18.5, 200, LVS.WHEEL_BRAKE)
	self:AddWheel( Vector(167.812,0,-1.46369), 8.5, 200, LVS.WHEEL_BRAKE )
	
	self.SNDFlare = self:AddSoundEmitter( Vector(16.0008,0,71.7432), "FLARE", "FLARE" )
	self.SNDFlare:SetSoundLevel( 110 )
	
	self.SND2A42 = self:AddSoundEmitter( Vector(109.29,0,92.85), "2А42_LASTSHOT", "2А42_LASTSHOT_IN" )
	self.SND2A42:SetSoundLevel( 110 )
	
	self.Start = self:AddSoundEmitter( Vector(0,0,0), "lvs_darklord/mi_engine/mi24_engine_start_exterior.wav", "lvs_darklord/mi_engine/mi24_engine_start_interior.wav" )
	self.Start:SetSoundLevel( 110 )
	self.Stop = self:AddSoundEmitter( Vector(0,0,0), "lvs_darklord/mi_engine/mi24_engine_stop_exterior.wav", "lvs_darklord/mi_engine/mi24_engine_stop_interior.wav" )
	self.Stop:SetSoundLevel( 110 )
end

function ENT:SetRotor( PhysRot )
	self:SetBodygroup( 4, PhysRot and 0 or 1 ) 
end

function ENT:SetTailRotor( PhysRot )
	self:SetBodygroup( 3, PhysRot and 0 or 1 ) 
end

function ENT:OnLandingGearToggled( bOn )
	if bOn then
		self:EmitSound( "lvs_darklord/other/asian_helicopter_gear_in.wav" )
	else
		self:EmitSound( "lvs_darklord/other/asian_helicopter_gear_out.wav" )
	end
end


function ENT:OnTick()	
	self:SetBodygroup( 5,2 ) 
	local PhysRot = self:GetThrottle() < 0.85

	if not self:IsSteeringDestroyed() then
		self:SetTailRotor( PhysRot )
	end

	if not self:IsEngineDestroyed() then
		self:SetRotor( PhysRot )
	end
end

function ENT:OnEngineActiveChanged( Active )
	if Active then
		self.Start:PlayOnce( 100 + math.Rand(-3,3), 1 )
	else
		self.Stop:PlayOnce( 100 + math.Rand(-3,3), 1 )
	end
end

