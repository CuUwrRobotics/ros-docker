# @Author: Nick Steele <nichlock>
# @Date:   21:59 Sep 01 2020
# @Last modified by:   nichlock
# @Last modified time: 19:10 Sep 19 2020

# Allow SSH logins for root TODO: don't use root
echo PermitRootLogin yes >> /etc/ssh/sshd_config
# Assign a password to root
echo root:r | chpasswd
# Start SSH service
service ssh restart

# Setup catkin_ws
/scripts/catkin_setup.sh

# Append anything needed to bashrc, including ros sources
/scripts/append_bashrc.sh

# Move the sources in place
$temporary_package_directory/file-setup.sh

# Print the hostname
echo '[42mContainer started successfully.[0m'
echo Container ID: $(cat /etc/hostname)

# Keep container running
tail -f /dev/null
