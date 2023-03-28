Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8FB6CBFF9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjC1M5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjC1M53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:57:29 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6A6AD09;
        Tue, 28 Mar 2023 05:57:17 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SChYtQ016389;
        Tue, 28 Mar 2023 12:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=nMAhbMqZSVBNBaNRKBYHQ9W/xDGZKvgtEVyOvoe2Kis=;
 b=VH1JV91vO11Npw+fXPFp2zhJ6ZCXo90bD7NRiWtroU1RvzzD1iEWSTkeEzFPAwOmDw6D
 2VANfsjpdnXa4wvB5yYdUYmzNHMKmiphyuLcElA3lhjLV5uXSjSH2GwRid8QoXv9lVWX
 I5d7vZRLyft6udZCFEjaDTtuy0h/nnEjATFyPjOjZUu0UbKHqKD8tOh/X9FUwJm03t5e
 FY9uagpmK6wcrbPi6DhSd7vvSMfVmEFwj57sHmOaQp4kpbJVTUFNav9L4ntukmOx+pgn
 LJewqqfEoOhV0qVcI1BFklNzdfp9WerigHYZ6a89FzXv5oMOOyywwG00pQZWZCMX2/rN KA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pm0g9gbsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 12:57:15 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32S0oc10016233;
        Tue, 28 Mar 2023 12:57:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3phrk6kyj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 12:57:13 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32SCvAaD30081614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Mar 2023 12:57:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A54B620043;
        Tue, 28 Mar 2023 12:57:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44FE620040;
        Tue, 28 Mar 2023 12:57:10 +0000 (GMT)
Received: from localhost (unknown [9.171.64.142])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 28 Mar 2023 12:57:10 +0000 (GMT)
Date:   Tue, 28 Mar 2023 14:57:08 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.3-rc5
Message-ID: <your-ad-here.call-01680008228-ext-8201@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nFBRKuedVPciyqYOceArC-CDnvF5Mmfv
X-Proofpoint-ORIG-GUID: nFBRKuedVPciyqYOceArC-CDnvF5Mmfv
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303280100
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 6.3-rc5.

Thank you,
Vasily

The following changes since commit d7a0bdbf17276b757d2b89f5351bbee9ecf58fe6:

  s390: update defconfigs (2023-03-13 09:15:11 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.3-4

for you to fetch changes up to f9bbf25e7b2b74b52b2f269216a92657774f239c:

  s390/ptrace: fix PTRACE_GET_LAST_BREAK error handling (2023-03-27 17:23:08 +0200)

----------------------------------------------------------------
s390 updates for 6.3-rc5

- Fix an error handling issue with PTRACE_GET_LAST_BREAK request so that
  an -EFAULT is returned if put_user() fails, instead of ignoring it.

- Fix a build race for the modules_prepare target when
  CONFIG_EXPOLINE_EXTERN is enabled by reintroducing the dependence
  on scripts.

- Fix a memory leak in vfio_ap device driver.

- Adds missing earlyclobber annotations to __clear_user() inline assembly
  to prevent incorrect register allocation.

----------------------------------------------------------------
Heiko Carstens (2):
      s390/uaccess: add missing earlyclobber annotations to __clear_user()
      s390/ptrace: fix PTRACE_GET_LAST_BREAK error handling

Jiri Slaby (SUSE) (1):
      s390: reintroduce expoline dependence to scripts

Tony Krowiak (1):
      s390/vfio-ap: fix memory leak in vfio_ap device driver

 arch/s390/Makefile                | 2 +-
 arch/s390/kernel/ptrace.c         | 8 ++------
 arch/s390/lib/uaccess.c           | 2 +-
 drivers/s390/crypto/vfio_ap_drv.c | 3 ++-
 4 files changed, 6 insertions(+), 9 deletions(-)
