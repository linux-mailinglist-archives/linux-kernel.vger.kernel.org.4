Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D7170989C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 15:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjESNoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 09:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjESNoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 09:44:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50644AA;
        Fri, 19 May 2023 06:44:17 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JDiG1J026493;
        Fri, 19 May 2023 13:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=EjAZT4UN24dbbozDuIDqkO2EKI6bcA9TP22AbafGM5o=;
 b=olH8shnzLUD5FRXEI2XDkT+NkWopCL57/Kh3hN9+svYc6samcioVb0bsdVcSRiaMFzj7
 1PbdD/UZxOOk3c/I4KQf6juu5ebYSF6bHNa9pic7VuFP9A50FO7bL6KRVNr8Cvex0Urm
 kwl6p4ZyXbn9MAu4CRfyFU+b+yE53baVE+K07pdRa/XnOG4ASl+SPpL/hdbUJInePPHY
 gLFULNdAXizPyr/IecyoZL1GBYcRcmNlnmo8Md3oRn6NnJWrNGZ4VRPHTom7xKEAKOzI
 Xcfi0H97ClXUv6tmP7eEVhm3ivm40SBotFR6IQXt9LFc9Nszh1TJlZczwvdVemLFCahq ow== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qpa8r800s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 13:44:15 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34J3pfDr027478;
        Fri, 19 May 2023 13:44:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qj264u6ne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 13:44:13 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34JDiAbJ39518472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 13:44:10 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1588C20040;
        Fri, 19 May 2023 13:44:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E32A120043;
        Fri, 19 May 2023 13:44:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 19 May 2023 13:44:09 +0000 (GMT)
Date:   Fri, 19 May 2023 15:44:08 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.4-rc3
Message-ID: <ZGd9KHlUSFgg+NHq@tuxmaker.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pZhXANFyfGicmatNSYirib6lgiBsCpyv
X-Proofpoint-ORIG-GUID: pZhXANFyfGicmatNSYirib6lgiBsCpyv
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_09,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0 adultscore=0
 clxscore=1011 priorityscore=1501 bulkscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305190114
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 6.4-rc3. It contain a fix to statfs code,
which was acked by Andrew Morton:
https://lore.kernel.org/all/20230511204513.3d0d60f0315350177a800284@linux-foundation.org/

Thank you,
Alexander

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.4-2

for you to fetch changes up to 0f1cbf941d5949110adf70725a9614e622de8d99:

  s390/iommu: get rid of S390_CCW_IOMMU and S390_AP_IOMMU (2023-05-01 14:11:28 -0300)

----------------------------------------------------------------
s390 updates for 6.4-rc3

- Add check whether the required facilities are installed
  before using the s390-specific ChaCha20 implementation.

- Key blobs for s390 protected key interface IOCTLs commands
  PKEY_VERIFYKEY2 and PKEY_VERIFYKEY3 may contain clear key
  material. Zeroize copies of these keys in kernel memory
  after creating protected keys.

- Set CONFIG_INIT_STACK_NONE=y in defconfigs to avoid extra
  overhead of initializing all stack variables by default.

- Make sure that when a new channel-path is enabled all
  subchannels are evaluated: with and without any devices
  connected on it.

- When SMT thread CPUs are added to CPU topology masks the
  nr_cpu_ids limit is not checked and could be exceeded.
  Respect the nr_cpu_ids limit and avoid a warning when
  CONFIG_DEBUG_PER_CPU_MAPS is set.

- The pointer to IPL Parameter Information Block is stored
  in the absolute lowcore as a virtual address. Save it as
  the physical address for later use by dump tools.

- Fix a Queued Direct I/O (QDIO) problem on z/VM guests using
  QIOASSIST with dedicated (pass through) QDIO-based devices
  such as FCP, real OSA or HiperSockets.

- s390's struct statfs and struct statfs64 contain padding,
  which field-by-field copying does not set. Initialize the
  respective structures with zeros before filling them and
  copying to userspace.

- Grow s390 compat_statfs64, statfs and statfs64 structures
  f_spare array member to cover padding and simplify things.

- Remove obsolete SCHED_BOOK and SCHED_DRAWER configs.

- Remove unneeded S390_CCW_IOMMU and S390_AP_IOM configs.

----------------------------------------------------------------
Alexander Gordeev (2):
  s390/topology: honour nr_cpu_ids when adding CPUs
  s390/ipl: fix IPIB virtual vs physical address confusion

Heiko Carstens (3):
  s390/crypto: use vector instructions only if available for ChaCha20
  s390/defconfigs: set CONFIG_INIT_STACK_NONE=y
  s390/qdio: fix do_sqbs() inline assembly constraint

Holger Dengler (1):
  s390/pkey: zeroize key blobs

Ilya Leoshkevich (2):
  statfs: enforce statfs[64] structure initialization
  s390/uapi: cover statfs padding by growing f_spare

Jason Gunthorpe (1):
  s390/iommu: get rid of S390_CCW_IOMMU and S390_AP_IOMMU

Lukas Bulwahn (1):
  s390/Kconfig: remove obsolete configs SCHED_{BOOK,DRAWER}

Vineeth Vijayan (1):
  s390/cio: include subchannels without devices also for evaluation

 Documentation/s390/vfio-ap.rst       |  1 -
 arch/s390/Kconfig                    | 11 +---------
 arch/s390/configs/debug_defconfig    |  3 +--
 arch/s390/configs/defconfig          |  3 +--
 arch/s390/configs/zfcpdump_defconfig |  1 +
 arch/s390/crypto/chacha-glue.c       |  2 +-
 arch/s390/include/asm/compat.h       |  2 +-
 arch/s390/include/uapi/asm/statfs.h  |  4 ++--
 arch/s390/kernel/ipl.c               |  3 +--
 arch/s390/kernel/topology.c          | 32 +++++++++++++++-------------
 drivers/iommu/Kconfig                | 16 --------------
 drivers/s390/cio/device.c            |  2 ++
 drivers/s390/cio/qdio.h              |  2 +-
 drivers/s390/crypto/pkey_api.c       |  3 +++
 fs/statfs.c                          |  4 ++--
 15 files changed, 34 insertions(+), 55 deletions(-)
