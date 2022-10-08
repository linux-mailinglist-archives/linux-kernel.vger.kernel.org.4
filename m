Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38C85F874A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 22:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiJHULr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 16:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiJHULp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 16:11:45 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0A129364;
        Sat,  8 Oct 2022 13:11:44 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 298H3e3l033294;
        Sat, 8 Oct 2022 20:11:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=vYAzWrf71f5+iSFKC/iENj96+1aAZKoRDQGd5z9ZAr0=;
 b=I/J3YiGFIHb11oY2bxakUfFNqI/LGKlI9sW7oL+dRp0Hhrgi6lpiYdILKFnil6DmpO2P
 Z4MYJt5yeaHWd5mnrcmSqktyU6oP7Stb1EzJMiYuiaobcDp0R4w7u66DreVbKUet5JAs
 AwDEZmPCVtAch1qmyexjSDuFSLQ5C/cJiPuJkQbgxLETPVPKBn2RQ0syH5Le09bLon5C
 cZPaXO+nkXf0KDh5RP62OQi6Lor1l2ha06m1Uno8aLNRMRqAiejhDd/sR4ym9vtMWY44
 mbxfe7A8Rlxy0ph/SYrZH0unvaFRpYv4ni6lJbZ3l+GMRFRxiHlP7doFJyEkHFZq7HuJ GA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k30gqfryn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 08 Oct 2022 20:11:42 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 298K6efh020299;
        Sat, 8 Oct 2022 20:11:40 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3k30u90rhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 08 Oct 2022 20:11:40 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 298KBbX532965354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 8 Oct 2022 20:11:37 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33A4C52050;
        Sat,  8 Oct 2022 20:11:37 +0000 (GMT)
Received: from localhost (unknown [9.171.10.159])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id D474C5204E;
        Sat,  8 Oct 2022 20:11:36 +0000 (GMT)
Date:   Sat, 8 Oct 2022 22:11:35 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 patches for the 6.1 merge window
Message-ID: <your-ad-here.call-01665259895-ext-4990@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QL8ZRs519MOGrL_sxnYedTe6dTCJ0NJv
X-Proofpoint-ORIG-GUID: QL8ZRs519MOGrL_sxnYedTe6dTCJ0NJv
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=698 clxscore=1015 malwarescore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210080130
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 6.1.

Thank you,
Vasily

