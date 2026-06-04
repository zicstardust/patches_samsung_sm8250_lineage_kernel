if [ -d "/tmp/zic-patchs-sm8250" ]; then
    rm -rf /tmp/zic-patchs-sm8250
fi

current_dir=$(dirname "$(readlink -f "$0")")

git clone --depth=1 https://github.com/zicstardust/patches_samsung_sm8250_lineage_kernel.git /tmp/zic-patchs-sm8250 -b lineage-23.2

cd kernel/samsung/sm8250

curl -LSs "https://raw.githubusercontent.com/KernelSU-Next/KernelSU-Next/next/kernel/setup.sh" | bash -s legacy

git apply --whitespace=fix < /tmp/zic-patchs-sm8250/patches/kernel_kernelsu.patch
git apply --whitespace=fix < /tmp/zic-patchs-sm8250/patches/kernel_droidspaces.patch

cp /tmp/zic-patchs-sm8250/configs/*.config arch/arm64/configs/

cd KernelSU-Next

git apply --whitespace=fix < /tmp/zic-patchs-sm8250/patches/kernelsu-next.patch

cd "$current_dir/device/samsung/sm8250-common"

git apply --whitespace=fix < /tmp/zic-patchs-sm8250/patches/device.patch

rm -rf /tmp/zic-patchs-sm8250

cd "$current_dir"