Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8B669796C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 11:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbjBOKAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 05:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbjBOKAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 05:00:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023F82BF16;
        Wed, 15 Feb 2023 02:00:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 913CCB820DC;
        Wed, 15 Feb 2023 10:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0145C433EF;
        Wed, 15 Feb 2023 10:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676455234;
        bh=IrU+aIiMDsCo/9t1tLwulF1zkfBra6cRuG3BYRBDIqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MrIiAPs+4a90XZeM0ZSgdleW2c38+wWs/QcXYna3jDVH9m0DS1ZHTP8iFGaon4BGS
         InVyWmJcO6iqQZiJaVW8cYFumNlSwUJy6mbzOG/hoSsF9K1Hp1+n5N9ssu7Tevtf9C
         O8yHKgUKmhdkQEwF2gtl+SQ2epBoqGT7r54CfXc2E7yVzsSCja5yGRKUleP34ml5ft
         oRp4jTSyS8jkClWZzvhQpLnJKFfLRcXJG3eJ7F3SAf51quDE05YYgT6Q9nHPvm1y2k
         S4GxDP2/ALIjVG/ijGFU0fP+eP5uUNn4bmmdu2OR7KsgOPoX02YMLpjlmdBBr9zDmR
         4QC9g2eFrh4RA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, Tony Luck <tony.luck@intel.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ia64@vger.kernel.org
Subject: [RFC PATCH 5/5] Documentation: Drop or replace remaining mentions of IA64
Date:   Wed, 15 Feb 2023 11:00:08 +0100
Message-Id: <20230215100008.2565237-6-ardb@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230215100008.2565237-1-ardb@kernel.org>
References: <20230215100008.2565237-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=19813; i=ardb@kernel.org; h=from:subject; bh=IrU+aIiMDsCo/9t1tLwulF1zkfBra6cRuG3BYRBDIqE=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBj7K0Y84jWI6c3Bk0g7+Dh5fPkMAWQDub58u7Xc 680oqK+a/GJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY+ytGAAKCRDDTyI5ktmP JHWKC/95HAuZfeaUZkYZhtjCQvq+ZkrTDq9MPPlM2DU4YhkQDW8PO5TjwW51seVyeHN/GWSMGDI NrNVGPaLYEW217XCdK6P3vAdYnf10/CGV6/8+5hsVfjDZ2IZ8vmVHXmMYeWmSGDogbDI8w+OFrf Wzxf33wiUDG3sVQ1Ad3paQ6kTAjdlhp45FACZfDbM1qiRCl1lkEaysYzf+6kwxbR05B3HWn9A4e FpOeC99uJcaV/gI332RYuHnSGg3l6n5fmasR3mO6xxUCaxGJYeO/374Cqs/eX1zpXKmlOZ5fC3f 3XVeyv94JM1HVuvXR04YdWggO8zggncsy5jVUl2/dpRinvmThAh3tR8gXRfV0kn3L9WDjC7K+bN fmC+5qyL3pSyMPEEEGxeJPwgkxg6OjPB5EqN7lDi6Hu1B/a/B7eGiusKWaOMLp+J3aE+e0XYrIj 17zjJpd/gJeG+f40GRqCL3j4HKNzNysfsggyK78sBOa0x3yxu5AiW00AyN/twhF0t0qoU=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop or update mentions of IA64, as appropriate.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu                 |  3 --
 Documentation/ABI/testing/sysfs-firmware-dmi-entries               |  2 +-
 Documentation/admin-guide/kdump/kdump.rst                          | 37 ++------------------
 Documentation/admin-guide/kdump/vmcoreinfo.rst                     | 30 ----------------
 Documentation/admin-guide/kernel-parameters.txt                    |  8 +----
 Documentation/admin-guide/mm/memory-hotplug.rst                    |  2 +-
 Documentation/admin-guide/sysctl/kernel.rst                        | 23 ++----------
 Documentation/arch.rst                                             |  1 -
 Documentation/block/ioprio.rst                                     |  3 --
 Documentation/core-api/debugging-via-ohci1394.rst                  |  6 ++--
 Documentation/kbuild/makefiles.rst                                 |  2 +-
 Documentation/networking/device_drivers/ethernet/neterion/s2io.rst |  4 +--
 Documentation/scheduler/sched-arch.rst                             |  4 +--
 Documentation/trace/kprobes.rst                                    |  1 -
 Documentation/translations/zh_CN/arch.rst                          |  1 -
 Documentation/translations/zh_CN/core-api/cpu_hotplug.rst          |  6 ----
 Documentation/translations/zh_CN/scheduler/sched-arch.rst          |  5 +--
 Makefile                                                           |  4 +--
 18 files changed, 18 insertions(+), 124 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index f54867cadb0f68a8..7fc70f8cd90ed4ec 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -354,9 +354,6 @@ Description:	Parameters for the CPU cache attributes
 			- ReadWriteAllocate:
 					both writeallocate and readallocate
 
