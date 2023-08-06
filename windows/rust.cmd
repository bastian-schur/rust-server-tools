:: GPL-3.0 license | https://github.com/bastian-schur/rust-server-tools

:: Create folders
IF NOT EXIST "server" (
	mkdir "server"
)
IF NOT EXIST "steamcmd" (
	mkdir "steamcmd"
)

:: Install Steam CMD
IF NOT EXIST "steamcmd/steamcmd.exe" (
	curl -L https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip -o steamcmd.zip
	tar -xf steamcmd.zip
	del steamcmd.zip
	move steamcmd.exe steamcmd/
)

:: Install/Update Rust
cd steamcmd
steamcmd.exe +login anonymous +force_install_dir "%CD%/../server" +app_update 258550 +quit
cd ../

:: Install carbon
curl -L https://github.com/CarbonCommunity/Carbon.Core/releases/download/production_build/Carbon.Windows.Release.zip -o carbon.zip
tar -xf carbon.zip -C server
::del carbon.zip

:: Start rust
cd server
RustDedicated.exe ^
-batchmode ^
+server.port 28015 ^
+rcon.port 28016 ^
+server.level "Procedural Map" ^
+server.maxplayers 10 ^
+server.seed 1027749846
+server.worldsize 3500
+server.hostname "CR-TestServer" ^
+server.description "Description shown on server connection window." ^
+server.url "http://yourwebsite.com" ^
+server.headerimage "http://yourwebsite.com/serverimage.jpg" ^
+server.identity "server1" ^
+rcon.password letmein ^
+rcon.web 1
