# This script is used by the system admin to create a new user and setup their permissions.
# It needs to be run as root on the Proxmox VE server.


USER_NAME=$1
echo "Creating user account for $USER_NAME, press enter to continue"
read

# Create the user account
pveum useradd $USER_NAME@pve
# Set the password
pveum passwd $USER_NAME@pve -password "12345678"
# Add the user to the group named "LabUsers"
pveum user modify $USER_NAME@pve -group LabUsers

# Create a pool named "$USER_NAME-pool"
pveum pool add $USER_NAME-pool
# Give the user the "PVEAdmin" role on the pool 
pveum aclmod /pool/$USER_NAME-pool -user $USER_NAME@pve -role PVEAdmin

# Create a ZFS dataset named "rpool/users/$USER_NAME" with a quota of 50GB
zfs create rpool/users/$USER_NAME -o quota=50G
# Inside it, create a dataset "active" and "templates"
zfs create rpool/users/$USER_NAME/active
zfs create rpool/users/$USER_NAME/templates

# Add the dataset "rpool/users/$USER_NAME/active" as ZFSPool datastore named "$USER_NAME-active"
pvesm add zfspool $USER_NAME-active --pool rpool/users/$USER_NAME/active --content rootdir,images --sparse true
# Add the dataset "rpool/users/$USER_NAME/templates" as dir datastore named "$USER_NAME-templates"
pvesm add dir $USER_NAME-templates --path /rpool/users/$USER_NAME/templates --content iso,backup,vztmpl

# Add the two datastores to the pool
pveum pool modify $USER_NAME-pool --storage $USER_NAME-active,$USER_NAME-templates