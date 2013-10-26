# System ZIP generator

This script generates a ZIP file of `/system` partation for 
flashing with third party recovery.

## Usage

create a directory named `system`, and prepare the ROM in it.
**Ensure that ownership and permission of all files are correct.**

Then run `pack.sh` to generate a ZIP file from it.
The updater script will be automatically generated, 
which will take care of symbol-linking and permissions for you.


## DISCLAIMER

FLAHSING HOMEBREW RECOVERY OR SYSTEM MAY VOID YOUR WARRANTY.
I TAKE NO RESPOSIBILITY FOR ANY DANAGE CAUSED BY THIS TOOL.

