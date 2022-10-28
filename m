Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E72A611B93
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 22:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiJ1Uew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 16:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJ1Uet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 16:34:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA513DF15;
        Fri, 28 Oct 2022 13:34:47 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SKC8kO027050;
        Fri, 28 Oct 2022 20:34:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=Z+c+2NzgQgy/iG0fUQt4UIBsAYyJLMFFQMFA1firyPg=;
 b=nF5VeWACRlgluR0P75ZSnTSB7kId4xGyNG8HFVh0SBR39x241JlI6jbGum186PhaZJOd
 TZcmyIP5AU977jSrfA8H4AQirV8dWSPjUdSxjwU9TJ9SV1St3FPKncwg4o3qKWUYjY93
 3zv/8yXLb0+HGgKJkqefwzScyQC0t+pAUZEfXAOxmwMyL52CbtZ3AOSbBNibfmvilZq+
 AWq/MQgL29Y1F/JtJvXfooNeAzyc6UUIPSc4ilZ7/Zm8tHQqSOtP4jboRMQekOT2gDj9
 2bgB4CgLyn/SlboLpkG2+RRAApn9VvZ5TCivamLsvwn05mkwTdBeGyxtU5bRLqPM0bm1 DA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kgnwerkbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 20:34:46 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29SKKhlC012769;
        Fri, 28 Oct 2022 20:34:43 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3kg0f919au-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 20:34:43 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29SKTKSW47251750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 20:29:20 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69243A4051;
        Fri, 28 Oct 2022 20:34:40 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1261BA4040;
        Fri, 28 Oct 2022 20:34:40 +0000 (GMT)
Received: from localhost (unknown [9.171.51.250])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 28 Oct 2022 20:34:39 +0000 (GMT)
Date:   Fri, 28 Oct 2022 22:34:38 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.1-rc3
Message-ID: <your-ad-here.call-01666989278-ext-6142@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ySwgt7YBtSaBcmJKsWgGeLxxOTE9ySfB
X-Proofpoint-GUID: ySwgt7YBtSaBcmJKsWgGeLxxOTE9ySfB
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_10,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=825 mlxscore=0 bulkscore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280129
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 6.1-rc3.

Thank you,
Vasily

The following changes since commit 247f34f7b80357943234f93f247a1ae6b6c3a740:

  Linux 6.1-rc2 (2022-10-23 15:27:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.1-3

for you to fetch changes up to e38de4804421b064a9c73c5a9b7f3df96b863e4b:

  s390/vfio-ap: Fix memory allocation for mdev_types array (2022-10-26 14:47:31 +0200)

----------------------------------------------------------------
s390 updates for 6.1-rc3

- Remove outdated linux390 link from MAINTAINERS.

- Add few missing EX_TABLE entries to inline assemblies.

- Fix raw data collection for pai_ext PMU.

- Add kernel image secure boot trailer for future firmware versions.

- Fix out-of-bounds access on cio_ignore free.

- Fix memory allocation of mdev_types array in vfio-ap.

----------------------------------------------------------------
Heiko Carstens (4):
      MAINTAINERS: remove outdated linux390 link
      s390/uaccess: add missing EX_TABLE entries to __clear_user()
      s390/futex: add missing EX_TABLE entry to __futex_atomic_op()
      s390/pci: add missing EX_TABLE entries to __pcistg_mio_inuser()/__pcilg_mio_inuser()

Jason J. Herne (1):
      s390/vfio-ap: Fix memory allocation for mdev_types array

Peter Oberparleiter (2):
      s390/boot: add secure boot trailer
      s390/cio: fix out-of-bounds access on cio_ignore free

Thomas Richter (1):
      s390/pai: fix raw data collection for PMU pai_ext

 MAINTAINERS                           | 12 ------------
 arch/s390/boot/vmlinux.lds.S          | 13 +++++++++++--
 arch/s390/include/asm/futex.h         |  3 ++-
 arch/s390/kernel/perf_pai_ext.c       |  1 +
 arch/s390/lib/uaccess.c               |  6 +++---
 arch/s390/pci/pci_mmio.c              |  8 ++++----
 drivers/s390/cio/css.c                |  8 ++------
 drivers/s390/crypto/vfio_ap_private.h |  2 +-
 8 files changed, 24 insertions(+), 29 deletions(-)
