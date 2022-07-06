set -x

source "/etc/libvirt/hooks/kvm.conf"

# unbind vtconsoles
echo 0 > /sys/class/vtconsole/vtcon0/bind
echo 0 > /sys/class/vtconsole/vtcon1/bind

# unbind efi framebuffer
echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

# avoid race condition (racist)
sleep 5

# detach the gpu
virsh nodedev-detach $VIRSH_GPU_VIDEO
virsh nodedev-detach $VIRSH_GPU_AUDIO
# load the mf vfio
modprobe vfio
modprobe vfio-pci
