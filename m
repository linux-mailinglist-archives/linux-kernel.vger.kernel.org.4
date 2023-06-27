Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D420740382
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 20:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjF0SiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 14:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjF0SiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:38:14 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5DE196;
        Tue, 27 Jun 2023 11:38:13 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35RIGFPZ004480;
        Tue, 27 Jun 2023 18:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=1eCnnbg9YXhtTERx/Zq8PzqOIMme9Px4wVF7cgR5UFE=;
 b=hXbESjNX7uB43DfOXzHYsNYLsP8OVexPORCdYxwM10Tu6TC5s0EkXRzd9zyEAkIN+ys2
 syMjQGJzmbvv5Cm1WtkSkQriakHR+whEYDO4jEQ/vG5T91uNNqlwvecH9h4iazqs6AUc
 1FZMFin48TgBo7a6Fyd1ZfQKmSyy0NcvCtVxhbsWZAJAU33rk4mz3IIw9wxwv3myBQbO
 aC1/ekud4fIYnbzdVOAd3axV6B5Z1vJIFY17ny2mvGXL6s0hwwEMXVf43Wt/qMLRjreZ
 0X2Zw49l6w2EhmNAkGJVpn389RcE8GvBuI0tnkNz4T23ErDiFGrOhKy13K5vDZEsmDsq Nw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rg4w78nat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 18:38:12 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35R0uLE7009956;
        Tue, 27 Jun 2023 18:38:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rdr4524fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 18:38:10 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35RIc6fn12059264
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2023 18:38:07 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB6BD20040;
        Tue, 27 Jun 2023 18:38:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C16A2004B;
        Tue, 27 Jun 2023 18:38:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 27 Jun 2023 18:38:06 +0000 (GMT)
Date:   Tue, 27 Jun 2023 20:38:05 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.5 merge window
Message-ID: <ZJssjVaDEfrQgB0I@tuxmaker.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D_N3GdccKSZLT_Nig8B2aY607yKVg2M2
X-Proofpoint-ORIG-GUID: D_N3GdccKSZLT_Nig8B2aY607yKVg2M2
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_12,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 mlxscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270168
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

These three commits were on 'protected-key' branch:

  9e436c195e2d s390/pkey: add support for ecc clear key
  f370f45c6475 s390/pkey: do not use struct pkey_protkey
  46a29b039e2e s390/pkey: introduce reverse x-mas trees

and were merged into 'features' branch as:

  e23b4fdb5cd0 Merge branch 'protected-key' into features

The three merged commits are on top of a prerequisite fix
844cf829e5f3 ("s390/pkey: zeroize key blobs"), which together
with the preceding commit are in the mainline already:

  844cf829e5f3 s390/pkey: zeroize key blobs
  8703dd6b238d s390/crypto: use vector instructions only if available for ChaCha20

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 5a05d1cdfec2..a8def50c149b 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -1293,6 +1293,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 			return PTR_ERR(kkey);
 		rc = pkey_keyblob2pkey(kkey, ktp.keylen, &ktp.protkey);
 		DEBUG_DBG("%s pkey_keyblob2pkey()=%d\n", __func__, rc);
+		memzero_explicit(kkey, ktp.keylen);
 		kfree(kkey);
 		if (rc)
 			break;
@@ -1426,6 +1427,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 					kkey, ktp.keylen, &ktp.protkey);
 		DEBUG_DBG("%s pkey_keyblob2pkey2()=%d\n", __func__, rc);
 		kfree(apqns);
+		memzero_explicit(kkey, ktp.keylen);
 		kfree(kkey);
 		if (rc)
 			break;
@@ -1552,6 +1554,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 					protkey, &protkeylen);
 		DEBUG_DBG("%s pkey_keyblob2pkey3()=%d\n", __func__, rc);
 		kfree(apqns);
