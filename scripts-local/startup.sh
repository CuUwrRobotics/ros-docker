# @Author: Nick Steele <nichlock>
# @Date:   21:59 Sep 01 2020
# @Last modified by:   Nick Steele
# @Last modified time: 19:38 May 12 2021

# Allow SSH logins for root TODO: don't use root
echo PermitRootLogin yes >> /etc/ssh/sshd_config
# Assign a password to root to allow SSH
echo root:r | chpasswd
# Start SSH service
service ssh restart

# Append anything needed to bashrc, including ros sources
$START_SCRIPTS/append-bashrc.sh

# Move the sources in place
$START_SCRIPTS/file-setup.sh

# Print the hostname
echo '[42mContainer started successfully.[0m'
echo Container ID: $(cat /etc/hostname)

# Keep container running
tail -f /dev/null
