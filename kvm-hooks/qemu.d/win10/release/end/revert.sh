set -x

# rebind the gpu
source "/etc/libvirt/hooks/kvm.conf"

virsh nodedev-reattach $VIRSH_GPU_VIDEO
virsh nodedev-reattach $VIRSH_GPU_AUDIO

# rebind vtconsoles
echo 1 > /sys/class/vtconsoles/vtcon0/bind
echo 1 > /sys/class/vtconsoles/vtcon1/bind

echo "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/bind
