enum PLAYER_INFO
{
    ORM:pormid,

    paccid,

    pname[24],
    ppass[65],
    psalt[13],
    pip[16],
    plastlogin[23],

    pskin,
    pmoney,
    pmoneyb,
    pinterior,
    pvw,

    Float:phealth,
    Float:parmour,

    Float:ppos[4],

    bool:plogged

}

new PlayerInfo[MAX_PLAYERS][PLAYER_INFO];

stock SetPlayerData(playerid)
{
    SetPlayerPos(playerid, PlayerInfo[playerid][ppos][0], PlayerInfo[playerid][ppos][1], PlayerInfo[playerid][ppos][2]);
    SetPlayerFacingAngle(playerid, PlayerInfo[playerid][ppos][3]);

    SetPlayerSkin(playerid, PlayerInfo[playerid][pskin]);
    SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][pvw]);
    SetPlayerInterior(playerid, PlayerInfo[playerid][pinterior]);

    SetPlayerHealth(playerid, PlayerInfo[playerid][phealth]);
    SetPlayerArmour(playerid, PlayerInfo[playerid][parmour]);
    GivePlayerMoney(playerid, PlayerInfo[playerid][pmoney]);
    return 1;
}

stock SavePlayerInfo(playerid)
{
    GetPlayerPos(playerid, PlayerInfo[playerid][ppos][0], PlayerInfo[playerid][ppos][1], PlayerInfo[playerid][ppos][2]);
    GetPlayerFacingAngle(playerid, PlayerInfo[playerid][ppos][3]);

    GetPlayerHealth(playerid, PlayerInfo[playerid][phealth]);
    GetPlayerArmour(playerid, PlayerInfo[playerid][parmour]);

    PlayerInfo[playerid][pinterior] = GetPlayerInterior(playerid);
    PlayerInfo[playerid][pvw] = GetPlayerVirtualWorld(playerid);

    format(PlayerInfo[playerid][plastlogin], 23, "%s", GetDate());
    format(PlayerInfo[playerid][pip], 16, "%s", GetPlayerIpEx(playerid));

    orm_update(PlayerInfo[playerid][pormid]);
    return 1;
}

stock bool:IsPlayerOnline(playerid)
    return PlayerInfo[playerid][plogged];

stock SetPlayerOnline(playerid, bool:online)
{
    PlayerInfo[playerid][plogged] = online;
    return 1;
}

stock ResetPlayerInfo(playerid)
{
    new Reset[PLAYER_INFO];
    PlayerInfo[playerid] = Reset;
    return 1;
}