#include <YSi_Coding\y_hooks>

hook OnPlayerSpawn(playerid)
{
    if(PlayerInfo[playerid][plogged] == false) return Kick(playerid);
    return 1;
}

hook OnPlayerRequestClass(playerid, classid)
{
    LoadPlayerInfo(playerid);
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    if(PlayerInfo[playerid][plogged] == true)
    {
        SavePlayerInfo(playerid);
    }

    orm_destroy(PlayerInfo[playerid][pormid]);
    ResetPlayerInfo(playerid);
    return 1;
}

function VerifyRegister(playerid)
{
    orm_setkey(PlayerInfo[playerid][pormid], "id");
    CleanChat(playerid);
    if(orm_errno(PlayerInfo[playerid][pormid]) == ERROR_OK)
    {
        return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", "Bem vindo(a)!\n\nDigite sua senha para login:", "Login", "Sair");
    }
    else
    {
        ShowPlayerDialog(playerid, DIALOG_RANDON, DIALOG_STYLE_MSGBOX, "Whitelist", "Foi notificado que sua conta não é registrada\nem nosso servidor, para se registrar entre em\nnosso discord.", "Sair", "");
        SetTimer("KickEx", 300, false);
    }
    return 1;
}