The following changes since commit b90cb1053190353cc30f0fef0ef1f378ccc063c5:

  Linux 6.0-rc3 (2022-08-28 15:05:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.1-1

for you to fetch changes up to 8fb65e05bd60058e15842e511b3ee5299ac51829:

  s390/pci: remove unused bus_next field from struct zpci_dev (2022-09-28 11:12:44 +0200)

----------------------------------------------------------------
s390 updates for the 6.1 merge window

- Make use of the IBM z16 processor activity instrumentation facility
  extension to count neural network processor assist operations: add a new
  PMU device driver so that perf can make use of this.

- Rework memcpy_real() to avoid DAT-off mode.

- Rework absolute lowcore access code.

- Various small fixes and improvements all over the code.

----------------------------------------------------------------
Alexander Gordeev (10):
      s390/boot: fix absolute zero lowcore corruption on boot
      s390/smp: enforce lowcore protection on CPU restart
      s390/smp: call smp_reinit_ipl_cpu() before scheduler is available
      s390/smp: rework absolute lowcore access
      s390/smp,ptdump: add absolute lowcore markers
      s390/dump: save IPL CPU registers once DAT is available
      s390/mm: rework memcpy_real() to avoid DAT-off mode
      s390/mm,ptdump: add real memory copy page markers
      s390/mm: uninline copy_oldmem_kernel() function
      s390/mm: fix no previous prototype warnings in maccess.c

Gaosheng Cui (1):
      s390/cio: remove unused ccw_device_force_console() declaration

Gerald Schaefer (2):
      s390/mm: remove useless hugepage address alignment
      s390/hugetlb: fix prepare_hugepage_range() check for 2 GB hugepages

Heiko Carstens (5):
      s390: update defconfigs
      s390/delay: sync comment within __delay() with reality
      s390/mm: remove unused access parameter from do_fault_error()
      s390/mm: split lowcore pages with set_memory_4k()
      s390/ptdump: add missing amode31 markers

Josh Poimboeuf (1):
      s390: fix nospec table alignments

Niklas Schnelle (2):
      s390/pci: convert high_memory to physical address
      s390/pci: remove unused bus_next field from struct zpci_dev

Thomas Richter (1):
      s390/pai: Add support for PAI Extension 1 NNPA counters

Vasily Gorbik (1):
      Merge branch 'fixes' into features

Wolfram Sang (1):
      s390: move from strlcpy with unused retval to strscpy

 arch/s390/boot/startup.c             |   8 +-
 arch/s390/configs/debug_defconfig    |  53 +--
 arch/s390/configs/defconfig          |  49 +--
 arch/s390/configs/zfcpdump_defconfig |   6 +-
 arch/s390/include/asm/abs_lowcore.h  |  17 +
 arch/s390/include/asm/ccwdev.h       |   1 -
 arch/s390/include/asm/ctl_reg.h      |   3 +-
 arch/s390/include/asm/hugetlb.h      |   6 +-
 arch/s390/include/asm/lowcore.h      |   4 +-
 arch/s390/include/asm/maccess.h      |  17 +
 arch/s390/include/asm/os_info.h      |  14 -
 arch/s390/include/asm/pai.h          |   6 +-
 arch/s390/include/asm/pci.h          |   1 -
 arch/s390/include/asm/pgtable.h      |   4 +
 arch/s390/include/asm/processor.h    |  17 -
 arch/s390/include/asm/smp.h          |   4 +-
 arch/s390/kernel/Makefile            |   4 +-
 arch/s390/kernel/abs_lowcore.c       |  95 +++++
 arch/s390/kernel/crash_dump.c        |  40 +--
 arch/s390/kernel/debug.c             |   2 +-
 arch/s390/kernel/early.c             |   2 +-
 arch/s390/kernel/ipl.c               |   9 +-
 arch/s390/kernel/machine_kexec.c     |   8 +-
 arch/s390/kernel/nmi.c               |   2 +-
 arch/s390/kernel/os_info.c           |  10 +-
 arch/s390/kernel/perf_pai_ext.c      | 671 +++++++++++++++++++++++++++++++++++
 arch/s390/kernel/setup.c             |  48 ++-
 arch/s390/kernel/smp.c               |  97 ++---
 arch/s390/kernel/vmlinux.lds.S       |   1 +
 arch/s390/lib/delay.c                |  11 +-
 arch/s390/mm/dump_pagetables.c       |  20 ++
 arch/s390/mm/fault.c                 |  17 +-
 arch/s390/mm/init.c                  |   2 +-
 arch/s390/mm/maccess.c               | 175 ++++-----
 arch/s390/mm/vmem.c                  | 104 +++++-
 arch/s390/pci/pci_dma.c              |   2 +-
 drivers/s390/block/dasd_devmap.c     |   2 +-
 drivers/s390/block/dasd_eer.c        |   4 +-
 drivers/s390/block/dcssblk.c         |   2 +-
 drivers/s390/char/hmcdrv_cache.c     |   2 +-
 drivers/s390/char/tape_class.c       |   4 +-
 drivers/s390/char/zcore.c            |   1 +
 drivers/s390/cio/qdio_debug.c        |   2 +-
 drivers/s390/net/ctcm_main.c         |   2 +-
 drivers/s390/net/fsm.c               |   2 +-
 drivers/s390/net/qeth_ethtool.c      |   4 +-
 drivers/s390/scsi/zfcp_aux.c         |   2 +-
 drivers/s390/scsi/zfcp_fc.c          |   2 +-
 48 files changed, 1243 insertions(+), 316 deletions(-)
 create mode 100644 arch/s390/include/asm/abs_lowcore.h
 create mode 100644 arch/s390/include/asm/maccess.h
 create mode 100644 arch/s390/kernel/abs_lowcore.c
 create mode 100644 arch/s390/kernel/perf_pai_ext.c
