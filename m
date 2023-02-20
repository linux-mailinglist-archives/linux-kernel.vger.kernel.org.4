Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFCE69CA72
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 13:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjBTMCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 07:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjBTMCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:02:14 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C921B561;
        Mon, 20 Feb 2023 04:02:12 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31KACp12022284;
        Mon, 20 Feb 2023 12:02:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=Kyxo6XQZYXPjt9mqETvHtxnwhzGzq1Xw+Ih//NsBJAg=;
 b=Iw/g0PtQjUnoc8TqZN5+e5ZdkD8LdR5SK/CWYg5uSSawNTUyVPYpF1gfYNApbOtsA28+
 4tO3PfuLitwC/vc1td1MX2LFBZucK+u+njNPUvKwvTCCNTDOqoO0F3Lg98Zdh5LW1ANC
 RLUeuWslYZXxHZe95vrSZgsmDM+eDCenm9Jmchw99qQhTXyrFFYvrmuSUfdYFtHE9Hnd
 QrT/Zo7rKiTVhG0/pXlkwE2DRm+BpLXEguTQ5UuPQKjMKADcnH9QsgnOR3BZZzM+8aus
 MEd8b29FKz8Qs9Mif7lXbOy8HJzbD1H3elb5kTGoPVvnQOul6NYyM5IWJc/qksek+12y kg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nv6wkj8xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 12:02:10 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31K6oCnk002338;
        Mon, 20 Feb 2023 12:02:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3ntnxf20hk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 12:02:07 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31KC23Ap25166090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Feb 2023 12:02:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9390E20040;
        Mon, 20 Feb 2023 12:02:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1060F2004B;
        Mon, 20 Feb 2023 12:02:03 +0000 (GMT)
Received: from osiris (unknown [9.171.2.64])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 20 Feb 2023 12:02:02 +0000 (GMT)
Date:   Mon, 20 Feb 2023 13:02:01 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.3 merge window
Message-ID: <Y/NhOcWmhpYRPnK0@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FaddgqflsRy0UBbYvGK3eHdi3ndQ520U
X-Proofpoint-GUID: FaddgqflsRy0UBbYvGK3eHdi3ndQ520U
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_08,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302200109
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 updates for the 6.3 merge window.

Please note that there will be a trivial merge conflict with the tip tree
(sched/core branch): within both trees are commits which remove code from
s390's arch_cpu_idle(). The merge resolution is to simply remove all lines
specified in both trees.

Also the shortstat when merging will look slightly different to the one
generated with 'git request-pull' below, since I merged our fixes branch
twice to avoid merge conflicts. So the real shortstat should look like:

 102 files changed, 4581 insertions(+), 4583 deletions(-)

Thanks,
Heiko

