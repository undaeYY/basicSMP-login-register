/*
|==============================================================================|
====================== [ Server Made From Scratch ] ============================
=====================[ If using this script please dont remove credits ] =======
=====================[ INDONESIA ROLEPLAY FROM SCRATCH ] =======================
Add your new system with your brain and dont remove the credits source
Dont be like a shit people
Contact me :
Facebook : Agil Ginting Manik *if you find some bugs or anything
Email : agilgm@ymail.com *Screen and send to me ty

================================================================================


	Thanks to Kush'is. Y_INI Tutorial :)
*/

/* Server Includes */
#include <a_samp>
#include <streamer>
#include <zcmd>
#include <foreach>
#include <sscanf2>
#include <YSI\y_ini>

/* Server Colors */
#define COLOR_PURPLE    0xC2A2DAAA
#define COLOR_GRAD2  	0xBFC0C2FF
#define COLOR_GRAD1 	0xB4B5B7FF
#define COLOR_GRAD2 	0xBFC0C2FF
#define COLOR_GREY 		0xAFAFAFAA
#define COLOR_GRAD3 	0xCBCCCEFF
#define COLOR_LIGHTBLUE 0x006FDD96
#define COLOR_GRAD4 	0xD8D8D8FF
#define COLOR_FADE 		0xC8C8C8C8
#define COLOR_FADE2 	0xC8C8C8C8
#define COLOR_FADE3 	0xAAAAAAAA
#define COLOR_FADE4 	0x8C8C8C8C
#define COLOR_YELLOW 	0xDABB3E00
#define COLOR_FADE5 	0x6E6E6E6E
#define COLOR_GRAD5 	0xE3E3E3FF
#define COLOR_FADE1 	0xE6E6E6E6
#define COLOR_GRAD6 	0xF0F0F0FF
#define TEAM_HIT_COLOR 	0xFFFFFF00
// Colors
#define COLOR_WHITE 0xFFFFFFFF
#define COLOR_FADE1 0xE6E6E6E6
#define COLOR_PM1 0xA65FC7FF
#define COLOR_PM2 0xD35FC7FF
#define COLOR_FADE2 0xC8C8C8C8
#define COLOR_FADE3 0xAAAAAAAA
#define COLOR_FADE4 0x8C8C8C8C
#define COLOR_FADE5 0x6E6E6E6E
#define TEAM_GROVE_COLOR 0x00AA00FF
#define COLOR_OOC 0xE0FFFFFF
#define COLOR_LIGHTGREEN 0xADFF2FFF
#define COLOR_LIGHTRED 0xFF6347FF
#define COLOR_ALLDEPT 0xFF8282AA
#define COLOR_DARKRED 0xAA3333FF
#define COLOR_RED 0xFF0606FF
#define TCOLOR_YELLOW 0xFFFF0000
#define COLOR_TWPINK 0xE75480AA
#define TEAM_HIT_COLOR 0xFFFFFF00
#define COLOR_DBLUE 0x2641FEAA
#define TEAM_CYAN_COLOR 0xFF8282AA
#define COLOR_GREEN 0x33AA33FF
#define COLOR_INDIGO 0x4B00B000
#define COLOR_PINK 0xFF66FF00
#define COLOR_BLACK 0x00000000
#define COLOR_ORANGE 0xFF9900FF
#define COLOR_REPORT 0xFFFF91FF
#define COLOR_RADIO 0x8D8DFFFF
#define COLOR_DEPTRADIO 0xFFD700FF
#define COLOR_BLUE 0x2641FEFF
#define COLOR_MEDIC 0xFF8282FF
#define COLOR_NEWBIE 0x7DAEFFFF
#define COLOR_LIME 0x00FF00FF
#define COLOR_NEWS 0x049C7100
#define COLOR_CYAN 0x01FCFFFF
#define COLOR_VIP 0xC93CCEFF
#define COLOR_INVIS 0xAFAFAF00

/* Server Defines */
#define PATH "Accounts/%s.ini"
#define SECONDS(%1) ((%1)*(1000))
#define ALTCOMMAND:%1->%2;           \
COMMAND:%1(playerid, params[])   \
return cmd_%2(playerid, params);
#define function%0(%1) forward%0(%1); public%0(%1)
/* Money HAX */
#define ResetMoneyBar ResetPlayerMoney
#define UpdateMoneyBar GivePlayerMoney

/* DIALOGS */
#define DIALOG_REGISTER   1
#define DIALOG_LOGIN      2
#define	DIALOG_AGE        3
#define DIALOG_SEX        4
#define ADMINMENU 1342


//Public Variable
new HelpTime[MAX_PLAYERS];
new Float:hPos[MAX_PLAYERS][3];
new hPOS[MAX_PLAYERS][2];
new Spec[MAX_PLAYERS];
new gPlayerLogged[MAX_PLAYERS];
new nonewbie = 0;
new bool:IsAFK[MAX_PLAYERS];
new Spawned[MAX_PLAYERS];
new CurrentMoney[MAX_PLAYERS];
new sendername[MAX_PLAYER_NAME];
new Speedo[MAX_PLAYERS];
new JoinMessages[MAX_PLAYERS];


/* ENUMS */
enum pInfo
{
    pPass,
    pCash,
    pBank,
    pAdmin,
    pHelper,
    pHelperDuty,
    pAdminDuty,
    pLevel,
    pSex,
    pAge,
   	Float:pPos_x,
	Float:pPos_y,
	Float:pPos_z,
	pSkin,
	pTeam,
	pSpeedo,
	pAccent
}
new PlayerInfo[MAX_PLAYERS][pInfo];
/* <--------------------------------------------> */

main()
{
    print(" ");
    print(" ");
    print("- Indonesia Roleplay GameMode Loaded -");
    print(" ");
    print(" Script By : Agil Ginting Manik");
}

new
	noooc = 0,
	Logged[ MAX_PLAYERS ],
	gOoc[ MAX_PLAYERS ]
