private _hasWs = "ws" in A3A_enabledDLC;
private _hasLawsOfWar = "orange" in A3A_enabledDLC;
private _hasApex = "expansion" in A3A_enabledDLC;
private _hasContact = "enoch" in A3A_enabledDLC;

///////////////////////////
//   Rebel Information   //
///////////////////////////

["name", "LL"] call _fnc_saveToTemplate;

["flag", "Flag_Green_F"] call _fnc_saveToTemplate;
["flagTexture", "\A3\Data_F\Flags\Flag_green_CO.paa"] call _fnc_saveToTemplate;
["flagMarkerType", "flag_EnochLooters"] call _fnc_saveToTemplate;

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

["vehiclePlane", "I_Plane_Fighter_03_dynamicLoadout_F"] call _fnc_saveToTemplate;
["vehiclePayloadPlane", "B_T_VTOL_01_infantry_F"] call _fnc_saveToTemplate;
["vehicleAttackHeliB", "B_Heli_Attack_01_dynamicLoadout_F"] call _fnc_saveToTemplate; // by rickgcn
["vehicleAttackHeliO", "O_Heli_Attack_02_dynamicLoadout_black_F"] call _fnc_saveToTemplate; // by rickgcn
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
// BLUFOR Initial Equipment
// Uniforms
"U_B_CombatUniform_mcam",
"U_B_CombatUniform_mcam_tshirt",
"U_B_CombatUniform_mcam_vest",
"U_B_GhillieSuit",
"U_B_HeliPilotCoveralls",
"U_B_Wetsuit",
"U_B_CombatUniform_mcam_worn",
"U_B_CombatUniform_wdl",
"U_B_CombatUniform_wdl_tshirt",
"U_B_CombatUniform_wdl_vest",
"U_B_CombatUniform_sgg",
"U_B_CombatUniform_sgg_tshirt",
"U_B_CombatUniform_sgg_vest",
"U_B_SpecopsUniform_sgg",
"U_B_PilotCoveralls",
"U_B_CTRG_1",
"U_B_CTRG_2",
"U_B_CTRG_3",
"U_B_survival_uniform",
"U_B_FullGhillie_lsh",
"U_B_FullGhillie_sard",
"U_B_FullGhillie_ard",
"U_B_T_Soldier_F",
"U_B_T_Soldier_AR_F",
"U_B_T_Soldier_SL_F",
"U_B_T_Sniper_F",
"U_B_T_FullGhillie_tna_F",
"U_B_CTRG_Soldier_F",
"U_B_CTRG_Soldier_2_F",
"U_B_CTRG_Soldier_3_F",
"U_B_CTRG_Soldier_Arid_F",
"U_B_CTRG_Soldier_2_Arid_F",
"U_B_CTRG_Soldier_3_Arid_F",
"U_B_CTRG_Soldier_urb_1_F",
"U_B_CTRG_Soldier_urb_2_F",
"U_B_CTRG_Soldier_urb_3_F",
"U_B_CombatUniform_vest_mcam_wdl_f",
"U_B_CombatUniform_mcam_wdl_f",
"U_B_CombatUniform_tshirt_mcam_wdL_f",
"U_B_CBRN_Suit_01_MTP_F",
"U_B_CBRN_Suit_01_Tropic_F",
"U_B_CBRN_Suit_01_Wdl_F",
// Helmets
"H_HelmetCrew_B",
"H_PilotHelmetFighter_B",
"H_PilotHelmetHeli_B",
"H_CrewHelmetHeli_B",
"H_HelmetB",
"H_HelmetB_camo",
"H_HelmetB_paint",
"H_HelmetB_plain_mcamo",
"H_HelmetB_plain_blk",
"H_Helmet_Kerry",
"H_HelmetB_grass",
"H_HelmetB_snakeskin",
"H_HelmetB_desert",
"H_HelmetB_black",
"H_HelmetB_sand",
"H_HelmetB_tna_F",
"H_HelmetB_plain_wdl",
"H_HelmetB_light",
"H_HelmetB_light_grass",
"H_HelmetB_light_snakeskin",
"H_HelmetB_light_desert",
"H_HelmetB_light_black",
"H_HelmetB_light_sand",
"H_HelmetB_Light_tna_F",
"H_HelmetB_light_wdl",
"H_HelmetSpecB",
"H_HelmetSpecB_paint1",
"H_HelmetSpecB_paint2",
"H_HelmetSpecB_blk",
"H_HelmetSpecB_snakeskin",
"H_HelmetSpecB_sand",
"H_HelmetB_Enh_tna_F",
"H_HelmetSpecB_wdl",
"H_HelmetB_TI_tna_F",
"H_HelmetB_TI_arid_F",
// Vests
"V_RebreatherB",
"V_Chestrig_rgr",
"V_BandollierB_rgr",
"V_TacVest_oli",
"V_TacVest_blk",
"V_PlateCarrier1_rgr",
"V_PlateCarrier1_blk",
"V_PlateCarrier1_tna_F",
"V_PlateCarrier1_rgr_noflag_F",
"V_PlateCarrier1_wdl",
"V_PlateCarrier2_rgr",
"V_PlateCarrier2_blk",
"V_PlateCarrier2_tna_F",
"V_PlateCarrier2_rgr_noflag_F",
"V_PlateCarrier2_wdl",
"V_PlateCarrierGL_rgr",
"V_PlateCarrierGL_blk",
"V_PlateCarrierGL_mtp",
"V_PlateCarrierGL_tna_F",
"V_PlateCarrierGL_wdl",
"V_PlateCarrierSpec_rgr",
"V_PlateCarrierSpec_blk",
"V_PlateCarrierSpec_mtp",
"V_PlateCarrierSpec_tna_F",
"V_PlateCarrierSpec_wdl",
"V_PlateCarrier_Kerry",
"V_PlateCarrierL_CTRG",
"V_PlateCarrierH_CTRG",
// Rifles
"arifle_MX_F",
"arifle_MXC_F",
"arifle_MX_GL_F",
"arifle_MX_SW_F",
"arifle_MXM_F",
"arifle_MX_Black_F",
"arifle_MXC_Black_F",
"arifle_MX_GL_Black_F",
"arifle_MX_SW_Black_F",
"arifle_MXM_Black_F",
"arifle_MX_khk_F",
"arifle_MXC_khk_F",
"arifle_MX_GL_khk_F",
"arifle_MX_SW_khk_F",
"arifle_MXM_khk_F",
"arifle_SDAR_F",
"arifle_SPAR_01_blk_F",
"arifle_SPAR_01_khk_F",
"arifle_SPAR_01_snd_F",
"arifle_SPAR_01_GL_blk_F",
"arifle_SPAR_01_GL_khk_F",
"arifle_SPAR_01_GL_snd_F",
"arifle_SPAR_02_blk_F",
"arifle_SPAR_02_khk_F",
"arifle_SPAR_02_snd_F",
"arifle_SPAR_03_blk_F",
"arifle_SPAR_03_khk_F",
"arifle_SPAR_03_snd_F",
// Rifle Magizines
"30Rnd_65x39_caseless_mag",
"30Rnd_65x39_caseless_khaki_mag",
"30Rnd_65x39_caseless_black_mag",
"30Rnd_65x39_caseless_mag_Tracer",
"30Rnd_65x39_caseless_khaki_mag_Tracer",
"30Rnd_65x39_caseless_black_mag_Tracer",
"100Rnd_65x39_caseless_mag",
"100Rnd_65x39_caseless_khaki_mag",
"100Rnd_65x39_caseless_black_mag",
"100Rnd_65x39_caseless_mag_Tracer",
"100Rnd_65x39_caseless_khaki_mag_tracer",
"100Rnd_65x39_caseless_black_mag_tracer",
"20Rnd_556x45_UW_mag",
"30Rnd_556x45_Stanag",
"30Rnd_556x45_Stanag_green",
"30Rnd_556x45_Stanag_red",
"30Rnd_556x45_Stanag_Tracer_Red",
"30Rnd_556x45_Stanag_Tracer_Green",
"30Rnd_556x45_Stanag_Tracer_Yellow",
"30Rnd_556x45_Stanag_Sand",
"30Rnd_556x45_Stanag_Sand_green",
"30Rnd_556x45_Stanag_Sand_red",
"30Rnd_556x45_Stanag_Sand_Tracer_Red",
"30Rnd_556x45_Stanag_Sand_Tracer_Green",
"30Rnd_556x45_Stanag_Sand_Tracer_Yellow",
"150Rnd_556x45_Drum_Mag_F",
"150Rnd_556x45_Drum_Sand_Mag_F",
"150Rnd_556x45_Drum_Sand_Mag_Tracer_F",
"150Rnd_556x45_Drum_Green_Mag_F",
"150Rnd_556x45_Drum_Green_Mag_Tracer_F",
"150Rnd_556x45_Drum_Mag_Tracer_F",
// Sniper Rifles
"srifle_DMR_02_F",
"srifle_DMR_02_camo_F",
"srifle_DMR_02_sniper_F",
"srifle_DMR_03_F",
"srifle_DMR_03_khaki_F",
"srifle_DMR_03_tan_F",
"srifle_DMR_03_multicam_F",
"srifle_DMR_03_woodland_F",
"srifle_LRR_F",
"srifle_LRR_camo_F",
"srifle_LRR_tna_F",
// Sniper Rifle Magazines
"10Rnd_338_Mag",
"20Rnd_762x51_Mag",
"7Rnd_408_Mag",
// MachineGuns
"MMG_02_camo_F",
"MMG_02_black_F",
"MMG_02_sand_F",
// MachineGun Magazines
"130Rnd_338_Mag",
// SMGs
"SMG_01_F",
// SMG Magazines
"30Rnd_45ACP_Mag_SMG_01",
"30Rnd_45ACP_Mag_SMG_01_tracer_green",
"30Rnd_45ACP_Mag_SMG_01_Tracer_Red",
"30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow",
// Handguns
"hgun_P07_F",
"hgun_P07_khk_F",
"hgun_P07_blk_F",
"hgun_Pistol_heavy_01_F",
"hgun_Pistol_heavy_01_green_F",
// Handgun Magazines
"16Rnd_9x21_Mag",
"16Rnd_9x21_red_Mag",
"16Rnd_9x21_green_Mag",
"16Rnd_9x21_yellow_Mag",
"30Rnd_9x21_Mag",
"30Rnd_9x21_Red_Mag",
"30Rnd_9x21_Yellow_Mag",
"30Rnd_9x21_Green_Mag",
"11Rnd_45ACP_Mag",
// Launchers
"launch_NLAW_F",
"launch_B_Titan_F",
"launch_B_Titan_short_F",
"launch_B_Titan_tna_F",
"launch_B_Titan_short_tna_F",
"launch_B_Titan_olive_F",
"launch_MRAWS_green_F",
"launch_MRAWS_sand_F",
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
"3Rnd_HE_Grenade_shell",
"3Rnd_UGL_FlareWhite_F",
"3Rnd_UGL_FlareGreen_F",
"3Rnd_UGL_FlareRed_F",
"3Rnd_UGL_FlareYellow_F",
"3Rnd_UGL_FlareCIR_F",
"3Rnd_Smoke_Grenade_shell",
"3Rnd_SmokeRed_Grenade_shell",
"3Rnd_SmokeGreen_Grenade_shell",
"3Rnd_SmokeYellow_Grenade_shell",
"3Rnd_SmokePurple_Grenade_shell",
"3Rnd_SmokeBlue_Grenade_shell",
"3Rnd_SmokeOrange_Grenade_shell",
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
"acc_flashlight",
"acc_flashlight_pistol",
"optic_MRD",
"optic_Holosight",
"optic_Holosight_smg",
"optic_Hamr",
"optic_Aco",
"optic_Aco_smg",
"optic_SOS",
"optic_Arco",
"optic_DMS",
"optic_AMS",
"optic_AMS_khk",
"optic_AMS_snd",
"optic_LRPS",
"optic_LRPS_tna_F",
"optic_ERCO_blk_F",
"optic_ERCO_khk_F",
"optic_ERCO_snd_F",
"optic_NVS",
"optic_Nightstalker",
"optic_tws",
"optic_tws_mg",
"muzzle_snds_H",
"muzzle_snds_H_khk_F",
"muzzle_snds_H_snd_F",
"muzzle_snds_M",
"muzzle_snds_m_khk_F",
"muzzle_snds_m_snd_F",
"muzzle_snds_L",
"muzzle_snds_B",
"muzzle_snds_acp",
"bipod_01_F_snd",
"bipod_01_F_blk",
"bipod_01_F_mtp",
"bipod_01_F_khk",
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
"Laserdesignator",
"Laserbatteries",
"NVGoggles",
"NVGoggles_OPFOR",
"NVGoggles_INDEP",
"NVGoggles_tna_F",
"NVGogglesB_blk_F",
"NVGogglesB_grn_F",
"NVGogglesB_gry_F",
"G_Combat",
"G_B_Diving",
"G_Tactical_Clear",
"G_Tactical_Black",
"G_Balaclava_TI_blk_F",
"G_Balaclava_TI_tna_F",
"G_Balaclava_TI_G_blk_F",
"G_Balaclava_TI_G_tna_F",
"G_AirPurifyingRespirator_01_F",
// Backpacks
"B_Bergen_mcamo_F",
"B_Bergen_tna_F",
"B_UAV_06_backpack_F",
"B_UAV_06_medical_backpack_F",
"B_UAV_01_backpack_F",
"B_UGV_02_Demining_backpack_F",
"B_UGV_02_Science_backpack_F",
"B_Parachute",
"B_Carryall_mcamo",
"B_Carryall_oli",
"B_Carryall_wdl_F",
"B_TacticalPack_mcamo",
"B_TacticalPack_rgr",
"B_Mortar_01_support_F",
"B_Mortar_01_weapon_F",
"B_HMG_01_support_F",
"B_HMG_01_support_high_F",
"B_HMG_01_weapon_F",
"B_HMG_01_high_weapon_F",
"B_GMG_01_weapon_F",
"B_GMG_01_high_weapon_F",
"B_GMG_01_A_weapon_F",
"B_HMG_01_A_weapon_F",
"B_RadioBag_01_wdl_F",
"B_RadioBag_01_mtp_F",
"B_RadioBag_01_tropic_F",
"B_AssaultPack_rgr",
"B_AssaultPack_mcamo",
"B_AssaultPack_Kerry",
"B_AssaultPack_tna_F",
"B_AssaultPack_wdl_F",
"B_Kitbag_rgr",
"B_Kitbag_mcamo",
"B_Static_Designator_01_weapon_F",
"B_W_Static_Designator_01_weapon_F",
"B_AA_01_weapon_F",
"B_AT_01_weapon_F",
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
    "U_B_CombatUniform_mcam",
    "U_B_CombatUniform_mcam_tshirt",
    "U_B_CombatUniform_mcam_vest",
    "U_B_GhillieSuit",
    "U_B_HeliPilotCoveralls",
    "U_B_Wetsuit",
    "U_B_CombatUniform_mcam_worn",
    "U_B_CombatUniform_wdl",
    "U_B_CombatUniform_wdl_tshirt",
    "U_B_CombatUniform_wdl_vest",
    "U_B_CombatUniform_sgg",
    "U_B_CombatUniform_sgg_tshirt",
    "U_B_CombatUniform_sgg_vest",
    "U_B_SpecopsUniform_sgg",
    "U_B_PilotCoveralls",
    "U_B_CTRG_1",
    "U_B_CTRG_2",
    "U_B_CTRG_3",
    "U_B_survival_uniform",
    "U_B_FullGhillie_lsh",
    "U_B_FullGhillie_sard",
    "U_B_FullGhillie_ard",
    "U_B_T_Soldier_F",
    "U_B_T_Soldier_AR_F",
    "U_B_T_Soldier_SL_F",
    "U_B_T_Sniper_F",
    "U_B_T_FullGhillie_tna_F",
    "U_B_CTRG_Soldier_F",
    "U_B_CTRG_Soldier_2_F",
    "U_B_CTRG_Soldier_3_F",
    "U_B_CTRG_Soldier_Arid_F",
    "U_B_CTRG_Soldier_2_Arid_F",
    "U_B_CTRG_Soldier_3_Arid_F",
    "U_B_CTRG_Soldier_urb_1_F",
    "U_B_CTRG_Soldier_urb_2_F",
    "U_B_CTRG_Soldier_urb_3_F",
    "U_B_CombatUniform_vest_mcam_wdl_f",
    "U_B_CombatUniform_mcam_wdl_f",
    "U_B_CombatUniform_tshirt_mcam_wdL_f",
    "U_B_CBRN_Suit_01_MTP_F",
    "U_B_CBRN_Suit_01_Tropic_F",
    "U_B_CBRN_Suit_01_Wdl_F"
];

