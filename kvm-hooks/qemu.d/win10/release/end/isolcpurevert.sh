systemctl set-property --runtime --user.slice AllowedCpu=0-7
systemctl set-property --runtime --system.slice AllowedCpu=0-7
systemctl set-property --runtime --init.slice AllowedCpu=0-7
