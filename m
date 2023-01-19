Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FB4673812
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjASMRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjASMQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:16:59 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCCE59251;
        Thu, 19 Jan 2023 04:16:58 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JAwEji029001;
        Thu, 19 Jan 2023 12:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=PYZGuaygt/CPh3pQjhkjxwSbTblfgOF5OMo2vG0rxcs=;
 b=is/RLvjtrZdhP9cbtYWgMaa+X7QbwUU6nVvqqdrnO4lZixWByPiHCaJ6nUT/VvyfSMME
 gtCPfH6p64Nn5nNOAVvGU6t6g3dYfL8IxOlZ0u05A03MrWH2BvF6sGThEivHc+Dup9Hq
 KWr32v4mkWnCUoD5ypwlwrMiJJvoDlbo74YoIx0V8sR1QH9Kz94eEonkJHSlcOJ2j/ik
 Y+XHpV9CdtanSGL4hhqnjr/1VNBjgv9DH+CDYqIWEM4mNxNDu+OmxJrOeE8zmGuHHAbm
 Khh0Wt/5/H0axOQCUYUr/dK2NhEKiHBCoK2UoY0VZppfaRcWIeie8U4Z+1g65+/A1jI/ XA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n717yeeqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 12:16:57 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30J5Wac2004659;
        Thu, 19 Jan 2023 12:16:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3n3m16pn6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 12:16:54 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30JCGp3j50659748
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 12:16:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F05442004E;
        Thu, 19 Jan 2023 12:16:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE02B2004B;
        Thu, 19 Jan 2023 12:16:50 +0000 (GMT)
Received: from osiris (unknown [9.152.212.250])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 19 Jan 2023 12:16:50 +0000 (GMT)
Date:   Thu, 19 Jan 2023 13:16:49 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 compile fix for 6.2-rc5
Message-ID: <Y8k0sZthY7L7rINA@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KDFSRfHD3Rf_Hv7X5YImoyPdk8VpWSFo
X-Proofpoint-GUID: KDFSRfHD3Rf_Hv7X5YImoyPdk8VpWSFo
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_09,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190095
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull a single compile fix for 6.2-rc5.

Thanks,
Heiko

The following changes since commit 1ecf7bd9c267ab85aff3c4a17fe56bc9754a13be:

  s390: update defconfigs (2023-01-11 21:26:40 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.2-3

for you to fetch changes up to 41e1992665a2701fa025a8b76970c43b4148446f:

  s390: workaround invalid gcc-11 out of bounds read warning (2023-01-17 19:00:59 +0100)

----------------------------------------------------------------
s390 compile fix for 6.2-rc5

- Workaround invalid gcc-11 out of bounds read warning caused by s390's
  S390_lowcore definition. This happens only with gcc 11.1.0 and 11.2.0.
  The code which causes this warning will be gone with the next merge
  window. Therefore just replace the memcpy() with a for loop to get rid of
  the warning.

----------------------------------------------------------------
Heiko Carstens (1):
      s390: workaround invalid gcc-11 out of bounds read warning

 arch/s390/kernel/setup.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 2b6091349daa..696c9e007a36 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -508,6 +508,7 @@ static void __init setup_lowcore_dat_on(void)
 {
 	struct lowcore *abs_lc;
 	unsigned long flags;
+	int i;
 
 	__ctl_clear_bit(0, 28);
 	S390_lowcore.external_new_psw.mask |= PSW_MASK_DAT;
@@ -523,8 +524,8 @@ static void __init setup_lowcore_dat_on(void)
 	abs_lc = get_abs_lowcore(&flags);
 	abs_lc->restart_flags = RESTART_FLAG_CTLREGS;
 	abs_lc->program_new_psw = S390_lowcore.program_new_psw;
-	memcpy(abs_lc->cregs_save_area, S390_lowcore.cregs_save_area,
-	       sizeof(abs_lc->cregs_save_area));
+	for (i = 0; i < 16; i++)
+		abs_lc->cregs_save_area[i] = S390_lowcore.cregs_save_area[i];
 	put_abs_lowcore(abs_lc, flags);
 }
 