private _dlcUniforms = [];

if (_hasContact) then {
    _dlcUniforms append [
        "U_I_L_Uniform_01_camo_F",
        "U_I_L_Uniform_01_tshirt_black_F",
        "U_I_L_Uniform_01_tshirt_olive_F",
        "U_I_L_Uniform_01_tshirt_skull_F",
        "U_I_L_Uniform_01_tshirt_sport_F"
    ];
};


["uniforms", _rebUniforms + _dlcUniforms] call _fnc_saveToTemplate;

["headgear", [
    "H_HelmetCrew_B",
    "H_PilotHelmetFighter_B",
    "H_PilotHelmetHeli_B",
    "H_CrewHelmetHeli_B",
    "H_HelmetB",
    "H_HelmetB_camo",
    "H_HelmetB_paint",
    "H_HelmetB_plain_mcamo",
    "H_HelmetB_plain_blk",
    "H_Helmet_Kerry",
    "H_HelmetB_grass",
    "H_HelmetB_snakeskin",
    "H_HelmetB_desert",
    "H_HelmetB_black",
    "H_HelmetB_sand",
    "H_HelmetB_tna_F",
    "H_HelmetB_plain_wdl",
    "H_HelmetB_light",
    "H_HelmetB_light_grass",
    "H_HelmetB_light_snakeskin",
    "H_HelmetB_light_desert",
    "H_HelmetB_light_black",
    "H_HelmetB_light_sand",
    "H_HelmetB_Light_tna_F",
    "H_HelmetB_light_wdl",
    "H_HelmetSpecB",
    "H_HelmetSpecB_paint1",
    "H_HelmetSpecB_paint2",
    "H_HelmetSpecB_blk",
    "H_HelmetSpecB_snakeskin",
    "H_HelmetSpecB_sand",
    "H_HelmetB_Enh_tna_F",
    "H_HelmetSpecB_wdl",
    "H_HelmetB_TI_tna_F",
    "H_HelmetB_TI_arid_F"
]] call _fnc_saveToTemplate;

