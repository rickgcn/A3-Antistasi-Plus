#include "..\..\script_component.hpp"
FIX_LINE_NUMBERS()
params ["_typeGroup", ["_withBackpck", ""]];

if (player != theBoss) exitWith {[localize "STR_A3A_reinf_addFIASquadHC_header", localize "STR_generic_commander_only"] call SCRT_fnc_misc_deniedHint;};
if (markerAlpha respawnTeamPlayer == 0) exitWith {[localize "STR_A3A_reinf_addFIASquadHC_header", localize "STR_A3A_reinf_addFIASquadHC_error_moveHq"] call SCRT_fnc_misc_deniedHint;};
if (!([player] call A3A_fnc_hasRadio)) exitWith {[localize "STR_A3A_reinf_addFIASquadHC_header", localize "STR_A3A_reinf_addFIASquadHC_error_radio"] call SCRT_fnc_misc_deniedHint;};
if ([getPosATL petros] call A3A_fnc_enemyNearCheck) exitWith {[localize "STR_A3A_reinf_addFIASquadHC_header", localize "STR_A3A_reinf_addFIASquadHC_error_enemynear"] call SCRT_fnc_misc_deniedHint;};

if (count hcAllGroups player >= ([6,10] select (player call A3A_fnc_isMember))) exitWith {
    [localize "STR_A3A_reinf_addFIASquadHC_header", localize "STR_A3A_reinf_addFIASquadHC_error_too_many_hc"] call A3A_fnc_customHint;
};

private _exit = false;
if (_typeGroup isEqualType "" && {_typeGroup isEqualTo ""}) then {
	_exit = true; 
    [localize "STR_A3A_reinf_addFIASquadHC_header", localize "STR_A3A_reinf_addFIASquadHC_error_not_supported"] call A3A_fnc_customHint;
};
if (_exit) exitWith {};

if (_typeGroup isEqualTo (FactionGet(reb,"groupAT")) && {tierWar < 3}) exitWith {
	[localize "STR_A3A_reinf_addFIASquadHC_header", localize "STR_A3A_reinf_addFIASquadHC_error_AT_restr"] call SCRT_fnc_misc_deniedHint;
};

if (_typeGroup in [FactionGet(reb,"staticMG"), FactionGet(reb,"vehicleLightArmed")] && {tierWar < 2}) exitWith {
	[localize "STR_A3A_reinf_addFIASquadHC_header", localize "STR_A3A_reinf_addFIASquadHC_error_MG_restr"] call SCRT_fnc_misc_deniedHint;
};

if (_typeGroup in [FactionGet(reb,"groupSquadSupp"), FactionGet(reb,"staticAT"), FactionGet(reb,"staticAA"), FactionGet(reb,"vehicleAT"), FactionGet(reb,"vehicleAA")] && {tierWar < 4}) exitWith {
	[localize "STR_A3A_reinf_addFIASquadHC_header", localize "STR_A3A_reinf_addFIASquadHC_error_ATAA_restr"] call SCRT_fnc_misc_deniedHint;
};

if (_typeGroup isEqualTo (A3A_faction_reb get 'staticMortar') && {tierWar < 5}) exitWith {
	[localize "STR_A3A_reinf_addFIASquadHC_header", localize "STR_A3A_reinf_addFIASquadHC_error_mortar_restr"] call SCRT_fnc_misc_deniedHint;
};

private _isInfantry = false;
private _typeVehX = "";
private _costs = 0;
private _costHR = 0;
private _formatX = [];
private _format = "Squd-";

private _hr = server getVariable "hr";
private _resourcesFIA = server getVariable "resourcesFIA";

