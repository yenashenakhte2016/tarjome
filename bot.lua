local redis = (loadfile "./libs/redis.lua")()
local token = arg[1] or "262840672:AAFFA8Gq5cXfjTTsdHoa6yH4LyM6GPxnaCI"
local bot, extension = require("lua-bot-api").configure(token)
extension.onInlineQueryReceive = function (qmsg)
	local photo1_url = 'http://s6.uplod.ir/i/00803/o3ykmq6a0d9b.jpg'
	local qresult = {}
	qresult.id= qmsg.id
	qresult.title='لینک شما'
	qresult.type = 'article'
	qresult.description = 'فرستادن لینک دعوت شما...'
	qresult.thumb_url = photo1_url
	qresult.message_text = ("🚫 شما هنوز در ربات عضو نیستید برای عضویت در pv ربات start/ را ارسال کنید")
	local chash = 'cuser:'..qmsg.from.id
	local hash = 'juser:'..qmsg.from.id
	if redis:get(hash) then
	if redis:get(chash) then
    qresult.message_text = "💢لینک معرفی:\nhttps://telegram.me/CreatorGroupSecurityBot?start="..qmsg.from.id.."\n\n💢 اعتبار:"..redis:get(chash).."\n\nوقتی که ۲۰ نفر توسط شما دعوت بشن میتونی گروه رایگانتو هر زمانی که بخوای بسازی\n\nدر ضمن هروقت یه نفر توسط شما دعوت بشه منم بهت همون موقع اطلاع میدم❗️زود باش لینک رو به دوستات بده...\n\nحتما باید ۲۰ نفر با لینک تو داخل ربات عضو بشن(فقط ارسال به ۲۰ نفر کافی نیست)"
	else
	redis:set(chash,0)
	qresult.message_text = "💢لینک معرفی:\nhttps://telegram.me/CreatorGroupSecurityBot?start="..qmsg.from.id.."\n\n💢 اعتبار:"..redis:get(chash).."\n\nوقتی که ۲۰ نفر توسط شما دعوت بشن میتونی گروه رایگانتو هر زمانی که بخوای بسازی\n\nدر ضمن هروقت یه نفر توسط شما دعوت بشه منم بهت همون موقع اطلاع میدم❗️زود باش لینک رو به دوستات بده...\n\nحتما باید ۲۰ نفر با لینک تو داخل ربات عضو بشن(فقط ارسال به ۲۰ نفر کافی نیست)"
end
end
    local res = bot.answerInlineQuery(qmsg.id, qresult)
    end
-- override onMessageReceive function so it does what we want
extension.onMessageReceive = function (msg)
	print("پیام تازه از طرف: " .. msg.from.first_name.."\nپیام:\n"..msg.text)
		if string.match(msg.text, "^/start (.*)$") then
		local hash = 'juser:'..msg.from.id
		local fhash = 'juser:'..string.sub(msg.text, 8)
		local fchash = 'cuser:'..string.sub(msg.text, 8)
		local chash = 'cuser:'..msg.from.id
		if not redis:get(hash) then
    	redis:set(hash,true)
    	redis:set(chash,0)
 local ahash = 'tiagoh:users'
        redis:hset(ahash, msg.from.id, 'newuser')
    	bot.sendMessage(msg.chat.id, "سلام "..msg.from.first_name.."\nبا من میتونی بی نهایت گروه رایگان با ربات @GroupSecurityBot بگیری\n\nهیچ کاری نداره، تو فقط باید این لینکی رو که پایین میدم رو به دوستات بدی تا من با اونها از طریق تو آشنا شم.\n\n💢لینک معرفی:\nhttps://telegram.me/CreatorGroupSecurityBot?start="..msg.from.id.."\n\n🔥وقتی که ۲۰ نفر توسط شما دعوت بشن میتونی گروه رایگانتو هر زمانی که بخوای بسازی🔥\n\nدر ضمن هروقت یه نفر توسط شما دعوت بشه منم بهت همون موقع اطلاع میدم\n\n💥لیست دستورات اصلی:\n/creategp - ساخت گروه\n/mylink - نمایش لینک معرفی شما\n\n❗️زود باش لینک رو به دوستات بده...\n\nحتما باید ۲۰ نفر با لینک تو داخل ربات عضو بشن(فقط ارسال به ۲۰ نفر کافی نیست)")
    	if redis:get(fhash) then
    	redis:incr(fchash)
    	bot.sendMessage(msg.chat.id, " به دوست شما برای ورود شما یک امتیاز داده شد :|")
    	bot.sendMessage(string.sub(msg.text, 8) , "تبریک،یک نفر از طرف شما وارد ربات شد و به اعتبار شما یک عضو افزوده شد")
	else 
		bot.sendMessage(msg.chat.id, "کد دعوت واردشده اشتباه است ولی به هرحال برای شما مشکلی وجود ندارد:)")
	end
else
			bot.sendMessage(msg.chat.id, "⁉️شما فقط میتوانید یک نفر را دعوت کنید")
end
elseif string.match(msg.text, "^[!/#]users$") then
		 if msg.from.username == 'DevMohammad' then
 local ahash = 'tiagoh:users'
local names = redis:hkeys(ahash)
    local text = 'لیست کاربران بات :\n\n'
    for i=1, #names do
      text = text..'> '..names[i]..'\n'
    end
    	bot.sendMessage(msg.from.id, text)
