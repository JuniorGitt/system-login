#include <YSI_Coding\y_hooks>

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case DIALOG_LOGIN:
        {
            if(response)
            {
                new String[65];
                SHA256_PassHash(inputtext, PlayerInfo[playerid][psalt], String, 65);
                if(!strlen(inputtext) || strcmp(String, PlayerInfo[playerid][ppass], false) != 0 || strcmp(String, PlayerInfo[playerid][ppass], false) == -1)
                {
                    SendClientMessage(playerid, COR_CINZA, "Senha incorreta.");
                    return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", "Bem vindo(a)!\n\nDigite sua senha para login:", "Login", "Sair");
                }

                SetPlayerOnline(playerid, true);
                SpawnPlayer(playerid);
                SetPlayerData(playerid);
                va_SendClientMessage(playerid, -1, "Seu ultimo login foi: %s.", PlayerInfo[playerid][plastlogin]);
                return 1;
            }
            else Kick(playerid);
        }
    }   
    return 1;
}