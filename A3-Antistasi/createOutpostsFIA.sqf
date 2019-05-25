if (!isServer) exitWith {};

private ["_tipo","_costs","_group","_unit","_tam","_roads","_road","_pos","_truckX","_texto","_mrk","_hr","_unitsX","_formatX"];

_tipo = _this select 0;
_positionTel = _this select 1;

if (_tipo == "delete") exitWith {hint "Deprecated option. Use Remove Garrison from HQ instead"};

_isRoad = isOnRoad _positionTel;

_texto = format ["%1 Observation Post",nameTeamPlayer];
_typeGroup = groupsSDKSniper;
_typeVehX = vehSDKBike;
private _tsk = "";
if (_isRoad) then
	{
	_texto = format ["%1 Roadblock",nameTeamPlayer];
	_typeGroup = groupsSDKAT;
	_typeVehX = vehSDKTruck;
	};

_mrk = createMarker [format ["FIAPost%1", random 1000], _positionTel];
_mrk setMarkerShape "ICON";

_dateLimit = [date select 0, date select 1, date select 2, date select 3, (date select 4) + 60];
_dateLimitNum = dateToNumber _dateLimit;
[[teamPlayer,civilian],"outpostsFIA",["We are sending a team to establish a Watchpost/Roadblock. Use HC to send the team to their destination","Post \ Roadblock Deploy",_mrk],_positionTel,false,0,true,"Move",true] call BIS_fnc_taskCreate;
//_tsk = ["outpostsFIA",[teamPlayer,civilian],["We are sending a team to establish a Watchpost/Roadblock. Use HC to send the team to their destination","Post \ Roadblock Deploy",_mrk],_positionTel,"CREATED",5,true,true,"Move"] call BIS_fnc_setTask;
//missionsX pushBackUnique _tsk; publicVariable "missionsX";
_formatX = [];
{
if (random 20 <= skillFIA) then {_formatX pushBack (_x select 1)} else {_formatX pushBack (_x select 0)};
} forEach _typeGroup;
_group = [getMarkerPos respawnTeamPlayer, teamPlayer, _formatX] call A3A_fnc_spawnGroup;
_group setGroupId ["Post"];
_road = [getMarkerPos respawnTeamPlayer] call A3A_fnc_findNearestGoodRoad;
_pos = position _road findEmptyPosition [1,30,"B_G_Van_01_transport_F"];
_truckX = _typeVehX createVehicle _pos;
//_nul = [_group] spawn dismountFIA;
_group addVehicle _truckX;
{[_x] call A3A_fnc_FIAinit} forEach units _group;
leader _group setBehaviour "SAFE";
(units _group) orderGetIn true;
theBoss hcSetGroup [_group];

waitUntil {sleep 1; ({alive _x} count units _group == 0) or ({(alive _x) and (_x distance _positionTel < 10)} count units _group > 0) or (dateToNumber date > _dateLimitNum)};

if ({(alive _x) and (_x distance _positionTel < 10)} count units _group > 0) then
	{
	if (isPlayer leader _group) then
		{
		_owner = (leader _group) getVariable ["owner",leader _group];
		(leader _group) remoteExec ["removeAllActions",leader _group];
		_owner remoteExec ["selectPlayer",leader _group];
		(leader _group) setVariable ["owner",_owner,true];
		{[_x] joinsilent group _owner} forEach units group _owner;
		[group _owner, _owner] remoteExec ["selectLeader", _owner];
		"" remoteExec ["hint",_owner];
		waitUntil {!(isPlayer leader _group)};
		};
	outpostsFIA = outpostsFIA + [_mrk]; publicVariable "outpostsFIA";
	sidesX setVariable [_mrk,teamPlayer,true];
	markersX = markersX + [_mrk];
	publicVariable "markersX";
	spawner setVariable [_mrk,2,true];
	["outpostsFIA",["We are sending a team to establish a Watchpost/Roadblock. Use HC to send the team to their destination","Post \ Roadblock Deploy",_mrk],_positionTel,"SUCCEEDED"] call A3A_fnc_taskUpdate;
	//["outpostsFIA", "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
	_nul = [-5,5,_positionTel] remoteExec ["A3A_fnc_citySupportChange",2];
	_mrk setMarkerType "loc_bunker";
	_mrk setMarkerColor colourTeamPlayer;
	_mrk setMarkerText _texto;
	if (_isRoad) then
		{
		_garrison = [staticCrewTeamPlayer];
		{
		if (random 20 <= skillFIA) then {_garrison pushBack (_x select 1)} else {_garrison pushBack (_x select 0)};
		} forEach groupsSDKAT;
		garrison setVariable [_mrk,_garrison,true];
		};
	}
else
	{
	["outpostsFIA",["We are sending a team to establish a Watchpost/Roadblock. Use HC to send the team to their destination","Post \ Roadblock Deploy",_mrk],_positionTel,"FAILED"] call A3A_fnc_taskUpdate;
	//["outpostsFIA", "FAILED",true] spawn BIS_fnc_taskSetState;
	sleep 3;
	deleteMarker _mrk;
	};

theBoss hcRemoveGroup _group;
{deleteVehicle _x} forEach units _group;
deleteVehicle _truckX;
deleteGroup _group;
sleep 15;

_nul = [0,"outpostsFIA"] spawn A3A_fnc_deleteTask;










