private _hasWs = "ws" in A3A_enabledDLC;
private _hasLawsOfWar = "orange" in A3A_enabledDLC;
private _hasApex = "expansion" in A3A_enabledDLC;
private _hasContact = "enoch" in A3A_enabledDLC;

///////////////////////////
//   Rebel Information   //
///////////////////////////

["name", "Syndikat"] call _fnc_saveToTemplate;

["flag", "Flag_Syndikat_F"] call _fnc_saveToTemplate;
["flagTexture", "\A3\Data_F_Exp\Flags\flag_SYND_CO.paa"] call _fnc_saveToTemplate;
["flagMarkerType", "flag_Syndicat"] call _fnc_saveToTemplate;

["vehicleBasic", "I_Quadbike_01_F"] call _fnc_saveToTemplate;
["vehicleLightUnarmed", "I_MRAP_03_F"] call _fnc_saveToTemplate;
["vehicleLightArmed", "I_MRAP_03_hmg_F"] call _fnc_saveToTemplate;
["vehicleTruck", "I_Truck_02_transport_F"] call _fnc_saveToTemplate;
["vehicleAT", "I_LT_01_AT_F"] call _fnc_saveToTemplate;
["vehicleAA", "I_LT_01_AA_F"] call _fnc_saveToTemplate;
["vehicleIFV", "I_APC_Wheeled_03_cannon_F"] call _fnc_saveToTemplate;
["vehicleTank", "I_MBT_03_cannon_F"] call _fnc_saveToTemplate;

["vehicleBoat", "I_Boat_Armed_01_minigun_F"] call _fnc_saveToTemplate;
["vehicleRepair", "I_Truck_02_box_F"] call _fnc_saveToTemplate;

["vehiclePlane", "I_Plane_Fighter_03_CAS_F"] call _fnc_saveToTemplate;
["vehiclePayloadPlane", "I_Plane_Fighter_03_CAS_F"] call _fnc_saveToTemplate;
["vehicleAttackHeliB", "B_Heli_Attack_01_F"] call _fnc_saveToTemplate; // by rickgcn
["vehicleAttackHeliO", "O_Heli_Attack_02_F"] call _fnc_saveToTemplate; // by rickgcn
["vehiclePlaneParaDrop", "B_T_VTOL_01_infantry_F"] call _fnc_saveToTemplate; // by rickgcn

["vehicleCivCar", "C_Offroad_01_F"] call _fnc_saveToTemplate;
["vehicleCivTruck", "C_Truck_02_transport_F"] call _fnc_saveToTemplate;
["vehicleCivHeli", "C_Heli_Light_01_civil_F"] call _fnc_saveToTemplate;
["vehicleCivBoat", "C_Rubberboat"] call _fnc_saveToTemplate;
["vehicleCivBoxSupply", "C_Van_01_box_F"] call _fnc_saveToTemplate;


["staticMG", "I_HMG_01_high_F"] call _fnc_saveToTemplate;
["staticAT", "I_static_AT_F"] call _fnc_saveToTemplate;
["staticAA", "I_static_AA_F"] call _fnc_saveToTemplate;
["staticMortar", "I_Mortar_01_F"] call _fnc_saveToTemplate;
["staticMortarMagHE", "8Rnd_82mm_Mo_shells"] call _fnc_saveToTemplate;
["staticMortarMagSmoke", "8Rnd_82mm_Mo_Smoke_white"] call _fnc_saveToTemplate;
["staticRadar", "B_Radar_System_01_F"] call _fnc_saveToTemplate;
["staticSAM", "B_SAM_System_03_F"] call _fnc_saveToTemplate;

["minesAT", ["ATMine_Range_Mag", "SLAMDirectionalMine_Wire_Mag"]] call _fnc_saveToTemplate;
["minesAPERS", ["ClaymoreDirectionalMine_Remote_Mag","APERSMine_Range_Mag", "APERSBoundingMine_Range_Mag", "APERSTripMine_Wire_Mag"]] call _fnc_saveToTemplate;

["breachingExplosivesAPC", [["DemoCharge_Remote_Mag", 1]]] call _fnc_saveToTemplate;
["breachingExplosivesTank", [["SatchelCharge_Remote_Mag", 1], ["DemoCharge_Remote_Mag", 2]]] call _fnc_saveToTemplate;

