//CLY DM Template for easy and fun deathmatch creation
//
//This script boosts the accuracy and/or power of weapons.
//Normally used to make pistols not so useless.
//
//Executed in a unit's "fired" eventhander set in spawn.sqs
///////////////////////////////////////////////////////////////////////////////////////

_unit=_this select 0;
_weapon=_this select 1;
_bullet=nearestObject [_unit,_this select 4];
_weapontype=getNumber (configFile/"CfgWeapons"/_weapon/"type");

if (_unit!=player) exitwith{};
if (!(CLY_boost select 0) && (CLY_boost select 1==1)) exitwith{};
if ((CLY_boost select 0) && (CLY_boost select 1==1) && (_weapontype!=2)) exitwith{};
if ((count CLY_boostarray>0) && !(_weapon in CLY_boostarray) && !(_weapontype==2 && CLY_boost select 0)) exitwith{};
if ((_weapon in CLY_noboostarray) && (_weapontype!=2)) exitwith{};
if (_bullet in CLY_noboostammoarray) exitwith{};

_power=1;
if (((count CLY_boostarray>0) && (_weapon in CLY_boostarray)) || ((count CLY_boostarray==0) && !(_weapon in CLY_noboostarray))) then {_power=CLY_boost select 1;};
_speed=(speed _bullet/3.6)*_power;

_dir=vectorDir _bullet;
_elevation=0;
if ((CLY_boost select 0) && (_weapontype==2)) then {_dir=_unit weaponDirection _weapon;_elevation=0.01-(CLY_boost select 1)*0.01;};
if (_elevation<0) then {_elevation=0;};

_vel=[(_dir select 0)*_speed,(_dir select 1)*_speed,(((_dir select 2)+_elevation)*_speed)];
_bullet setVelocity _vel;