;
forward BroadCast(color,const string[]);
public BroadCast(color,const string[])
{
	SendClientMessageToAll(color, string);
	return 1;
}
public OnPlayerConnect(playerid)
{
    gOoc[ playerid ] = 0; Logged[ playerid ] = 0;
    // Reset stats!
    PlayerInfo[ playerid ][ pCash ] = 0;
    PlayerInfo[ playerid ][ pBank ] = 0;
    PlayerInfo[ playerid ][ pAdmin ] = 0;
	PlayerInfo[ playerid ][ pHelper ] = 0;
	PlayerInfo[ playerid ][pSpeedo] = 0;
	PlayerInfo[ playerid ][ pHelperDuty ] = 0;
	PlayerInfo[ playerid ][ pAdminDuty ] = 0;
	PlayerInfo[ playerid ][ pLevel ] = 0;
    PlayerInfo[ playerid ][ pSex ] = 0;
    PlayerInfo[ playerid ][ pAge ] = 0;
    PlayerInfo[ playerid ][ pPos_x ] = 0.0;
    PlayerInfo[ playerid ][ pPos_y ] = 0.0;
    PlayerInfo[ playerid ][ pPos_z ] = 0.0;
    PlayerInfo[ playerid ][ pSkin ] = 0;
    PlayerInfo[ playerid ][ pTeam ] = 0;
    PlayerInfo[ playerid ][ pAccent ] = 0;
    if(fexist(UserPath(playerid)))
    {
        INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
        ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD,"Indonesia Roleplay","Type your password below to login:","Login","Quit");
    }
    else
    {
        ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD,"Indonesia Roleplay","Type your password below to register a new account:","Register","Quit");
    }
    {
    Spawned[playerid] = 0;
	IsAFK[playerid] = false;
	}
    return 1;
}
forward HelperBroadCast(color,const string[],level);
public HelperBroadCast(color,const string[],level)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if (PlayerInfo[i][pHelper] >= level)
			{
				SendClientMessage(i, color, string);
				printf("%s", string);
			}
		}
	}
	return 1;
}
public OnGameModeInit()
{
	/* <-------------------------------------------> */
	AddPlayerClass(21,-2382.0168,-582.0441,132.1172,125.2504,0,0,0,0,0,0);
	AddPlayerClass(59,-2382.0168,-582.0441,132.1172,125.2504,0,0,0,0,0,0);
	/* <-------------------------------------------> */
	ShowPlayerMarkers(0);
	ShowNameTags(1);
	DisableInteriorEnterExits();
	EnableStuntBonusForAll(0);
	SetNameTagDrawDistance(10.0);
	// =========== TIMERS ===========
	SetTimer("MoneyUpdate",1000,1);
	SetTimer("SaveAccounts", SECONDS(13), 1);
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
   	if(dialogid == DIALOG_AGE)
	{
	    if(!response)
       	{
         	Kick(playerid);
       	}
       	else
       	{
		    if(strlen(inputtext))
		    {
		        new age = strval(inputtext);
		        if(age > 100 || age < 16)
				{
                    ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "- Age -","How old are you??\n{FF0000}(( 16 - 100 ))","Answer","Quit");
				}
				else
				{
					PlayerInfo[playerid][pAge] = age;
					new
						string[ 64 ]
					;
					format(string, sizeof(string), "INFO: You're {3BB9FF}%d years old.",age);
					SendClientMessage(playerid, -1, string);
     				GivePlayerCash(playerid, 300);
					SaveAccountStats(playerid);
					SpawnPlayer(playerid);
				}
			}
			else
			{
			    return 0;
			}
		}
	}
	if(dialogid == ADMINMENU)
	{
 		if(response)
		{
			if(listitem == 0) //
			{
				if (PlayerInfo[playerid][pAdmin] >= 1)
				{
                    SendClientMessage(playerid, COLOR_GREEN, "================================================================");
					SendClientMessage(playerid, COLOR_WHITE, "*Trial Admin: /check /noooc(off) /weather /skydive /afrisk");
					SendClientMessage(playerid, COLOR_WHITE, "*Trial Admin: /setint /setplayerint /setworld /chill /slap");
					SendClientMessage(playerid, COLOR_WHITE, "*Trial Admin: /jail /skick /sban /spec ");
					SendClientMessage(playerid, COLOR_GREEN, "================================================================");

				}
			}
			if(listitem == 1) //
			{
				if (PlayerInfo[playerid][pAdmin] >= 2)
				{
				    SendClientMessage(playerid, COLOR_GREEN, "================================================================");
					SendClientMessage(playerid, COLOR_WHITE, "*Junior Admin: /kick /name /mole /cnn /aprison /unprison");
					SendClientMessage(playerid, COLOR_WHITE, "*Junior Admin: /entercar /entercard /gotocar /pslap /freeze /unfreeze /mute /noooc(on)");
				    SendClientMessage(playerid, COLOR_WHITE, "*Junior Admin: /logout /forceskin /goto /gotoid /setchamp /aduty");
				    SendClientMessage(playerid, COLOR_GREEN, "================================================================");
				}
			}
			if(listitem == 2) //
			{
				if (PlayerInfo[playerid][pAdmin] >= 3)
				{
				    SendClientMessage(playerid, COLOR_GREEN, "================================================================");
					SendClientMessage(playerid, COLOR_WHITE, "*Senior Admin: /ban /learn /warn /setteam /fly /setskin");
					SendClientMessage(playerid, COLOR_WHITE, "*Senior Admin: /fourdive /gethere /house /biz /sbiz ");
				    SendClientMessage(playerid, COLOR_WHITE, "*Senior Admin: /cnnn /makeircadmin /getcar /tod /weatherall /up");
				    SendClientMessage(playerid, COLOR_GREEN, "================================================================");
				}
			}
			if(listitem == 3) //
			{
				if (PlayerInfo[playerid][pAdmin] >= 4)
				{
                    SendClientMessage(playerid, COLOR_GREEN, "================================================================");
				    SendClientMessage(playerid, COLOR_WHITE, "*Head Admin: /asellhouse /edit /bigears /am /fuelcars /factions /explode /getip");
				    SendClientMessage(playerid, COLOR_WHITE, "*Head Admin: /makeleader /lockplayer /sethp /setarmor /givegun /areset /healcar ");
				    SendClientMessage(playerid, COLOR_WHITE, "*Head Admin: /pban /unbanip /unban /deleteaccount /setstat /jetpack /jobs /hq /setpot");
				    SendClientMessage(playerid, COLOR_GREEN, "================================================================");
				}
			}
			if(listitem == 4) //
			{
				if (PlayerInfo[playerid][pAdmin] >= 5)
				{
				    SendClientMessage(playerid, COLOR_GREEN, "*Owner: /edithousecar /logoutpl /logoutall /startevent /restart(gmx) /setname");
				    SendClientMessage(playerid, COLOR_GREEN, "*Owner: /hirecar /houseo /money /givemoney /veh /makeadmin /benter");
				    SendClientMessage(playerid, COLOR_GREEN, "*Owner: /henter /hexit /createvehicle /destroyvehicle /createdealership /destroydealership");
				    SendClientMessage(playerid, COLOR_GREEN, "*Owner: /editcar /editcardealership /createcdveh /destroycdveh");
				    SendClientMessage(playerid, COLOR_GREEN, "================================================================");
				}

			}
		}
	}
	if(dialogid == DIALOG_SEX)
	{
        if(response)
		{
  			PlayerInfo[playerid][pSex] = 1;
			SendClientMessage(playerid, -1, "INFO: You are {3BB9FF}male.");
			SetPlayerSkin(playerid, 60);
			PlayerInfo[playerid][pSkin] = 60;
			ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "- Age -","How old are you??\n{FF0000}(( 16 - 100 ))","Answer","Quit");
		}
		else
		{
			PlayerInfo[playerid][pSex] = 2;
			SendClientMessage(playerid, -1, "INFO: You are {3BB9FF}female.");
			SetPlayerSkin(playerid, 233);
			PlayerInfo[playerid][pSkin] = 233;
			ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "- Age -","How old are you??\n{FF0000}(( 16 - 100 ))","Answer","Quit");
		}
	}
    switch( dialogid )
    {
        case DIALOG_REGISTER:
        {
            if (!response) return Kick(playerid);
            if(response)
            {
                if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Registering...","You have entered an invalid password.\nType your password below to register a new account.","Register","Quit");
                new INI:File = INI_Open(UserPath(playerid));
                INI_SetTag(File,"data");
                INI_WriteInt(File,"Password",udb_hash(inputtext));
                INI_WriteInt(File,"Cash",0);
                INI_WriteInt(File,"Admin",0);
                INI_WriteInt(File,"Sex",0);
                INI_WriteInt(File,"Age",0);
                INI_WriteFloat(File,"Pos_x",0);
    			INI_WriteFloat(File,"Pos_y",0);
    			INI_WriteFloat(File,"Pos_z",0);
   			 	INI_WriteInt(File,"Skin",0);
   			 	INI_WriteInt(File,"Team",0);
   			 	INI_WriteInt(File,"Accent",0);
		        INI_WriteInt(File,"Helper",0);
		        INI_WriteInt(File,"HelperDuty",0);
   			 	INI_WriteInt(File,"Level",0);
   			 	INI_WriteInt(File,"Cellphone",0);
   			 	INI_WriteInt(File,"Number",0);
   			 	INI_WriteInt(File,"NMute",0);
                INI_Close(File);

			 	ShowPlayerDialog(playerid, DIALOG_SEX, DIALOG_STYLE_MSGBOX, "- Sex -","What gender are you?","Male","Female");
            }
        }
        case DIALOG_LOGIN:
        {
            if ( !response ) return Kick ( playerid );
            if( response )
            {
                if(udb_hash(inputtext) == PlayerInfo[playerid][pPass])
                {
                    INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
                    new
                        tmp2[ 256 ],
                        playername2[ MAX_PLAYER_NAME ]
					;
	    			GetPlayerName(playerid, playername2, sizeof(playername2));
   					format(tmp2, sizeof(tmp2), "~w~Welcome ~n~~g~%s", playername2);
					GameTextForPlayer(playerid, tmp2, 5000, 1);
					SetTimerEx("UnsetFirstSpawn", 5000, false, "i", playerid);
					ResetPlayerMoney(playerid);
                    CurrentMoney[playerid] = PlayerInfo[playerid][pCash];
   					SetSpawnInfo(playerid, PlayerInfo[playerid][pTeam], PlayerInfo[playerid][pSkin], PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z], 1.0, -1, -1, -1, -1, -1, -1);
				}
                else
                {
                    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD,"Login","You have entered an incorrect password.\nType your password below to login.","Login","Quit");
                }
                return 1;
            }
        }
    }
    return 1;
}
public OnPlayerSpawn(playerid)
{
   	if(IsPlayerConnected(playerid))
	{
    	SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
    	SetPlayerToTeamColor(playerid);
    	Logged[playerid] = 1;
	}
	if(PlayerInfo[playerid][pPos_x] == 0 && PlayerInfo[playerid][pPos_y] == 0)
    {
        SetPlayerPos(playerid, 1271.3654,181.0756,19.4705);
        Logged[playerid] = 1;
    }
    else
	{
		SetPlayerPos(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
		Logged[playerid] = 1;
 	}
    return 1;
}

public OnPlayerText(playerid, text[])
{
	new
		realchat = 1,
		string[ 128 ]
	;
	if(IsPlayerConnected(playerid))
	{
		if(realchat)
		{
			if(PlayerInfo[playerid][pAccent] == 0)
			{
    			format(string, sizeof(string), "%s says: %s", RPName(playerid), text);
				ProxDetector(20.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
			}
			else
			{
				new
					accent[20]
				;
				switch(PlayerInfo[playerid][pAccent])
				{
					case 1: accent = "Russian";
					case 2: accent = "Italian";
					case 3: accent = "Germany";
					case 4: accent = "Japanese";
					case 5: accent = "French";
					case 6: accent = "Spain";
					case 7: accent = "China";
					case 8: accent = "British";
				}
				format(string, sizeof(string), "%s says: [%s Accent] %s", RPName(playerid), accent, text);
				ProxDetector(20.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
			}
			return 0;
		}
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	SaveAccountStats(playerid);
    return 1;
}

function SetPlayerToTeamColor(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    SetPlayerColor(playerid,TEAM_HIT_COLOR);
	}
}

function OOCOff(color,const string[])
{
	foreach (Player,i)
	{
		if(!gOoc{i})
		{
			SendClientMessage(i, color, string);
		}
	}
}
function AskOff(color,const string[])
{
	foreach (Player,i)
	{
		if(!gOoc{i})
		{
			SendClientMessage(i, color, string);
		}
	}
}
function SaveAccountStats(playerid)
{
	if(Logged[playerid] == 1)
	{
	new
		INI:File = INI_Open(UserPath(playerid))
	;
    INI_SetTag(File,"data");

   	PlayerInfo[playerid][pSkin] = GetPlayerSkin(playerid);
    PlayerInfo[playerid][pCash] = GetPlayerCash(playerid);
   	new
	   	Float:x,
	    Float:y,
		Float:z
	;
	GetPlayerPos(playerid,x,y,z);
	PlayerInfo[playerid][pPos_x] = x;
	PlayerInfo[playerid][pPos_y] = y;
	PlayerInfo[playerid][pPos_z] = z;

    INI_WriteInt(File,"Cash",PlayerInfo[playerid][pCash]);
    INI_WriteInt(File,"Bank",PlayerInfo[playerid][pBank]);
    INI_WriteInt(File,"Admin",PlayerInfo[playerid][pAdmin]);
    INI_WriteInt(File,"Helper",PlayerInfo[playerid][pHelper]);
    INI_WriteInt(File,"HelperDuty",PlayerInfo[playerid][pHelperDuty]);
    INI_WriteInt(File,"AdminDuty",PlayerInfo[playerid][pAdminDuty]);
    INI_WriteInt(File,"Level",PlayerInfo[playerid][pLevel]);
    INI_WriteInt(File,"Sex",PlayerInfo[playerid][pSex]);
    INI_WriteInt(File,"Age",PlayerInfo[playerid][pAge]);
    INI_WriteFloat(File,"Pos_x",PlayerInfo[playerid][pPos_x]);
    INI_WriteFloat(File,"Pos_y",PlayerInfo[playerid][pPos_y]);
    INI_WriteFloat(File,"Pos_z",PlayerInfo[playerid][pPos_z]);
    INI_WriteInt(File,"Skin",PlayerInfo[playerid][pSkin]);
    INI_WriteInt(File,"Team",PlayerInfo[playerid][pTeam]);
    INI_WriteInt(File,"Speedo",PlayerInfo[playerid][pSpeedo]);
    INI_WriteInt(File,"Accent",PlayerInfo[playerid][pAccent]);
	INI_Close(File);
    }
    return 1;
}

function SaveAccounts()
{
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			SaveAccountStats(i);
  		}
	}
}

function GameModeExitFunc()
{
 	GameModeExit();
	return 1;
}

function LoadUser_data(playerid,name[],value[])
{
    INI_Int("Password",PlayerInfo[playerid][pPass]);
    INI_Int("Cash",PlayerInfo[playerid][pCash]);
    INI_Int("Bank",PlayerInfo[playerid][pBank]);
    INI_Int("Admin",PlayerInfo[playerid][pAdmin]);
    INI_Int("Helper",PlayerInfo[playerid][pHelper]);
    INI_Int("HelperDuty",PlayerInfo[playerid][pHelperDuty]);
    INI_Int("AdminDuty",PlayerInfo[playerid][pAdminDuty]);
    INI_Int("Sex",PlayerInfo[playerid][pSex]);
    INI_Int("Age",PlayerInfo[playerid][pAge]);
    INI_Int("Speedo",PlayerInfo[playerid][pSpeedo]);
    INI_Float("Pos_x",PlayerInfo[playerid][pPos_x]);
    INI_Float("Pos_y",PlayerInfo[playerid][pPos_y]);
    INI_Float("Pos_z",PlayerInfo[playerid][pPos_z]);
    INI_Int("Skin",PlayerInfo[playerid][pSkin]);
    INI_Int("Team",PlayerInfo[playerid][pTeam]);
    INI_Int("Accent",PlayerInfo[playerid][pAccent]);
    return 1;
}

function MoneyUpdate(playerid)
{
	if(GetPlayerCash(playerid) < GetPlayerMoney(playerid))
	{
		foreach(Player, i)
		{
  			new const old_money = GetPlayerCash(playerid);
    		ResetPlayerCash(playerid), GivePlayerCash(playerid, old_money);
   		}
	}
 	return 1;
}

function ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx, Float:posy, Float:posz;
		new BigEar[MAX_PLAYERS];
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i) && (GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i)))
			{
				if(!BigEar[i])
				{
					GetPlayerPos(i, posx, posy, posz);
					tempposx = (oldposx -posx);
					tempposy = (oldposy -posy);
					tempposz = (oldposz -posz);
					if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
					{
						SendClientMessage(i, col1, string);
					}
					else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
					{
						SendClientMessage(i, col2, string);
					}
					else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
					{
						SendClientMessage(i, col3, string);
					}
					else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
					{
						SendClientMessage(i, col4, string);
					}
					else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
					{
						SendClientMessage(i, col5, string);
					}
				}
				else
				{
					SendClientMessage(i, col1, string);
				}
			}
		}
	}
	return 1;
}

