while true; do
sudo service redis-server start
	lua bot.lua
	sleep 5s
done