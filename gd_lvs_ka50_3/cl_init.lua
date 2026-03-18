include("shared.lua")

function ENT:DamageFX()
	self.nextDFX = self.nextDFX or 0
	self.nextDFX2 = self.nextDFX2 or 0

	if self.nextDFX < CurTime() then
		self.nextDFX = CurTime() + 0.05

		local HP = self:GetHP()
		local MaxHP = self:GetMaxHP()

		if HP > MaxHP * 0.25 then return end

		local effectdata = EffectData()
			effectdata:SetOrigin( self:LocalToWorld( Vector(-22.9299,47.3977,82.457) ) )
			effectdata:SetNormal( self:GetUp() )
			effectdata:SetMagnitude( math.Rand(0.5,1.5) )
			effectdata:SetEntity( self )
		util.Effect( "lvs_exhaust_fire", effectdata )
	end
	
	if self.nextDFX2 < CurTime() then
		self.nextDFX2 = CurTime() + 0.05

		local HP = self:GetHP()
		local MaxHP = self:GetMaxHP()

		if HP > MaxHP * 0.45 then return end

		local effectdata = EffectData()
			effectdata:SetOrigin( self:LocalToWorld( Vector(-22.9299,-47.3977,82.457) ) )
			effectdata:SetNormal( self:GetUp() )
			effectdata:SetMagnitude( math.Rand(0.5,1.5) )
			effectdata:SetEntity( self )
		util.Effect( "lvs_exhaust_fire", effectdata )
	end
end

function ENT:OnFrame()
	local FT = RealFrameTime()
	
	self:AnimRotor(FT)
	self:DamageFX(FT)
	self:AnimLandingGear(FT)
	self:AnimControlSurfaces( FT )
end

function ENT:AnimRotor()
	local RPM = self:GetThrottle() * 3500

	self.RPM = self.RPM and (self.RPM + RPM * RealFrameTime() * 0.5) or 0
	self.RPM2 = self.RPM2 and (self.RPM2 + RPM * RealFrameTime() * 0.5) or 0
	
	local Rot1 = Angle(0,self.RPM,0)
	Rot1:Normalize() 
	
	self:ManipulateBoneAngles( 11, -Rot1)
	self:ManipulateBoneAngles( 12, Rot1)
end

function ENT:AnimControlSurfaces( frametime )
	local FT = frametime * 10

	local Steer = self:GetSteer()

	local Pitch = -Steer.y * 30
	local Yaw = -Steer.z * 20
	local Roll = math.Clamp(-Steer.x * 60,-30,30)

	self.smPitch = self.smPitch and self.smPitch + (Pitch - self.smPitch) * FT or 0
	self.smYaw = self.smYaw and self.smYaw + (Yaw - self.smYaw) * FT or 0
	self.smRoll = self.smRoll and self.smRoll + (Roll - self.smRoll) * FT or 0

	self:ManipulateBoneAngles( 13, Angle( self.smPitch,0,0) )
	self:ManipulateBoneAngles( 14, Angle( self.smPitch,0,0) )

	self:ManipulateBoneAngles( 15, Angle( self.smYaw,0,0 ) )
end

function ENT:AnimLandingGear( frametime )
	self._smLandingGear = self._smLandingGear and self._smLandingGear + ((1 - self:GetLandingGear()) - self._smLandingGear) * frametime * 4 or 0
	
	local gExp = self._smLandingGear ^ 15
	
	self:ManipulateBoneAngles( 1, Angle( 90,0,0) * self._smLandingGear )
	self:ManipulateBoneAngles( 2, Angle( 55,-10,0) * self._smLandingGear )
	self:ManipulateBoneAngles( 3, Angle( 55,10,0) * self._smLandingGear )
	self:ManipulateBonePosition( 2, Vector( -5,10,0) * self._smLandingGear )
	self:ManipulateBonePosition( 3, Vector( -5,-10,0) * self._smLandingGear )
	
	self:ManipulateBoneAngles( 7, Angle(0,0,90) * (1 - gExp) )
	self:ManipulateBoneAngles( 8, Angle(0,0,-90) * (1 - gExp) )
	
	self:ManipulateBoneAngles( 9, Angle(0,0,35) * (1 - gExp) )
	self:ManipulateBoneAngles( 10, Angle(0,0,-35) * (1 - gExp) )
end
