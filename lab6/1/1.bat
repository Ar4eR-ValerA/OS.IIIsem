wmic OS get Version > version
wmic OS get FreePhysicalMemory > memory
wmic ComputerSystem get TotalPhysicalMemory >> memory
wmic LogicalDisk get DeviceID > disks