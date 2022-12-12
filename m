Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC49F64A533
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 17:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbiLLQoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 11:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiLLQoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 11:44:14 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC4013EBE;
        Mon, 12 Dec 2022 08:41:33 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCGdBYS031994;
        Mon, 12 Dec 2022 16:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=FHPfgqaQjFhunimdozavH7rwB/PCD29nwlDXsBkpa60=;
 b=AGQzGMDo8ILEBEoeGNHzAPiSmW8mrY+rwPjwqXMh8ib3c5b1aKid6H/25K+UkHRtAM50
 Xn/7bgaXnTuBNIMt1G1hP+wsyAzAY4dhRWo0BypjWxlNouhcOcTrfb3kftxfLM11MR8X
 qPauyAYIA8IGqLXTwC/MnYGtmgakb5uSizFL8V4JEAJnlEo3iSXXWMtPilZXQO9aASby
 BN10e2WNNEoWzMzpaKuzoHAi2a3QXJwrrA6qhNA2tCDm/dHoXJfX+cJb5abORZPfLBZg
 FIWVGjc+dDjgMm2iWBDWOqCVZWSGQ/ZDSj+APhQnPuEG9PfWuFDa+YDozzRD7EZuh63+ bA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3me6k4aqs3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 16:41:32 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCFJWBE027385;
        Mon, 12 Dec 2022 16:41:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3mchr624kv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 16:41:30 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BCGfLxI25428684
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 16:41:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D155420043;
        Mon, 12 Dec 2022 16:41:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4354520049;
        Mon, 12 Dec 2022 16:41:21 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.171.75.126])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 12 Dec 2022 16:41:21 +0000 (GMT)
Date:   Mon, 12 Dec 2022 17:41:19 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] s390 updates for 6.2 merge window
Message-ID: <Y5dZr4AVA7CzzHLy@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JF_hsvLsQvOpWRcUCQ3q6HmiqDrEwQ5m
X-Proofpoint-ORIG-GUID: JF_hsvLsQvOpWRcUCQ3q6HmiqDrEwQ5m
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2212120150
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 6.2 merge window.

Thank you,
Alexander

