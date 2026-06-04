#if [ -z "$1" ]; then
#    patch_mode="full"
#fi


if [ -d "/tmp/patchs-sm8250" ]; then
    rm -rf /tmp/patchs-sm8250
fi

current_dir=$(dirname "$(readlink -f "$0")")
#current_dir=$(pwd)

git clone --depth=1 https://github.com/zicstardust/patchs-sm8250.git /tmp/patchs-sm8250

cd kernel/samsung/sm8250

curl -LSs "https://raw.githubusercontent.com/KernelSU-Next/KernelSU-Next/next/kernel/setup.sh" | bash -s legacy

git apply < /tmp/patchs-sm8250/patches/kernel_kernelsu.patch
git apply < /tmp/patchs-sm8250/patches/kernel_droidspaces.patch

cp /tmp/patchs-sm8250/configs/*.config arch/arm64/configs/

cd KernelSU-Next

git apply < /tmp/patchs-sm8250/patches/kernelsu-next.patch

cd "$current_dir/device/samsung/sm8250-common"

git apply < /tmp/patchs-sm8250/patches/device.patch

cd "$current_dir"