// if (_hasWs) then {
//   _vehicleAA = "I_Tura_Truck_02_aa_lxWS";
//   _staticAA = "I_Tura_ZU23_lxWS";
// };
// ["vehicleAA", _vehicleAA] call _fnc_saveToTemplate;
// ["staticAA", _staticAA] call _fnc_saveToTemplate;

//////////////////////////////////////
//       Antistasi Plus Stuff       //
//////////////////////////////////////

//classname, price, type, availability condition
private _shopWs = if (_hasWs) then {
    [
        ["I_UAV_02_lxWS", 3500, "UAV", {tierWar > 2}], 
        ["I_G_UAV_02_IED_lxWS", 4500, "UAV", {tierWar > 3}],
        ["I_G_Offroad_01_armor_base_lxWS", 4500, "UNARMEDCAR", {true}],
        ["I_G_Offroad_01_armor_armed_lxWS", 4500, "ARMEDCAR", {true}],
        ["I_G_Offroad_01_armor_AT_lxWS", 4500, "ARMEDCAR", {true}]
    ]
} else {
    []
};

private _shopApex = if (_hasApex) then {
    [
        ["I_C_Offroad_02_unarmed_F", 200, "UNARMEDCAR", {true}], 
        ["I_C_Offroad_02_LMG_F", 800, "ARMEDCAR", {true}],
        ["I_C_Offroad_02_AT_F", 1450, "ARMEDCAR", {true}]
    ]
} else {
    []
};

private _vehiclesBlackMarket = _shopWs + _shopApex + [
    ["I_UAV_01_F", 2000, "UAV", {true}],
    ["I_LT_01_AA_F", 7500, "AA", {{sidesX getVariable [_x,sideUnknown] isEqualTo teamPlayer} count (milbases + airportsX) > 0}],
    ["I_APC_Wheeled_03_cannon_F", 15000, "APC", {{sidesX getVariable [_x,sideUnknown] isEqualTo teamPlayer} count seaports > 0}],
    ["B_Heli_Light_01_dynamicLoadout_F", 25000, "HELI", {{sidesX getVariable [_x,sideUnknown] isEqualTo teamPlayer} count airportsX > 0}]
];
["blackMarketStock", _vehiclesBlackMarket] call _fnc_saveToTemplate;

["variants", [
    ["I_APC_Wheeled_03_cannon_F", ["Guerilla_01",1]],
    ["I_LT_01_AA_F", ["Indep_Olive",1]]
]] call _fnc_saveToTemplate;


///////////////////////////
//  Rebel Starting Gear  //
///////////////////////////