The following changes since commit 247f34f7b80357943234f93f247a1ae6b6c3a740:

  Linux 6.1-rc2 (2022-10-23 15:27:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.2-1

for you to fetch changes up to bb3860cc02c660b409a1e02521b84b1d7d4e84cd:

  s390/nmi: get rid of private slab cache (2022-11-30 19:43:28 +0100)

----------------------------------------------------------------
s390 updates for 6.2 merge window

- Factor out handle_write() function and simplify 3215 console
  write operation.

- When 3170 terminal emulator is connected to the 3215 console
  driver the boot time could be very long due to limited buffer
  space or missing operator input. Add con3215_drop command line
  parameter and con3215_drop sysfs attribute file to instruct
  the kernel drop console data when such conditions are met.

- Fix white space errors in 3215 console driver.

- Move enum paiext_mode definition to a header file and rename
  it to paievt_mode to indicate this is now used for several
  events. Rename PAI_MODE_COUNTER to PAI_MODE_COUNTING to make
  consistent with PAI_MODE_SAMPLING.

- Simplify the logic of PMU pai_crypto mapped buffer reference
  counter and make it consistent with PMU pai_ext.

- Rename PMU pai_crypto mapped buffer structure member users
  to active_events to make it consistent with PMU pai_ext.

- Enable HUGETLB_PAGE_OPTIMIZE_VMEMMAP configuration option.
  This results in saving of 12K per 1M hugetlb page (~1.2%)
  and 32764K per 2G hugetlb page (~1.6%).

- Use generic serial.h, bugs.h, shmparam.h and vga.h header
  files and scrap s390-specific versions.

- The generic percpu setup code does not expect the s390-like
  implementation and emits a warning. To get rid of that warning
  and provide sane CPU-to-node and CPU-to-CPU distance mappings
  implementat a minimal version of setup_per_cpu_areas().

- Use kstrtobool() instead of strtobool() for re-IPL sysfs device
  attributes.

- Avoid unnecessary lookup of a pointer to MSI descriptor when
  setting IRQ affinity for a PCI device.

- Get rid of "an incompatible function type cast" warning by
  changing debug_sprintf_format_fn() function prototype so it
  matches the debug_format_proc_t function type.

- Remove unused info_blk_hdr__pcpus() and get_page_state()
  functions.

- Get rid of clang "unused unused insn cache ops function"
  warning by moving s390_insn definition to a private header.

- Get rid of clang "unused function" warning by making function
  raw3270_state_final() only available if CONFIG_TN3270_CONSOLE
  is enabled.

- Use kstrobool() to parse sclp_con_drop parameter to make it
  identical to the con3215_drop parameter and allow passing
  values like "yes" and "true".

- Use sysfs_emit() for all SCLP sysfs show functions, which is
  the current standard way to generate output strings.

- Make SCLP con_drop sysfs attribute also writable and allow to
  change its value during runtime. This makes SCLP console drop
  handling consistent with the 3215 device driver.

- Virtual and physical addresses are indentical on s390. However,
  there is still a confusion when pointers are directly casted to
  physical addresses or vice versa. Use correct address converters
  virt_to_phys() and phys_to_virt() for s390 channel IO drivers.

- Support for power managemant has been removed from s390 since
  quite some time. Remove unused power managemant code from the
  appldata device driver.

- Allow memory tools like KASAN see memory accesses from the
  checksum code. Switch to GENERIC_CSUM if KASAN is enabled,
  just like x86 does.

- Add support of ECKD DASDs disks so it could be used as boot
  and dump devices.

- Follow checkpatch recommendations and use octal values instead
  of S_IRUGO and S_IWUSR for dump device attributes in sysfs.

- Changes to vx-insn.h do not cause a recompile of C files that
  use asm(".include \"asm/vx-insn.h\"\n") magic to access vector
  instruction macros from inline assemblies. Add wrapper include
  header file to avoid this problem.

- Use vector instruction macros instead of byte patterns to
  increase register validation routine readability.

- The current machine check register validation handling does not
  take into account various scenarios and might lead to killing a
  wrong user process or potentially ignore corrupted FPU registers.
  Simplify logic of the machine check handler and stop the whole
  machine if the previous context was kerenel mode. If the previous
  context was user mode, kill the current task.

- Introduce sclp_emergency_printk() function which can be used to
  emit a message in emergency cases. It is supposed to be used in
  cases where regular console device drivers may not work anymore,
  e.g. unrecoverable machine checks.

  Keep the early Service-Call Control Block so it can also be used
  after initdata has been freed to allow sclp_emergency_printk()
  implementation.

- In case a system will be stopped because of an unrecoverable
  machine check error print the machine check interruption code
  to give a hint of what went wrong.

- Move storage error checking from the assembly entry code to C
  in order to simplify machine check handling. Enter the handler
  with DAT turned on, which simplifies the entry code even more.

- The machine check extended save areas are allocated using
  a private "nmi_save_areas" slab cache which guarantees a
  required power-of-two alignment. Get rid of that cache in
  favour of kmalloc().

----------------------------------------------------------------
Alexander Gordeev (2):
  s390/cio: sort out physical vs virtual pointers usage
  vfio/ccw: sort out physical vs virtual pointers usage

Christophe JAILLET (1):
  s390/ipl: Use kstrtobool() instead of strtobool()

Eric Farman (1):
  vfio/ccw: identify CCW data addresses as physical

Gerald Schaefer (1):
  s390: select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP

Heiko Carstens (23):
  s390: use generic serial.h header file
  s390: use generic bugs.h header file
  s390: use generic shmparam.h header file
  s390: use generic vga.h header file
  s390/mm: provide minimal setup_per_cpu_areas() implementation
  s390/debug: remove function type cast
  s390/hypfs: remove unused info_blk_hdr__pcpus() function
  s390/mm: remove unused get_page_state() function
  s390/kprobes: define insn cache ops within private header file
  s390/3270: make raw3270_state_final() depend on CONFIG_TN3270_CONSOLE
  s390/sclp: use kstrobool() to parse sclp_con_drop parameter
  s390/sclp: convert to use sysfs_emit()
  s390/sclp: allow to change sclp_console_drop during runtime
  s390/appldata: remove power management callbacks
  s390/checksum: support GENERIC_CSUM, enable it for KASAN
  s390/vx: add vx-insn.h wrapper include file
  s390/nmi: use vector instruction macros instead of byte patterns
  s390/nmi: rework register validation handling
  s390/sclp: keep sclp_early_sccb
  s390/sclp: introduce sclp_emergency_printk()
  s390/nmi: print machine check interruption code before stopping system
  s390/nmi: move storage error checking back to C, enter with DAT on
  s390/nmi: get rid of private slab cache

Sven Schnelle (3):
  s390/ipl: add eckd support
  s390/ipl: add eckd dump support
  s390/ipl: use octal values instead of S_* macros

Thomas Gleixner (1):
  s390/pci: Use irq_data_get_msi_desc()

Thomas Richter (6):
  s390/con3215: Simplify console write operation
  s390/con3215: Drop console data printout when buffer full
  s390/con3215: Fix white space errors
  s390/pai: move enum definition to header file
  s390/pai: rework pai_crypto mapped buffer reference count
  s390/pai: rename structure member users to active_events

 .../admin-guide/kernel-parameters.txt         |  11 +
 arch/s390/Kconfig                             |   7 +
 arch/s390/appldata/appldata_base.c            | 113 +--
 arch/s390/boot/ipl_parm.c                     |   9 +
 arch/s390/hypfs/hypfs_diag.c                  |   8 -
 arch/s390/include/asm/bugs.h                  |  21 -
 arch/s390/include/asm/checksum.h              |   7 +
 arch/s390/include/asm/ipl.h                   |  11 +
 arch/s390/include/asm/pai.h                   |   6 +
 arch/s390/include/asm/sclp.h                  |   2 +
 arch/s390/include/asm/serial.h                |   7 -
 arch/s390/include/asm/shmparam.h              |  12 -
 arch/s390/include/asm/vga.h                   |   7 -
 arch/s390/include/asm/vx-insn-asm.h           | 681 ++++++++++++++++++
 arch/s390/include/asm/vx-insn.h               | 671 +----------------
 arch/s390/include/uapi/asm/ipl.h              |  29 +
 arch/s390/kernel/debug.c                      |   7 +-
 arch/s390/kernel/entry.S                      |  34 +-
 arch/s390/kernel/fpu.c                        |   3 +-
 arch/s390/kernel/ipl.c                        | 403 ++++++++++-
 arch/s390/kernel/kprobes.c                    |   3 +-
 arch/s390/kernel/kprobes.h                    |   9 +
 arch/s390/kernel/nmi.c                        | 181 +++--
 arch/s390/kernel/perf_pai_crypto.c            |  48 +-
 arch/s390/kernel/perf_pai_ext.c               |  12 +-
 arch/s390/kernel/setup.c                      |   3 +-
 arch/s390/mm/init.c                           |  39 +-
 arch/s390/mm/page-states.c                    |  11 -
 arch/s390/pci/pci_irq.c                       |   2 +-
 drivers/s390/char/con3215.c                   | 275 ++++---
 drivers/s390/char/raw3270.c                   |  12 +-
 drivers/s390/char/sclp.c                      |  25 +-
 drivers/s390/char/sclp.h                      |   2 +-
 drivers/s390/char/sclp_early.c                |   4 +-
 drivers/s390/char/sclp_early_core.c           |  26 +-
 drivers/s390/char/zcore.c                     |   4 +
 drivers/s390/cio/chsc_sch.c                   |   3 +-
 drivers/s390/cio/cio.c                        |  14 +-
 drivers/s390/cio/device.c                     |   2 +-
 drivers/s390/cio/device_fsm.c                 |  13 +-
 drivers/s390/cio/device_id.c                  |   2 +-
 drivers/s390/cio/device_pgid.c                |  11 +-
 drivers/s390/cio/device_status.c              |   3 +-
 drivers/s390/cio/eadm_sch.c                   |   9 +-
 drivers/s390/cio/fcx.c                        |  23 +-
 drivers/s390/cio/itcw.c                       |   3 +-
 drivers/s390/cio/vfio_ccw_cp.c                |   4 +-
 drivers/s390/cio/vfio_ccw_fsm.c               |   2 +-
 lib/raid6/s390vx.uc                           |   3 +-
 49 files changed, 1598 insertions(+), 1199 deletions(-)
 delete mode 100644 arch/s390/include/asm/bugs.h
 delete mode 100644 arch/s390/include/asm/serial.h
 delete mode 100644 arch/s390/include/asm/shmparam.h
 delete mode 100644 arch/s390/include/asm/vga.h
 create mode 100644 arch/s390/include/asm/vx-insn-asm.h
 create mode 100644 arch/s390/kernel/kprobes.h
