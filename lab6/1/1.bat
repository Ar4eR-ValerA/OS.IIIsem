wmic OS get Version > "%~dp0version.txt"
wmic OS get FreePhysicalMemory > "%~dp0memory.txt"
wmic ComputerSystem get TotalPhysicalMemory >> "%~dp0memory.txt"
wmic LogicalDisk get DeviceID > "%~dp0disks.txt"