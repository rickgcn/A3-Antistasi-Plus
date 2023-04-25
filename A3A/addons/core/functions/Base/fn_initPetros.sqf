#include "..\..\script_component.hpp"
FIX_LINE_NUMBERS()
Info("initPetros started");
scriptName "fn_initPetros";

petros setSkill 1;
petros setVariable ["respawning",false];
petros allowDamage false;

[petros, "GreekHead_A3_01", "Male01GRE", 1.1, "Petros"] call A3A_fnc_setIdentity;

removeHeadgear petros;
removeGoggles petros;
private _vest = selectRandomWeighted (A3A_rebelGear get "ArmoredVests");
if (_vest == "") then { _vest = selectRandomWeighted (A3A_rebelGear get "CivilianVests") };
petros addVest _vest;
[petros, "Rifles"] call A3A_fnc_randomRifle;
petros selectWeapon (primaryWeapon petros);

// by rickgcn, re-setting petros's loadouts
comment "Remove existing items";
removeAllWeapons petros;
removeAllItems petros;
removeAllAssignedItems petros;
removeUniform petros;
removeVest petros;
removeBackpack petros;
removeHeadgear petros;
removeGoggles petros;

comment "Add weapons";
petros addWeapon "arifle_SPAR_01_blk_F";
petros addPrimaryWeaponItem "acc_pointer_IR";
petros addPrimaryWeaponItem "optic_ERCO_blk_F";
petros addPrimaryWeaponItem "30Rnd_556x45_Stanag";
petros addWeapon "hgun_P07_khk_F";
petros addHandgunItem "16Rnd_9x21_Mag";

comment "Add containers";
petros forceAddUniform "U_B_CTRG_Soldier_3_F";
petros addVest "V_PlateCarrier2_rgr_noflag_F";

comment "Add items to containers";
petros addItemToUniform "FirstAidKit";
for "_i" from 1 to 4 do {petros addItemToUniform "30Rnd_556x45_Stanag";};
petros addItemToVest "30Rnd_556x45_Stanag";
for "_i" from 1 to 2 do {petros addItemToVest "16Rnd_9x21_Mag";};
for "_i" from 1 to 2 do {petros addItemToVest "HandGrenade";};
petros addItemToVest "SmokeShell";
petros addItemToVest "SmokeShellGreen";
for "_i" from 1 to 2 do {petros addItemToVest "Chemlight_green";};
petros addGoggles "G_Tactical_Black";

comment "Add items";
petros linkItem "ItemMap";
petros linkItem "ItemCompass";
petros linkItem "ItemWatch";
petros linkItem "ItemRadio";
petros linkItem "ItemGPS";

comment "Set identity";
[petros,"Miller","male03engb"] call BIS_fnc_setIdentity;

if (petros == leader group petros) then {
	group petros setGroupIdGlobal ["Petros","GroupColor4"];
	petros disableAI "MOVE";
	petros disableAI "AUTOTARGET";
	petros setBehaviour "SAFE";
};

// Install both moving and static actions
[petros,"petros"] remoteExec ["A3A_fnc_flagaction", 0, petros];

[petros,true] call A3A_fnc_punishment_FF_addEH;

petros addEventHandler
[
    "HandleDamage",
    {
    _part = _this select 1;
    _damage = _this select 2;
    _injurer = _this select 3;

    _victim = _this select 0;
    _instigator = _this select 6;
    if (isPlayer _injurer) then
    {
        _damage = (_this select 0) getHitPointDamage (_this select 7);
    };
    if ((isNull _injurer) or (_injurer == petros)) then {_damage = 0};
        if (_part == "") then
        {
            if (_damage > 1) then
            {
                if (!(petros getVariable ["incapacitated",false])) then
                {
                    petros setVariable ["incapacitated",true,true];
                    _damage = 0.9;
                    if (!isNull _injurer) then {[petros,side _injurer] spawn A3A_fnc_unconscious} else {[petros,sideUnknown] spawn A3A_fnc_unconscious};
                }
                else
                {
                    _overall = (petros getVariable ["overallDamage",0]) + (_damage - 1);
                    if (_overall > 1) then
                    {
                        petros removeAllEventHandlers "HandleDamage";
                    }
                    else
                    {
                        petros setVariable ["overallDamage",_overall];
                        _damage = 0.9;
                    };
                };
            };
        };
    _damage;
    }
];

petros addMPEventHandler ["mpkilled",
{
    removeAllActions petros;
    _killer = _this select 1;
    if (isServer) then
	{
        if ((side _killer == Invaders) or (side _killer == Occupants) and !(isPlayer _killer) and !(isNull _killer)) then
		{
			_nul = [] spawn {
				garrison setVariable ["Synd_HQ",[],true];
				_hrT = server getVariable "hr";
				_resourcesFIAT = server getVariable "resourcesFIA";
				[-1*(round(_hrT*0.9)),-1*(round(_resourcesFIAT*0.9))] remoteExec ["A3A_fnc_resourcesFIA",2];
				waitUntil {count allPlayers > 0};
				if (!isNull theBoss) then {
					[] remoteExec ["A3A_fnc_placementSelection",theBoss];
				} else {
					private _playersWithRank =
						(call A3A_fnc_playableUnits)
						select {(side (group _x) == teamPlayer) && isPlayer _x && _x == _x getVariable ["owner", _x]}
						apply {[([_x] call A3A_fnc_numericRank) select 0, _x]};
					_playersWithRank sort false;

					 [] remoteExec ["A3A_fnc_placementSelection", _playersWithRank select 0 select 1];
				};
			};
			{
				if (side _x == Occupants) then {_x setPos (getMarkerPos respawnOccupants)};
			} forEach (call A3A_fnc_playableUnits);
		}
        else
		{
            [] call A3A_fnc_createPetros;
		};
	};
}];
[] spawn {sleep 120; petros allowDamage true;};

Info("initPetros completed");