The following changes since commit b7bfaa761d760e72a969d116517eaa12e404c262:

  Linux 6.2-rc3 (2023-01-08 11:49:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.3-1

for you to fetch changes up to 6472a2dcc4274452bb46fb5a0d968a1c1ed772ee:

  s390/irq,idle: simplify idle check (2023-02-15 11:07:01 +0100)

----------------------------------------------------------------
s390 updates for 6.3 merge window

- Large cleanup of the con3270/tty3270 driver. Among others this fixes:
  * Background Color Support
  * ASCII Line Character Support
  * VT100 Support
  * Geometries other than 80x24

- Cleanup and improve cmpxchg() code. Also add cmpxchg_user_key() to
  uaccess functions, which will be used by KVM to access KVM guest memory
  with a specific storage key.

- Add support for user space events counting to CPUMF.

- Cleanup the vfio/ccw code, which also allows now to properly support 2K
  Format-2 IDALs.

- Move kernel page table allocation and initialization to decompressor,
  which finally allows to enter the kernel with dynamic address translation
  enabled. This in turn allows to get rid of code with special handling in
  the kernel, which has to distinguish if DAT is on or off.

- Replace kretprobe with rethook.

- Various improvements to vfio/ap queue resets:
  * Use TAPQ to verify completion of a reset in progress rather than
    multiple invocations of ZAPQ.
  * Check TAPQ response codes when verifying successful completion of ZAPQ.
  * Fix erroneous handling of some error response codes.
  * Increase the maximum amount of time to wait for successful completion
    of ZAPQ.

- Rework system call wrappers to get rid of alias functions, which were
  only left on s390.

- Cleanup diag288_wdt watchdog driver. It has been agreed on with Guenter
  Roeck that this goes upstream via the s390 tree.

- Add missing loadparm parameter handling for list-directed ECKD ipl/reipl.

- Various improvements to memory detection code.

- Remove arch_cpu_idle_time() since the current implementation is broken,
  and allows user space observable accounted idle times which can
  temporarily decrease.

- Add Reset DAT-Protection support: (only) allow to change PTEs from RO to
  RW with a new RDP instruction. Unlike the currently used IPTE
  instruction, this does not necessarily guarantee that TLBs of all CPUs
  are synchronously flushed; and that remote CPUs can see spurious
  protection faults. The overall improvement for not requiring an all CPU
  synchronization, like it is required with IPTE, should be beneficial.

- Fix KFENCE page fault reporting.

- Smaller cleanups and improvement all over the place.

----------------------------------------------------------------
Alexander Egorenkov (8):
      s390/kexec: fix ipl report address for kdump
      watchdog: diag288_wdt: do not use stack buffers for hardware data
      watchdog: diag288_wdt: fix __diag288() inline assembly
      watchdog: diag288_wdt: get rid of register asm
      watchdog: diag288_wdt: remove power management
      watchdog: diag288_wdt: unify command buffer handling for diag288 zvm
      watchdog: diag288_wdt: de-duplicate diag_stat_inc() calls
      watchdog: diag288_wdt: unify lpar and zvm diag288 helpers

Alexander Gordeev (16):
      s390: expicitly align _edata and _end symbols on page boundary
      s390/boot: cleanup decompressor header files
      s390/early: fix sclp_early_sccb variable lifetime
      s390/kasan: sort out physical vs virtual memory confusion
      s390/kasan: cleanup setup of zero pgtable
      s390/kasan: cleanup setup of untracked memory pgtables
      s390/kasan: use set_pXe_bit() for pgtable entries setup
      s390/pgtable: add REGION3_KERNEL_EXEC protection
      s390/boot: detect and enable memory facilities
      s390/mm: start kernel with DAT enabled
      s390/maccess: remove dead DAT-off code
      s390/kasan: remove identity mapping support
      s390/boot: allow setup of different virtual address types
      s390/mm: allocate Real Memory Copy Area in decompressor
      s390/mm: allocate Absolute Lowcore Area in decompressor
      s390/mem_detect: do not update output parameters on failure

Christophe JAILLET (2):
      s390/vfio-ap: fix an error handling path in vfio_ap_mdev_probe_queue()
      s390/ipl: use kstrtobool() instead of strtobool()

Eric Farman (17):
      vfio/ccw: cleanup some of the mdev commentary
      vfio/ccw: simplify the cp_get_orb interface
      vfio/ccw: allow non-zero storage keys
      vfio/ccw: move where IDA flag is set in ORB
      vfio/ccw: replace copy_from_iova with vfio_dma_rw
      vfio/ccw: simplify CCW chain fetch routines
      vfio/ccw: remove unnecessary malloc alignment
      vfio/ccw: pass page count to page_array struct
      vfio/ccw: populate page_array struct inline
      vfio/ccw: refactor the idaw counter
      vfio/ccw: read only one Format-1 IDAW
      vfio/ccw: calculate number of IDAWs regardless of format
      vfio/ccw: allocate/populate the guest idal
      vfio/ccw: handle a guest Format-1 IDAL
      vfio/ccw: don't group contiguous pages on 2K IDAWs
      vfio/ccw: remove old IDA format restrictions
      vfio/ccw: remove WARN_ON during shutdown

Gerald Schaefer (1):
      s390/mm: add support for RDP (Reset DAT-Protection)

Halil Pasic (3):
      s390: vfio-ap: tighten the NIB validity check
      s390/ap: fix status returned by ap_aqic()
      s390/ap: fix status returned by ap_qact()

Harald Freudenberger (1):
      s390/zcrypt: introduce ctfm field in struct CPRBX

Heiko Carstens (41):
      s390/cmpxchg: use symbolic names for inline assembly operands
      s390/cmpxchg: make variables local to each case label
      s390/cmpxchg: remove digits from input constraints
      s390/extable: add EX_TABLE_UA_LOAD_REGPAIR() macro
      s390/uaccess: add cmpxchg_user_key()
      s390/uaccess: avoid __ashlti3() call
      s390/con3270: move condev definition
      s390/archrandom: add missing header include
      s390/cpum_sf: add READ_ONCE() semantics to compare and swap loops
      s390/percpu: add READ_ONCE() to arch_this_cpu_to_op_simple()
      KVM: s390: interrupt: use READ_ONCE() before cmpxchg()
      s390: update defconfigs
      s390: move __amode31_base declaration to proper header file
      s390: workaround invalid gcc-11 out of bounds read warning
      Merge branch 'fixes' into features
      s390/cache: change type from unsigned long long to unsigned long
      s390/syscalls: remove SYSCALL_METADATA() from compat syscalls
      s390/syscalls: remove __SC_COMPAT_TYPE define
      s390/syscalls: move __S390_SYS_STUBx() macro
      s390/syscalls: remove trailing semicolon
      s390/syscalls: get rid of system call alias functions
      s390/hmcdrv: use strscpy() instead of strlcpy()
      s390/rethook: add local rethook header file
      s390/diag: make __diag8c_tmp_amode31 static
      Merge branch 'fixes' into features
      Merge branch 'cmpxchg_user_key' into features
      s390/idle: move idle time accounting to account_idle_time_irq()
      s390/idle: mark arch_cpu_idle() noinstr
      s390/processor: always inline cpu flag helper functions
      MAINTAINERS: add diag288_wdt driver to s390 maintained files
      s390/vx: add 64 and 128 bit members to __vector128 struct
      s390/vx: use simple assignments to access __vector128 members
      s390/idle: remove arch_cpu_idle_time() and corresponding code
      Revert "s390/mem_detect: do not update output parameters on failure"
      s390/vx: remove __uint128_t type from __vector128 struct again
      s390/entry: remove toolchain dependent micro-optimization
      s390: remove confusing comment from uapi types header file
      s390/kfence: fix page fault reporting
      s390/processor: let cpu helper functions return boolean values
      s390/processor: add test_and_set_cpu_flag() and test_and_clear_cpu_flag()
      s390/irq,idle: simplify idle check

Ilya Leoshkevich (1):
      s390: discard .interp section

Janis Schoetterl-Glausch (2):
      s390/cmpxchg: make loop condition for 1,2 byte cases precise
      s390/uaccess: limit number of retries for cmpxchg_user_key()

Jiapeng Chong (1):
      s390/vmem: use swap() instead of open coding it

Masahiro Yamada (2):
      s390: define RUNTIME_DISCARD_EXIT to fix link error with GNU ld < 2.36
      s390: fix -Wundef warning for CONFIG_KERNEL_ZSTD

Nicholas Piggin (1):
      s390: remove the last remnants of cputime_t

Niklas Schnelle (1):
      s390/debug: add _ASM_S390_ prefix to header guard

Peter Xu (1):
      s390/mm: define private VM_FAULT_* reasons from top bits

Randy Dunlap (1):
      Documentation: s390: correct spelling

Sven Schnelle (58):
      s390/tty3270: add tty3270_create_view()
      s390/3270: unify con3270 + tty3270
      s390/tty3270: rename to con3270
      s390/tty3270: add support for diag 8c
      s390/con3270: fix formatting issues
      s390/raw3270: fix formatting issues
      s390/tty3270: use switch/case in tty3270_erase_line()
      s390/tty3270: use switch/case in tty3270_erase_display()
      s390/raw3270: use __packed instead of __attribute__((packed))
      s390/tty3270: add struct tty3270_attribute
      s390/tty3270: add support for background color
      s390/tty3270: add support for graphic escape
      s390/tty3270: add support for VT100 graphics escape
      s390/tty3270: ignore NUL characters
      s390/tty3270: add AID defines
      s390/raw3270: add raw3270_start_request() helper
      s390/tty3270: move resize work to raw3270
      s390/tty3270: resize terminal when the clear key is pressed
      s390/tty3270: split up tty3270_convert_line()
      s390/con3270: add helper to get number of tty rows
      s390/tty3270: allocate screen with scrollback
      s390/raw3270: make raw3270_buffer_address() accept x/y coordinates
      s390/con3270: move tty3270_convert_line()
      s390/tty3270: move ASCII->EBCDIC conversion to convert_line()
      s390/tty3270: add 3270 datastream helpers
      s390/con3270: generate status line during output
      s390/tty3270: convert lines during output
      s390/tty3270: use normal char buffer for prompt/input
      s390/con3270: rewrite command line recalling
      s390/con3270: reduce f_color and b_color attribute size to 4 bit
      s390/con3270: reduce highlight width to 3 bits
      s390/con3270: add key help to status area
      s390/con3270: fix camelcase in enum members
      s390/con3270: fix multiple assignments in one line
      s390/con3270: use msecs_to_jiffies()
      s390/con3270: fix minor checkpatch issues
      s390/raw3270: move EXPORT_SYMBOL() next to functions
      s390/raw3270: fix indentation/whitespace errors
      s390/raw3270: fix raw3270 declarations
      s390/raw3270: add comment to spinlock member
      s390/raw3270: use DEVICE_ATTR_RO() for sysfs attributes
      s390/raw3270: remove BUG_ON in raw3270_request_reset()
      s390/raw3270: split up raw3270_activate_view()
      s390/raw3270: fix nullpointer check
      s390/fs3270: fix whitespace errors
      s390/fs3270: add missing braces to if/else
      s390/fs3270: remove duplicate assignment
      s390/fs3270: use *ptr instead of struct in kzalloc
      s390/fs3270: fix function prototypes
      s390/fs3270: fix screen reset on activate
      s390/fs3270: split header files
      s390/diag: use __packed __aligned
      s390/con3270: return from notifier when activate view fails
      s390/con3270: simplify update flags
      s390/con3270: set SBA and RA addresses when converting lines
      s390/con3270: add special output handling when oops_in_progress is set
      s390/ipl: add DEFINE_GENERIC_LOADPARM()
      s390/ipl: add loadparm parameter to eckd ipl/reipl data

Thomas Richter (12):
      s390/cpumf: support user space events for counting
      s390/cpum_sf: move functions from header file to source file
      s390/cpum_sf: remove debug statements from function setup_pmc_cpu
      s390/cpum_sf: sampling buffer setup to handle virtual addresses
      s390/cpum_sf: rework macro AUX_SDB_NUM_xxx
      s390/cpum_sf: diagnostic sampling buffer setup to handle virtual addresses
      s390/cpum_cf: simplify hw_perf_event_destroy()
      s390/cpum_cf: move cpum_cf_ctrset_size()
      s390/cpum_cf: move stccm_avail()
      s390/cpum_cf: remove in-kernel counting facility interface
      s390/cpum_cf: merge source files for CPU Measurement counter facility
      s390/cpum_cf: simplify PMC_INIT and PMC_RELEASE usage

Tony Krowiak (6):
      s390/vfio-ap: verify reset complete in separate function
      s390/vfio_ap: check TAPQ response code when waiting for queue reset
      s390/vfio_ap: use TAPQ to verify reset in progress completes
      s390/vfio_ap: verify ZAPQ completion after return of response code zero
      s390/vfio_ap: fix handling of error response codes
      s390/vfio_ap: increase max wait time for reset verification

Vasily Gorbik (18):
      s390/kprobes: replace kretprobe with rethook
      s390/decompressor: specify __decompress() buf len to avoid overflow
      s390/boot: avoid mapping standby memory
      s390/boot: remove pgtable_populate_end
      s390/mm,ptdump: avoid Kasan vs Memcpy Real markers swapping
      s390/mem_detect: fix detect_memory() error handling
      s390/kasan: update kasan memory layout note
      s390/vmem: fix empty page tables cleanup under KASAN
      s390/vmem: remove unnecessary KASAN checks
      s390/mem_detect: rely on diag260() if sclp_early_get_memsize() fails
      s390/boot: fix mem_detect extended area allocation
      s390/mem_detect: handle online memory limit just once
      s390/mem_detect: add get_mem_detect_online_total()
      s390/boot: avoid page tables memory in kaslr
      s390/kasan: avoid mapping KASAN shadow for standby memory
      s390/boot: move detect_facilities() after cmd line parsing
      s390/boot: avoid potential amode31 truncation
      s390/mem_detect: do not truncate online memory ranges info

Vineeth Vijayan (4):
      docs/ABI: use linux-s390 list as the main contact
      s390/cio: evaluate devices with non-operational paths
      s390/cio: introduce locking for register/unregister functions
      MAINTAINERS: add entry for s390 SCM driver

Xu Panda (1):
      s390/zcrypt: use strscpy() to instead of strncpy()

 Documentation/ABI/testing/sysfs-bus-css |   15 +-
 Documentation/s390/pci.rst              |    4 +-
 Documentation/s390/vfio-ccw.rst         |    6 +-
 MAINTAINERS                             |    8 +
 arch/s390/Kconfig                       |    1 +
 arch/s390/boot/Makefile                 |    2 +-
 arch/s390/boot/boot.h                   |   40 +-
 arch/s390/boot/decompressor.c           |    7 +-
 arch/s390/boot/decompressor.h           |   26 -
 arch/s390/boot/kaslr.c                  |   20 +-
 arch/s390/boot/mem_detect.c             |   72 +-
 arch/s390/boot/startup.c                |   86 +-
 arch/s390/boot/vmem.c                   |  278 ++++
 arch/s390/configs/debug_defconfig       |    7 +-
 arch/s390/configs/defconfig             |    6 +-
 arch/s390/configs/zfcpdump_defconfig    |    2 +-
 arch/s390/crypto/arch_random.c          |    1 +
 arch/s390/include/asm/abs_lowcore.h     |   16 +-
 arch/s390/include/asm/ap.h              |   12 +-
 arch/s390/include/asm/asm-extable.h     |    4 +
 arch/s390/include/asm/ccwdev.h          |    2 +
 arch/s390/include/asm/cmpxchg.h         |  109 +-
 arch/s390/include/asm/cpu_mcf.h         |  112 --
 arch/s390/include/asm/cpu_mf.h          |   82 +-
 arch/s390/include/asm/cputime.h         |   19 -
 arch/s390/include/asm/debug.h           |    6 +-
 arch/s390/include/asm/diag.h            |   16 +-
 arch/s390/include/asm/fpu/internal.h    |    4 +-
 arch/s390/include/asm/idals.h           |   12 +
 arch/s390/include/asm/idle.h            |    5 -
 arch/s390/include/asm/kasan.h           |   12 +-
 arch/s390/include/asm/kprobes.h         |    2 -
 arch/s390/include/asm/maccess.h         |    2 +-
 arch/s390/include/asm/mem_detect.h      |   39 +-
 arch/s390/include/asm/percpu.h          |    2 +-
 arch/s390/include/asm/pgtable.h         |   69 +-
 arch/s390/include/asm/processor.h       |   29 +-
 arch/s390/include/asm/ptrace.h          |    2 +-
 arch/s390/include/asm/setup.h           |    6 +
 arch/s390/include/asm/syscall_wrapper.h |  144 +-
 arch/s390/include/asm/uaccess.h         |  208 +++
 arch/s390/include/asm/unwind.h          |   10 +-
 arch/s390/include/uapi/asm/fs3270.h     |   25 +
 arch/s390/include/uapi/asm/raw3270.h    |   75 +
 arch/s390/include/uapi/asm/types.h      |   15 +-
 arch/s390/include/uapi/asm/zcrypt.h     |    3 +-
 arch/s390/kernel/Makefile               |    3 +-
 arch/s390/kernel/abs_lowcore.c          |   49 -
 arch/s390/kernel/cache.c                |    2 +-
 arch/s390/kernel/compat_signal.c        |    4 +-
 arch/s390/kernel/crash_dump.c           |    2 +-
 arch/s390/kernel/diag.c                 |   26 +
 arch/s390/kernel/early.c                |    8 +-
 arch/s390/kernel/entry.S                |    6 -
 arch/s390/kernel/entry.h                |    1 -
 arch/s390/kernel/head64.S               |    1 +
 arch/s390/kernel/idle.c                 |   91 +-
 arch/s390/kernel/ipl.c                  |  101 +-
 arch/s390/kernel/irq.c                  |    8 +-
 arch/s390/kernel/kprobes.c              |   30 -
 arch/s390/kernel/machine_kexec.c        |    5 +-
 arch/s390/kernel/machine_kexec_file.c   |    5 +-
 arch/s390/kernel/mcount.S               |   12 +-
 arch/s390/kernel/os_info.c              |    5 +-
 arch/s390/kernel/perf_cpum_cf.c         |  308 +++-
 arch/s390/kernel/perf_cpum_cf_common.c  |  233 ---
 arch/s390/kernel/perf_cpum_sf.c         |  245 +++-
 arch/s390/kernel/perf_pai_ext.c         |    2 +-
 arch/s390/kernel/process.c              |    4 +-
 arch/s390/kernel/ptrace.c               |    6 +-
 arch/s390/kernel/rethook.c              |   34 +
 arch/s390/kernel/rethook.h              |    7 +
 arch/s390/kernel/setup.c                |   95 +-
 arch/s390/kernel/signal.c               |    4 +-
 arch/s390/kernel/smp.c                  |   14 +-
 arch/s390/kernel/stacktrace.c           |    6 +-
 arch/s390/kernel/text_amode31.S         |   13 +
 arch/s390/kernel/vmlinux.lds.S          |    8 +
 arch/s390/kvm/interrupt.c               |   12 +-
 arch/s390/lib/test_unwind.c             |   12 +-
 arch/s390/mm/dump_pagetables.c          |   16 +-
 arch/s390/mm/extable.c                  |    9 +-
 arch/s390/mm/fault.c                    |   63 +-
 arch/s390/mm/init.c                     |   35 +-
 arch/s390/mm/kasan_init.c               |  246 +---
 arch/s390/mm/maccess.c                  |   28 +-
 arch/s390/mm/pgtable.c                  |   25 +
 arch/s390/mm/vmem.c                     |  103 +-
 drivers/s390/char/Kconfig               |   11 +-
 drivers/s390/char/Makefile              |    4 +-
 drivers/s390/char/con3270.c             | 2409 +++++++++++++++++++++++++------
 drivers/s390/char/diag_ftp.c            |    4 +-
 drivers/s390/char/fs3270.c              |  124 +-
 drivers/s390/char/raw3270.c             |  376 ++---
 drivers/s390/char/raw3270.h             |  227 +--
 drivers/s390/char/sclp_early.c          |    2 +-
 drivers/s390/char/sclp_ftp.c            |    6 +-
 drivers/s390/char/tty3270.c             | 1963 -------------------------
 drivers/s390/char/tty3270.h             |   15 -
 drivers/s390/cio/css.c                  |   21 +-
 drivers/s390/cio/css.h                  |    2 +-
 drivers/s390/cio/device.c               |    9 +
 drivers/s390/cio/vfio_ccw_cp.c          |  365 ++---
 drivers/s390/cio/vfio_ccw_cp.h          |    3 +-
 drivers/s390/cio/vfio_ccw_drv.c         |    2 +-
 drivers/s390/cio/vfio_ccw_fsm.c         |    2 +-
 drivers/s390/crypto/vfio_ap_ops.c       |  116 +-
 drivers/s390/crypto/zcrypt_api.c        |    6 +-
 drivers/watchdog/diag288_wdt.c          |  161 +--
 109 files changed, 4690 insertions(+), 4648 deletions(-)
 create mode 100644 arch/s390/boot/vmem.c
 delete mode 100644 arch/s390/include/asm/cpu_mcf.h
 create mode 100644 arch/s390/include/uapi/asm/fs3270.h
 create mode 100644 arch/s390/include/uapi/asm/raw3270.h
 delete mode 100644 arch/s390/kernel/perf_cpum_cf_common.c
 create mode 100644 arch/s390/kernel/rethook.c
 create mode 100644 arch/s390/kernel/rethook.h
 delete mode 100644 drivers/s390/char/tty3270.c
 delete mode 100644 drivers/s390/char/tty3270.h
