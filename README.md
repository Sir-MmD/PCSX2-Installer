# 🎮PCSX2-Installer
![App Screenshot](https://raw.githubusercontent.com/Sir-MmD/PCSX2-Installer/refs/heads/main/banner.png)
## What does this script do?
This script aims to set up PCSX2 (PlayStation 2 Emulator) faster and more simply.

Simply execute the script and wait until it finishes.

## 🎬Installation Tutorial
https://www.youtube.com/watch?v=INGQxIoP3Ds

## 📀Download Games
Once the script has finished the installation, you can now download your PS2 game ROM from the internet or use one from the list below:

- https://romsfun.com/roms/playstation-2/
- https://www.emulatorgames.net/roms/playstation-2/
- https://coolrom.com.au/roms/ps2/
- https://cdromance.org/ps2-iso/
- https://www.romsgames.net/roms/playstation-2/
- https://vimm.net/vault/PS2
- https://www.romspedia.com/roms/playstation-2

After downloading, place the ".iso" file of the ROM inside the "PCSX2/ROM" folder:

![App Screenshot](https://raw.githubusercontent.com/Sir-MmD/PCSX2-Installer/refs/heads/main/ROM.png)

## 🛠Custom Texture
You can download custom texture packs from websites like https://gbatemp.net and place them inside the "PCSX2/TEXTURE" folder:

![App Screenshot](https://raw.githubusercontent.com/Sir-MmD/PCSX2-Installer/refs/heads/main/TEXTURE.png)

## 🖼Game Covers
![cover](https://raw.githubusercontent.com/Sir-MmD/PCSX2-Installer/refs/heads/main/cover.gif)

### Normal Covers:
```python
https://raw.githubusercontent.com/xlenore/ps2-covers/main/covers/default/${serial}.jpg
```
### 3D Covers:
```python
https://raw.githubusercontent.com/xlenore/ps2-covers/main/covers/3d/${serial}.png
```
Copy one of the Normal or 3D links and paste it in Tools -> Cover Downloader, then press Start

## ⚙️Default Settings
This script sets the upscale resolution to "4K (2160p)" by default and "16x" for anisotropic filtering. You can modify these settings in Settings -> Graphics -> Rendering

The FPS counter can also be disabled in Settings -> Graphics -> OSD

Theme of the PCSX2 is set to "Ruby". You can select other themes in Settings -> Interface -> Theme
## ℹ️More Info
This script places all data inside the PCSX2 folder, which means you can also use it as a portable solution for PCSX2.

If you move the PCSX2 folder after the installation, you should execute "Reconfig_Paths.bat" to fix the path variables inside Documents/USER/PCSX2/inis/PCSX2.ini

## ©️CopyRight
#### PCSX2: https://github.com/PCSX2/pcsx2
#### PS2-Cover: https://github.com/xlenore/ps2-covers
#### 7zip: https://www.7-zip.org