// ============ STOCKS ============
//==============================[SERVERSIDE CASH FUNCTIONS]=====================
stock GivePlayerCash(playerid, money)
{
	PlayerInfo[playerid][pCash] += money;
 ResetMoneyBar(playerid);
	UpdateMoneyBar(playerid,PlayerInfo[playerid][pCash]);
	return PlayerInfo[playerid][pCash];
}
stock ErrorMessages(playerid, errorID)
{
if(errorID == 1)  return SendClientMessage(playerid,COLOR_RED,"ERROR: You are not a high enough level to use this command");
if(errorID == 2)  return SendClientMessage(playerid,COLOR_RED,"ERROR: Player is not connected");
if(errorID == 3)  return SendClientMessage(playerid,COLOR_RED,"ERROR: Player is not connected or is yourself or is the highest level admin");
if(errorID == 4)  return SendClientMessage(playerid,COLOR_RED,"ERROR: Player is not connected or is yourself");
if(errorID == 5)  return SendClientMessage(playerid,COLOR_RED,"ERROR: You need to be Level 4 to use this Command");
if(errorID == 6)  return SendClientMessage(playerid,COLOR_RED,"ERROR: You need to be Level 3 to use this Command");
if(errorID == 7)  return SendClientMessage(playerid,COLOR_RED,"ERROR: You need to be Level 2 to use this Command");
if(errorID == 8)  return SendClientMessage(playerid,COLOR_RED,"ERROR: You need to be Level 1 to use this Command");
if(errorID == 9)  return SendClientMessage(playerid,COLOR_RED,"ERROR: You need to be Level 5 to use this Command");
if(errorID == 10) return SendClientMessage(playerid,COLOR_RED,"ERROR: You are not in a vehicle");
return 1;
}