if (_typeGroup isEqualType []) then {
    _formatX = _typeGroup;
	{ _costs = _costs + (server getVariable _x); _costHR = _costHR +1 } forEach _typeGroup;

	if (_withBackpck == "MG") then {_costs = _costs + ([FactionGet(reb,"staticMG")] call A3A_fnc_vehiclePrice)};
	if (_withBackpck == "Mortar") then {_costs = _costs + ([FactionGet(reb,"staticMortar")] call A3A_fnc_vehiclePrice)};
	_isInfantry = true;

} else { // modified by rickgcn, to make tank crew to 3 members, fighter crew to 1 members
    private _typeCrew = FactionGet(reb,"unitCrew");
    switch (true) do {
        case (_typeGroup isEqualTo FactionGet(reb,"vehicleTank")): {
            _costs = (3*(server getVariable _typeCrew)) + ([FactionGet(reb,"vehicleTank")] call A3A_fnc_vehiclePrice);
            _formatX = [_typeCrew, _typeCrew, _typeCrew];
            _costHR = 3;
        };
        case (_typeGroup isEqualTo FactionGet(reb,"vehiclePlane")): {
            _costs = (1*(server getVariable _typeCrew)) + ([FactionGet(reb,"vehiclePlane")] call A3A_fnc_vehiclePrice);
            _formatX = [_typeCrew];
            _costHR = 1;
        };
        default {
            _costs = 2*(server getVariable _typeCrew) + ([_typeGroup] call A3A_fnc_vehiclePrice);
            if (_typeGroup == FactionGet(reb,"staticAA")) then { _costs = _costs + ([FactionGet(reb,"vehicleTruck")] call A3A_fnc_vehiclePrice) };
            _formatX = [_typeCrew, _typeCrew];
            _costHR = 2;

            if ((_typeGroup == FactionGet(reb,"staticMortar")) or (_typeGroup == FactionGet(reb,"staticMG"))) exitWith { _isInfantry = true };
        };
    };
};

if (_hr < _costHR) then {_exit = true; [localize "STR_A3A_reinf_addFIASquadHC_header", format [localize "STR_A3A_reinf_addFIASquadHC_error_not_enough_hr",_costHR]] call SCRT_fnc_misc_deniedHint;};

if (_resourcesFIA < _costs) then {_exit = true; [localize "STR_A3A_reinf_addFIASquadHC_header", format [localize "STR_A3A_reinf_addFIASquadHC_error_not_enough_money",_costs, A3A_faction_civ get "currencySymbol"]] call SCRT_fnc_misc_deniedHint;};

if (_exit) exitWith {};

private _mounts = [];
private _vehType = switch true do {
    case (!_isInfantry && {_typeGroup isEqualTo FactionGet(reb,"staticAA")}): {
        if (FactionGet(reb,"vehicleAA") isEqualTo "") exitWith {_mounts pushBack [FactionGet(reb,"staticAA"),-1,[[1],[],[]]]; FactionGet(reb,"vehicleTruck")};
        FactionGet(reb,"vehicleAA")
    };
    case (!_isInfantry): {_typeGroup};
    case (count _formatX isEqualTo 2): {FactionGet(reb,"vehicleBasic")};
    case (_typeGroup isEqualTo FactionGet(reb,"groupSquadMech")): {FactionGet(reb,"vehicleIFV")}; // by rickgcn
    case (count _formatX > 4): {FactionGet(reb,"vehicleTruck")};
    default {FactionGet(reb,"vehicleLightUnarmed")};
};
private _idFormat = switch _typeGroup do {
    case FactionGet(reb,"groupMedium"): {"Tm-"};
    case FactionGet(reb,"groupAT"): {"AT-"};
    case FactionGet(reb,"groupSniper"): {"Snpr-"};
    case FactionGet(reb,"groupSentry"): {"Stry-"};
    case FactionGet(reb,"groupCrew"): {"Crew-"};
    case FactionGet(reb,"groupSquadMech"): {"Mech-"}; // by rickgcn
    case FactionGet(reb,"staticMortar"): {"Mort-"};
    case FactionGet(reb,"staticMG"): {"MG-"};
    case FactionGet(reb,"vehicleAT"): {"M.AT-"};
    case FactionGet(reb,"vehicleLightArmed"): {"M.MG-"};
    case FactionGet(reb,"vehicleTank"): {"Tank-"}; // by rickgcn
    case FactionGet(reb,"staticAA"): {"M.AA-"};
    case FactionGet(reb,"vehicleAttackHeliB"): {"Heli-"}; // by rickgcn
    case FactionGet(reb,"vehicleAttackHeliO"): {"Heli-"}; // by rickgcn
    case FactionGet(reb,"vehiclePlane"): {"CAS-"}; // by rickgcn
    case FactionGet(reb,"vehiclePlaneFighter"): {"ASF-"}; // by rickgcn
    default {
        switch _withBackpck do {
            case "MG": {"SqMG-"};
            case "Mortar": {"Mortar"};
            default {"Squd-"};
        };
    };
};
private _special = if (_isInfantry) then { // by rickgcn, added special classes named "MechSquad" and "Tank"
    if (_typeGroup isEqualTo FactionGet(reb,"groupSquadMech")) exitWith {"MechSquad"};
    if (_typeGroup isEqualType []) then { _withBackpck } else {"staticAutoT"};
} else {
    if (_mounts isNotEqualTo []) exitWith {"BuildAA"};
    if (_typeGroup isEqualTo FactionGet(reb,"vehicleTank")) exitWith {"Tank"};
    "VehicleSquad"
};