-		attributes:
-			    LEGACY used only on IA64 and is same as write_policy
-
 		coherency_line_size:
 				     the minimum amount of data in bytes that gets
 				     transferred from memory to cache
diff --git a/Documentation/ABI/testing/sysfs-firmware-dmi-entries b/Documentation/ABI/testing/sysfs-firmware-dmi-entries
index fe0289c877684958..b6c23807b8047405 100644
--- a/Documentation/ABI/testing/sysfs-firmware-dmi-entries
+++ b/Documentation/ABI/testing/sysfs-firmware-dmi-entries
@@ -2,7 +2,7 @@ What:		/sys/firmware/dmi/entries/
 Date:		February 2011
 Contact:	Mike Waychison <mikew@google.com>
 Description:
-		Many machines' firmware (x86 and ia64) export DMI /
+		Many machines' firmware (x86 and arm64) export DMI /
 		SMBIOS tables to the operating system.  Getting at this
 		information is often valuable to userland, especially in
 		cases where there are OEM extensions used.
diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index a748e7eb4429b886..5762e7477a0c8edb 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -17,7 +17,7 @@ You can use common commands, such as cp, scp or makedumpfile to copy
 the memory image to a dump file on the local disk, or across the network
 to a remote system.
 
-Kdump and kexec are currently supported on the x86, x86_64, ppc64, ia64,
+Kdump and kexec are currently supported on the x86, x86_64, ppc64,
 s390x, arm and arm64 architectures.
 
 When the system kernel boots, it reserves a small section of memory for
@@ -113,7 +113,7 @@ There are two possible methods of using Kdump.
 2) Or use the system kernel binary itself as dump-capture kernel and there is
    no need to build a separate dump-capture kernel. This is possible
    only with the architectures which support a relocatable kernel. As
-   of today, i386, x86_64, ppc64, ia64, arm and arm64 architectures support
+   of today, i386, x86_64, ppc64, arm and arm64 architectures support
    relocatable kernel.
 
 Building a relocatable kernel is advantageous from the point of view that
@@ -236,24 +236,6 @@ Dump-capture kernel config options (Arch Dependent, ppc64)
 
    Make and install the kernel and its modules.
 
-Dump-capture kernel config options (Arch Dependent, ia64)
-----------------------------------------------------------
-
-- No specific options are required to create a dump-capture kernel
-  for ia64, other than those specified in the arch independent section
-  above. This means that it is possible to use the system kernel
-  as a dump-capture kernel if desired.
-
-  The crashkernel region can be automatically placed by the system
-  kernel at runtime. This is done by specifying the base address as 0,
-  or omitting it all together::
-
-	crashkernel=256M@0
-
-  or::
-
-	crashkernel=256M
-
 Dump-capture kernel config options (Arch Dependent, arm)
 ----------------------------------------------------------
 
@@ -348,11 +330,6 @@ Boot into System Kernel
 
    On ppc64, use "crashkernel=128M@32M".
 
-   On ia64, 256M@256M is a generous value that typically works.
-   The region may be automatically placed on ia64, see the
-   dump-capture kernel config option notes above.
-   If use sparse memory, the size should be rounded to GRANULE boundaries.
-
    On s390x, typically use "crashkernel=xxM". The value of xx is dependent
    on the memory consumption of the kdump system. In general this is not
    dependent on the memory size of the production system.
@@ -383,10 +360,6 @@ For ppc64:
 
 	- Use vmlinux
 
-For ia64:
-
-	- Use vmlinux or vmlinuz.gz
-
 For s390x:
 
 	- Use image or bzImage
@@ -428,14 +401,10 @@ to load dump-capture kernel::
    --initrd=<initrd-for-dump-capture-kernel> \
    --append="root=<root-dev> <arch-specific-options>"
 
-Please note, that --args-linux does not need to be specified for ia64.
-It is planned to make this a no-op on that architecture, but for now
-it should be omitted
-
 Following are the arch specific command line options to be used while
 loading dump-capture kernel.
 
-For i386, x86_64 and ia64:
+For i386 and x86_64:
 
 	"1 irqpoll nr_cpus=1 reset_devices"
 
diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 86fd884928700bd0..54f3971340ad1459 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -419,36 +419,6 @@ of a higher page table lookup overhead, and also consumes more page
 table space per process. Used to check whether PAE was enabled in the
 crash kernel when converting virtual addresses to physical addresses.
 
