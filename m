Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501AA65C486
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238151AbjACRCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238270AbjACRAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:00:23 -0500
Received: from fx409.security-mail.net (smtpout253.security-mail.net [46.30.205.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA6A13D17
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 09:00:17 -0800 (PST)
Received: from localhost (fx409.security-mail.net [127.0.0.1])
        by fx409.security-mail.net (Postfix) with ESMTP id 74A253496FF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:44:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1672764272;
        bh=oYDHnU5ZKUzTL1QpW0EIuqTwZIHaQIzA1PnB5i8pcQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=z++p2gugvnjYFPs1gbd80s1pGejmbjBg6kMAlZQ63NTsOXlC0yNajYSA1yWZ4rAtm
         a6t5fa0W5vGGtPoBLqnt2P/9NwuVyrIC1EERVO7W1tY3y9dkMRQdZjQnR4+egXCgPf
         w/RWLnhZ7wXxAbJcdpzxjxdUW2uw4q1rDo28nFP0=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id 313C6349641; Tue,  3 Jan
 2023 17:44:32 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx409.security-mail.net (Postfix) with ESMTPS id 305BA3494C0; Tue,  3 Jan
 2023 17:44:31 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id F06DD27E03F5; Tue,  3 Jan 2023
 17:44:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id D076627E03FC; Tue,  3 Jan 2023 17:44:30 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 oCybUT6LI-hS; Tue,  3 Jan 2023 17:44:30 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id A08B727E03F5; Tue,  3 Jan 2023
 17:44:30 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <174a4.63b45b6f.2e05f.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu D076627E03FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1672764270;
 bh=lGV8+LYV/syNTS2qikQ1y3mIfJPOF1M2LPSPeT12PHQ=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=jn4Ku+nRXQJfRAYobvbgq/8vkRsW6zr8iiMqU4S5OM1ylXUwi59uT9AWFozeAOP1s
 4yWH3FRCRX+3rvbZl5L8XCuTVqKiZdUMCcQm8zAr/nXI4vjUqzmIheea3tBEUwUOrp
 rN/oRsG9Hclw3DAksm9jmR1IMJwNkgBGMpdqlmIc=
From:   Yann Sionneau <ysionneau@kalray.eu>
Cc:     Yann Sionneau <ysionneau@kalray.eu>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>
Subject: [RFC PATCH 01/25] Documentation: kvx: Add basic documentation
Date:   Tue,  3 Jan 2023 17:43:35 +0100
Message-ID: <20230103164359.24347-2-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230103164359.24347-1-ysionneau@kalray.eu>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some documentation for kvx arch and its Linux port.

CC: Jonathan Corbet <corbet@lwn.net>
CC: linux-doc@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Co-developed-by: Clement Leger <clement.leger@bootlin.com>
Signed-off-by: Clement Leger <clement.leger@bootlin.com>
Co-developed-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Signed-off-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---
 Documentation/kvx/kvx-exceptions.txt | 246 ++++++++++++++++++++++++
 Documentation/kvx/kvx-iommu.txt      | 183 ++++++++++++++++++
 Documentation/kvx/kvx-mmu.txt        | 272 +++++++++++++++++++++++++++
 Documentation/kvx/kvx-smp.txt        |  36 ++++
 Documentation/kvx/kvx.txt            | 268 ++++++++++++++++++++++++++
 5 files changed, 1005 insertions(+)
 create mode 100644 Documentation/kvx/kvx-exceptions.txt
 create mode 100644 Documentation/kvx/kvx-iommu.txt
 create mode 100644 Documentation/kvx/kvx-mmu.txt
 create mode 100644 Documentation/kvx/kvx-smp.txt
 create mode 100644 Documentation/kvx/kvx.txt

diff --git a/Documentation/kvx/kvx-exceptions.txt b/Documentation/kvx/kvx-exceptions.txt
new file mode 100644
index 000000000000..11368287bd48
--- /dev/null
+++ b/Documentation/kvx/kvx-exceptions.txt
@@ -0,0 +1,246 @@
+Exceptions
+==========
+On kvx, handlers are set using $ev (exception vector) register which
+specifies a base address.
+An offset is added to $ev upon exception and the result is used as
+"Next $pc".
+The offset depends on which exception vector the cpu wants to jump to:
+* $ev + 0x00 for debug
+* $ev + 0x40 for trap
+* $ev + 0x80 for interrupt
+* $ev + 0xc0 for syscall
+
+Then, handlers are laid in the following order:
+
+         _____________
+        |             |
+        |   Syscall   |
+        |_____________|
+        |             |
+        |  Interrupts |
+        |_____________|
+        |             |
+        |    Traps    |
+        |_____________|
+        |             | ^
+        |    Debug    | | Stride
+BASE -> |_____________| v
+
+
+Interrupts, and traps are serviced similarly, ie:
+- Jump to handler
+- Save all registers
+- Prepare the call (do_IRQ or trap_handler)
+- restore all registers
+- return from exception
+
+entry.S file is (as for other architectures) the entry point into the kernel.
+It contains all assembly routines related to interrupts/traps/syscall.
+
+Syscall handling
+================
+
+When executing a syscall, it must be done using "scall $r6"
+where $r6 contains the syscall number. Using this convention allow to
+modify and restart a syscall from the kernel.
+
+Syscalls are handled differently than interrupts/exceptions. From an ABI
+point of view, scalls are like function calls: any caller saved register
+can be clobbered by the syscall. However, syscall parameters are passed
+using registers r0 through r7. These registers must be preserved to avoid
+cloberring them before the actual syscall function.
+
+On syscall from userspace (scall instruction), the processor will put
+the syscall number in $es.sn and switch from user to kernel privilege
+mode. kvx_syscall_handler will be called in kernel mode.
+
+The following steps are then taken:
+
+- Switch to kernel stack
+- Extract syscall number
+- Check that the syscall number is not bogus
+ - If so, set syscall func to a not implemented one
+- Check if tracing is enabled
+ - If so, jump to trace_syscall_enter
+ - Save syscall arguments (r0 -> r7) on stack in pt_regs
+ - Call do_trace_syscall_enter function
+- Restore syscall arguments since they have been modified by C call
+- Call the syscall function
+- Save $r0 in pt_regs since it can be cloberred afterward
+- If tracing was enabled, call trace_syscall_exit
+- Call work_pending
+- Return to user !
+
+The trace call is handled out of the fast path. All slow path handling
+is done in another part of code to avoid messing with the cache.
+
+Signals
+=======
+
+Signals are handled when exiting kernel before returning to user.
+When handling a signal, the path is the following:
+
+1 - User application is executing normally
+    Then any exception happens (syscall, interrupt, trap)
+2 - The exception handling path is taken
+    and before returning to user, pending signals are checked
+3 - Signal are handled by do_signal
+    Registers are saved and a special part of the stack is modified
+    to create a trampoline to call rt_sigreturn
+    $spc is modified to jump to user signal handler
+    $ra is modified to jump to sigreturn trampoline directly after
+    returning from user signal handler.
+4 - User signal handler is called after rfe from exception
+    when returning, $ra is retored to $pc, resulting in a call
+    to the syscall trampoline.
+5 - syscall trampoline is executed, leading to rt_sigreturn syscall
+6 - rt_sigreturn syscall is executed
+    Previous registers are restored to allow returning to user correctly
+7 - User application is restored at the exact point it was interrupted
+    before.
+
+
+        +----------+
+        |    1     |
+        | User app | @func
+        |  (user)  |
+        +---+------+
+            |
+            | it/trap/scall
+            |
+        +---v-------+
+        |    2      |
+        | exception |
+        | handling  |
+        | (kernel)  |
+        +---+-------+
+            |
+            | Check if signal are pending, if so, handle signals
+            |
+        +---v--------+
+        |    3       |
+        | do_signal  |
+        |  handling  |
+        |  (kernel)  |
+        +----+-------+
+             |
+             | Return to user signal handler
+             |
+        +----v------+
+        |    4      |
+        |  signal   |
+        |  handler  |
+        |  (user)   |
+        +----+------+
+             |
+             | Return to sigreturn trampoline
+             |
+        +----v-------+
+        |    5       |
+        |  syscall   |
+        |rt_sigreturn|
+        |  (user)    |
+        +----+-------+
+             |
+             | Syscall to rt_sigreturn
+             |
+        +----v-------+
+        |    6       |
+        |  sigreturn |
+        |  handler   |
+        |  (kernel)  |
+        +----+-------+
+             |
+             | Modify context to return to original func
+             |
+        +----v-----+
+        |    7     |
+        | User app | @func
+        |  (user)  |
+        +----------+
+
+Registers handling
+==================
+
+MMU is disabled in all exceptions paths, during register save and restoration.
+This will prevent from triggering MMU fault (such as TLB miss) which could
+clobber the current register state. Such event can occurs when RWX mode is
+enabled and the memory accessed to save register can trigger a TLB miss.
+Aside from that which is common for all exceptions path, registers are saved
+differently regarding the type of exception.
+
+Interrupts and traps
+--------------------
+
+When interrupt and traps are triggered, we only save the caller-saved registers.
+Indeed, we rely on the fact that C code will save and restore callee-saved and
+hence, there is no need to save them. This path is the following:
+
+     +------------+          +-----------+        +---------------+
+IT   | Save caller| C Call   | Execute C |  Ret   | Restore caller| Ret from IT
++--->+   saved    +--------->+  handler  +------->+     saved     +----->
+     | registers  |          +-----------+        |   registers   |
+     +------------+                               +---------------+
+
+However, when returning to user, we check if there is work_pending. If a signal
+is pending and there is a signal handler to be called, then we need all
+registers to be saved on the stack in the pt_regs before executing the signal
+handler and restored after that. Since we only saved caller-saved registers, we
+need to also save callee-saved registers to restore them correctly when
+returning to user. This path is the following (a bit more complicated !):
+
+      +------------+
+      | Save caller|          +-----------+  Ret   +------------+
+ IT   |   saved    | C Call   | Execute C | to asm | Check work |
+ +--->+ registers  +--------->+  handler  +------->+   pending  |
+      | to pt_regs |          +-----------+        +--+---+-----+
+      +------------+                                  |   |
+                        Work pending                  |   | No work pending
+         +--------------------------------------------+   |
+         |                                                |
+         |                                   +------------+
+         v                                   |
+  +------+------+                            v
+  | Save callee |                    +-------+-------+
+  |   saved     |                    | Restore caller|  RFE from IT
+  | registers   |                    |     saved     +------->
+  | to pt_regs  |                    |   registers   |
+  +--+-------+--+                    | from pt_regs  |
+     |       |                       +-------+-------+
+     |       |         +---------+           ^
+     |       |         | Execute |           |
+     |       +-------->+ needed  +-----------+
+     |                 |  work   |
+     |                 +---------+
+     |Signal handler ?
+     v
++----+----------+ RFE to user +-------------+       +--------------+
+|   Copy all    | handler     |  Execute    |  ret  | rt_sigreturn |
+|   registers   +------------>+ user signal +------>+ trampoline   |
+| from pt_regs  |             |  handler    |       |  to kernel   |
+| to user stack |             +-------------+       +------+-------+
++---------------+                                          |
+                         syscall rt_sigreturn              |
+         +-------------------------------------------------+
+         |
+         v
++--------+-------+                      +-------------+
+|   Recopy all   |                      | Restore all |  RFE
+| registers from +--------------------->+    saved    +------->
+|   user stack   |       Return         |  registers  |
+|   to pt_regs   |    from sigreturn    |from pt_regs |
++----------------+  (via ret_from_fork) +-------------+
+
+
+Syscalls
+--------
+As explained before, for syscalls, we can use whatever callee-saved registers
+we want since syscall are seen as a "classic" call from ABI pov.
+Only different path is the one for clone. For this path, since the child expects
+to find same callee-registers content than his parent, we must save them before
+executing the clone syscall and restore them after that for the child. This is
+done via a redefinition of __sys_clone in assembly which will be called in place
+of the standard sys_clone. This new call will save callee saved registers
+in pt_regs. Parent will return using the syscall standard path. Freshly spawned
+child however will be woken up via ret_from_fork which will restore all
+registers (even if caller saved are not needed).
diff --git a/Documentation/kvx/kvx-iommu.txt b/Documentation/kvx/kvx-iommu.txt
new file mode 100644
index 000000000000..96b74ce71acb
--- /dev/null
+++ b/Documentation/kvx/kvx-iommu.txt
@@ -0,0 +1,183 @@
+IOMMU
+=====
+
+General Overview
+----------------
+
+To exchange data between device and users through memory, the driver has to
+set up a buffer by doing some kernel allocation. The address of the buffer is
+virtual and the physical one is obtained through the MMU. When the device wants
+to access the same physical memory space it uses a bus address. This address is
+obtained by using the DMA mapping API. The Coolidge SoC includes several IOMMUs for clusters,
+PCIe peripherals, SoC peripherals, and more; that will translate this "bus address"
+into a physical one during DMA operations.
+
+The bus addresses are IOVA (I/O Virtual Address) or DMA addresses. This
+addresses can be obtained by calling the allocation functions of the DMA APIs.
+It can also be obtained through classical kernel allocation of physical
+contiguous memory and then calling mapping functions of the DMA API.
+
+In order to be able to use the kvx IOMMU we have implemented the IOMMU DMA
+interface in arch/kvx/mm/dma-mapping.c. DMA functions are registered by
+implementing arch_setup_dma_ops() and generic IOMMU functions. Generic IOMMU
+are calling our specific IOMMU functions that adding or removing mappings
+between DMA addresses and physical addresses in the IOMMU TLB.
+
+Specifics IOMMU functions are defined in the kvx IOMMU driver. A kvx IOMMU
+driver is managing two physical hardware IOMMU used for TX and RX. In the next
+section we described the HW IOMMUs.
+
+
+Cluster IOMMUs
+--------------
+
+IOMMUs on cluster are used for DMA and cryptographic accelerators.
+There are six IOMMUs connected to the:
+	- cluster DMA tx
+	- cluster DMA rx
+	- first non secure cryptographic accelerator
+	- second non secure cryptographic accelerator
+	- first secure cryptographic accelerator
+	- second secure cryptographic accelerator
+
+SoC peripherals IOMMUs
+----------------------
+
+Since SoC peripherals are connected to an AXI bus, two IOMMUs are used: one for
+each AXI channel (read and write). These two IOMMUs are shared between all master
+devices and DMA. These two IOMMUs will have the same entries but need to be configured
+independently.
+
+PCIe IOMMUs
+-----------
+
+There is a slave IOMMU (read and write from the MPPA to the PCIe endpoint)
+and a master IOMMU (read and write from a PCIe endpoint to system DDR).
+The PCIe root complex and the MSI/MSI-X controller have been designed to use
+the IOMMU feature when enabled. (For example for supporting endpoint that
+support only 32 bits addresses and allow them to access any memory in a
+64 bits address space). For security reason it is highly recommended to
+activate the IOMMU for PCIe.
+
+IOMMU implementation
+--------------------
+
+The kvx is providing several IOMMUs. Here is a simplified view of all IOMMUs
+and translations that occurs between memory and devices:
+
+ +---------------------------------------------------------------------+
+ | +------------+     +---------+                          | CLUSTER X |
+ | | Cores 0-15 +---->+ Crypto  |                          +-----------|
+ | +-----+------+     +----+----+                                      |
+ |       |                 |                                           |
+ |       v                 v                                           |
+ |   +-------+        +------------------------------+                 |
+ |   |  MMU  |   +----+ IOMMU x4 (secure + insecure) |                 |
+ |   +---+---+   |    +------------------------------+                 |
+ |       |       |                                                     |
+ +--------------------+                                                |
+        |        |    |                                                |
+        v        v    |                                                |
+    +---+--------+-+  |                                                |
+    |    MEMORY    |  |     +----------+     +--------+     +-------+  |
+    |              +<-|-----+ IOMMU Rx |<----+ DMA Rx |<----+       |  |
+    |              |  |     +----------+     +--------+     |       |  |
+    |              |  |                                     |  NoC  |  |
+    |              |  |     +----------+     +--------+     |       |  |
+    |              +--|---->| IOMMU Tx +---->| DMA Tx +---->+       |  |
+    |              |  |     +----------+     +--------+     +-------+  |
+    |              |  +------------------------------------------------+
+    |              |
+    |              |     +--------------+     +------+
+    |              |<--->+ IOMMU Rx/Tx  +<--->+ PCIe +
+    |              |     +--------------+     +------+
+    |              |
+    |              |     +--------------+     +------------------------+
+    |              |<--->+ IOMMU Rx/Tx  +<--->+ master Soc Peripherals |
+    |              |     +--------------+     +------------------------+
+    +--------------+
+
+
+There is also an IOMMU dedicated to the crypto module but this module will not
+be accessed by the operating system.
+
+We will provide one driver to manage IOMMUs RX/TX. All of them will be
+described in the device tree to be able to get their particularities. See
+the example below that describes the relation between IOMMU, DMA and NoC in
+the cluster.
+
+IOMMU is related to a specific bus like PCIe we will be able to specify that
+all peripherals will go through this IOMMU.
+
+### IOMMU Page table
+
+We need to be able to know which IO virtual addresses (IOVA) are mapped in the
+TLB in order to be able to remove entries when a device finishes a transfer and
+release memory. This information could be extracted when needed by computing all
+sets used by the memory and then reads all sixteen ways and compare them to the
+IOVA but it won't be efficient. We also need to be able to translate an IOVA
+to a physical address as required by the iova_to_phys IOMMU ops that is used
+by DMA. Like previously it can be done by extracting the set from the address
+and comparing the IOVA to each sixteen entries of the given set.
+
+A solution is to keep a page table for the IOMMU. But this method is not
+efficient for reloading an entry of the TLB without the help of an hardware
+page table. So to prevent the need of a refill we will update the TLB when a
+device request access to memory and if there is no more slot available in the
+TLB we will just fail and the device will have to try again later. It is not
+efficient but at least we won't need to manage the refill of the TLB.
+
+This leads to an issue with the memory that can be used for transfer between
+device and memory (see Limitations below). As we only support 4Ko page size we
+can only map 8Mo. To be able to manage bigger transfer we can implement the
+huge page table in the Linux kernel and use a page table that match the size of
+huge page table for a given IOMMU (typically the PCIe IOMMU).
+
+As we won't refill the TLB we know that we won't have more than 128*16 entries.
+In this case we can simply keep a table with all possible entries.
+
+### Maintenance interface
+
+It is possible to have several "maintainers" for the same IOMMU. The driver is
+using two of them. One that writes the TLB and another interface reads TLB. For
+debug purpose it is possible to display the content of the tlb by using the
+following command in gdb:
+
+    gdb> p kvx_iommu_dump_tlb( <iommu addr>, 0)
+
+Since different management interface are used for read and write it is safe to
+execute the above command at any moment.
+
+### Interrupts
+
+IOMMU can have 3 kind of interrupts that corresponds to 3 different types of
+errors (no mapping. protection, parity). When the IOMMU is shared between
+clusters (SoC periph and PCIe) then fifteen IRQs are generated according to the
+configuration of an association table. The association table is indexed by the
+ASN number (9 bits) and the entry of the table is a subscription mask with one
+bit per destination. Currently this is not managed by the driver.
+
+The driver is only managing interrupts for the cluster. The mode used is the
+stall one. So when an interrupt occurs it is managed by the driver. All others
+interrupts that occurs are stored and the IOMMU is stalled. When driver cleans
+the first interrupt others will be managed one by one.
+
+### ASN (Address Space Number)
+
+This is also know as ASID in some other architecture. Each device will have a
+given ASN that will be given through the device tree. As address space is
+managed at the IOMMU domain level we will use one group and one domain per ID.
+ASN are coded on 9 bits.
+
+Device tree
+-----------
+
+Relationships between devices, DMAs and IOMMUs are described in the
+device tree (see Documentation/devicetree/bindings/iommu/kalray,kvx-iommu.txt
+for more details).
+
+Limitations
+-----------
+
+Only supporting 4 KB page size will limit the size of mapped memory to 8 MB
+because the IOMMU TLB can have at most 128*16 entries.
diff --git a/Documentation/kvx/kvx-mmu.txt b/Documentation/kvx/kvx-mmu.txt
new file mode 100644
index 000000000000..a3ebbef36981
--- /dev/null
+++ b/Documentation/kvx/kvx-mmu.txt
@@ -0,0 +1,272 @@
+MMU
+===
+
+Virtual addresses are on 41 bits for kvx when using 64-bit mode.
+To differentiate kernel from user space, we use the high order bit
+(bit 40). When bit 40 is set, then the higher remaining bits must also be set to
+1. The virtual address must be extended with 1 when the bit 40 is set,
+if not the address must be zero extended. Bit 40 is set for kernel space
+mappings and not set for user space mappings.
+
+Memory Map
+==========
+
+In Linux physical memories are arranged into banks according to the cost of an
+access in term of distance to a memory. As we are UMA architecture we only have
+one bank and thus one node.
+
+A node is divided into several kind of zone. For example if DMA can only access
+a specific area in the physical memory we will define a ZONE_DMA for this purpose.
+In our case we are considering that DMA can access all DDR so we don't have a specific
+zone for this. On 64 bit architecture all DDR can be mapped in virtual kernel space
+so there is no need for a ZONE_HIGHMEM. That means that in our case there is
+only one ZONE_NORMAL. This will be updated if DMA cannot access all memory.
+
+Currently, the memory mapping is the following for 4KB page:
+
++-----------------------+-----------------------+------+-------+--------------+
+| Start                 | End                   | Attr | Size  | Name         |
++-----------------------+-----------------------+------+-------+--------------+
+| 0000 0000 0000 0000   | 0000 003F FFFF FFFF   | ---  | 256GB | User         |
+| 0000 0040 0000 0000   | 0000 007F FFFF FFFF   | ---  | 256GB |   MMAP       |
+| 0000 0080 0000 0000   | FFFF FF7F FFFF FFFF   | ---  | ---   | Gap          |
+| FFFF FF80 0000 0000   | FFFF FFFF FFFF FFFF   | ---  | 512GB | Kernel       |
+|   FFFF FF80 0000 0000 |   FFFF FF8F FFFF FFFF | RWX  | 64GB  |   Direct Map |
+|   FFFF FF90 0000 0000 |   FFFF FF90 3FFF FFFF | RWX  | 1GB   |   Vmalloc    |
+|   FFFF FF90 4000 0000 |   FFFF FFFF FFFF FFFF | RW   | 447GB |   Free area  |
++-----------------------+-----------------------+------+-------+--------------+
+
+Enable the MMU
+==============
+
+All kernel functions and symbols are in virtual memory except for kvx_start()
+function which is loaded at 0x0 in physical memory.
+To be able to switch from physical addresses to virtual addresses we choose to
+setup the TLB at the very beginning of the boot process to be able to map both
+pieces of code. For this we added two entries in the LTLB. The first one,
+LTLB[0], contains the mapping between virtual memory and DDR. Its size is 512MB.
+The second entry, LTLB[1], contains a flat mapping of the first 2MB of the SMEM.
+Once those two entries are present we can enable the MMU. LTLB[1] will be
+removed during paging_init() because once we are really running in virtual space
+it will not be used anymore.
+In order to access more than 512MB DDR memory, the remaining memory (> 512MB) is
+refill using a comparison in kernel_perf_refill that does not walk the kernel
+page table, thus having a faster refill time for kernel. These entries are
+inserted into the LTLB for easier computation (4 LTLB entries). The drawback of
+this approach is that mapped entries are using RWX protection attributes,
+leading to no protection at all.
+
+Kernel strict RWX
+=================
+
+CONFIG_STRICT_KERNEL_RWX is enabled by default in default_defconfig.
+Once booted, if CONFIG_STRICT_KERNEL_RWX is enable, the kernel text and memory
+will be mapped in the init_mm page table. Once mapped, the refill routine for
+the kernel is patched to always do a page table walk, bypassing the faster
+comparison but enforcing page protection attributes when refilling.
+Finally, the LTLB[0] entry is replaced by a 4K one, mapping only exceptions with
+RX protection. It allows us to never trigger nomapping on nomapping refill
+routine which would (obviously) not work... Once this is done, we can flush the
+4 LTLB entries for kernel refill in order to be sure there is no stalled
+entries and that new entries inserted in JTLB will apply.
+
+By default, the following policy is applied on vmlinux sections:
+- init_data: RW
+- init_text: RX (or RWX if parameter rodata=off)
+- text: RX (or RWX if parameter rodata=off)
+- rodata: RW before init, RO after init
+- sdata: RW
+
+Kernel RWX mode can then be switched on/off using /sys/kvx/kernel_rwx file.
+
+Privilege Level
+================
+Since we are using privilege levels on kvx, we make use of the virtual
+spaces to be in the same space as the user. The kernel will have the
+$ps.mmup set in kernel (PL1) and unset for user (PL2).
+As said in kvx documentation, we have two cases when the kernel is
+booted:
+- Either we have been booted by someone (bootloader, hypervisor, etc)
+- Or we are alone (boot from flash)
+
+In both cases, we will use the virtual space 0. Indeed, if we are alone
+on the core, then it means nobody is using the MMU and we can take the
+first virtual space. If not alone, then when writing an entry to the tlb
+using writetlb instruction, the hypervisor will catch it and change the
+virtual space accordingly.
+
+Memblock
+========
+
+When the kernel starts there is no memory allocator available. One of the first
+step in the kernel is to detect the amount of DDR available by getting this
+information in the device tree and initialize the low-level "memblock" allocator.
+
+We start by reserving memory for the whole kernel. For instance with a device
+tree containing 512Mo of DDR you could see the following boot messages:
+
+setup_bootmem: Memory  : 0x100000000 - 0x120000000
+setup_bootmem: Reserved: 0x10001f000 - 0x1002d1bc0
+
+During the paging init we need to set:
+  - min_low_pfn that is the lowest PFN available in the system
+  - max_low_pfn that indicates the end if NORMAL zone
+  - max_pfn that is the number of pages in the system
+
+This setting is used for dividing memory into pages and for configuring the
+zone. See the memory map section for more information about ZONE.
+
+Zones are configured in free_area_init_core(). During start_kernel() other
+allocations are done for command line, cpu areas, PID hash table, different
+caches for VFS. This allocator is used until mem_init() is called.
+
+mem_init() is provided by the architecture. For MPPA we just call
+free_all_bootmem() that will go through all pages that are not used by the
+low level allocator and mark them as not used. So physical pages that are
+reserved for the kernel are still used and remain in physical memory. All pages
+released will now be used by the buddy allocator.
+
+Peripherals
+===========
+
+Peripherals are mapped using standard ioremap infrastructure, therefore
+mapped addresses are located in the vmalloc space.
+
+LTLB Usage
+==========
+
+LTLB is used to add resident mapping which allows for faster MMU lookup.
+Currently, the LTLB is used to map some mandatory kernel pages and to allow fast
+accesses to l2 cache (mailbox and registers).
+When CONFIG_STRICT_KERNEL_RWX is disabled, 4 entries are reserved for kernel
+TLB refill using 512MB pages. When CONFIG_STRICT_KERNEL_RWX is enabled, these
+entries are unused since kernel is paginated using the same mecanism than for
+user (page walking and entries in JTLB)
+
+Page Table
+==========
+
+We only support three levels for the page table and 4KB for page size.
+
+3 levels page table
+-------------------
+
+...-----+--------+--------+--------+--------+--------+
+      40|39    32|31    24|23    16|15     8|7      0|
+...-----++-------+--+-----+---+----+----+---+--------+
+         |          |         |         |
+         |          |         |         +--->  [11:0] Offset (12 bits)
+         |          |         +------------->  [20:12] PTE offset (9 bits)
+         |          +----------------------->  [29:21] PMD offset (9 bits)
+         +---------------------------------->  [39:30] PGD offset (10 bits)
+Bits 40 to 64 are signed extended according to bit 39. If bit 39 is equal to 1
+we are in kernel space.
+
+As 10 bits are used for PGD we need to allocate 2 pages.
+
+PTE format
+==========
+
+About the format of the PTE entry, as we are not forced by hardware for choices,
+we choose to follow the format described in the RiscV implementation as a
+starting point.
+
+ +---------+--------+----+--------+---+---+---+---+---+---+------+---+---+
+ | 63..23  | 22..13 | 12 | 11..10 | 9 | 8 | 7 | 6 | 5 | 4 | 3..2 | 1 | 0 |
+ +---------+--------+----+--------+---+---+---+---+---+---+------+---+---+
+     PFN     Unused   S    PageSZ   H   G   X   W   R   D    CP    A   P
+       where:
+        P: Present
+        A: Accessed
+        CP: Cache policy
+        D: Dirty
+        R: Read
+        W: Write
+        X: Executable
+        G: Global
+        H: Huge page
+        PageSZ: Page size as set in TLB format (0:4Ko, 1:64Ko, 2:2Mo, 3:512Mo)
+        S: Soft/Special
+        PFN: Page frame number (depends on page size)
+
+Huge bit must be somewhere in the first 12 bits to be able to detect it
+when reading the PMD entry.
+
+PageSZ must be on bit 10 and 11 because it matches the TEL.PS bits. And
+by doing that it is easier in assembly to set the TEL.PS to PageSZ.
+
+Fast TLB refill
+===============
+
+kvx core does not feature a hardware page walker. This work must be done
+by the core in software. In order to optimize TLB refill, a special fast
+path is taken when entering in kernel space.
+In order to speed up the process, the following actions are taken:
+# Save some registers in a per process scratchpad
+# If the trap is a nomapping then try the fastpath
+# Save some more registers for this fastpath
+# Check if faulting address is a memory direct mapping one.
+ # If entry is a direct mapping one and RWX is not enabled, add an entry into LTLB
+ # If not, continue
+# Try to walk the page table
+ # If entry is not present, take the slowpath (do_page_fault)
+# Refill the tlb properly
+# Exit by restoring only a few registers
+
+ASN Handling
+============
+
+Disclaimer: Some part of this are taken from ARC architecture.
+
+kvx MMU provides 9-bit ASN (Address Space Number) in order to tag TLB entries.
+It allows for multiple process with the same virtual space to cohabit without
+the need to flush TLB everytime we context switch.
+kvx implementation to use them is based on other architectures (such as arc
+or xtensa) and uses a wrapping ASN counter containing both cycle/generation and
+asn.
+
++---------+--------+
+|63     10|9      0|
++---------+--------+
+  Cycle      ASN
+
+This ASN counter is incremented monotonously to allocate new ASNs. When the
+counter reaches 511 (9 bit), TLB is completely flushed and a new cycle is
+started. A new allocation cycle, post rollover, could potentially reassign an
+ASN to a different task. Thus the rule is to reassign an ASN when the current
+context cycles does not match the allocation cycle.
+The 64 bit @cpu_asn_cache (and mm->asn) have 9 bits MMU ASN and rest 55 bits
+serve as cycle/generation indicator and natural 64 bit unsigned math
+automagically increments the generation when lower 9 bits rollover.
+When the counter completely wraps, we reset the counter to first cycle value
+(ie cycle = 1). This allows to distinguish context without any ASN and old cycle
+generated value with the same operation (XOR on cycle).
+
+Huge page
+=========
+
+Currently only 3 level page table has been implemented for 4Ko base page size.
+So the page shift is 12 bits, the pmd shift is 21 and the pgdir shift is 30
+bits. This choice implies that for 4Ko base page size if we use a PMD as a huge
+page the size will be 2Mo and if we use a PUD as a huge page it will be 1Go.
+
+To support other huge page sizes (64Ko and 512Mo) we need to use several
+contiguous entries in the page table. For huge page of 64Ko we will need to
+use 16 entries in the PTE and for a huge page of 512Mo it means that 256
+entries in PMD will be used.
+
+Debug
+=====
+
+In order to debug the page table and tlb entries, gdb scripts contains commands
+which allows to dump the page table:
+- lx-kvx-page-table-walk
+ - Display the current process page table by default
+- lx-kvx-tlb-decode
+ - Display the content of $tel and $teh into something readable
+
+Other commands available in kvx-gdb are the following:
+- mppa-dump-tlb
+ - Display the content of TLBs (JTLB and LTLB)
+- mppa-lookup-addr
+ - Find physical address matching a virtual one
diff --git a/Documentation/kvx/kvx-smp.txt b/Documentation/kvx/kvx-smp.txt
new file mode 100644
index 000000000000..1b69d77db8cd
--- /dev/null
+++ b/Documentation/kvx/kvx-smp.txt
@@ -0,0 +1,36 @@
+SMP
+===
+
+On kvx, 5 clusters are organized as groups of 16 processors + 1
+secure core (RM) for each cluster. These 17 processors are L1$ coherent
+for TCM (tightly Coupled Memory). A mixed hw/sw L2$ is present to have
+cache coherency on DDR as well as TCM.
+The RM manager is not meant to run Linux so, 16 processors are available
+for SMP.
+
+Booting
+=======
+
+When booting the kvx processor, only the RM is woken up. This RM will
+execute a portion of code located in a section named .rm_firmware.
+By default, a simple power off code is embedded in this section.
+To avoid embedding the firmware in kernel sources, the section is patched
+using external tools to add the L2$ firmware (and replace the default firmware).
+Before executing this firmware, the RM boots the PE0. PE0 will then enable L2
+coherency and request will be stalled until RM boots the L2$ firmware.
+
+Locking primitives
+==================
+
+spinlock/rwlock are using the kernel standard queued spinlock/rwlocks.
+These primitives are based on cmpxch and xchg. More particularly, it uses xchg16
+which is implemented as a read modify write with acswap on 32 bit word since
+kvx does not have cmpxchg for size < 32bits.
+
+IPI
+===
+
+An IPI controller allows to communicate between CPUs using a simple
+memory mapped register. This register can simply be written using a mask to
+trigger interrupts directly to the cores matching the mask.
+
diff --git a/Documentation/kvx/kvx.txt b/Documentation/kvx/kvx.txt
new file mode 100644
index 000000000000..8ce0703de681
--- /dev/null
+++ b/Documentation/kvx/kvx.txt
@@ -0,0 +1,268 @@
+kvx Core Implementation
+=======================
+
+This documents will try to explain any architecture choice for the kvx
+linux port.
+
+Regarding the peripheral, we MUST use device tree to describe ALL
+peripherals. The bindings should always start with "kalray,kvx" for all
+core related peripherals (watchdog, timer, etc)
+
+System Architecture
+===================
+
+On kvx, we have 4 levels of privilege level starting from 0 (most
+privileged one) to 3 (less privilege one). A system of owners allows
+to delegate ownership of resources by using specials system registers.
+
+The 2 main software stacks for Linux Kernel are the following:
+
++-------------+       +-------------+
+| PL0: Debug  |       | PL0: Debug  |
++-------------+       +-------------+
+| PL1: Linux  |       | PL1: HyperV |
++-------------+       +-------------+
+| PL2: User   |       | PL2: Linux  |
++-------------+       +-------------+
+|             |       | PL3: User   |
++-------------+       +-------------+
+
+In both cases, the kvx support for privileges has been designed using
+only relative PL and thus should work on both configurations without
+any modifications.
+
+When booting, the CPU is executing in PL0 and owns all the privileges.
+This level is almost dedicated to the debug routines for the debugguer.
+It only needs to own few privileges (breakpoint 0 and watchpoint 0) to
+be able to debug a system executing in PL1 to PL3.
+Debug routines are not always there for instance when the kernel is
+executing alone (booted from flash).
+In order to ease the load of debug routines, software convention is to
+jump directly to PL1 and let PL0 for the debug.
+When the kernel boots, it checks if the current privilege level is 0
+($ps.pl is the only absolute value). If so, then it will delegate
+almost all resources to PL1 and use a RFE to lower its execution
+privilege level (see asm_delegate_pl in head.S).
+If the current PL is already different from 0, then it means somebody
+is above us and we need to request resource to inform it we need them. It will
+then either delegate them to us directly or virtualize the delegation.
+All privileges levels have their set of banked registers (ps, ea, sps,
+sr, etc) which contain privilege level specific values.
+$sr (system reserved) is banked and will hold the current task_struct.
+This register is reserved and should not be touched by any other code.
+For more information, refer to the kvx system level architecture manual.
+
+Boot
+====
+
+On kvx, the RM (Secure Core) of Cluster 0 will boot first. It will then be able
+to boot a firmware. This firmware is stored in the rm_firmware section.
+The first argument ($r0) of this firmware will be a pointer to a function with
+the following prototype: void firmware_init_done(uint64_t features). This
+function is responsible of describing the features supported by the firmware and
+will start the first PE after that.
+By default, the rm_firmware function act as the "default" firmware. This
+function does nothing except calling firmware_init_done and then goes to sleep.
+In order to add another firmware, the rm_firmware section is patched using
+objcopy. The content of this section is then replaced by the provided firmware.
+This firmware will do an init and then call firmware_init_done before running
+the main loop.
+When the PE boots, it will check for the firmware features to enable or disable
+specific core features (L2$ for instance).
+
+When entering the C (kvx_lowlevel_start) the kernel will look for a special
+magic in $r0 (0x494C314B). This magic tells the kernel if there is arguments
+passed by a bootloader.
+Currently, the following values are passed through registers:
+ - r1: pointer to command line setup by bootloader
+ - r2: device tree
+
+If this magic is not set, then, the command line will be the one
+provided in the device tree (see bootargs). The default device tree is
+not builtin but will be patched by the runner used (simulator or jtag) in the
+dtb section.
+
+A default stdout-path is desirable to allow early printk.
+
+Boot Memory Allocator
+=====================
+
+The boot memory allocator is used to allocate memory before paging is enabled.
+It is initialized with DDR and also with the shared memory. This first one is
+initialized during the setup_bootmem() and the second one when calling
+early_init_fdt_scan_reserved_mem().
+
+
+Virtual and physical memory
+===========================
+
+The mapping used and the memory management is described in
+Documentation/kvx/kvx-mmu.txt.
+Our Kernel is compiled using virtual addresses that starts at
+0xffffff0000000000. But when it is started the kernel uses physical addresses.
+Before calling the first function arch_low_level_start() we configure 2 entries
+of the LTLB.
+
+The first entry will map the first 1G of virtual address space to the first
+1G of DDR:
+  - TLB[0]: 0xffffff0000000000 -> 0x100000000 (size 512Mo)
+
+The second entry will be a flat mapping of the first 512 Ko of the SMEM. It
+is required to have this flat mapping because there is still code located at
+this address that needs to be executed:
+  - TLB[1]: 0x0 -> 0x0 (size 512Ko)
+
+Once virtual space reached the second entry is removed.
+
+To be able to set breakpoints when MMU is enabled we added a label called
+gdb_mmu_enabled. If you try to set a breakpoint on a function that is in
+virtual memory before the activation of the MMU this address as no signification
+for GDB. So, for example, if you want to break on the function start_kernel()
+you will need to run:
+
+	kvx-gdb -silent path_to/vmlinux \
+		-ex 'tbreak gdb_mmu_enabled' -ex 'run' \
+		-ex 'break start_kernel' \
+		-ex 'continue'
+
+We will also add an option to kvx-gdb to simplify this step.
+
+Timers
+======
+
+The free-runinng clock (clocksource) is based on the DSU. This clock is
+not interruptible and never stops even if core go into idle.
+
+Regarding the tick (clockevent), we use the timer 0 available on the core.
+This timer allows to set a periodic tick which will be used as the main
+tick for each core. Note that this clock is percpu.
+
+get_cycles implementation is based on performance counter. One of them
+is used to count cycles. Note that since this is used only when the core
+is running, there is no need to worry about core sleeping (which will
+stop the cycle counter)
+
+Context switching
+=================
+
+context switching is done in entry.S. When spawning a fresh thread,
+copy_thread is called. During this call, we setup callee saved register
+r20 and r21 to special values containing the function to call.
+
+The normal path for a kernel thread will be the following:
+
+ 1 - Enter copy_thread_tls and setup callee saved registers which will
+     be restored in __switch_to.
+ 2 - set r20 and r21 (in thread_struct) to function and argument and
+     ra to ret_from_kernel_thread.
+     These callee saved will be restored in switch_to.
+ 3 - Call _switch_to at some point.
+ 4 - Save all callee saved register since switch_to is seen as a
+     standard function call by the caller.
+ 5 - Change stack pointer to the new stack
+ 6 - At the end of switch to, set sr0 to the new task and use ret to
+     jump to ret_from_kernel_thread (address restored from ra).
+ 7 - In ret_from_kernel_thread, execute the function with arguments by
+     using r20, r21 and we are done
+
+For more explanation, you can refer to https://lwn.net/Articles/520227/
+
+User thread creation
+====================
+
+We are using almost the same path as copy_thread to create it.
+The detailed path is the following:
+
+ 1 - Call start_thread which will setup user pc and stack pointer in
+     task regs. We also set sps and clear privilege mode bit.
+     When returning from exception, it will "flip" to user mode.
+ 2 - Enter copy_thread_tls and setup callee saved registers which will
+     be restored in __switch_to. Also, set the "return" function to be
+     ret_from_fork which will be called at end of switch_to
+ 3 - set r20 (in thread_struct) with tracing information.
+     (simply by lazyness to avoid computing it in assembly...)
+ 4 - Call _switch_to at some point.
+ 5 - The current pc will then be restored to be ret_from fork.
+ 6 - Ret from fork calls schedule_tail and then check if tracing is
+     enabled. If so call syscall_trace_exit
+ 7 - finally, instead of returning to kernel, we restore all registers
+     that have been setup by start_thread by restoring regs stored on
+     stack
+
+L2$ handling
+============
+
+On kvx, the L2$ is handled by a firmware running on the RM. This firmware needs
+various information to be aware of its configuration and communicate with the
+kernel. In order to do that, when firmware is starting, the device tree is given
+as parameter along with the "registers" zone. This zone is simply a memory area
+where data are exchanged between kernel <-> L2$. When some commands are written
+to it, the kernel sends an interrupt using a mailbox.
+If the L2$ node is not present in the device tree, then, the RM will directly go
+into sleeping.
+
+Boot diagram:
+
+           RM                       PE 0
+                          +
+       +---------+        |
+       |  Boot   |        |
+       +----+----+        |
+            |             |
+            v             |
+      +-----+-----+       |
+      |  Prepare  |       |
+      | L2 shared |       |
+      |  memory   |       |
+      |(registers)|       |
+      +-----+-----+       |
+            |             |      +-----------+
+            +------------------->+   Boot    |
+            |             |      +-----+-----+
+            v             |            |
+   +--------+---------+   |            |
+   | L2 firmware      |   |            |
+   | parameters:      |   |            |
+   | r0 = registers   |   |            |
+   | r1 = DTB         |   |            |
+   +--------+---------+   |            |
+            |             |            |
+            v             |            |
+    +-------+--------+    |     +------+------+
+    |  L2 firmware   |    |     | Wait for L2 |
+    |   execution    |    |     | to be ready |
+    +-------+--------+    |     +------+------+
+            |             |            |
+     +------v-------+     |            v
+     | L2 requests  |     |     +------+------+
++--->+   handling   |     |     |   Enable    |
+|    +-------+------+     |     | L2 caching  |
+|            |            |     +------+------+
+|            |            |            |
++------------+            +            v
+
+
+Since this driver is started early (before SMP boot), A lot of drivers are not
+yet probed (mailboxes, iommu, etc) and thus can not be used.
+
+Building
+========
+
+In order to build the kernel, you will need a complete kvx toolchain.
+First, setup the config using the following command line
+
+$ make ARCH=kvx O=your_directory default_defconfig
+
+Adjust any configuration option you may need and then, build the kernel:
+
+$ make ARCH=kvx O=your_directory -j12
+
+You will finally have a vmlinux image ready to be run.
+
+$ kvx-mppa -- vmlinux
+
+Additionally, you may want to debug it. To do so, use kvx-gdb:
+
+$ kvx-gdb vmlinux
+
+
-- 
2.37.2







