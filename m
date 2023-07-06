Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8CF749BAD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjGFM2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGFM2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:28:15 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD6219B;
        Thu,  6 Jul 2023 05:28:13 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366CI8jD012709;
        Thu, 6 Jul 2023 12:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=iZJAxyp8W8foEIG+0aOAjZnJVslMSn40P1/8B12ig5Q=;
 b=ZqgXl04c8U0OiwPqx2EQ79Tc+PrCsmQOLbEGwidJZI7mTxLyvHQLOZRVCogzQFZILgHn
 KG91qWpuvn04Cdp0kp5GrEhZK86nS/Prntd6CCfnryQ4AayW6kHeGO1R0Rbr3/RFSERT
 Xce/YOtRdZo+ftV8/Lc/O8Nf3nSbdVp15u/X9VS0VtCypw4wwL1YSXCpKNCC3xsYJ/Qr
 yL128/f+4McFd1hJLodoZ5ub84OAsf9boCXKwZ4DA0odsmZ8vFNYt0pY5iBIH3NgzI9o
 aNt9SmU1oMnE/Fj1dI9FaXqBFwo1HmXqp1EFRiXc8nppToTMIQ/TU5SH94Db5NzKpdwD MQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rnwg7r817-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 12:28:11 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3669NqD2009583;
        Thu, 6 Jul 2023 12:28:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3rjbs52e7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 12:28:09 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 366CS6aH52035992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Jul 2023 12:28:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 513532004B;
        Thu,  6 Jul 2023 12:28:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1199220063;
        Thu,  6 Jul 2023 12:28:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu,  6 Jul 2023 12:28:06 +0000 (GMT)
Date:   Thu, 6 Jul 2023 14:28:04 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.5 merge window part 2
Message-ID: <ZKazVPjc1OAM8iaL@tuxmaker.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gP28heq-jnwi9zYa3491KOd7IQOjKNpe
X-Proofpoint-ORIG-GUID: gP28heq-jnwi9zYa3491KOd7IQOjKNpe
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_07,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060108
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Please pull s390 changes for 6.5 merge window part 2.

Thank you,
Alexander

The following changes since commit 6a46676994607a1bde51cba71c1b0d373a555f45:

  Merge tag 's390-6.5-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2023-06-27 15:49:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.5-2

for you to fetch changes up to 54372cf043276735e29045abf998895b2ac277cf:

  Revert "s390/mm: get rid of VMEM_MAX_PHYS macro" (2023-07-04 07:46:26 +0200)

----------------------------------------------------------------
s390 updates for 6.5 merge window part 2

- Fix virtual vs physical address confusion in vmem_add_range()
  and vmem_remove_range() functions.

- Include <linux/io.h> instead of <asm/io.h> and <asm-generic/io.h>
  throughout s390 code.

- Make all PSW related defines also available for assembler files.
  Remove PSW_DEFAULT_KEY define from uapi for that.

- When adding an undefined symbol the build still succeeds, but
  userspace crashes trying to execute VDSO, because the symbol
  is not resolved. Add undefined symbols check to prevent that.

- Use kvmalloc_array() instead of kzalloc() for allocaton of 256k
  memory when executing s390 crypto adapter IOCTL.

- Add -fPIE flag to prevent decompressor misaligned symbol build
  error with clang.

- Use .balign instead of .align everywhere. This is a no-op for s390,
  but with this there no mix in using .align and .balign anymore.

- Filter out -mno-pic-data-is-text-relative flag when compiling
  kernel to prevent VDSO build error.

- Rework entering of DAT-on mode on CPU restart to use PSW_KERNEL_BITS
  mask directly.

- Do not retry administrative requests to some s390 crypto cards,
  since the firmware assumes replay attacks.

- Remove most of the debug code, which is build in when kernel config
  option CONFIG_ZCRYPT_DEBUG is enabled.

- Remove CONFIG_ZCRYPT_MULTIDEVNODES kernel config option and switch
  off the multiple devices support for the s390 zcrypt device driver.

- With the conversion to generic entry machine checks are accounted
  to the current context instead of irq time. As result, the STCKF
  instruction at the beginning of the machine check handler and the
  lowcore member are no longer required, therefore remove it.

- Fix various typos found with codespell.

- Minor cleanups to CPU-measurement Counter and Sampling Facilities code.

- Revert patch that removes VMEM_MAX_PHYS macro, since it causes
  a regression.

----------------------------------------------------------------
Alexander Gordeev (5):
      s390/mm: get rid of VMEM_MAX_PHYS macro
      s390/vmem: fix virtual vs physical address confusion
      s390/mm: fence off VM macros from asm and linker
      s390/entry: rework entering DAT-on mode on CPU restart
      Revert "s390/mm: get rid of VMEM_MAX_PHYS macro"

Baoquan He (1):
      s390/mm: do not include <asm-generic/io.h> directly

Harald Freudenberger (3):
      s390/zcrypt: cleanup some debug code
      s390/zcrypt: do not retry administrative requests
      s390/zcrypt: remove ZCRYPT_MULTIDEVNODES kernel config option

Heiko Carstens (7):
      s390/zcrypt: use kvmalloc_array() instead of kzalloc()
      s390/decompressor: fix misaligned symbol build error
      s390: consistently use .balign instead of .align
      s390/ptrace: remove PSW_DEFAULT_KEY from uapi
      s390/ptrace: make all psw related defines also available for asm
      s390: include linux/io.h instead of asm/io.h
      s390: fix various typos