-ia64
-====
-
-pgdat_list|(pgdat_list, MAX_NUMNODES)
--------------------------------------
-
-pg_data_t array storing all NUMA nodes information. MAX_NUMNODES
-indicates the number of the nodes.
-
-node_memblk|(node_memblk, NR_NODE_MEMBLKS)
-------------------------------------------
-
-List of node memory chunks. Filled when parsing the SRAT table to obtain
-information about memory nodes. NR_NODE_MEMBLKS indicates the number of
-node memory chunks.
-
-These values are used to compute the number of nodes the crashed kernel used.
-
-node_memblk_s|(node_memblk_s, start_paddr)|(node_memblk_s, size)
-----------------------------------------------------------------
-
-The size of a struct node_memblk_s and the offsets of the
-node_memblk_s's members. Used to compute the number of nodes.
-
-PGTABLE_3|PGTABLE_4
--------------------
-
-User-space tools need to know whether the crash kernel was in 3-level or
-4-level paging mode. Used to distinguish the page table.
-
 ARM64
 =====
 
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6cfa6e3996cf75ee..d0e67c70ba90bce6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1443,7 +1443,7 @@
 			See comment before function elanfreq_setup() in
 			arch/x86/kernel/cpu/cpufreq/elanfreq.c.
 
-	elfcorehdr=[size[KMG]@]offset[KMG] [IA64,PPC,SH,X86,S390]
+	elfcorehdr=[size[KMG]@]offset[KMG] [PPC,SH,X86,S390]
 			Specifies physical address of start of kernel core
 			image elf header and optionally the size. Generally
 			kexec loader will pass this option to capture kernel.
@@ -1506,12 +1506,6 @@
 	floppy=		[HW]
 			See Documentation/admin-guide/blockdev/floppy.rst.
 
-	force_pal_cache_flush
-			[IA-64] Avoid check_sal_cache_flush which may hang on
-			buggy SAL_CACHE_FLUSH implementations. Using this
-			parameter will force ia64_sal_cache_flush to call
-			ia64_pal_cache_flush instead of SAL_CACHE_FLUSH.
-
 	forcepae	[X86-32]
 			Forcefully enable Physical Address Extension (PAE).
 			Many Pentium M systems disable PAE but may have a
diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index a3c9e8ad8fa0d83f..09128f1a29001124 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -35,7 +35,7 @@ used to expose persistent memory, other performance-differentiated memory and
 reserved memory regions as ordinary system RAM to Linux.
 
 Linux only supports memory hot(un)plug on selected 64 bit architectures, such as
-x86_64, arm64, ppc64, s390x and ia64.
+x86_64, arm64, ppc64 and s390x.
 
 Memory Hot(Un)Plug Granularity
 ------------------------------
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 46e3d62c0eea84d1..bf8efef45b1d5d7a 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -436,7 +436,7 @@ ignore-unaligned-usertrap
 
 On architectures where unaligned accesses cause traps, and where this
 feature is supported (``CONFIG_SYSCTL_ARCH_UNALIGN_NO_WARN``;
-currently, ``arc``, ``ia64`` and ``loongarch``), controls whether all
+currently, ``arc`` and ``loongarch``), controls whether all
 unaligned traps are logged.
 
 = =============================================================
@@ -445,10 +445,7 @@ unaligned traps are logged.
   setting.
 = =============================================================
 
-See also `unaligned-trap`_ and `unaligned-dump-stack`_. On ``ia64``,
-this allows system administrators to override the
-``IA64_THREAD_UAC_NOPRINT`` ``prctl`` and avoid logs being flooded.
-
+See also `unaligned-trap`_.
 
 kexec_load_disabled
 ===================
@@ -1471,22 +1468,6 @@ See Documentation/admin-guide/kernel-parameters.rst and
 Documentation/trace/boottime-trace.rst.
 
 
-.. _unaligned-dump-stack:
-
-unaligned-dump-stack (ia64)
-===========================
-
-When logging unaligned accesses, controls whether the stack is
-dumped.
-
-= ===================================================
-0 Do not dump the stack. This is the default setting.
-1 Dump the stack.
-= ===================================================
-
-See also `ignore-unaligned-usertrap`_.
-
-
 unaligned-trap
 ==============
 
diff --git a/Documentation/arch.rst b/Documentation/arch.rst
index 41a66a8b38e42479..3f9962e45c098c62 100644
--- a/Documentation/arch.rst
+++ b/Documentation/arch.rst
@@ -12,7 +12,6 @@ implementation.
    arc/index
    arm/index
    arm64/index
