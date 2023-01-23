# ultimate-macOS-KVM
Helping you build the ultimate macOS virtual machine, powered by KVM.

## Requirements
As with all other virtual machines / hypervisors, you don't need an *uber-powerful* PC, but you should expect guest performance to be relative to your host's. Performance *can* change dramatically based on guest properties, such as virtual cores, allocated memory, and virtual CPU threads - but it really does boil down to how beefy your host's hardware is.
Here's a table with my best judgement on minimum, recommended, and best system requirements:
|                 |                   **Minimum**                  |                           **Recommended**                          |                                   **Optimal**                                  |
|-----------------|:----------------------------------------------:|:------------------------------------------------------------------:|:---------------------------------------------------------------------------:|
| **OS**          |                    linux-5.x                   |                             Linux Mint                             |                                  Arch Linux                                 |
| **Motherboard** |             Virtualisation<br>UEFI             |        Virtualisation<br>UEFI<br>IOMMU<br>Intel VT-D / AMD-V       | Virtualisation<br>UEFI<br>IOMMU<br>Intel VT-D / AMD-V<br>Isolated PCI Lanes |
| **CPU**         | ~2014 Intel / AMD<br>Virtualisation<br>2 cores | Intel i5 / Ryzen 5<br>Virtualisation<br>4-8 cores<br>Hyperthreaded |     Intel i9 / Ryzen 9<br>Virtualisation<br>8-16 cores<br>Hyperthreaded     |
| **Memory**      |                      4 GB                      |                                16 GB                               |                                    32 GB+                                   |
| **Disk Type**   |                    SATA HDD                    |                              SATA SSD                              |                                   NVMe SSD                                  |
| **Disk Space**  |                      40 GB                     |                               120 GB                               |                                   500 GB+                                   |
| **Resolution**  |                  1280x720                 |                           2560x1440                          |                                3840x2160                               |
| **GPU (VFIO)**  |                        -                       |                             AMD RX 580                             |                                AMD RX 6600 XT                               |

**You must also have all the required dependencies installed before starting - and any optional ones too along the way. Click the dropdown below to see the list.**
<details>
<summary><b>Dependencies</b></summary>
<br>
<b>Required</b>
<ul>
<li><b>Git</b> 》 <code>git</code></li>
<li><b>QEMU</b> 》 <code>qemu-base</code> or <code>qemu-full</code></li>
<li><b>Libvirt</b> 》 <code>libvirt</code></li>
<li><b>Python</b> 》 <code>python</code></li>
</ul>
<b>Optional / Recommended</b>
<ul>
<li><b>Virtual Machine Manager (GUI)</b> 》 <code>virt-manager</code></li>
</ul>
</details>

## Features
<ul>
<li><b>AutoPilot</b></li>
Automatically generates a valid, customised, and ready-to-use QEMU config script in seconds.

<li><b>Automatic System Checks</b></li>
Several check scripts can be used to make sure your system is correctly prepared for both passthrough and non-passthrough KVM.

<li><b>GPU Compatibility Checker</b></li>
Detects GPUs in your host system and checks them against a list of known compatible and incompatible macOS GPUs, providing a summary including any extra card-specific quirks.

<li><b>VFIO-IDs and IOMMU Helpers</b></li>
Auto-detects and lists IOMMU groups, VFIO-IDs, and checks if devices are stubbed to kernel driver correctly.

<li><b>VFIO-PCI Passthrough Assistant</b></li>
Advanced passthrough tinkering made easy with auto-detection and configuration walkthroughs.

<li><b>Import to virt-manager</b></li>
Easily convert any AutoPilot-generated QEMU scripts into an importable XML file for virt-manager (GUI).

</ul>

## Installation
It's easy to get up and running. Simply clone the repo, fix permissions, and run.
Make sure you have **all** dependencies installed before using.

```
git clone https://github.com/Coopydood/ultimate-macOS-KVM
cd ultimate-macOS-KVM
chmod +x setup.py
```
or, do all this with a one-liner:
```
git clone https://github.com/Coopydood/ultimate-macOS-KVM && cd ultimate-macOS-KVM && chmod +x setup.py
```
## Setup
Okay, so you've cloned my repo, cd'd into the directory, and made the ``setup.py`` file executeable. Great! 
Now, before running the script - and to avoid the subsequent and inevitable gotcha - you should enable the ``libvirtd`` daemon first if it hasn't been already:
```
sudo systemctl enable libvirtd
```
and/or check the status of the daemon with
```
systemctl status libvirtd
```

Okay, now you're ready to use **ultimate-macOS-KVM**. Use the main ``setup.py`` file. This is your main menu / central hub for the project and everything can be accessed from here. Most sub-scripts included in the project should *not* be run on their own.
```
./setup.py
```

## Documentation
More detailed write-ups on the project and the scripts included, as well as some tutorials can be found on this repo's wiki.
[I'm working on it...](https://github.com/Coopydood/ultimate-macOS-KVM/wiki)

## Disclaimer
This is my way of giving back to the QEMU, KVM, and VFIO community. Please don't expect much as this is a passion-project and not a priority in my life.
- I'm not responsible for any time you waste using this project.
- I'm not responsible if you make an oopsie whoopsie. 
- Do NOT run anything as ``sudo``. If you have an urge to then you need to break that habit __**asap.**__ None of my scripts require superuser priviledges.
- Expect headaches. Some severe.
- You need a LOT of patience. I mean it. Despite trying to alleviate some of the hassle, you WILL run into stupid gotchas that require trial and error out of my control. 
- I'm by no means an expert on this stuff nor would I claim to be.
- I've simply made *what I had to go through* **easier** for you. Hopefully.
- Yes, my Python is pretty bad. But if it works, it works.

## Credits / Greetz
While I am the creator of these automation/ease-of-use scripts, this project is not possible without both the prior and current works of some very talented people. Although, the testing done voluntarily (no, really) by my very best online friends cannot be overstated either and so they're in here too. Hi guys.
- **[Dortania](https://github.com/Dortania)** 》 Extensive documentation and Hackintosh development
- **[Kholia](https://github.com/kholia)** 》 Development of scripts and documentation. ultimate-macOS-KVM is intended as an extension to [OSX-KVM](https://github.com/kholia/OSX-KVM).
- **[thenickdude](https://github.com/thenickdude)** 》 Personal support throughout my KVM misadventures and countless community contribs. Cheers man.
- **[vu1tur](to@vu1tur.eu.org)** 》 Open source dmg to img conversion tool; used and bundled by this project.
- **[Eversiege](https://github.com/eversiege)** 》 Support and testing, та справжній xoxol.exe.
- **[CyberneticSquid](https://github.com/cyberneticsquid)** 》 Testing for me at stupid-o'-clock because he's a cool Aussie.
- **[Cake](https://github.com/cam-jm)** 》 Another Aussie testing for me in the middle of my sleep-deprived nights, with a slight obsession over cake.
- **[DomTrues](https://github.com/domtrues)** 》 My personal constitution-munching American. Legend has it that I live in his attic, although even I'm not sure. Love this guy either way.
- **[Kaz](https://github.com/Eaz11)** 》 Other than his brilliant English accent's pronounciations (including "macOS Syria"), he's a good mate who's done extensive testing for me. Say hi to your nephew for me.
- **[GigantTech](https://twitter.com/TechGigant)** 》 Moderately annoying German guy that I convinced to install Linux subsequently letting him test my project. It's free real estate!
