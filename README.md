# ESXI-Provisioning
Script to convert thick Provisioned VMDK on free ESXI to thin VMDK

This project includes a bash script that converts VMware ESXi thick Provisioned VMDK to thin provisioned vmdk.

## Background on VMware ESXi

VMware ESXi is a lightweight operating system designed to run virtual machines.
Whenever you hear about someone running virtual machines or cloud servers
they're using ESXi, Xen, QEMU/KVM, or a similar technology under the hood.

ESXi is proprietary software, but you can download it and use it for free. You
will need to register for a VMware account and [download ESXi (also called
"vSphere Hypervisor")](https://www.vmware.com/products/vsphere-hypervisor/)
before you use this script.

## Instructions

1.  Download the script and transfer it to the EXSi host using SCP or open a text file on the esxi host and copy the script over.

2.  Make the script executable. e.g `chmod u+rx this-script.sh`.

3.  change directory to the directory of your datastore where the VM is located. `cd /vmfs/volumes/datastore1/VM-TO-THIN`.

4.  Run the script and pass the VM name as an argument `./this-script.sh VM-TO-THIN`

5.  Let the script run it may take some time to clone, deregister the VM and rerehister with the thin provisioned VMDK.


DISCLAIMER
==========

This submission is supplied without any WARRANTY (EXPRESSED or IMPLIED)
and is intended in good faith to provide the ESXi community with a
way to test the chnage the provisioning of an VMDK.