private _initialRebelEquipment = [
// INDEP Initial Equipment
// Helmets
"H_HelmetCrew_I",
"H_PilotHelmetFighter_I",
"H_PilotHelmetHeli_I",
"H_CrewHelmetHeli_I",
"H_HelmetIA",
"H_HelmetIA_net",
"H_HelmetIA_camo",
// Vests
"V_RebreatherIA",
"V_Chestrig_oli",
"V_BandollierB_oli",
"V_TacVest_oli",
"V_PlateCarrierIA1_dgtl",
"V_PlateCarrierIA2_dgtl",
"V_PlateCarrierIAGL_dgtl",
// Rifles
"arifle_Mk20_F",
"arifle_Mk20C_F",
"arifle_Mk20_GL_F",
"arifle_SDAR_F",
// Rifle Magazines
"30Rnd_556x45_Stanag",
"30Rnd_556x45_Stanag_Tracer_Red",
"30Rnd_556x45_Stanag_Tracer_Green",
"30Rnd_556x45_Stanag_Tracer_Yellow",
"30Rnd_556x45_Stanag_red",
"30Rnd_556x45_Stanag_green",
"20Rnd_556x45_UW_mag",
// Sniper Rifles
"srifle_EBR_F",
"srifle_GM6_F",
// Sniper Rifle Magazines
"20Rnd_762x51_Mag",
"5Rnd_127x108_Mag",
"5Rnd_127x108_APDS_Mag",
// MachineGuns
"LMG_Mk200_F",
// MachineGun Magazines
"200Rnd_65x39_cased_Box",
"200Rnd_65x39_cased_Box_Tracer",
"200Rnd_65x39_cased_Box_Red",
"200Rnd_65x39_cased_Box_Tracer_Red",
// SMGs
"hgun_PDW2000_F",
// SMG Magazines
"30Rnd_9x21_Mag",
"30Rnd_9x21_Red_Mag",
"30Rnd_9x21_Yellow_Mag",
"30Rnd_9x21_Green_Mag",
"16Rnd_9x21_Mag",
"16Rnd_9x21_red_Mag",
"16Rnd_9x21_green_Mag",
"16Rnd_9x21_yellow_Mag",
// Handguns
"hgun_ACPC2_F",
// Handgun Magazines
"9Rnd_45ACP_Mag",
// Launchers
"launch_NLAW_F",
"launch_I_Titan_F",
"launch_I_Titan_short_F",
"launch_MRAWS_olive_rail_F",
// Launcher Magazines
"NLAW_F",
"Titan_AA",
"Titan_AT",
"Titan_AP",
"MRAWS_HEAT_F",
"MRAWS_HE_F",
"MRAWS_HEAT55_F",
// UGL Grenades
"1Rnd_HE_Grenade_shell",
"UGL_FlareWhite_F",
"UGL_FlareGreen_F",
"UGL_FlareRed_F",
"UGL_FlareYellow_F",
"UGL_FlareCIR_F",
"1Rnd_Smoke_Grenade_shell",
"1Rnd_SmokeRed_Grenade_shell",
"1Rnd_SmokeGreen_Grenade_shell",
"1Rnd_SmokeYellow_Grenade_shell",
"1Rnd_SmokePurple_Grenade_shell",
"1Rnd_SmokeBlue_Grenade_shell",
"1Rnd_SmokeOrange_Grenade_shell",
// Hand Grenades
"HandGrenade",
"MiniGrenade",
"SmokeShell",
"SmokeShellYellow",
"SmokeShellGreen",
"SmokeShellRed",
"SmokeShellPurple",
"SmokeShellOrange",
"SmokeShellBlue",
"Chemlight_green",
"Chemlight_red",
"Chemlight_yellow",
"Chemlight_blue",
// Explosives
"DemoCharge_Remote_Mag",
"SatchelCharge_Remote_Mag",
"ATMine_Range_Mag",
"ClaymoreDirectionalMine_Remote_Mag",
"APERSMine_Range_Mag",
"APERSBoundingMine_Range_Mag",
"SLAMDirectionalMine_Wire_Mag",
"APERSTripMine_Wire_Mag",
"APERSMineDispenser_Mag",
"TrainingMine_Mag",
// Weapon Accessories
"acc_pointer_IR",
"optic_ACO_grn",
"optic_Holosight",
"optic_Holosight_smg",
"optic_MRCO",
"optic_SOS",
"optic_LRPS",
"optic_NVS",
"optic_tws",
"optic_tws_mg",
"muzzle_snds_L",
"muzzle_snds_M",
"muzzle_snds_B",
"muzzle_snds_H_MG",
"muzzle_snds_acp",
"bipod_03_F_blk",
"bipod_03_F_oli",
// Items
"FirstAidKit",
"Medikit",
"ToolKit",
"ItemGPS",
"I_UavTerminal",
"ItemRadio",
"MineDetector",
"Binocular",
"Rangefinder",
"Laserdesignator_03",
"Laserbatteries",
"NVGoggles_INDEP",
"G_Combat",
"G_I_Diving",
"G_Tactical_Clear",
"G_Tactical_Black",
// Backpacks
"B_FieldPack_oli",
"B_Carryall_oli",
"B_AssaultPack_dgtl",
"B_TacticalPack_oli",
"B_Bergen_dgtl_F",
"I_UAV_06_backpack_F",
"I_UAV_06_medical_backpack_F",
"I_UAV_01_backpack_F",
"I_UGV_02_Science_backpack_F",
"I_UGV_02_Demining_backpack_F",
"I_Mortar_01_support_F",
"I_Mortar_01_weapon_F",
"I_HMG_01_support_F",
"I_HMG_01_support_high_F",
"I_HMG_01_weapon_F",
"I_HMG_01_A_weapon_F",
"I_HMG_01_high_weapon_F",
"I_HMG_02_support_F",
"I_HMG_02_support_high_F",
"I_HMG_02_weapon_F",
"I_HMG_02_high_weapon_F",
"I_GMG_01_weapon_F",
"I_GMG_01_A_weapon_F",
"I_GMG_01_high_weapon_F",
"B_RadioBag_01_digi_F",
"I_AA_01_weapon_F",
"I_AT_01_weapon_F",
// Self Revive Kit
"A3AP_SelfReviveKit"
];

