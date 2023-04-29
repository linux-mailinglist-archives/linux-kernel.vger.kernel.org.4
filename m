Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E860E6F25F4
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 21:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjD2TRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 15:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjD2TRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 15:17:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA06A10C8;
        Sat, 29 Apr 2023 12:17:15 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33TJBrk5006821;
        Sat, 29 Apr 2023 19:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=U7cBPtBD74et/mq/30RW2kWeKjHp8DEOTwuK/Zfl808=;
 b=tXFgbEj+FuEKzERSOmcMwFkKx3x0bMlrRTp1tQBF2GcccE38bWXw/gTc887dG/3XPcd0
 8vbO8g/fikoQqUMJ8TJIFY6asu3KND9RCNljK+oiWKH94ExgxLNX9Exkn9fo0JEV6oCS
 y9Q7Ee6F+WP9qubRr+VTdqbf56uNWBFbqU1u/BzUgCyDlfrYXfGNPk0P0yIrjKfWl6M5
 KqbPAYJeZ8IgaCrE4ZOJLGtC1wHm2L0aj4LsDCpw491+km0DihwCfFfQzBtH/YXuM43x
 F7B8zaVROCQcHv6Pr62tyjXngJcyHbaCSXOWGdYY75N86zABOpM9rJWllxfCNYswVo4H Zg== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q98rp0g86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Apr 2023 19:17:10 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33TIi3Fc014837;
        Sat, 29 Apr 2023 19:17:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3q8tv6r89e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Apr 2023 19:17:07 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33TJH47H34013848
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Apr 2023 19:17:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C4B020043;
        Sat, 29 Apr 2023 19:17:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7DB820040;
        Sat, 29 Apr 2023 19:17:03 +0000 (GMT)
Received: from localhost (unknown [9.179.20.219])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Sat, 29 Apr 2023 19:17:03 +0000 (GMT)
Date:   Sat, 29 Apr 2023 21:17:02 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 patches for the 6.4 merge window
Message-ID: <your-ad-here.call-01682795822-ext-1971@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UrzPOFkUgjE_hbBDWafKOIdQfs-EsqpL
X-Proofpoint-GUID: UrzPOFkUgjE_hbBDWafKOIdQfs-EsqpL
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-29_03,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1011
 mlxscore=0 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304290182
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 6.4. There is a stackleak common code change
which allow specifying architecture-specific stackleak poison function
to enable faster implementation. This change has been acked-by Mark Rutland.
https://lore.kernel.org/all/ZDZz8QvPdpGJqMd6@FVFF77S0Q05N/

There are a few small merge conflicts, notably with driver-core and tip
trees. Both have already been pulled, and here are the manual conflict
resolutions:

diff --cc arch/s390/kernel/setup.c
index 4259b6c50516,0903fe356634..fe10da1a271e
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@@ -385,18 -381,13 +381,13 @@@ void stack_free(unsigned long stack
  #endif
  }
  
- int __init arch_early_irq_init(void)
 -void __init arch_call_rest_init(void)
++void __init __noreturn arch_call_rest_init(void)
  {
- 	unsigned long stack;
- 
- 	stack = __get_free_pages(GFP_KERNEL, THREAD_SIZE_ORDER);
- 	if (!stack)
- 		panic("Couldn't allocate async stack");
- 	S390_lowcore.async_stack = stack + STACK_INIT_OFFSET;
- 	return 0;
+ 	smp_reinit_ipl_cpu();
+ 	rest_init();
  }
  
- void __init __noreturn arch_call_rest_init(void)
+ static unsigned long __init stack_alloc_early(void)
  {
  	unsigned long stack;
  
diff --cc arch/s390/kernel/topology.c
index 72af753d1bba,e5d6a1c25d13..9fd19530c9a5
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@@ -637,33 -637,14 +637,23 @@@ static struct ctl_table topology_ctl_ta
  	{ },
  };
  
- static struct ctl_table topology_dir_table[] = {
- 	{
- 		.procname	= "s390",
- 		.maxlen		= 0,
- 		.mode		= 0555,
- 		.child		= topology_ctl_table,
- 	},
- 	{ },
- };
- 
  static int __init topology_init(void)
  {
 +	struct device *dev_root;
 +	int rc = 0;
 +
  	timer_setup(&topology_timer, topology_timer_fn, TIMER_DEFERRABLE);
  	if (MACHINE_HAS_TOPOLOGY)
  		set_topology_timer();
  	else
  		topology_update_polarization_simple();
- 	register_sysctl_table(topology_dir_table);
+ 	register_sysctl("s390", topology_ctl_table);
 -	return device_create_file(cpu_subsys.dev_root, &dev_attr_dispatching);
 +
 +	dev_root = bus_get_dev_root(&cpu_subsys);
 +	if (dev_root) {
 +		rc = device_create_file(dev_root, &dev_attr_dispatching);
 +		put_device(dev_root);
 +	}
 +	return rc;
  }
  device_initcall(topology_init);