/////////////////////
///  Identities   ///
/////////////////////

["voices", ["Male01POL", "Male02POL", "Male03POL"]] call _fnc_saveToTemplate;
["faces", [
    "LivonianHead_1", "LivonianHead_2", "LivonianHead_3", "LivonianHead_4",
    "LivonianHead_5", "LivonianHead_6", "LivonianHead_7", "LivonianHead_8",
    "LivonianHead_9", "LivonianHead_10",
    "WhiteHead_01", "WhiteHead_02", "WhiteHead_03", "WhiteHead_04",
    "WhiteHead_06", "WhiteHead_07", "WhiteHead_08", "WhiteHead_10", "WhiteHead_11",
    "WhiteHead_13", "WhiteHead_15", "WhiteHead_16", "WhiteHead_17", "WhiteHead_18",
    "WhiteHead_19", "WhiteHead_20", "WhiteHead_21"
]] call _fnc_saveToTemplate;

//////////////////////////
//       Loadouts       //
//////////////////////////

private _loadoutData = call _fnc_createLoadoutData;
_loadoutData set ["maps", ["ItemMap"]];
_loadoutData set ["watches", ["ItemWatch"]];
_loadoutData set ["compasses", ["ItemCompass"]];
_loadoutData set ["binoculars", ["Binocular"]];

_loadoutData set ["uniforms", _rebUniforms + _dlcUniforms];

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