if (_hasLawsOfWar) then {
    _initialRebelEquipment append [
        "V_Pocketed_olive_F", 
        "V_Pocketed_coyote_F", 
        "V_Pocketed_black_F"
    ];
};

private _civilianBackpacks =  [];
if (_hasLawsOfWar) then {
    _civilianBackpacks append [
        "B_Messenger_Black_F", 
        "B_Messenger_Coyote_F", 
        "B_Messenger_Gray_F",
        "B_Messenger_Olive_F", 
        "B_LegStrapBag_black_F", 
        "B_LegStrapBag_coyote_F", 
        "B_LegStrapBag_olive_F"
    ];
} else {
    _civilianBackpacks append ["B_FieldPack_blk","B_AssaultPack_blk"];
};

["civilianBackpacks", _civilianBackpacks createHashMapFromArray []] call _fnc_saveToTemplate;

_initialRebelEquipment append _civilianBackpacks;

// if (_hasContact) then {
//     _initialRebelEquipment append [
//         "sgun_HunterShotgun_01_F",
//         "sgun_HunterShotgun_01_sawedoff_F",
//         "2Rnd_12Gauge_Pellets",
//         "2Rnd_12Gauge_Slug"
//     ];
// };

// if (_hasApex) then {
//     _initialRebelEquipment append [
//         "hgun_Pistol_01_F",
//         "10Rnd_9x21_Mag",
//         ["launch_RPG7_F", 3], 
//         ["RPG7_F", 9]
//     ];
// } else {
//     _initialRebelEquipment append [["launch_RPG32_F", 2], ["RPG32_F", 6]];
// };

if (A3A_hasTFAR) then {_initialRebelEquipment append ["tf_microdagr","tf_anprc154"]};
if (A3A_hasTFAR && startWithLongRangeRadio) then {_initialRebelEquipment append ["tf_anprc155","tf_anprc155_coyote"]};
if (A3A_hasTFARBeta) then {_initialRebelEquipment append ["TFAR_microdagr","TFAR_anprc154"]};
if (A3A_hasTFARBeta && startWithLongRangeRadio) then {_initialRebelEquipment append ["TFAR_anprc155","TFAR_anprc155_coyote"]};
["initialRebelEquipment", _initialRebelEquipment] call _fnc_saveToTemplate;

private _rebUniforms = [
    "U_I_CombatUniform",
	"U_I_CombatUniform_tshirt",
	"U_I_CombatUniform_shortsleeve",
	"U_I_pilotCoveralls",
	"U_I_HeliPilotCoveralls",
	"U_I_GhillieSuit",
	"U_I_OfficerUniform",
	"U_I_Wetsuit",
	"U_I_FullGhillie_lsh",
	"U_I_FullGhillie_sard",
	"U_I_FullGhillie_ard",
	"U_I_CBRN_Suit_01_AAF_F",
	"U_Tank_green_F"
];

["uniforms", _rebUniforms] call _fnc_saveToTemplate;

["headgear", [
    "H_Booniehat_dgtl",
	"H_Cap_blk_Raven",
	"H_MilCap_dgtl",
	"H_HelmetCrew_I",
	"H_PilotHelmetFighter_I",
	"H_PilotHelmetHeli_I",
	"H_CrewHelmetHeli_I",
	"H_HelmetIA",
	"H_HelmetIA_net",
	"H_HelmetIA_camo"
]] call _fnc_saveToTemplate;

/////////////////////
///  Identities   ///
/////////////////////