-   ia64/index
    loongarch/index
    m68k/index
    mips/index
diff --git a/Documentation/block/ioprio.rst b/Documentation/block/ioprio.rst
index f72b0de65af731f1..a25c6d5df87b20ff 100644
--- a/Documentation/block/ioprio.rst
+++ b/Documentation/block/ioprio.rst
@@ -80,9 +80,6 @@ ionice.c tool::
   #elif defined(__x86_64__)
   #define __NR_ioprio_set		251
   #define __NR_ioprio_get		252
-  #elif defined(__ia64__)
-  #define __NR_ioprio_set		1274
-  #define __NR_ioprio_get		1275
   #else
   #error "Unsupported arch"
   #endif
diff --git a/Documentation/core-api/debugging-via-ohci1394.rst b/Documentation/core-api/debugging-via-ohci1394.rst
index 981ad4f89fd3e445..cb3d3228dfc8449b 100644
--- a/Documentation/core-api/debugging-via-ohci1394.rst
+++ b/Documentation/core-api/debugging-via-ohci1394.rst
@@ -23,9 +23,9 @@ Retrieving a full system memory dump is also possible over the FireWire,
 using data transfer rates in the order of 10MB/s or more.
 
 With most FireWire controllers, memory access is limited to the low 4 GB
-of physical address space.  This can be a problem on IA64 machines where
-memory is located mostly above that limit, but it is rarely a problem on
-more common hardware such as x86, x86-64 and PowerPC.
+of physical address space.  This can be a problem on machines where memory is
+located mostly above that limit, but it is rarely a problem on more common
+hardware such as x86, x86-64 and PowerPC.
 
 At least LSI FW643e and FW643e2 controllers are known to support access to
 physical addresses above 4 GB, but this feature is currently not enabled by
diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index 38bc74eaa5474039..9ca798a51a2d0e7b 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -114,7 +114,7 @@ knowledge about the kernel Makefiles, plus detailed knowledge about the
 public interface for kbuild.
 
 *Arch developers* are people who work on an entire architecture, such
-as sparc or ia64.  Arch developers need to know about the arch Makefile
+as sparc or x86.  Arch developers need to know about the arch Makefile
 as well as kbuild Makefiles.
 
 *Kbuild developers* are people who work on the kernel build system itself.
diff --git a/Documentation/networking/device_drivers/ethernet/neterion/s2io.rst b/Documentation/networking/device_drivers/ethernet/neterion/s2io.rst
index c5673ec4559ba733..d731b5a985611f89 100644
--- a/Documentation/networking/device_drivers/ethernet/neterion/s2io.rst
+++ b/Documentation/networking/device_drivers/ethernet/neterion/s2io.rst
@@ -64,8 +64,8 @@ c. Multi-buffer receive mode. Scattering of packet across multiple
    IBM xSeries).
 
 d. MSI/MSI-X. Can be enabled on platforms which support this feature
-   (IA64, Xeon) resulting in noticeable performance improvement(up to 7%
-   on certain platforms).
+   resulting in noticeable performance improvement (up to 7% on certain
+   platforms).
 
 e. Statistics. Comprehensive MAC-level and software statistics displayed
    using "ethtool -S" option.
diff --git a/Documentation/scheduler/sched-arch.rst b/Documentation/scheduler/sched-arch.rst
index 0eaec669790a006c..f2c23769d4fbfa9e 100644
--- a/Documentation/scheduler/sched-arch.rst
+++ b/Documentation/scheduler/sched-arch.rst
@@ -10,7 +10,7 @@ Context switch
 By default, the switch_to arch function is called with the runqueue
 locked. This is usually not a problem unless switch_to may need to
 take the runqueue lock. This is usually due to a wake up operation in
-the context switch. See arch/ia64/include/asm/switch_to.h for an example.
+the context switch.
 
 To request the scheduler call switch_to with the runqueue unlocked,
 you must `#define __ARCH_WANT_UNLOCKED_CTXSW` in a header file