--

Also, a fixup is required for the drivers/s390/crypto/ap_bus.c:

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 85bb0de15e76..8d6b9a52bf3c 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -1570,7 +1570,7 @@ static ssize_t bindings_show(const struct bus_type *bus, char *buf)
 
 static BUS_ATTR_RO(bindings);
 
-static ssize_t features_show(struct bus_type *bus, char *buf)
+static ssize_t features_show(const struct bus_type *bus, char *buf)
 {
        int n = 0;
 
--
Besides that auto-merging does well.

Thank you,
Vasily

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.4-1

for you to fetch changes up to 2a405f6bb3a5b2baaa74dfc5aaa0e1b99145bd1b:

  s390/stackleak: provide fast __stackleak_poison() implementation (2023-04-20 11:36:35 +0200)

----------------------------------------------------------------
s390 updates for the 6.4 merge window

- Add support for stackleak feature. Also allow specifying
  architecture-specific stackleak poison function to enable faster
  implementation. On s390, the mvc-based implementation helps decrease
  typical overhead from a factor of 3 to just 25%

- Convert all assembler files to use SYM* style macros, deprecating the
  ENTRY() macro and other annotations. Select ARCH_USE_SYM_ANNOTATIONS

- Improve KASLR to also randomize module and special amode31 code
  base load addresses

- Rework decompressor memory tracking to support memory holes and improve
  error handling

- Add support for protected virtualization AP binding

- Add support for set_direct_map() calls

- Implement set_memory_rox() and noexec module_alloc()

- Remove obsolete overriding of mem*() functions for KASAN

- Rework kexec/kdump to avoid using nodat_stack to call purgatory

- Convert the rest of the s390 code to use flexible-array member instead
  of a zero-length array

- Clean up uaccess inline asm

- Enable ARCH_HAS_MEMBARRIER_SYNC_CORE

- Convert to using CONFIG_FUNCTION_ALIGNMENT and enable
  DEBUG_FORCE_FUNCTION_ALIGN_64B

- Resolve last_break in userspace fault reports

- Simplify one-level sysctl registration

- Clean up branch prediction handling

- Rework CPU counter facility to retrieve available counter sets just
  once

- Other various small fixes and improvements all over the code

----------------------------------------------------------------
Al Viro (1):
      s390: trim ancient junk from copy_thread()

Alexander Gordeev (5):
      s390/kexec: turn DAT mode off immediately before purgatory
      s390/kdump: cleanup do_start_kdump() prototype and usage
      s390/kdump: fix virtual vs physical address confusion
      s390/kdump: rework invocation of DAT-off code
      s390/kdump: remove nodat stack restriction for calling nodat functions

Gustavo A. R. Silva (2):
      s390/diag: replace zero-length array with flexible-array member
      s390/fcx: replace zero-length array with flexible-array member

Harald Freudenberger (15):
      s390/zcrypt: make psmid unsigned long instead of long long
      s390/zcrypt: rework length information for dqap
      s390/zcrypt: replace scnprintf with sysfs_emit
      s390/ap: exploit new B bit from QCI config info
      s390/ap: introduce new AP bus sysfs attribute features
      s390/ap: make tapq gr2 response a struct
      s390/ap: filter ap card functions, new queue functions attribute
      s390/ap: provide F bit parameter for ap_rapq() and ap_zapq()
      s390/ap: new low level inline functions ap_bapq() and ap_aapq()
      s390/ap: introduce low frequency polling possibility
      s390/ap: implement SE AP bind, unbind and associate
      s390/ap: add ap status asynch error support
      s390/zcrypt: remove unused ancient padding code
      s390/zcrypt: simplify prep of CCA key token
      s390/zcrypt: rework arrays with length zero occurrences

Heiko Carstens (66):
      s390: update defconfigs
      s390/bp: add missing BPENTER to program check handler
      s390/bp: remove TIF_ISOLATE_BP
      s390/bp: remove s390_isolate_bp_guest()
      s390/bp: remove __bpon()
      s390/setup: always inline gen_lpswe()
      Merge branch 'decompressor-memory-tracking' into features
      s390: make use of CONFIG_FUNCTION_ALIGNMENT
      s390/ftrace: move hotpatch trampolines to mcount.S
      s390/expoline: use __ALIGN instead of open coded .align
      s390/vdso: use __ALIGN instead of open coded .align
      s390: enable DEBUG_FORCE_FUNCTION_ALIGN_64B
      s390/mm: make use of atomic_fetch_xor()
      s390: enable ARCH_HAS_MEMBARRIER_SYNC_CORE
      s390/uaccess: add missing earlyclobber annotations to __clear_user()
      s390/uaccess: use symbolic names for inline assembly operands
      s390/uaccess: remove unused label in inline assemblies
      s390/uaccess: rename/sort labels in inline assemblies
      s390/uaccess: sort EX_TABLE list for inline assemblies
      s390/uaccess: rename tmp1 and tmp2 variables
      s390/uaccess: get rid of not needed local variable
      s390/uaccess: remove extra blank line
      s390/dumpstack: simplify in stack logic code
      s390/stack: use STACK_INIT_OFFSET where possible
      s390/stack: set lowcore kernel stack pointer early
      s390: use init_thread_union aka initial stack for the first process
      s390/stacktrace: remove call_on_stack_noreturn()
      s390: remove arch_early_irq_init()
      s390: move on_thread_stack() to processor.h
      s390: enable HAVE_ARCH_STACKLEAK
      s390/checksum: always use cksm instruction
      s390/checksum: remove not needed uaccess.h include
      s390/kaslr: provide kaslr_enabled() function
      s390/kaslr: randomize module base load address
      s390/mm: implement set_memory_rox()
      s390/mm: implement set_memory_rwnx()
      s390/mm: use set_memory_*() helpers instead of open coding
      s390/ftrace: do not assume module_alloc() returns executable memory
      s390/module: create module allocations without exec permissions
      s390/mm: rename POPULATE_ONE2ONE to POPULATE_DIRECT
      s390/mm: fix direct map accounting
      s390/debug: replace zero-length array with flexible-array member
      s390/sclp: replace zero-length array with flexible-array member
      s390/cio: replace zero-length array with flexible-array member
      s390/kasan: remove override of mem*() functions
      s390/lib: use SYM* macros instead of ENTRY(), etc.
      s390/amode31: use SYM* macros instead of ENTRY(), etc.
      s390/crypto,chacha: use SYM* macros instead of ENTRY(), etc.
      s390/crc32be: use SYM* macros instead of ENTRY(), etc.
      s390/crc32le: use SYM* macros instead of ENTRY(), etc.
      s390/mcount: use SYM* macros instead of ENTRY(), etc.
      s390/earlypgm: use SYM* macros instead of ENTRY(), etc.
      s390/head64: use SYM* macros instead of ENTRY(), etc.
      s390/reipl: use SYM* macros instead of ENTRY(), etc.
      s390/kprobes: use SYM* macros instead of ENTRY(), etc.
      s390/purgatory: use SYM* macros instead of ENTRY(), etc.
      s390/entry: use SYM* macros instead of ENTRY(), etc.
      s390/relocate_kernel: use SYM* macros instead of ENTRY(), etc.
      s390/relocate_kernel: adjust indentation
      s390/mm: use BIT macro to generate SET_MEMORY bit masks
      s390/mm: enable ARCH_HAS_SET_DIRECT_MAP
      s390: wire up memfd_secret system call
      s390/mm: use VM_FLUSH_RESET_PERMS in module_alloc()
      s390: select ARCH_USE_SYM_ANNOTATIONS
      stackleak: allow to specify arch specific stackleak poison function
      s390/stackleak: provide fast __stackleak_poison() implementation

Ilya Leoshkevich (1):
      s390/dumpstack: resolve userspace last_break

Lizhe (1):
      s390/vfio-ap: remove redundant driver match function

Luis Chamberlain (6):
      s390: simplify one-level sysctl registration for topology_ctl_table
      s390: simplify one-level syctl registration for s390dbf_table
      s390: simplify one-level sysctl registration for appldata_table
      s390: simplify one level sysctl registration for cmm_table
      s390: simplify one-level sysctl registration for page_table_sysctl
      s390: simplify dynamic sysctl registration for appldata_register_ops

Marc Hartmayer (1):
      s390/boot: improve install.sh script

Nico Boehr (1):
      s390/ipl: fix physical-virtual confusion for diag308

Niklas Schnelle (4):
      PCI: s390: Fix use-after-free of PCI resources with per-function hotplug
      s390/pci: only add specific device in zpci_bus_scan_device()
      s390/pci: remove redundant pci_bus_add_devices() on new bus
      s390/pci: clean up left over special treatment for function zero

Sven Schnelle (1):
      s390/ipl: add missing intersection check to ipl_report handling

Thomas Richter (7):
      s390/cpum_sf: remove flag PERF_CPUM_SF_FULL_BLOCKS
      s390/cpum_cf: log bad return code of function cfset_all_copy
      s390/cpum_cf: remove unnecessary copy_from_user call
      s390/cpum_cf: simplify pr_err() statement in cpumf_pmu_enable/disable
      s390/cpum_cf: introduce static CPU counter facility information
      s390/cpum_cf: provide counter number to validate_ctr_version()
      s390/cpum_cf: remove function validate_ctr_auth() by inline code

Vasily Gorbik (12):
      s390/boot: remove non-functioning image bootable check
      s390/boot: rename mem_detect to physmem_info
      s390/boot: rework decompressor reserved tracking
      s390/mm,pageattr: allow KASAN shadow memory
      s390/kasan: move shadow mapping to decompressor
      Merge branch 'uaccess-inline-asm-cleanup' into features
      s390/entry: rely on long-displacement facility
      s390: make extables read-only
      s390/boot: do not change default_lma
      s390/boot: pin amode31 default lma
      s390/kaslr: generalize and improve random base distribution
      s390/kaslr: randomize amode31 base address

Yu Zhe (1):
      s390/zcrypt: remove unnecessary (void *) conversions

 .../sched/membarrier-sync-core/arch-support.txt    |   4 +-
 arch/s390/Kconfig                                  |  10 +-
 arch/s390/appldata/appldata_base.c                 |  32 +-
 arch/s390/boot/Makefile                            |   2 +-
 arch/s390/boot/boot.h                              |  42 ++-
 arch/s390/boot/install.sh                          |   8 +-
 arch/s390/boot/ipl_parm.c                          |   6 +-
 arch/s390/boot/ipl_report.c                        | 100 ++---
 arch/s390/boot/kaslr.c                             | 171 +++++----
 arch/s390/boot/mem_detect.c                        | 191 ----------
 arch/s390/boot/pgm_check_info.c                    |   7 +-
 arch/s390/boot/physmem_info.c                      | 328 +++++++++++++++++
 arch/s390/boot/startup.c                           | 129 ++++---
 arch/s390/boot/vmem.c                              | 284 +++++++++++---
 arch/s390/boot/vmlinux.lds.S                       |   2 +
 arch/s390/configs/debug_defconfig                  |  13 +-
 arch/s390/configs/defconfig                        |  12 +-
 arch/s390/configs/zfcpdump_defconfig               |   2 +-
 arch/s390/crypto/chacha-s390.S                     |  47 +--
 arch/s390/crypto/crc32be-vx.S                      |  17 +-
 arch/s390/crypto/crc32le-vx.S                      |  30 +-
 arch/s390/include/asm/ap.h                         | 152 ++++++--
 arch/s390/include/asm/checksum.h                   |  10 +-
 arch/s390/include/asm/diag.h                       |   2 +-
 arch/s390/include/asm/entry-common.h               |   5 -
 arch/s390/include/asm/fcx.h                        |   2 +-
 arch/s390/include/asm/kasan.h                      |  31 +-
 arch/s390/include/asm/linkage.h                    |   2 +-
 arch/s390/include/asm/mem_detect.h                 | 117 ------
 arch/s390/include/asm/nospec-insn.h                |   3 +-
 arch/s390/include/asm/perf_event.h                 |   2 -
 arch/s390/include/asm/pgtable.h                    |   2 +-
 arch/s390/include/asm/physmem_info.h               | 171 +++++++++
 arch/s390/include/asm/processor.h                  |  46 ++-
 arch/s390/include/asm/set_memory.h                 |  36 +-
 arch/s390/include/asm/setup.h                      |  20 +-
 arch/s390/include/asm/stacktrace.h                 |  52 ++-
 arch/s390/include/asm/string.h                     |  15 +-
 arch/s390/include/asm/thread_info.h                |  10 +-
 arch/s390/kernel/debug.c                           |  14 +-
 arch/s390/kernel/dumpstack.c                       |  46 ++-
 arch/s390/kernel/early.c                           |  23 +-
 arch/s390/kernel/earlypgm.S                        |   4 +-
 arch/s390/kernel/entry.S                           | 152 ++++----
 arch/s390/kernel/ftrace.c                          |  22 +-
 arch/s390/kernel/head64.S                          |  14 +-
 arch/s390/kernel/ipl.c                             |   7 +-
 arch/s390/kernel/kprobes.c                         |   2 +-
 arch/s390/kernel/kprobes_insn_page.S               |   4 +-
 arch/s390/kernel/machine_kexec.c                   |  56 ++-
 arch/s390/kernel/mcount.S                          |  26 +-
 arch/s390/kernel/module.c                          |  29 +-
 arch/s390/kernel/perf_cpum_cf.c                    | 206 +++++------
 arch/s390/kernel/perf_cpum_sf.c                    |  14 +-
 arch/s390/kernel/process.c                         |  10 +-
 arch/s390/kernel/processor.c                       |  18 -
 arch/s390/kernel/reipl.S                           |  10 +-
 arch/s390/kernel/relocate_kernel.S                 |  96 +++--
 arch/s390/kernel/setup.c                           | 152 +++-----
 arch/s390/kernel/smp.c                             |  11 +-
 arch/s390/kernel/syscalls/syscall.tbl              |   2 +-
 arch/s390/kernel/text_amode31.S                    |  75 ++--
 arch/s390/kernel/topology.c                        |  12 +-
 arch/s390/kernel/vdso32/vdso_user_wrapper.S        |   3 +-
 arch/s390/kernel/vdso64/vdso_user_wrapper.S        |   5 +-
 arch/s390/kernel/vmlinux.lds.S                     |  10 +-
 arch/s390/lib/mem.S                                |  28 +-
 arch/s390/lib/uaccess.c                            | 137 +++----
 arch/s390/mm/Makefile                              |   3 -
 arch/s390/mm/cmm.c                                 |  12 +-
 arch/s390/mm/init.c                                |   5 +-
 arch/s390/mm/kasan_init.c                          | 301 ---------------
 arch/s390/mm/pageattr.c                            |  94 ++++-
 arch/s390/mm/pgalloc.c                             |  20 +-
 arch/s390/mm/vmem.c                                |  35 +-
 arch/s390/pci/pci.c                                |  39 +-
 arch/s390/pci/pci_bus.c                            |  23 +-
 arch/s390/pci/pci_bus.h                            |   3 +-
 arch/s390/purgatory/head.S                         |  62 +---
 arch/s390/purgatory/kexec-purgatory.S              |  14 +-
 drivers/pci/bus.c                                  |  21 ++
 drivers/s390/char/sclp.h                           |   2 +-
 drivers/s390/char/sclp_cmd.c                       |   2 +-
 drivers/s390/char/sclp_early_core.c                |   8 +-
 drivers/s390/cio/chsc.c                            |   2 +-
 drivers/s390/cio/chsc.h                            |   2 +-
 drivers/s390/crypto/ap_bus.c                       | 254 +++++++------
 drivers/s390/crypto/ap_bus.h                       |  70 ++--
 drivers/s390/crypto/ap_card.c                      |  23 +-
 drivers/s390/crypto/ap_queue.c                     | 410 +++++++++++++++++----
 drivers/s390/crypto/vfio_ap_drv.c                  |   6 -
 drivers/s390/crypto/vfio_ap_ops.c                  |  16 +-
 drivers/s390/crypto/zcrypt_api.c                   |  60 +--
 drivers/s390/crypto/zcrypt_card.c                  |   6 +-
 drivers/s390/crypto/zcrypt_cca_key.h               |  37 +-
 drivers/s390/crypto/zcrypt_ccamisc.c               |  74 ++--
 drivers/s390/crypto/zcrypt_cex2c.c                 |  66 ++--
 drivers/s390/crypto/zcrypt_cex4.c                  | 141 ++++---
 drivers/s390/crypto/zcrypt_ep11misc.c              |   2 +-
 drivers/s390/crypto/zcrypt_msgtype50.c             |  15 +-
 drivers/s390/crypto/zcrypt_msgtype6.c              | 139 +++----
 drivers/s390/crypto/zcrypt_queue.c                 |   4 +-
 include/linux/pci.h                                |   1 +
 kernel/stackleak.c                                 |  17 +-
 lib/Kconfig.debug                                  |   2 +-
 105 files changed, 2831 insertions(+), 2463 deletions(-)
 delete mode 100644 arch/s390/boot/mem_detect.c
 create mode 100644 arch/s390/boot/physmem_info.c
 delete mode 100644 arch/s390/include/asm/mem_detect.h
 create mode 100644 arch/s390/include/asm/physmem_info.h
 delete mode 100644 arch/s390/mm/kasan_init.c