stock SetPlayerCash(playerid, money)
{
	PlayerInfo[playerid][pCash] = money;
	UpdateMoneyBar(playerid,PlayerInfo[playerid][pCash]);
	return PlayerInfo[playerid][pCash];
}

stock ResetPlayerCash(playerid)
{
	PlayerInfo[playerid][pCash] = 0;
 ResetMoneyBar(playerid);
	UpdateMoneyBar(playerid,PlayerInfo[playerid][pCash]);
	return PlayerInfo[playerid][pCash];
}

stock GetPlayerCash(playerid)
{
    PlayerInfo[playerid][pCash] = 0;
    UpdateMoneyBar(playerid,PlayerInfo[playerid][pCash]);
	return PlayerInfo[playerid][pCash];
}
stock SendAdminMessage( color, string[] )
{
    foreach (Player,i)
    {
		if( PlayerInfo[ i] [ pAdmin ] > 1 )
		{
		    SendClientMessage( i, color, string );
		}
    }
}

stock GetName(playerid)
{
    new GName[24];
    GetPlayerName(playerid, GName, sizeof(GName));
    return GName;
}
stock UserPath(playerid)
{
    new string[128],playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid,playername,sizeof(playername));
    format(string,sizeof(string),PATH,playername);
    return string;
}

stock SendHelperMessage( color, string[] )
{
    foreach (Player,i)
    {
		if( PlayerInfo[ i] [ pHelper ] > 1 )
		{
		    SendClientMessage( i, color, string );
		}
    }
}

/* Credits to Dracoblue */
stock udb_hash(buf[]) {
    new length=strlen(buf);
    new s1 = 1;
    new s2 = 0;
    new n;
    for (n=0; n<length; n++)
    {
       s1 = (s1 + buf[n]) % 65521;
       s2 = (s2 + s1)     % 65521;
    }
    return (s2 << 16) + s1;
}

stock RPName(playerid)
{
    new string[24];
    GetPlayerName(playerid,string,24);
    new str[24];
    strmid(str,string,0,strlen(string),24);
    for(new i = 0; i < MAX_PLAYER_NAME; i++)
    {
        if (str[i] == '_') str[i] = ' ';
    }
    return str;
}
stock IsPlayerNearPlayer(playerid, targetid, Float:radius)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(targetid, x, y, z);
	if(IsPlayerInRangeOfPoint(playerid, radius ,x, y, z))
	{
	    return 1;
	}
	return 0;
}
stock RPHLN(playerid)
{
	new name[32];
	if(PlayerInfo[playerid][pHelper] == 1) format(name, sizeof(name), "Trial Helper");
	else if(PlayerInfo[playerid][pHelper] == 2) format(name, sizeof(name), "Junior Helper");
	else if(PlayerInfo[playerid][pHelper] == 3) format(name, sizeof(name), "Senior Helper");
	else if(PlayerInfo[playerid][pHelper] == 4) format(name, sizeof(name), "Head Helper");
	else if(PlayerInfo[playerid][pHelper] == 5) format(name, sizeof(name), "Vice Head Helper");
	else if(PlayerInfo[playerid][pHelper] >= 5) format(name, sizeof(name), "Lead Of Helper");
	return name;
}
// =================================

stock ShowStats(playerid, playerb)
{
	new string[256], sex[8], Float:H, Float:A;
	// Gender
	if(PlayerInfo[playerb][pSex] == 1) format(sex, sizeof(sex), "Male");
	else if(PlayerInfo[playerb][pSex] == 2) format(sex, sizeof(sex), "Female");
	format(string, sizeof(string), " Statistics of %s", RPName(playerb));
	SendClientMessage(playerid, COLOR_ORANGE, string);
	format(string, sizeof(string), "Level: [%d] - Sex: [%s] - Age: [%d] - Money: [$%d] - Bank: [$%d]", PlayerInfo[playerb][pLevel], sex, PlayerInfo[playerb][pAge], PlayerInfo[playerb][pCash], PlayerInfo[playerb][pBank]);
	SendClientMessage(playerid, COLOR_LIGHTRED, string);
	return 1;
}

