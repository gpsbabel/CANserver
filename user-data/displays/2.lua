if (CANServer_getAnalysisVar("DisplayOn") < 1) then
    return "1m t0b1000r"
end

local battPowerKW = (CANServer_getAnalysisVar("BattVolts") * CANServer_getAnalysisVar("BattAmps") / 1000.0)
local graphBattPower = math.floor(math.min(math.max((24) * (battPowerKW) / (300), -24), 24))

local bsr = CANServer_getAnalysisVar("BSR");
local bsl = CANServer_getAnalysisVar("BSL");
local bsd = 0;

if (bsl == 1 or bsl == 2) then
    bsd = 1;
end
if (bsr == 1 or bsr == 2) then
    bsd = bsd + 2;
end
if (bsd > 0) then
	return bsd .. "v63488c6m1000r";
else 
	local speedUnitText = "HMK"
	local displaySpeed = CANServer_getAnalysisVar("VehSpeed")
	if (CANServer_getAnalysisVar("DistanceUnitMiles") == 1) then
		speedUnitText = "HPM"
		displaySpeed = displaySpeed * 0.6213712;
	end

	return "65535c" .. math.floor(displaySpeed * 10) .. "v" .. speedUnitText .. "u" 
				.. graphBattPower .. "b0m100r"
end
