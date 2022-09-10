Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0BE5B45FD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 13:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiIJLAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 07:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiIJLAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 07:00:15 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53A9303C1;
        Sat, 10 Sep 2022 04:00:13 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28AAVUmI029080;
        Sat, 10 Sep 2022 11:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=BYq2Yzlbmcp890FD5E8AWx2DvgLgZmzL7hQQrObUyDc=;
 b=NqR0WkwzlvjdwyF2cOIJaLgqzT58XRYkrW8o9ugHXj2Xu1o9JczysM9uNJdkfPYGOmR1
 SC8fvuEpBG66MJtAPhfWRV1yBbWeKeouv9nSkAF/K3D88V+jm7IbIlzOIiaRjiER+uZ2
 JseRc2obofwWTps9in5aScBtOBgyRIlkMsYgBpclR+iVKPZGNf2WMlOOGIywesUTcO86
 L9VZqkdgdjfweL/0DB9o64kseTSqvgKxmrl6OOz/dFMR9em6ntib9SUCAXAeW+66WcWe
 R3NoVcPt+f1ykgjoERzl1AxgZIlF0yjTnHEwbzuUb2iTuYe9cvlGfe1ZL4nigpwkvVDC sw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jgrwf8d95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Sep 2022 11:00:12 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28AApo2P021978;
        Sat, 10 Sep 2022 11:00:10 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 3jgj7907yv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Sep 2022 11:00:09 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28AB06P836176304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Sep 2022 11:00:06 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CE53AE04D;
        Sat, 10 Sep 2022 11:00:06 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41FC3AE051;
        Sat, 10 Sep 2022 11:00:06 +0000 (GMT)
Received: from localhost (unknown [9.171.12.48])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 10 Sep 2022 11:00:06 +0000 (GMT)
Date:   Sat, 10 Sep 2022 13:00:04 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.0-rc5
Message-ID: <your-ad-here.call-01662807604-ext-8310@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PwcoFUXw82O5XkcsDqdHgZokFlbBX7cZ
X-Proofpoint-ORIG-GUID: PwcoFUXw82O5XkcsDqdHgZokFlbBX7cZ
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-10_04,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 mlxlogscore=802 suspectscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209100038
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 6.0-rc5.

Thank you,
Vasily

The following changes since commit 7c8d42fdf1a84b1a0dd60d6528309c8ec127e87c:

  s390/hugetlb: fix prepare_hugepage_range() check for 2 GB hugepages (2022-08-30 21:57:07 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.0-4

for you to fetch changes up to 8d96bba75a43ba564bf8732e955d9f519d2bbaec:

  s390/smp: enforce lowcore protection on CPU restart (2022-09-07 14:04:01 +0200)

----------------------------------------------------------------
s390 updates for 6.0-rc5

- Fix absolute zero lowcore corruption on kdump when CPU0 is offline.

- Fix lowcore protection setup for offline CPU restart.

----------------------------------------------------------------
Alexander Gordeev (2):
      s390/boot: fix absolute zero lowcore corruption on boot
      s390/smp: enforce lowcore protection on CPU restart

 arch/s390/kernel/nmi.c   | 2 +-
 arch/s390/kernel/setup.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)