/* LOGS */
function PayLog(string[])
{
	new
		entry[ 128 ],
		year,
		month,
		day,
		hour,
		minute,
		second
	;
	getdate(year, month, day);
	gettime(hour, minute, second);

	format(entry, sizeof(entry), "%s | (%d-%d-%d) (%d:%d:%d)\n",string, day, month, year, hour, minute, second);
	new File:hFile;
	hFile = fopen("Basic/logs/PayLog.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}
function OOCLog(string[])
{
	new
		entry[ 128 ],
		year,
		month,
		day,
		hour,
		minute,
		second
	;
	getdate(year, month, day);
	gettime(hour, minute, second);

	format(entry, sizeof(entry), "%s | (%d-%d-%d) (%d:%d:%d)\n",string, day, month, year, hour, minute, second);
	new File:hFile;
	hFile = fopen("Basic/logs/OOCLog.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}
function AskLog(string[])
{
	new
		entry[ 128 ],
		year,
		month,
		day,
		hour,
		minute,
		second
	;
	getdate(year, month, day);
	gettime(hour, minute, second);

	format(entry, sizeof(entry), "%s | (%d-%d-%d) (%d:%d:%d)\n",string, day, month, year, hour, minute, second);
	new File:hFile;
	hFile = fopen("Basic/logs/AskLog.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}
//==================[ ALL COMMAND HERE DONT REMOVE THIS SECTION ]===============
//==============================[ Stats ]=======================================
CMD:stats(playerid, params[])
{
	ShowStats(playerid, playerid);
	return 1;
}
//==================================[ ahelp ]===================================
CMD:ahelp(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] == 0) return SendClientMessage(playerid, -1,"Kamu bukan lah Staff Kami!");
 	ShowPlayerDialog(playerid, ADMINMENU, DIALOG_STYLE_LIST, "Admin Help","Trial Admin\nJunior Admin\nSenior Admin\nHead Admin\nOwner", "Commands", "Cancel");
	if(PlayerInfo[playerid][pAdmin] >= 1)
 	return 1;
}
//========================================[ Helper Help ]=======================
CMD:hhelp(playerid, params[])
{
 	if(PlayerInfo[playerid][pHelper] == 0) return SendClientMessage(playerid, -1,"Kamu Bukan Admin / Helper!");
 	SendClientMessage(playerid, -1, "____________________________________________________________________");
	if(PlayerInfo[playerid][pHelper] >= 1)
	{
        SendClientMessage(playerid, COLOR_FADE, "Trial Helper: /hc (HelperChat)/goto /hduty ");
    }
   	if(PlayerInfo[playerid][pHelper] >= 2)
	{
        SendClientMessage(playerid, COLOR_FADE, "Junior Helper: /hc (HelperChat /hduty ");
    }
   	if(PlayerInfo[playerid][pHelper] >= 3)
	{
        SendClientMessage(playerid, COLOR_FADE, "Senior Helper:/hc (HelperChat /hduty ");
    }
   	if(PlayerInfo[playerid][pHelper] >= 4)
	{
        SendClientMessage(playerid, COLOR_FADE, "Vice Helper:/hc (HelperChat /hduty ");
    }
   	if(PlayerInfo[playerid][pHelper] >= 5)
	{
        SendClientMessage(playerid, COLOR_FADE, "Lead Of Helper:/hc (HelperChat /hduty ");
	}
 	SendClientMessage(playerid, -1, "____________________________________________________________________");
 	return 1;
}
//====================================[ Help ]==================================
CMD:help(playerid, params[])
{
   	new BigString15[1024];
	strcat( BigString15, "\t\t{00C0FF}Commands List:\t\t\n\n");
	strcat( BigString15, "{FF6347}GENERAL: {FFFFFF}/stats /inv /reportbug /serverstats /tog /call (/p)ickup (/h)angup /buysim /wtc /search /changepass /tabcheck /fuel\n");
	strcat( BigString15, "{FF6347}GENERAL: {FFFFFF}/pay (/un)blindfold (/un)tie /colorcar /paintcar /buy /phonebook /withdraw /deposit /wire /paycheck /id /afkcheck\n");
	strcat( BigString15, "{FF6347}GENERAL: {FFFFFF}/points /speedlimit /helpers /joinevent /quitevent /train /stuck\n");
	strcat( BigString15, "{FF6347}GENERAL: {FFFFFF}/bid /loyal /walkstyle\n");
	strcat( BigString15, "{FF6347}CHAT: {FFFFFF}/newbie /o /b /s /l /w /wt /f /r /d /call /sms /report /helpme /accent\n");
	strcat( BigString15, "{FF6347}INTERACTIONS: {FFFFFF}/me /do /enter /exit /drop /contract /engine /license /showlicense /refer /tow\n");
	strcat( BigString15, "{FF6347}BUSINESS: {FFFFFF}/buybiz /vault /lock /sellbiztomarket\n" );
	strcat( BigString15, "{FF6347}HOUSE: {FFFFFF}/buyhouse /hdeposit /hwithdraw /lock /houseupgrade /sellhousetomarket\n");
	strcat( BigString15, "{FF6347}HELP: {FFFFFF}/animlist /vehhelp /bizhelp /househelp /jobhelp /factionhelp /familyhelp /helperhelp /viphelp /referhelp /cookieshelp\n");
	strcat( BigString15, "{FF6347}HELP: {FFFFFF}/robberyhelp /fishhelp /gatehelp /garagehelp" );
	ShowPlayerDialog(playerid, 1398, DIALOG_STYLE_MSGBOX, "{00C0FF}World Wide Roleplay", BigString15, "OK", "");
	return 1;
}
//==================================[ OOC (Chat) ]==============================
ALTCOMMAND:o->ooc;
CMD:ooc(playerid, params[])
{
	new
		string[ 186 ]
	;
	if((noooc) && PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "OOC Chat closed by administrator!");
	if(isnull(params)) return SendClientMessage(playerid, COLOR_GRAD2, "Bantuan: {FFFFFF}(/o)oc [ooc chat]");

	format(string, sizeof(string), "(( OOC: %s: %s ))", RPName(playerid), params);
	OOCOff(0xCCFFFF00, string);
	OOCLog(string);
	printf("%s", string);
	return 1;
}
//====================================[ B (Chat) ]==============================
CMD:b(playerid, params[])
{
	new
		string[ 128 ]
	;
	if(isnull(params)) return SendClientMessage(playerid, COLOR_GRAD2, "Bantuan: {FFFFFF} /b [ooc chat]");
	format(string, sizeof(string), "(( OOC: %s [ %i ]: %s ))", RPName( playerid ), playerid, params);
	printf("%s", string);
	ProxDetector(30.0, playerid, string, COLOR_FADE,COLOR_FADE,COLOR_FADE,COLOR_FADE,COLOR_FADE);
	return 1;
}
//=================================[ Do (Chat) ]================================
CMD:do(playerid, params[])
{
	new
		result[ 128 ],
		string[ 128 ]
 	;
	if(sscanf(params, "s[128]", result)) return SendClientMessage(playerid, COLOR_GRAD2, "Bantuan: {FFFFFF}/do [action]");
	format(string, sizeof(string), "* %s (( %s ))", result, RPName(playerid));
	ProxDetector(15.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	printf("%s", string);
	return 1;
}
//=================================[ Me (Chat) ]================================
CMD:me(playerid, params[])
{
	new
		result[ 128 ],
		string[ 128 ]
 	;
	if(sscanf(params, "s[128]", result)) return SendClientMessage(playerid, COLOR_GRAD2, "Bantuan: {FFFFFF}/do [action]");
	format(string, sizeof(string), "* %s %s", RPName(playerid), result);
	ProxDetector(15.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	printf("%s", string);
	return 1;
}
//=======================[ Low Chat ]===========================================
CMD:low(playerid, params[])
{
	new
		string[ 128 ]
	;
	if(sscanf(params, "s[128]", params)) return SendClientMessage(playerid, COLOR_WHITE, "Bantuan: (/l)ow [text]");
	if(strlen(PlayerInfo[playerid])) format(string, sizeof(string), "%s (low): %s", RPName(playerid), params);
	ProxDetector(20.0, playerid, string, COLOR_FADE,COLOR_FADE,COLOR_FADE,COLOR_FADE,COLOR_FADE);
	format(string, sizeof(string), "%s (low): %s", RPName(playerid), params);
	printf("%s", string);
	return 1;
}
//==================================[ S (Shout) ]===============================
CMD:s(playerid, params[])
{
	new
		string[ 128 ]
	;
	if(sscanf(params, "s[128]", params)) return SendClientMessage(playerid, COLOR_WHITE, "Bantuan: (/s)hout [text]");
	if(strlen(PlayerInfo[playerid])) format(string, sizeof(string), "%s Shout: %s", RPName(playerid), params);
	ProxDetector(40.0, playerid, string, COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE);
	format(string, sizeof(string), "%s Shout: %s!", RPName(playerid), params);
	printf("%s", string);
	return 1;
}
//=================================[ Accent ]===================================
CMD:accent(playerid, params[])
{
	if(isnull(params)) return SendClientMessage(playerid, COLOR_GRAD1, "Bantuan: {FFFFFF}/accent [russian | italian | germany | japanese | french | spain | china | british | none]");
	if(!strcmp(params,"russian",true))
	{
		PlayerInfo[playerid][pAccent] = 1;
		SendClientMessage(playerid, COLOR_GRAD1, "Your accent is now Russian!");
	}
	else if(!strcmp(params,"italian",true))
	{
		PlayerInfo[playerid][pAccent] = 2;
		SendClientMessage(playerid, COLOR_GRAD1, "Your accent is now Italian!");
	}
	else if(!strcmp(params,"germany",true))
	{
		PlayerInfo[playerid][pAccent] = 3;
		SendClientMessage(playerid, COLOR_GRAD1, "Your accent is now Germany!");
	}
	else if(!strcmp(params,"japanese",true))
	{
		PlayerInfo[playerid][pAccent] = 4;
		SendClientMessage(playerid, COLOR_GRAD1, "Your accent is now Japanese!");
	}
	else if(!strcmp(params,"french",true))
	{
		PlayerInfo[playerid][pAccent] = 5;
		SendClientMessage(playerid, COLOR_GRAD1, "Your accent is now French!");
	}
	else if(!strcmp(params,"spain",true))
	{
		PlayerInfo[playerid][pAccent] = 6;
		SendClientMessage(playerid, COLOR_GRAD1, "Your accent is now Spain!");
	}
	else if(!strcmp(params,"china",true))
	{
		PlayerInfo[playerid][pAccent] = 7;
		SendClientMessage(playerid, COLOR_GRAD1, "Your accent is now China!");
	}
	else if(!strcmp(params,"british", true))
	{
		PlayerInfo[playerid][pAccent] = 8;
		SendClientMessage(playerid, COLOR_GRAD1, "Your accent is now British!");
	}
	else if(!strcmp(params,"none",true))
	{
		PlayerInfo[playerid][pAccent] = 0;
		SendClientMessage(playerid, COLOR_GRAD1, "You removed the accent!");
	}
	else return SendClientMessage(playerid, COLOR_GREY, "Invalid name accent!");
	return 1;
}
//============================[ Give Money ]====================================
CMD:givemoney(playerid, params[])
{
	new targetid,type,string[128];
	if(sscanf(params, "ui", targetid, type)) return SendClientMessage(playerid, COLOR_GRAD2, "Bantuan: {FFFFFF}/givemoney [playerid] [amount]");
	if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, COLOR_GREY, "* This player is not in server..");
	if(type < 0 || type > 99999999) return SendClientMessage(playerid, COLOR_GREY, "* Cannot go under 0 or above 99999999.");
	if(PlayerInfo[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_GRAD1, "Kamu Bukan Staff Kami!");

	GivePlayerCash(targetid, type);
	format(string, sizeof(string),"AdmCmd: %s Memberikan %s %d", RPName( playerid ), RPName( targetid ), type);
	SendAdminMessage(COLOR_YELLOW,string);
	return 1;
}
//===============================[ Helper Chat ]================================
CMD:hc(playerid, params[])
{
    new string[128];
	if(!PlayerInfo[playerid][pHelper] && !PlayerInfo[playerid][pAdmin]) return SendClientMessage(playerid, COLOR_GREY, "Kamu Bukan Bagian Dari Tim Staff Kami");
	if(sscanf(params, "s[128]", params)) return SendClientMessage(playerid, COLOR_WHITE, "Bantuan: (/hc) [text]");
	if(PlayerInfo[playerid][pHelper]) format(string, sizeof(string), "** %s: %s", RPName(playerid), params);
	{
		if(IsPlayerConnected(playerid))
		{
			if(PlayerInfo[playerid][pHelper] || (PlayerInfo[playerid][pAdmin]))
			{
		    	SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			}
		}
	}
	return 1;
}
//================================ [ Admins ]===================================
CMD:admins(playerid, params[])
{
        new sendername[MAX_PLAYER_NAME];
        new string [128];

		if(IsPlayerConnected(playerid))
	    {
			SendClientMessage(playerid, COLOR_GREEN, "___________ |- Online Admins -| ___________");
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
				    if(PlayerInfo[i][pAdmin] >= 1)
				    {
      					GetPlayerName(i, sendername, sizeof(sendername));
           				format(string, 256, " Admins: %s ", sendername);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					}
                    if(PlayerInfo[playerid][pHelper] >= 1)
                    {
                   		 GetPlayerName(i, sendername, sizeof(sendername));
						 format(string, 256, "Helper: %s", sendername);
						 SendClientMessage(playerid, COLOR_GREEN, string);
					}
				}
			}
		}
		SendClientMessage(playerid,COLOR_RED,"No Admin or Helper online in the list");
		SendClientMessage(playerid, COLOR_GREEN, " _______________________________________");
		return 1;
	}
//==========================[ GOTO ]============================================
CMD:goto(playerid, params[])
{
	new playerb, string[128];
	new Float:Pos[3];
	if(!PlayerInfo[playerid][pHelper] && !PlayerInfo[playerid][pAdmin]) return SendClientMessage(playerid, COLOR_GREY, "Kamu Bukan Bagian Dari Tim Staff Kami");
	if(sscanf(params, "u", playerb)) return SendClientMessage(playerid, COLOR_WHITE, "Bantuan: /goto [playerid]");
	if(PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pHelper] < 1)
	{
	    if(!HelpTime[playerb]) return SendClientMessage(playerid, COLOR_GREY, "This player hasn't requested any help.");
	   	if(hPos[playerid][0] == 0 && hPos[playerid][1] == 0 && hPos[playerid][2] == 0 && hPOS[playerid][0] == 0 && hPOS[playerid][0] == 0)
	   	{
		    GetPlayerPos(playerid, hPos[playerid][0], hPos[playerid][1], hPos[playerid][2]);
		    hPOS[playerid][0] = GetPlayerInterior(playerid);
		    hPOS[playerid][1] = GetPlayerVirtualWorld(playerid);
			GetPlayerPos(playerb, Pos[0], Pos[1], Pos[2]);
			SetPlayerPos(playerid, Pos[0]+1, Pos[1], Pos[2]);
			SetPlayerInterior(playerid, GetPlayerInterior(playerb));
			SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(playerb));
			format(string, sizeof(string), " You have teleported to %s.", RPName(playerb));
			SendClientMessage(playerid, COLOR_GREEN, string);
			format(string, sizeof(string), " %s %s has teleported to you.", RPHLN(playerid), RPName(playerid));
			SendClientMessage(playerb, COLOR_GREEN, string);
			format(string, sizeof(string), "Helper: %s has teleported to %s.", RPName(playerid), RPName(playerb));
			SendHelperMessage(COLOR_DARKRED, string);
		}
		else SendClientMessage(playerid, COLOR_GREY, "You must /goback before teleporting to another player.");
		}
		else
		{
		if(Spec[playerb]) return SendClientMessage(playerid, COLOR_GREY, "Player is spectating someone.");
		GetPlayerPos(playerb, Pos[0], Pos[1], Pos[2]);
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
		    SetVehiclePos(GetPlayerVehicleID(playerid), Pos[0]+2, Pos[1]+2, Pos[2]);
		}
		else
		{
		    SetPlayerPos(playerid, Pos[0]+1, Pos[1], Pos[2]);
		}
		SetPlayerInterior(playerid, GetPlayerInterior(playerb));
		SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(playerb));
		format(string, sizeof(string), " You have teleported to %s.", RPName(playerb));
		SendClientMessage(playerid, COLOR_RED, string);
		format(string, sizeof(string), " Administrator %s has teleported to you.", RPName(playerid));
		SendClientMessage(playerb, COLOR_RED, string);
	}
	return 1;
}
//=======================================[ Gethere ]============================
CMD:gethere(playerid, params[])
{
	new playerb, string[128];
	new Float:Pos[3];
    if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_GREY, "Kamu Bukan Bagian Dari Tim Staff Kami");
	if(sscanf(params, "u", playerb)) return SendClientMessage(playerid, COLOR_WHITE, "Bantuan: /goto [playerid]");
	if(PlayerInfo[playerid][pAdmin] < PlayerInfo[playerb][pAdmin]) return SendClientMessage(playerid, COLOR_GREY, "Player has a higher admin level than you.");
    if(Spec[playerb]) return SendClientMessage(playerid, COLOR_GREY, "Player is spectating someone.");
	GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
	if(IsPlayerInAnyVehicle(playerb) && GetPlayerState(playerb) == PLAYER_STATE_DRIVER && !GetPlayerInterior(playerid))
		{
    	SetVehiclePos(GetPlayerVehicleID(playerb), Pos[0]+2, Pos[1]+2, Pos[2]);
		}
		else
		{
	    SetPlayerPos(playerb, Pos[0]+1, Pos[1], Pos[2]);
		}
			SetPlayerInterior(playerb, GetPlayerInterior(playerid));
			SetPlayerVirtualWorld(playerb, GetPlayerVirtualWorld(playerid));
			format(string, sizeof(string), " You have teleported %s to you.", RPName(playerb));
			SendClientMessage(playerid, COLOR_RED, string);
			format(string, sizeof(string), " Kamu Telah Dikirim Ke admin %s.", RPName(playerid));
			SendClientMessage(playerb, COLOR_RED, string);
			return 1;
}
//==================================[ Sendto ]==================================
CMD:sendto(playerid, params[])
{
   	new playerb;
	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_GREY, "Kamu Bukan Bagian Dari Staff Kami");
	if(sscanf(params,"us[32]", playerb, params))
	{
	    SendClientMessage(playerid, COLOR_WHITE, "Bantuan: /sendto [playerid] [place]");
	    SendClientMessage(playerid, COLOR_GREY, "PLACES: ls | dmv | gym | dealership | trucker | productsdropoff | bank | mechanic");
	    return 1;
	}
    if(!strcmp(params, "ls", true))
	{
	    SetPlayerInterior(playerb, 0);
	    SetPlayerVirtualWorld(playerb, 0);
	    SetPlayerPos(playerb,1515.2551,-1666.3148,14.0469);
	    SendClientMessage(playerb, COLOR_WHITE, " Kamu Telah Dikirim Ke Los Santos.");
     	return 1;
	}
	else if(!strcmp(params, "sf", true))
	{
	    SetPlayerInterior(playerb, 0);
	    SetPlayerVirtualWorld(playerb, 0);
	    SetPlayerPos(playerb,-1417.0,-295.8,14.1);
	    SendClientMessage(playerb, COLOR_WHITE, " Kamu Telah Dikirim Ke San Fierro.");
     	return 1;
	}
	else if(!strcmp(params, "lv", true))
	{
	    SetPlayerInterior(playerb, 0);
	    SetPlayerVirtualWorld(playerb, 0);
	    SetPlayerPos(playerid,1699.2,1435.1, 10.7);
	    SendClientMessage(playerb, COLOR_WHITE, " Kamu Telah Dikirim Ke Las Venturas.");
     	return 1;
	}
	else if(!strcmp(params, "dmv", true))
	{
	    SetPlayerInterior(playerb, 0);
	    SetPlayerVirtualWorld(playerb, 0);
	    SetPlayerPos(playerb,2058.6326,-1914.0176,13.5469);
	    SendClientMessage(playerb, COLOR_WHITE, " Kamu Telah Dikirim Ke DMV.");
     	return 1;
	}
	else if (!strcmp(params,"area51",true))
	{
            SetPlayerInterior(playerb, 0);
	        SetPlayerVirtualWorld(playerb, 0);
		    SetPlayerPos(playerb,202.1886,1881.4122,17.2199);
		    SendClientMessage(playerb, COLOR_WHITE, " Kamu Telah Dikirim Ke area51.");
	}
	else if(!strcmp(params, "gym", true))
	{
	    SetPlayerInterior(playerb, 0);
	    SetPlayerVirtualWorld(playerb, 0);
	    SetPlayerPos(playerb,2224.8137,-1723.4457,13.5625);
	    SendClientMessage(playerb, COLOR_WHITE, " Kamu Telah Dikirim Ke Gym.");
     	return 1;
	}
	else if(!strcmp(params, "dealership", true))
	{
	    SetPlayerInterior(playerb, 0);
	    SetPlayerVirtualWorld(playerb, 0);
	    SetPlayerPos(playerb,546.1611,-1273.8046,17.2482);
	    SendClientMessage(playerb, COLOR_WHITE, " YKamu Telah Dikirim Ke Dealership.");
     	return 1;
	}
	else if(!strcmp(params, "trucker", true))
	{
	    SetPlayerInterior(playerb, 0);
	    SetPlayerVirtualWorld(playerb, 0);
	    SetPlayerPos(playerb,1-520.4179,-505.3250,24.6084);
	    SendClientMessage(playerb, COLOR_WHITE, " Kamu Telah Dikirim Ke Trucker Job.");
     	return 1;
	}
	else if(!strcmp(params, "productsdropoff", true))
	{
	    SetPlayerInterior(playerb, 0);
	    SetPlayerVirtualWorld(playerb, 0);
	    SetPlayerPos(playerb,2222.5107,-2682.7368,13.5409);
	    SendClientMessage(playerb, COLOR_WHITE, " Kamu Telah Dikirim Ke Products Dropoff.");
     	return 1;
	}
	else if(!strcmp(params, "mechanic", true))
	{
	    SetPlayerInterior(playerb, 0);
	    SetPlayerVirtualWorld(playerb, 0);
	    SetPlayerPos(playerb,2330.0693,-2315.4709,13.5469);
	    SendClientMessage(playerb, COLOR_WHITE, " Kamu Telah Dikirim Ke Mechanic Job.");
     	return 1;
	}
	else if(!strcmp(params, "bank", true))
	{
	    SetPlayerInterior(playerb, 0);
	    SetPlayerVirtualWorld(playerb, 0);
	    SetPlayerPos(playerb,1462.4095,-1011.1602,26.8438);
	    SendClientMessage(playerb, COLOR_WHITE, " Kamu Telah Dikirim Ke Bank.");
     	return 1;
	}
	return 1;
}
/*----------------------------------[No OOC]----------------------------------*/
CMD:noooc(playerid, params[])
	{
	    if(IsPlayerConnected(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= 1 && (!noooc))
			{
				noooc = 1;
				BroadCast(COLOR_RED, "   OOC chat channel Telah Dimatikan Oleh Admin !");
			}
			else if (PlayerInfo[playerid][pAdmin] >= 2 && (noooc))
			{
				noooc = 0;
				BroadCast(COLOR_GREEN, "   OOC chat channel Telah Di Aktifkan Oleh Admin !");
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD1, "   Kamu Tidak Di ijinkan menggunakan Perintah Ini!");
			}
		}
		return 1;
	}
