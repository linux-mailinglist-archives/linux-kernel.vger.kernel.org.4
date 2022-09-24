Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879AB5E8E5E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 18:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbiIXQKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 12:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiIXQKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 12:10:20 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D47220FA;
        Sat, 24 Sep 2022 09:10:17 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28ODob3f004287;
        Sat, 24 Sep 2022 16:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=a4zcKXoJ05wmFaNpgRVGyWwOgOwSRvLYCZBnIZmH8hs=;
 b=RjMIuiKNYFqW5cDQMfVdVR8gFCjOW7e9PipZ8dLpSeFQLQojuKgqOsnQUUAmxcIIuLkr
 E5TX/96tXvfv3w1MHnfnrt0C0mpzUWSgweMSNp+2jT3SHf86is4hev28Isr6R2cYc4BG
 AbBmHrifuHDBPAftspOhoYIZdYeOH32nDEo6RZgPyhVVOSt53o6aLMP7QGVF8+0M7a9D
 iJ6e/M+G0mGomFox6iMbjz1cPkHol0CTe7Z8tX1FHV9HhtVSJTp/9sGGGKFSOR9oOoUS
 ZKNzsfct0BQORMMnVEX/EsVK4JVuIwn1GEDW3nLq0nhn9rIZKqx5BJLORjp9DYeVp7nw nA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jswxx0n82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Sep 2022 16:10:16 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28OG5gor008063;
        Sat, 24 Sep 2022 16:10:14 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3jssh98h28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Sep 2022 16:10:14 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28OGAAbh52494838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 24 Sep 2022 16:10:10 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C939542041;
        Sat, 24 Sep 2022 16:10:10 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BA9842045;
        Sat, 24 Sep 2022 16:10:10 +0000 (GMT)
Received: from localhost (unknown [9.171.68.51])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 24 Sep 2022 16:10:10 +0000 (GMT)
Date:   Sat, 24 Sep 2022 18:10:08 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.0-rc7
Message-ID: <your-ad-here.call-01664035808-ext-9945@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: P-hKLUEv0vRCgVAQK6XNQ1CNk_yv2rry
X-Proofpoint-ORIG-GUID: P-hKLUEv0vRCgVAQK6XNQ1CNk_yv2rry
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-24_07,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1011 phishscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209240120
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 6.0-rc7.

Thank you,
Vasily

The following changes since commit 8d96bba75a43ba564bf8732e955d9f519d2bbaec:

  s390/smp: enforce lowcore protection on CPU restart (2022-09-07 14:04:01 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.0-5

for you to fetch changes up to 1918f2b20c3de73ef6f644979896e20a2e7dbb2d:

  s390/vfio-ap: bypass unnecessary processing of AP resources (2022-09-21 22:33:16 +0200)

----------------------------------------------------------------
s390 updates for v6.0-rc7

- Fix potential hangs in VFIO AP driver.

----------------------------------------------------------------
Tony Krowiak (1):
      s390/vfio-ap: bypass unnecessary processing of AP resources

 drivers/s390/crypto/vfio_ap_ops.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
