#!/bin/sh

# # move to vms folder
#cd /vmfs/volumes/datastore1/${1}
#pwd
# # #Clone the vmdk to a thin provisioned disk using vmkfstools - 
vmkfstools -i ${1}.vmdk -d thin thin-${1}.vmdk
# # #Rename old flat file - 
mv ${1}-flat.vmdk ${1}-flat.vmdk.old
# # #Rename new flat file - 
mv thin-${1}-flat.vmdk ${1}-flat.vmdk
# # get VM iD to unregister
a=$(vim-cmd /vmsvc/getallvms | grep -i ${1} | wc -l )
if [ "$a" == 0 ]
then 
	echo "ERROR ${a} VMs found with that name"
	exit 0
else
	if [ "$a" -lt "2" ]
	then
		vm_id=$(vim-cmd /vmsvc/getallvms | grep -i ${1} | awk '{print $1}')
		echo "1 vm found with that pattern"
		echo "deregistering VM with id of $vm_id"
		vim-cmd /vmsvc/unregister $vm_id
		echo $(pwd)
		vim-cmd solo/registervm $(pwd)/${1}.vmx
		echo "Deleting old vmdk"
		rm ${1}-flat.vmdk.old 
		echo "Completed"
	else
		echo "ERROR ${a} VMs found for that name."
		echo "Exiting"
	fi
fi
	#Unregister VM from ESXi inventory, this is necessary for the host to recognise the new disk type (Right-click VM > Unregister)
	#vim-cmd /vmsvc/unregister $vm_id
	#Re-register the VM (Create / Register VM > Register an existing virtual machine)
	#vim-cmd solo/registervm {$1}.vmx
	#Boot the VM and check all is well.

	#Delete unnecessary vmdk files - rm thin-vm01.vmdk && rm vm01-flat.vmdk.old