end
	elseif string.match(msg.text, "^[!/#]mylink$") or msg.text == 'لینک من' then
		local chash = 'cuser:'..msg.from.id
		local hash = 'juser:'..msg.from.id
		if redis:get(hash) then
		if redis:get(chash) then
    	bot.sendMessage(msg.chat.id, "💢لینک معرفی:\nhttps://telegram.me/CreatorGroupSecurityBot?start="..msg.from.id.."\n\n💢 اعتبار:"..redis:get(chash).."\n\nوقتی که ۲۰ نفر توسط شما دعوت بشن میتونی گروه رایگانتو هر زمانی که بخوای بسازی\n\nدر ضمن هروقت یه نفر توسط شما دعوت بشه منم بهت همون موقع اطلاع میدم❗️زود باش لینک رو به دوستات بده...\n\nحتما باید ۲۰ نفر با لینک تو داخل ربات عضو بشن(فقط ارسال به ۲۰ نفر کافی نیست)")
	    else
		redis:set(chash,0)
		bot.sendMessage(msg.chat.id, "💢لینک معرفی:\nhttps://telegram.me/creatorGroupsecurityBot?start="..msg.from.id.."\n\n💢 اعتبار:"..redis:get(chash).."\n\nوقتی که ۲۰ نفر توسط شما دعوت بشن میتونی گروه رایگانتو هر زمانی که بخوای بسازی\n\nدر ضمن هروقت یه نفر توسط شما دعوت بشه منم بهت همون موقع اطلاع میدم❗️زود باش لینک رو به دوستات بده...\n\nحتما باید ۲۰ نفر با لینک تو داخل ربات عضو بشن(فقط ارسال به ۲۰ نفر کافی نیست)")
		end
		end
    	elseif string.match(msg.text, "^[!/#]start$") then
		local hash = 'juser:'..msg.from.id
		local chash = 'cuser:'..msg.from.id
		if not redis:get(hash) then
    	redis:set(hash,true)
    	redis:set(chash,0)
local ahash = 'tiagoh:users'
    redis:hset(ahash, msg.from.id, 'newuser')
    	bot.sendMessage(msg.chat.id, "سلام "..msg.from.first_name.." \nبا من میتونی تعداد نامحدود گروه ضد اسپم با ربات @GroupSecurityBot دریافت کنی\n\nهیچ کاری نداره، تو فقط باید این لینکی رو که پایین میدم رو به دوستات بدی تا من با اونها از طریق تو آشنا شم.\n\n💢لینک معرفی:\nhttps://telegram.me/GroupSecurityBot?start="..msg.from.id.."\n\nوقتی 20 نفر آوردی میتونی هر وقت خواستی گروه رایگانتو بگیری\n\nدر ضمن هروقت یه نفر توسط شما دعوت بشه منم بهت همون موقع اطلاع میدم\n\n💥لیست دستورات اصلی:\n/creategp - ساخت گروه\n/mylink - نمایش لینک معرفی شما\n\n❗️زود باش لینک رو به دوستات بده...\n\nحتما باید ۲۰ نفر با لینک تو داخل ربات عضو بشن(فقط ارسال به ۲۰ نفر کافی نیست)")
	    else
		bot.sendMessage(msg.chat.id, "سلام "..msg.from.first_name.."\nقبلا یکبار عضو شدی ها☹️")
	end
		elseif string.match(msg.text, "^[!#/]creategp (.*)$") then
		local chash = 'cuser:'..msg.from.id
		local hash = 'juser:'..msg.from.id
		if redis:get(hash) then
			if tonumber(redis:get(chash)) >= 20 then
		redis:set(chash,tonumber(redis:get(chash)) - 20)
		bot.sendMessage(-101134339, "/cgp "..msg.from.id.." "..string.sub(msg.text, 11))
		bot.sendMessage(msg.chat.id, '👏گروه "'..string.sub(msg.text, 11)..'" ساخته شد و 20 عضو از اعتبار شما کسر شد و شما با موفقیت در ان عضو شده به صاحب گروه ارتقا پیدا کردید\n‼️اگر مشکلی در هنگام کار پیش امد لطفا از صفحه اسکرین شات گرفته و به:\n@MutePukerBot👈\nبفرستید🤗')
			else
		bot.sendMessage(msg.chat.id,"🚫 شما اعتبار کافی ندارید\n\n💢لینک معرفی:\nhttps://telegram.me/CreatorGroupSecurityaBot?start="..msg.from.id.."\n\n💢 اعتبار:"..redis:get(chash).."\n\n🔥وقتی که ۲۰ نفر توسط شما دعوت بشن میتونی گروه رایگانتو هر زمانی که بخوای بسازی🔥\n\nدر ضمن هروقت یه نفر توسط شما دعوت بشه منم بهت همون موقع اطلاع میدم❗️زود باش لینک رو به دوستات بده...\n\nحتما باید ۲۰ نفر با لینک تو داخل ربات عضو بشن(فقط ارسال به ۲۰ نفر کافی نیست)")
	end
	end
		elseif string.match(msg.text, "^[!#/]creategp$") then
		bot.sendMessage(msg.chat.id, "🚫 لطفا اسم گروه را  به درستي وارد نماييد.")
	end
end

-- This runs the internal update and callback handler
-- you can even override run()
extension.run()