+		memzero_explicit(kkey, ktp.keylen);
 		kfree(kkey);
 		if (rc) {
 			kfree(protkey);
diff --git a/arch/s390/crypto/chacha-glue.c b/arch/s390/crypto/chacha-glue.c
index 7752bd314558..5fae187f947a 100644
--- a/arch/s390/crypto/chacha-glue.c
+++ b/arch/s390/crypto/chacha-glue.c
@@ -82,7 +82,7 @@ void chacha_crypt_arch(u32 *state, u8 *dst, const u8 *src,
 	 * it cannot handle a block of data or less, but otherwise
 	 * it can handle data of arbitrary size
 	 */
-	if (bytes <= CHACHA_BLOCK_SIZE || nrounds != 20)
+	if (bytes <= CHACHA_BLOCK_SIZE || nrounds != 20 || !MACHINE_HAS_VX)
 		chacha_crypt_generic(state, dst, src, bytes, nrounds);
 	else
 		chacha20_crypt_s390(state, dst, src, bytes,

As result, the shortstat when merging will look different
to the one generated with 'git request-pull' below:

  21 files changed, 997 insertions(+), 328 deletions(-)


Please pull s390 changes for 6.5 merge window.

Thank you,
Alexander

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.5-1

for you to fetch changes up to 9b9cf3c77e7e090b30657b3d2c288deb58dfb4f2:

  s390/cpum_cf: rework PER_CPU_DEFINE of struct cpu_cf_events (2023-06-15 13:31:58 +0200)

----------------------------------------------------------------
s390 updates for 6.5 merge window

- Fix the style of protected key API driver source: use
  x-mas tree for all local variable declarations.

- Rework protected key API driver to not use the struct
  pkey_protkey and pkey_clrkey anymore. Both structures
  have a fixed size buffer, but with the support of ECC
  protected key these buffers are not big enough. Use
  dynamic buffers internally and transparently for
  userspace.

- Add support for a new 'non CCA clear key token' with
  ECC clear keys supported: ECC P256, ECC P384, ECC P521,
  ECC ED25519 and ECC ED448. This makes it possible to
  derive a protected key from the ECC clear key input via
  PKEY_KBLOB2PROTK3 ioctl, while currently the only way
  to derive is via PCKMO instruction.

- The s390 PMU of PAI crypto and extension 1 NNPA counters
  use atomic_t for reference counting. Replace this with
  the proper data type refcount_t.

- Select ARCH_SUPPORTS_INT128, but limit this to clang for
  now, since gcc generates inefficient code, which may lead
  to stack overflows.

- Replace one-element array with flexible-array member in
  struct vfio_ccw_parent and refactor the rest of the code
  accordingly. Also, prefer struct_size() over sizeof() open-
  coded versions.

- Introduce OS_INFO_FLAGS_ENTRY pointing to a flags field and
  OS_INFO_FLAG_REIPL_CLEAR flag that informs a dumper whether
  the system memory should be cleared or not once dumped.

- Fix a hang when a user attempts to remove a VFIO-AP mediated
  device attached to a guest: add VFIO_DEVICE_GET_IRQ_INFO and
  VFIO_DEVICE_SET_IRQS IOCTLs and wire up the VFIO bus driver
  callback to request a release of the device.

- Fix calculation for R_390_GOTENT relocations for modules.

- Allow any user space process with CAP_PERFMON capability
  read and display the CPU Measurement facility counter sets.

- Rework large statically-defined per-CPU cpu_cf_events data
  structure and replace it with dynamically allocated structures
  created when a perf_event_open() system call is invoked or
  /dev/hwctr device is accessed.

----------------------------------------------------------------
Alexander Gordeev (1):
      Merge branch 'protected-key' into features

Gustavo A. R. Silva (2):
      vfio/ccw: replace one-element array with flexible-array member
      vfio/ccw: use struct_size() helper

Harald Freudenberger (3):
      s390/pkey: introduce reverse x-mas trees
      s390/pkey: do not use struct pkey_protkey
      s390/pkey: add support for ecc clear key

Heiko Carstens (2):
      s390: select ARCH_SUPPORTS_INT128
      s390/crypto: use vector instructions only if available for ChaCha20

Holger Dengler (1):
      s390/pkey: zeroize key blobs

Mikhail Zaslonko (2):
      s390/ipl: add REIPL_CLEAR flag to os_info
      s390/zcore: conditionally clear memory on reipl

Sumanth Korikkar (1):
      s390/module: fix rela calculation for R_390_GOTENT

Thomas Richter (4):
      s390/pai_crypto: replace atomic_t with refcount_t
      s390/pai_ext: replace atomic_t with refcount_t
      s390/cpum_cf: open access to hwctr device for CAP_PERFMON privileged process
      s390/cpum_cf: rework PER_CPU_DEFINE of struct cpu_cf_events

Tony Krowiak (3):
      s390/vfio-ap: realize the VFIO_DEVICE_GET_IRQ_INFO ioctl
      s390/vfio-ap: realize the VFIO_DEVICE_SET_IRQS ioctl
      s390/vfio-ap: wire in the vfio_device_ops request callback

 arch/s390/Kconfig                      |   1 +
 arch/s390/crypto/chacha-glue.c         |   2 +-
 arch/s390/crypto/paes_s390.c           |   9 +-
 arch/s390/include/asm/asm-prototypes.h |   4 +
 arch/s390/include/asm/cpacf.h          |   7 +-
 arch/s390/include/asm/os_info.h        |   7 +-
 arch/s390/include/asm/pkey.h           |   4 +-
 arch/s390/include/uapi/asm/pkey.h      |  15 +-
 arch/s390/kernel/ipl.c                 |  16 +
 arch/s390/kernel/module.c              |   3 +-
 arch/s390/kernel/perf_cpum_cf.c        | 452 ++++++++++++++++------
 arch/s390/kernel/perf_pai_crypto.c     |  19 +-
 arch/s390/kernel/perf_pai_ext.c        |  23 +-
 arch/s390/lib/Makefile                 |   2 +-
 arch/s390/lib/tishift.S                |  63 +++
 drivers/s390/char/zcore.c              |  41 +-
 drivers/s390/cio/vfio_ccw_drv.c        |   2 +-
 drivers/s390/cio/vfio_ccw_private.h    |   2 +-
 drivers/s390/crypto/pkey_api.c         | 512 ++++++++++++++++---------
 drivers/s390/crypto/vfio_ap_ops.c      | 134 ++++++-
 drivers/s390/crypto/vfio_ap_private.h  |   3 +
 include/uapi/linux/vfio.h              |   9 +
 22 files changed, 1001 insertions(+), 329 deletions(-)
 create mode 100644 arch/s390/lib/tishift.S