private _vehiclePlacementMethod = if (getMarkerPos respawnTeamPlayer distance player > 50) then {
    {
        private _searchCenter = getMarkerPos respawnTeamPlayer getPos [20 + random 30, random 360];
        private _spawnPos = _searchCenter findEmptyPosition [0, 30, _vehType];
        if (_spawnPos isEqualTo []) then {_spawnPos = _searchCenter};
        private _vehicle = _vehType createVehicle _spawnPos;

        if (_mounts isNotEqualTo []) then {
            private _static = FactionGet(reb,"staticAA") createVehicle _spawnPos;
            private _nodes = [_vehicle, _static] call A3A_Logistics_fnc_canLoad;
            if (_nodes isEqualType 0) exitWith {};
            (_nodes + [true]) call A3A_Logistics_fnc_load;
            _static call HR_GRG_fnc_vehInit;
        };

        [_formatX, _idFormat, _special, _vehicle] spawn A3A_fnc_spawnHCGroup;
    }
} else { HR_GRG_fnc_confirmPlacement };
if (!_isInfantry) exitWith { [_vehType, "HCSquadVehicle", [_formatX, _idFormat, _special], _mounts] call _vehiclePlacementMethod };

private _vehCost = [_vehType] call A3A_fnc_vehiclePrice;
if (_isInfantry and (_costs + _vehCost) > server getVariable "resourcesFIA") exitWith {
    [localize "STR_A3A_reinf_addFIASquadHC_header", format [localize "STR_A3A_reinf_addFIASquadHC_error_not_enough_money_barefoot",_vehCost, A3A_faction_civ get "currencySymbol"]] call A3A_fnc_customHint;
    [_formatX, _idFormat, _special, objNull] spawn A3A_fnc_spawnHCGroup;
};

// by rickgcn, runs when recruit mech squads
if (_typeGroup isEqualTo FactionGet(reb,"groupSquadMech")) exitWith {[_vehType, "HCSquadVehicle", [_formatX, _idFormat, _special], _mounts] call _vehiclePlacementMethod;};

#ifdef UseDoomGUI
    ERROR("Disabled due to UseDoomGUI Switch.")
#else
    createDialog "vehQuery";
#endif

sleep 1;
disableSerialization;
private _display = findDisplay 100;

if (str (_display) != "no display") then {
	private _ChildControl = _display displayCtrl 104;
	_ChildControl  ctrlSetTooltip format [localize "STR_dialog_fia_squad_hc_buy_veh", _vehCost, A3A_faction_civ get "currencySymbol"];
	_ChildControl = _display displayCtrl 105;
	_ChildControl  ctrlSetTooltip localize "STR_dialog_fia_squad_hc_barefoot";
};

waitUntil {(!dialog) or (!isNil "vehQuery")};
if ((!dialog) and (isNil "vehQuery")) exitWith { [_formatX, _idFormat, _special, objNull] spawn A3A_fnc_spawnHCGroup }; //spawn group call here

vehQuery = nil;
[_vehType, "HCSquadVehicle", [_formatX, _idFormat, _special], _mounts] call _vehiclePlacementMethod;
