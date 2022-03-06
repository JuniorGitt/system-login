#include <YSI_Coding\y_hooks>

new MySQL:dbconn;

stock DatabaseStart()
{
    dbconn = mysql_connect_file();
    
    if(mysql_errno() != 0)
    {
        print("MySQL: Não foi possivel iniciar o banco de dados.");
        SendRconCommand("exit");
    }
    else print("MySQL: Conexão com o banco de dados efetuada com sucesso.");

    print("MySQL: Checando tabelas.");

    mysql_query(dbconn, "CREATE TABLE IF NOT EXISTS player (\
    id INT AUTO_INCREMENT,\
    name VARCHAR(24) NOT NULL,\
    pass VARCHAR(65) NOT NULL,\
    salt VARCHAR(13) NOT NULL,\
    ip VARCHAR(16) DEFAULT 'N/A',\
    lastlogin VARCHAR(23) DEFAULT 'N/A',\
    skin INT DEFAULT 1,\
    money INT DEFAULT 250,\
    moneyb INT DEFAULT 500,\
    interior INT DEFAULT 0,\
    vw INT DEFAULT 0,\
    health FLOAT DEFAULT 100,\
    armour FLOAT DEFAULT 0,\
    posx DOUBLE DEFAULT 1742.5883,\
    posy DOUBLE DEFAULT -1860.1143,\
    posz DOUBLE DEFAULT 13.5791,\
    posa DOUBLE DEFAULT 2.1128,\
    PRIMARY KEY(id));");

    print("MySQL: Tabelas checadas.");
    return 1;
}

stock LoadPlayerInfo(playerid)
{
    format(PlayerInfo[playerid][pname], 24, "%s", GetPlayerNameEx(playerid));

    PlayerInfo[playerid][pormid] = orm_create("player", dbconn);

    orm_addvar_int(PlayerInfo[playerid][pormid], PlayerInfo[playerid][paccid], "id");

    orm_addvar_string(PlayerInfo[playerid][pormid], PlayerInfo[playerid][pname], MAX_PLAYER_NAME, "name");
    orm_addvar_string(PlayerInfo[playerid][pormid], PlayerInfo[playerid][ppass], 65, "pass");
    orm_addvar_string(PlayerInfo[playerid][pormid], PlayerInfo[playerid][psalt], 13, "salt");
    orm_addvar_string(PlayerInfo[playerid][pormid], PlayerInfo[playerid][pip], 16, "ip");
    orm_addvar_string(PlayerInfo[playerid][pormid], PlayerInfo[playerid][plastlogin], 23, "lastlogin");
    
    orm_addvar_int(PlayerInfo[playerid][pormid], PlayerInfo[playerid][pskin], "skin");
    orm_addvar_int(PlayerInfo[playerid][pormid], PlayerInfo[playerid][pmoney], "money");
    orm_addvar_int(PlayerInfo[playerid][pormid], PlayerInfo[playerid][pmoneyb], "moneyb");
    orm_addvar_int(PlayerInfo[playerid][pormid], PlayerInfo[playerid][pinterior], "interior");
    orm_addvar_int(PlayerInfo[playerid][pormid], PlayerInfo[playerid][pvw], "vw");

    orm_addvar_float(PlayerInfo[playerid][pormid], PlayerInfo[playerid][phealth], "health");
    orm_addvar_float(PlayerInfo[playerid][pormid], PlayerInfo[playerid][parmour], "armour");

    orm_addvar_float(PlayerInfo[playerid][pormid], PlayerInfo[playerid][ppos][0], "posx");
    orm_addvar_float(PlayerInfo[playerid][pormid], PlayerInfo[playerid][ppos][1], "posy");
    orm_addvar_float(PlayerInfo[playerid][pormid], PlayerInfo[playerid][ppos][2], "posz");
    orm_addvar_float(PlayerInfo[playerid][pormid], PlayerInfo[playerid][ppos][3], "posa");

    orm_setkey(PlayerInfo[playerid][pormid], "name");
    orm_select(PlayerInfo[playerid][pormid], "VerifyRegister", "d", playerid);
    return 1;
}