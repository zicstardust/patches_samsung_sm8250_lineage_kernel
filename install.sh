if [ -z "$1" ]; then
    patches="all"
else
    patches="$1"
fi

if [ "$patches" != "all" ] && [ "$patches" != "kernelsu-next" ] && [ "$patches" != "droidspaces" ]; then
    echo "Usage: $0 [all|kernelsu-next|droidspaces]"
    exit 1
fi

if [ -d "/tmp/zic-patchs-sm8250" ]; then
    rm -rf /tmp/zic-patchs-sm8250
fi

git clone --depth=1 https://github.com/zicstardust/patches_samsung_sm8250_lineage_kernel.git /tmp/zic-patchs-sm8250 -b lineage-23.2

cd kernel/samsung/sm8250

if [ "$patches" = "all" ] || [ "$patches" = "droidspaces" ]; then
    echo "Applying DroidSpaces kernel patches..."
    cp /tmp/zic-patchs-sm8250/configs/droidspaces.config arch/arm64/configs/
    cp /tmp/zic-patchs-sm8250/configs/droidspaces-additional.config arch/arm64/configs/
    git apply --whitespace=fix < /tmp/zic-patchs-sm8250/patches/kernel_droidspaces.patch
fi

if [ "$patches" = "all" ] || [ "$patches" = "kernelsu-next" ]; then
    echo "Applying KernelSU-Next kernel patches..."
    cp /tmp/zic-patchs-sm8250/configs/kernelsu-next.config arch/arm64/configs/
    curl -LSs "https://raw.githubusercontent.com/KernelSU-Next/KernelSU-Next/next/kernel/setup.sh" | bash -s legacy
    git apply --whitespace=fix < /tmp/zic-patchs-sm8250/patches/kernel_kernelsu.patch
    echo "Applying KernelSU-Next module patches..."
    cd KernelSU-Next
    git apply --whitespace=fix < /tmp/zic-patchs-sm8250/patches/kernelsu-next.patch
fi

cd "$current_dir/device/samsung/sm8250-common"

if [ "$patches" = "all" ]; then
    echo "Applying device patches..."
    git apply --whitespace=fix < /tmp/zic-patchs-sm8250/patches/device_all.patch
elif [ "$patches" = "droidspaces" ]; then
    echo "Applying DroidSpaces device patches..."
    git apply --whitespace=fix < /tmp/zic-patchs-sm8250/patches/device_droidspaces.patch
elif [ "$patches" = "kernelsu-next" ]; then
    echo "Applying KernelSU-Next device patches..."
    git apply --whitespace=fix < /tmp/zic-patchs-sm8250/patches/device_kernelsu-next.patch
fi

rm -rf /tmp/zic-patchs-sm8250

cd "$current_dir"