Sumanth Korikkar (1):
      s390/vdso: filter out mno-pic-data-is-text-relative cflag

Sven Schnelle (2):
      s390/vdso: check for undefined symbols after build
      s390/entry: remove mcck clock

Thomas Richter (6):
      s390/cpum_cf: remove unneeded debug statements
      s390/cpum_sf: simplify function setup_pmu_cpu
      s390/cpum_sf: remove parameter in call to pr_err
      s390/cpum_sf: remove unnecessary debug statement
      s390/cpum_sf: handle casts consistently
      s390/cpum_sf: remove check on CPU being online

 arch/s390/Makefile                     |   1 +
 arch/s390/appldata/appldata_base.c     |   4 +-
 arch/s390/appldata/appldata_mem.c      |   2 +-
 arch/s390/boot/head.S                  |  16 ++---
 arch/s390/boot/head_kdump.S            |   6 +-
 arch/s390/crypto/crc32be-vx.S          |   2 +-
 arch/s390/include/asm/ap.h             |   2 +-
 arch/s390/include/asm/appldata.h       |   2 +-
 arch/s390/include/asm/asm-extable.h    |   4 +-
 arch/s390/include/asm/dma.h            |   2 +-
 arch/s390/include/asm/lowcore.h        |   4 +-
 arch/s390/include/asm/page.h           |   6 +-
 arch/s390/include/asm/ptrace.h         |  52 +++++++-------
 arch/s390/include/uapi/asm/cmb.h       |   2 +-
 arch/s390/include/uapi/asm/dasd.h      |   2 +-
 arch/s390/include/uapi/asm/pkey.h      |   6 +-
 arch/s390/include/uapi/asm/ptrace.h    | 121 ++++++++++++++++-----------------
 arch/s390/kernel/asm-offsets.c         |   1 -
 arch/s390/kernel/cpcmd.c               |   2 +-
 arch/s390/kernel/dis.c                 |   4 +-
 arch/s390/kernel/entry.S               |  14 ++--
 arch/s390/kernel/head64.S              |   2 +-
 arch/s390/kernel/kprobes_insn_page.S   |   2 +-
 arch/s390/kernel/nospec-branch.c       |   2 +-
 arch/s390/kernel/perf_cpum_cf.c        |  32 +--------
 arch/s390/kernel/perf_cpum_sf.c        |  58 ++++++----------
 arch/s390/kernel/perf_pai_ext.c        |   4 +-
 arch/s390/kernel/process.c             |   2 +-
 arch/s390/kernel/setup.c               |   2 +-
 arch/s390/kernel/smp.c                 |   2 +-
 arch/s390/kernel/time.c                |   2 +-
 arch/s390/kernel/vdso32/Makefile       |   6 +-
 arch/s390/kernel/vdso64/Makefile       |   6 +-
 arch/s390/kvm/gaccess.c                |   4 +-
 arch/s390/kvm/intercept.c              |   2 +-
 arch/s390/kvm/kvm-s390.c               |   2 +-
 arch/s390/kvm/pci.c                    |   2 +-
 arch/s390/kvm/priv.c                   |   3 +-
 arch/s390/kvm/pv.c                     |   2 +-
 arch/s390/kvm/sigp.c                   |   2 +-
 arch/s390/kvm/vsie.c                   |   4 +-
 arch/s390/lib/spinlock.c               |   2 +-
 arch/s390/mm/gmap.c                    |   2 +-
 arch/s390/mm/maccess.c                 |   2 +-
 arch/s390/mm/vmem.c                    |   4 +-
 arch/s390/net/bpf_jit_comp.c           |   4 +-
 arch/s390/pci/pci_irq.c                |   6 +-
 arch/s390/purgatory/head.S             |   2 +-
 drivers/crypto/Kconfig                 |  11 ---
 drivers/s390/block/dasd_diag.c         |   2 +-
 drivers/s390/block/dasd_eckd.c         |   4 +-
 drivers/s390/block/dasd_fba.c          |   2 +-
 drivers/s390/block/dcssblk.c           |   2 +-
 drivers/s390/char/con3215.c            |   2 +-
 drivers/s390/char/monwriter.c          |   2 +-
 drivers/s390/cio/ccwgroup.c            |   2 +-
 drivers/s390/cio/device.c              |   2 +-
 drivers/s390/cio/device_fsm.c          |   4 +-
 drivers/s390/cio/vfio_ccw_cp.c         |   4 +-
 drivers/s390/crypto/ap_bus.c           |   4 +-
 drivers/s390/crypto/ap_bus.h           |  27 +-------
 drivers/s390/crypto/ap_queue.c         |   7 --
 drivers/s390/crypto/vfio_ap_ops.c      |   4 +-
 drivers/s390/crypto/zcrypt_api.c       | 113 ++----------------------------
 drivers/s390/crypto/zcrypt_api.h       |   3 -
 drivers/s390/crypto/zcrypt_ccamisc.c   |   2 +-
 drivers/s390/crypto/zcrypt_ccamisc.h   |   4 +-
 drivers/s390/crypto/zcrypt_ep11misc.c  |   2 +-
 drivers/s390/crypto/zcrypt_ep11misc.h  |   4 +-
 drivers/s390/crypto/zcrypt_msgtype50.c |  10 ---
 drivers/s390/crypto/zcrypt_msgtype6.c  |  16 ++---
 drivers/s390/net/ctcm_mpc.c            |  10 +--
 drivers/s390/net/netiucv.c             |   2 +-
 73 files changed, 235 insertions(+), 428 deletions(-)
