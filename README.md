# Patches Kernel Samsung SM8250 LineageOS

- Include KernelSU-Next (legacy non-gki)
- Droidspaces support (LXC containers)

## Requirements
- Device with LineageOS 23.2 installed.
- LineageOS build environment

## How to use

- Configure the LineageOS build environment for your device. [Example for r8q](https://wiki.lineageos.org/devices/r8q/build/variant1/).

- Go to the root directory of the LineageOS build environment (default: `$HOME/android/lineage`)

- Apply the patches from this repository.

```bash
curl https://raw.githubusercontent.com/zicstardust/patches_samsung_sm8250_lineage_kernel/lineage-23.2/install.sh | bash
```

### Build the kernel

Start build environment:

```bash
cd $HOME/android/lineage
source build/envsetup.sh
mkdir -p $HOME/.ccache
export CCACHE_DIR=$HOME/.ccache
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
croot
breakfast <DEVICE_CODINAME>
```

Build:

```bash
m bootimage
```
If everything goes well, the kernel image will be available in `$HOME/android/lineage/out/target/product/<device>/boot.img`


### Install kernel

Connect the device via USB with USB debugging enabled.

Reboot into fastbootd mode:

```bash
adb reboot fastboot
```

Flash the compiled kernel:
```bash
fastboot flash boot boot.img
```

Restart your device:

```bash
fastboot reboot
```

Install the droidspaces and kernelSU-next apks:

[droidspaces apk](https://github.com/ravindu644/Droidspaces-OSS/releases/latest)

[KernelSU-next apk](https://github.com/KernelSU-Next/KernelSU-Next/releases/latest)

