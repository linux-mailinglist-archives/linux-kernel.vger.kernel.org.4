Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA13626249
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 20:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbiKKTp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 14:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbiKKTp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 14:45:26 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A31F7F57D;
        Fri, 11 Nov 2022 11:45:25 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABJFU1W026611;
        Fri, 11 Nov 2022 19:45:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=zF029rsPI1IAz/q0/sXxOn73sfbKFwU3fPO/WNda7XE=;
 b=XEolMzGCHpnd7INIlvtP7jxTD9eNtTVRXwLI1fgONFVP7l5yv+RgtAZhAa38IRq75Tem
 mg4+NwKiw2DGxFOxk9KPTZVatXlUPOqwLsY1iIpP2Naz6/rTJiPNRDqbMFXSWo8tNdtG
 96GLt4TJDuiHtH+UNmhTuQE/nuW7Qmjs5/B/RvO4p4gZ5jczvY7rP4fh9IUK53WnG5s2
 2R4H0wRffOecp4g5EIDyO5Tuz5K0dTRvBEt4JFwsNelUBGUThjfmtFGL68vbH5hfgew6
 Bry0A3sRN/K2cyHsYpZAXJyJeYutkT49nN+QbO4WRhSA4LdFOp0cbkrxSs8LwLNTajPN hQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ksvd2rpdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 19:45:24 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ABJa9Rc022586;
        Fri, 11 Nov 2022 19:45:22 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3kngnch52y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 19:45:22 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ABJjJQL393820
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 19:45:19 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 030DF42041;
        Fri, 11 Nov 2022 19:45:19 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2EDC4203F;
        Fri, 11 Nov 2022 19:45:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 11 Nov 2022 19:45:18 +0000 (GMT)
Date:   Fri, 11 Nov 2022 20:45:17 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] s390 updates for 6.1-rc5
Message-ID: <Y26mTTsPtdaNJ4lP@tuxmaker.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CMxuZk_rDvYvcWtnywGsdtmYT4WNeFYq
X-Proofpoint-GUID: CMxuZk_rDvYvcWtnywGsdtmYT4WNeFYq
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_10,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=602
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 phishscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211110133
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 6.1-rc5.

Thank you,
Alexander

The following changes since commit e38de4804421b064a9c73c5a9b7f3df96b863e4b:

  s390/vfio-ap: Fix memory allocation for mdev_types array (2022-10-21 10:50:02 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.1-4

for you to fetch changes up to 30d17fac6aaedb40d111bb159f4b35525637ea78:

  scripts/min-tool-version.sh: raise minimum clang version to 15.0.0 for s390 (2022-10-31 13:34:56 +0100)

----------------------------------------------------------------
s390 updates for 6.1-rc5

- fix memcpy warning about field-spanning write in zcrypt driver.

- minor updates to defconfigs.

- Remove CONFIG_DEBUG_INFO_BTF from all defconfigs and add btf.config
  addon config file. It significantly decreases compile time and allows
  quickly enabling that option into the current kernel config.

- Add kasan.config addon config file which allows to easily enable
  KASAN into the current kernel config.

- binutils commit 906f69cf65da ("IBM zSystems: Issue error for *DBL
  relocs on misaligned symbols") caused several link errors.
  Always build relocatable kernel to avoid this problem.

- Raise the minimum clang version to 15.0.0 to avoid silent generation
  of a corrupted code.

----------------------------------------------------------------
Harald Freudenberger (1):
  s390/zcrypt: fix warning about field-spanning write

Heiko Carstens (5):
  s390: update defconfigs
  s390/configs: move CONFIG_DEBUG_INFO_BTF into btf.config addon config
  s390/configs: add kasan.config addon config file
  s390: always build relocatable kernel
  scripts/min-tool-version.sh: raise minimum clang version to 15.0.0 for
    s390

 arch/s390/Kconfig                     |  6 +--
 arch/s390/Makefile                    |  2 -
 arch/s390/boot/Makefile               |  3 +-
 arch/s390/boot/startup.c              |  3 +-
 arch/s390/configs/btf.config          |  1 +
 arch/s390/configs/debug_defconfig     | 65 +++++++++++++-------------
 arch/s390/configs/defconfig           | 67 +++++++++++++--------------
 arch/s390/configs/kasan.config        |  3 ++
 arch/s390/configs/zfcpdump_defconfig  |  1 -
 drivers/s390/crypto/zcrypt_msgtype6.c | 21 ++++++---
 scripts/min-tool-version.sh           |  2 +-
 11 files changed, 90 insertions(+), 84 deletions(-)
 create mode 100644 arch/s390/configs/btf.config
 create mode 100644 arch/s390/configs/kasan.config