["faces", ["TanoanHead_A3_01","TanoanHead_A3_02","TanoanHead_A3_03","TanoanHead_A3_04","TanoanHead_A3_05","TanoanHead_A3_06","TanoanHead_A3_07","TanoanHead_A3_08"]] call _fnc_saveToTemplate;
["voices", ["Male01ENGFRE","Male02ENGFRE"]] call _fnc_saveToTemplate;

//////////////////////////
//       Loadouts       //
//////////////////////////

private _loadoutData = call _fnc_createLoadoutData;
_loadoutData set ["maps", ["ItemMap"]];
_loadoutData set ["watches", ["ItemWatch"]];
_loadoutData set ["compasses", ["ItemCompass"]];
_loadoutData set ["binoculars", ["Binocular"]];

_loadoutData set ["uniforms", _rebUniforms];

_loadoutData set ["glasses", ["G_Shades_Black", "G_Shades_Blue", "G_Shades_Green", "G_Shades_Red", "G_Aviator", "G_Spectacles", "G_Spectacles_Tinted", "G_Sport_BlackWhite", "G_Sport_Blackyellow", "G_Sport_Greenblack", "G_Sport_Checkered", "G_Sport_Red", "G_Squares", "G_Squares_Tinted"]];
_loadoutData set ["goggles", ["G_Lowprofile"]];
_loadoutData set ["facemask", ["G_Bandanna_blk", "G_Bandanna_oli", "G_Bandanna_khk", "G_Bandanna_tan", "G_Bandanna_beast", "G_Bandanna_shades", "G_Bandanna_sport", "G_Bandanna_aviator"]];

_loadoutData set ["items_medical_basic", ["BASIC"] call A3A_fnc_itemset_medicalSupplies];
_loadoutData set ["items_medical_standard", ["STANDARD"] call A3A_fnc_itemset_medicalSupplies];
_loadoutData set ["items_medical_medic", ["MEDIC"] call A3A_fnc_itemset_medicalSupplies];
_loadoutData set ["items_miscEssentials", [] call A3A_fnc_itemset_miscEssentials];

////////////////////////
//  Rebel Unit Types  //
///////////////////////.

private _squadLeaderTemplate = {
    ["uniforms"] call _fnc_setUniform;
    [selectRandomWeighted [[], 1.25, "glasses", 1, "goggles", 0.75, "facemask", 1]] call _fnc_setFacewear;

    ["items_medical_standard"] call _fnc_addItemSet;
    ["items_miscEssentials"] call _fnc_addItemSet;

    ["maps"] call _fnc_addMap;
    ["watches"] call _fnc_addWatch;
    ["compasses"] call _fnc_addCompass;
    ["binoculars"] call _fnc_addBinoculars;
};

private _riflemanTemplate = {
    ["uniforms"] call _fnc_setUniform;
    [selectRandomWeighted [[], 1.25, "glasses", 1, "goggles", 0.75, "facemask", 1]] call _fnc_setFacewear;
    
    ["items_medical_standard"] call _fnc_addItemSet;
    ["items_miscEssentials"] call _fnc_addItemSet;

    ["maps"] call _fnc_addMap;
    ["watches"] call _fnc_addWatch;
    ["compasses"] call _fnc_addCompass;
};

private _prefix = "militia";
private _unitTypes = [
    ["Petros", _squadLeaderTemplate],
    ["SquadLeader", _squadLeaderTemplate],
    ["Rifleman", _riflemanTemplate],
    ["staticCrew", _riflemanTemplate],
    ["Medic", _riflemanTemplate, [["medic", true]]],
    ["Engineer", _riflemanTemplate, [["engineer", true]]],
    ["ExplosivesExpert", _riflemanTemplate, [["explosiveSpecialist", true]]],
    ["Grenadier", _riflemanTemplate],
    ["LAT", _riflemanTemplate],
    ["AT", _riflemanTemplate],
    ["AA", _riflemanTemplate],
    ["MachineGunner", _riflemanTemplate],
    ["Marksman", _riflemanTemplate],
    ["Sniper", _riflemanTemplate],
    ["Unarmed", _riflemanTemplate]
];

[_prefix, _unitTypes, _loadoutData] call _fnc_generateAndSaveUnitsToTemplate;
