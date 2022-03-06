//INCLUDES

#include <a_samp>
#include <a_mysql>
#include <a_util>
#include <sscanf2>

#include <YSI>

//MACROS//

#define function%0(%1) forward %0(%1); public %0(%1)

//CORES//

#define COR_CINZA 0xAFAFAFAA

//CARGOS ADMINISTRATIVOS//

//ENUMERADORES//

enum //DIALOGS//
{
    DIALOG_LOGIN,
    DIALOG_RANDON
}
//HEADERS//

#include "../headers/PlayerInfo.inc"

//MODULES//

#include "../modules/core/database.pwn"

#include "../modules/server/login/login.pwn"

#include "../modules/server/login/dialogs.pwn"

main()
{}

public OnGameModeInit()
{
    DatabaseStart();
    return 1;
}

public OnGameModeExit()
{
    mysql_close(dbconn);
    return 1;
}