@@ -68,8 +68,6 @@ Possible arch/ problems
 
 Possible arch problems I found (and either tried to fix or didn't):
 
-ia64 - is safe_halt call racy vs interrupts? (does it sleep?) (See #4a)
-
 sh64 - Is sleeping racy vs interrupts? (See #4a)
 
 sparc - IRQs on at this point(?), change local_irq_save to _disable.
diff --git a/Documentation/trace/kprobes.rst b/Documentation/trace/kprobes.rst
index fc7ce76eab655c01..f825970a14957346 100644
--- a/Documentation/trace/kprobes.rst
+++ b/Documentation/trace/kprobes.rst
@@ -315,7 +315,6 @@ architectures:
 - i386 (Supports jump optimization)
 - x86_64 (AMD-64, EM64T) (Supports jump optimization)
 - ppc64
-- ia64 (Does not support probes on instruction slot1.)
 - sparc64 (Return probes not yet implemented.)
 - arm
 - ppc
diff --git a/Documentation/translations/zh_CN/arch.rst b/Documentation/translations/zh_CN/arch.rst
index 690e173d8b2a83cc..ae7014476cc7677a 100644
--- a/Documentation/translations/zh_CN/arch.rst
+++ b/Documentation/translations/zh_CN/arch.rst
@@ -18,7 +18,6 @@
 TODOList:
 
 * arm/index
-* ia64/index
 * m68k/index
 * nios2/index
 * powerpc/index
diff --git a/Documentation/translations/zh_CN/core-api/cpu_hotplug.rst b/Documentation/translations/zh_CN/core-api/cpu_hotplug.rst
index 4772a900c37a048c..bc0d7ea6d834cc22 100644
--- a/Documentation/translations/zh_CN/core-api/cpu_hotplug.rst
+++ b/Documentation/translations/zh_CN/core-api/cpu_hotplug.rst
@@ -49,12 +49,6 @@ CPU热拔插支持的一个更新颖的用途是它在SMP的暂停恢复支持
   限制内核将支持的CPU总量。如果这里提供的数量低于实际可用的CPU数量，那么其他CPU
   以后就不能上线了。
 
-``additional_cpus=n``
-  使用它来限制可热插拔的CPU。该选项设置
-  ``cpu_possible_mask = cpu_present_mask + additional_cpus``
-
-  这个选项只限于IA64架构。
-
 ``possible_cpus=n``
   这个选项设置 ``cpu_possible_mask`` 中的 ``possible_cpus`` 位。
 
diff --git a/Documentation/translations/zh_CN/scheduler/sched-arch.rst b/Documentation/translations/zh_CN/scheduler/sched-arch.rst
index 754a15c6b60f3a1e..de41b028b2b0245c 100644
--- a/Documentation/translations/zh_CN/scheduler/sched-arch.rst
+++ b/Documentation/translations/zh_CN/scheduler/sched-arch.rst
@@ -20,8 +20,7 @@
 ==========
 1. 运行队列锁
 默认情况下，switch_to arch函数在调用时锁定了运行队列。这通常不是一个问题，除非
-switch_to可能需要获取运行队列锁。这通常是由于上下文切换中的唤醒操作造成的。见
-arch/ia64/include/asm/switch_to.h的例子。
+switch_to可能需要获取运行队列锁。这通常是由于上下文切换中的唤醒操作造成的。
 
 为了要求调度器在运行队列解锁的情况下调用switch_to，你必须在头文件
 中`#define __ARCH_WANT_UNLOCKED_CTXSW`(通常是定义switch_to的那个文件）。
@@ -68,8 +67,6 @@ arch/x86/kernel/process.c有轮询和睡眠空闲函数的例子。
 
 我发现的可能的arch问题（并试图解决或没有解决）。:
 
-ia64 - safe_halt的调用与中断相比，是否很荒谬？ (它睡眠了吗) (参考 #4a)
-
 sh64 - 睡眠与中断相比，是否很荒谬？ (参考 #4a)
 
 sparc - 在这一点上，IRQ是开着的（？），把local_irq_save改为_disable。
diff --git a/Makefile b/Makefile
index 716a975730a68e3a..ddae1033f4bc64c8 100644
--- a/Makefile
+++ b/Makefile
@@ -392,7 +392,7 @@ include $(srctree)/scripts/subarch.include
 # When performing cross compilation for other architectures ARCH shall be set
 # to the target architecture. (See arch/* for the possibilities).
 # ARCH can be set during invocation of make:
-# make ARCH=ia64
+# make ARCH=arm64
 # Another way is to have ARCH set in the environment.
 # The default ARCH is the host where make is executed.
 
@@ -400,7 +400,7 @@ include $(srctree)/scripts/subarch.include
 # during compilation. Only gcc and related bin-utils executables
 # are prefixed with $(CROSS_COMPILE).
 # CROSS_COMPILE can be set on the command line
-# make CROSS_COMPILE=ia64-linux-
+# make CROSS_COMPILE=aarch64-linux-gnu-
 # Alternatively CROSS_COMPILE can be set in the environment.
 # Default value for CROSS_COMPILE is not to prefix executables
 # Note: Some architectures assign CROSS_COMPILE in their arch/*/Makefile
-- 
2.39.1