//----------------------------[ nonewbie ]---------------------------
CMD:noask(playerid, params[])
	{
	    if(IsPlayerConnected(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= 2 && (!nonewbie))
			{
				nonewbie = 1;
				BroadCast(COLOR_GRAD2, "   Ask chat channel Telah Dimatikan Oleh Admin!");
			}
			else if (PlayerInfo[playerid][pAdmin] >= 2 && (nonewbie))
			{
				nonewbie = 0;
				BroadCast(COLOR_GRAD2, "   Ask chat channel Telah Di Aktifkan Oleh Admin!");
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD1, "   Kamu Tidak Di ijinkan menggunakan Perintah Ini!");
			}
		}
		return 1;
	}
//------------------------------[ ASK ]----------------------------------------
CMD:ask(playerid, params[])
{
	new
		string [ 186 ]
	;
	if ((nonewbie) && PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Ask Chat closed by administrator!");
	if(isnull(params)) return SendClientMessage(playerid, COLOR_WHITE, "Bantuan: {FFFFFF}(/ask)ing [Untuk Bertanya]");
	format(string, sizeof(string), "[ASK]: %s[%i]: %s ", RPName(playerid), playerid, params);
	SendClientMessageToAll(COLOR_GREEN, "** Untuk Menjawab Pertanyaan, /pm [ID] [Answer]");
	AskOff(0xCCFFFF00, string);
	AskLog(string);
	printf("%s",string);
	return 1;
}
 //----------------------------------[Helper Duty]---------------------------------------------
new gmodName[MAX_PLAYER_NAME];
CMD:hduty(playerid, params[])
{
    new
		string [ 186 ]
	;
 	if(IsPlayerConnected(playerid))
        {
               if(PlayerInfo[playerid][pHelper] >= 1)
            {
                if(PlayerInfo[playerid][pHelperDuty] == 0)
                {
                    SetPlayerColor(playerid, COLOR_GREEN);
                    PlayerInfo[playerid][pHelperDuty] = 1;
                    format(string, sizeof(string), "%s is Sedang Bekerja sebagai Admin. /helpme to get help.", gmodName);
                    SetPlayerHealth(playerid, 1000);
                    SetPlayerArmour(playerid, 1000);
                    SendClientMessageToAll(COLOR_GREEN, string);
                    return 1;
                }
                else
                {
                    SetPlayerColor(playerid, COLOR_INVIS);
                    PlayerInfo[playerid][pHelperDuty] = 0;
                    format(string, sizeof(string), "%s Sudah Tidak bekerja lagi sebagai Helper.", gmodName);
                    SetPlayerHealth(playerid, 100);
                    SetPlayerArmour(playerid, 0);
                    SendClientMessageToAll(COLOR_GREEN, string);
                    return 1;
                }
            }
        }
     }
 //----------------------------------[Admin Duty]---------------------------------------------
new amodName[MAX_PLAYER_NAME];
CMD:aduty(playerid, params[])
{
    new
		string [ 186 ]
	;
 	if(IsPlayerConnected(playerid))
        {
               if(PlayerInfo[playerid][pAdmin] >= 1)
            {
                if(PlayerInfo[playerid][pAdminDuty] == 0)
                {
                    SetPlayerColor(playerid, COLOR_RED);
                    PlayerInfo[playerid][pAdminDuty] = 1;
                    format(string, sizeof(string), "%s Sejak Bekerja sebagai Admin /helpme to get help.", amodName);
                    SetPlayerHealth(playerid, 1000);
                    SetPlayerArmour(playerid, 1000);
                    SendClientMessageToAll(COLOR_RED, string);
                    return 1;
                }
                else
                {
                    SetPlayerColor(playerid, COLOR_INVIS);
                    PlayerInfo[playerid][pAdminDuty] = 0;
                    format(string, sizeof(string), "%s Sudah Tidak bekerja lagi sebagai Admin.", amodName);
                    SetPlayerHealth(playerid, 100);
                    SetPlayerArmour(playerid, 0);
                    SendClientMessageToAll(COLOR_RED, string);
                    return 1;
                }
            }
        }
     }

//====================== [Private Message ]=====================================
CMD:pm(playerid, params[])
{
    new str[256], str2[256], id, Name1[MAX_PLAYER_NAME], Name2[MAX_PLAYER_NAME];
    if(sscanf(params, "us", id, str2))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Bantuan: /pm <id> <message>");
        return 1;
    }
    if(!IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_YELLOW, "ERROR: Player is not connected.");
    if(playerid == id) return SendClientMessage(playerid, COLOR_YELLOW, "ERROR: You can't pm yourself.");
    {
        GetPlayerName(playerid, Name1, sizeof(Name1));
        GetPlayerName(id, Name2, sizeof(Name2));
        format(str, sizeof(str), "PM to %s (ID: %d): %s", Name2, id, str2);
        SendClientMessage(playerid, COLOR_YELLOW, str);
        format(str, sizeof(str), "PM from %s (ID: %d): %s", Name1, playerid, str2);
        SendClientMessage(id, COLOR_YELLOW, str);
    }
    return 1;
}
//===================== [ Helpme For Helper Command Respone] ===================
CMD:helpme(playerid, params[])
{
	new message[1024], string[1024], playername[MAX_PLAYER_NAME];
	if(sscanf(params, "s", message)) return SendClientMessage(playerid, COLOR_RED, "[Helpme]{FFFFFF} Bantuan: /helpme [Pertanyaan]");
	GetPlayerName(playerid, playername, sizeof(playername));
	format(string, sizeof(string), "Pertanyaan Kamu: %s", message);

	SendClientMessage(playerid, COLOR_GREEN, "===========================");
	SendClientMessage(playerid, COLOR_GREEN, "Permintaan kamu akan kami kirim ke staff yang sedang bekerja.");
	SendClientMessage(playerid, COLOR_GREEN, "Jangan Menggulangi Perintah /helpme - Akan ada saksi tegas untuk hal ini.");
	SendClientMessage(playerid, COLOR_GREEN, string);
    SendClientMessage(playerid, COLOR_GREEN, "===========================");

    new temp[1024];
	format(temp, sizeof(temp), "[STAFF ON DUTY PLEASE RESPONE]{FFFFFF} Player name: %s(%i)  - Pertanyaan: %s", playername, playerid, message);
	SendAdminMessage(COLOR_GREEN, "======[Seseorang telah bertanya - Untuk melihat Informasi dan segera merespon]======");
	SendAdminMessage(COLOR_GREEN, temp);
    SendAdminMessage(COLOR_GREEN, "===========================");

	return 1;
}
CMD:time(playerid,params[])
{
	#pragma unused params
	new string[64];
	new hour,minuite,second;
	gettime(hour,minuite,second);
	format(string, sizeof(string), "~g~|~w~%d:%d~g~|", hour, minuite);
	return GameTextForPlayer(playerid, string, 5000, 1);
}
CMD:fix(playerid,params[])
{
	#pragma unused params
 	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		if (IsPlayerInAnyVehicle(playerid))
		{
			SetVehicleHealth(GetPlayerVehicleID(playerid),1250.0);
			return SendClientMessage(playerid,COLOR_BLUE,"|- Mobil Telah diperbaiki! -|");
		}
		else return ErrorMessages(playerid, 10);
	}
	else return ErrorMessages(playerid, 8);
}
CMD:tog(playerid, params[])
{
	new string[128];
	if(!IsPlayerConnected(playerid)) return SendClientMessage(playerid, COLOR_GREY, "You need to login first before using any command.");
	if(sscanf(params, "s[16]", params))
	{
	    SendClientMessage(playerid, COLOR_WHITE, "Bantuan: /tog [option]");
	    SendClientMessage(playerid, COLOR_GREY, "Pilihan: fuel | speedo | phone | vip | join | oldskool | loyal");
	    if(PlayerInfo[playerid][pAdmin]) SendClientMessage(playerid, COLOR_GREY, "Pilihan: adminooc | adminnewbie | betachat");
	    return 1;
	}
	if(!strcmp(params, "speedo", true))
	{
		if(!PlayerInfo[playerid][pSpeedo]) return SendClientMessage(playerid, COLOR_GREY, "Kamu tidak memiliki speedometer.");
		if(!Speedo[playerid])
		{
		    Speedo[playerid] = 1;
		    format(string, sizeof(string), "Kamu mematikan speedometer {33AA33}on{33CCFF}.");
		    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
		}
	}
	return 1;
}

