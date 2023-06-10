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

:: Install Oxide
curl -L https://umod.org/games/rust/download?tag=public -o oxide.zip
tar -xf oxide.zip -C server
del oxide.zip

:: Install Oxide RustEdit Extension
curl -L https://raw.githubusercontent.com/k1lly0u/Oxide.Ext.RustEdit/master/Oxide.Ext.RustEdit.dll -o server/RustDedicated_Data\Managed/Oxide.Ext.RustEdit.dll

:: Start rust
cd server
RustDedicated.exe ^
-batchmode ^
+server.port 28015 ^
+rcon.port 28016 ^
+server.level "Procedural Map" ^
+server.maxplayers 10 ^
+server.seed 1027749846 ^
 +server.worldsize 3500 ^
+server.hostname "Rust test server" ^
+server.description "Description shown on server connection window." ^
+server.url "http://yourwebsite.com" ^
+server.headerimage "http://yourwebsite.com/serverimage.jpg" ^
+server.identity "server1" ^
+rcon.password letmein ^
+rcon.web 1