CMD:pay(playerid, params[])
{
	new string[128], playerb, amount;
   	if(!IsPlayerConnected(playerid)) return SendClientMessage(playerid, COLOR_GREY, "Kamu Harus Masuk ke Dalam Game Dulu Untuk Menggunakan Perintah ini.");
	if(sscanf(params, "ui", playerb, amount)) return SendClientMessage(playerid, COLOR_WHITE, "Bantuan: /pay [playerid] [amount]");
	if(amount <= 0) return SendClientMessage(playerid, COLOR_GREY, "Invalid money amount.");
	if(amount > 2000 && PlayerInfo[playerid][pLevel] < 4) return SendClientMessage(playerid, COLOR_GREY, "Kamu Harus Level 3 Untuk memberikan lebih dari $2000.");
	if(playerid == playerb) return SendClientMessage(playerid, COLOR_GREY, "You can't pay money to yourself.");
	if(!IsPlayerConnected(playerb)) return SendClientMessage(playerid, COLOR_GREY, "Invalid player id.");
	if(PlayerInfo[playerid][pLevel] < 2) return SendClientMessage(playerid, COLOR_GREY, "Kamu harus level 2 Untuk memberikan uang kepada seseorang.");
	if(!IsPlayerNearPlayer(playerid, playerb, 2)) return SendClientMessage(playerid, COLOR_GREY, "Kamu terlalu jauh dari orang tersebut.");
	if(PlayerInfo[playerid][pCash] < amount) return SendClientMessage(playerid, COLOR_GREY, "Kamu tidak memiliki cukup uang untuk melakukan ini.");
	format(string, sizeof(string), "* %s Mengeluarkan dompet dan memberikannya %s beberapa rupiah.", RPName(playerid), RPName(playerb), amount);
	ProxDetector(30.0, playerid, string, COLOR_FADE,COLOR_FADE,COLOR_FADE,COLOR_FADE,COLOR_FADE);
	format(string, sizeof(string), " You have given %s $%d.", RPName(playerb), amount);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	format(string, sizeof(string), " %s Telah Memberikanmu $%d.", RPName(playerid), amount);
	SendClientMessage(playerb, COLOR_LIGHTBLUE, string);
	format(string, sizeof(string), "%s Telah Memberikan %s $%d.",RPName(playerid), RPName(playerb), amount);
	return 1;
}
