Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE36B6AB2B2
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 23:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjCEWBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 17:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCEWBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 17:01:42 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF998CDCD;
        Sun,  5 Mar 2023 14:01:40 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 325LVveD008457;
        Sun, 5 Mar 2023 22:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=jOu+ATFD6epKfa/dIl5O1pLo9na6LoDoSY0228fDne4=;
 b=P9La3Bol9p62H2LUjQOZtpy9A9oY6uKxGPUWC2+BnhlvqtzcycYVA+JypkaQncNg7JZM
 4R5qKWzAAWF/dIIl5R1Xj5JOHo3JtjDn/VPubv1GEGKp5llF8SGgg9CDNof4G8Iktal9
 7PmLNYTyteU+Jatk9LTzRUJ96bwzUCp6Ft35rIKCDMuZId0uUApKipN3DRC0sZdwQjLH
 fhyXuMEU2dbVM1lF3H7m5zpxQBriv/Ap5VTTVgv3Q+/IiigvTcDiuKOJ18SAYywAQszx
 NOYmV01TXrk8v7+ytoh4pDn7BxBA3a5wL2jcuTaB+w4VPmHDjZmCVKhGSuvfij1In/9l pA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p416whrqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Mar 2023 22:00:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 325HLY92023407;
        Sun, 5 Mar 2023 22:00:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p4u040m1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Mar 2023 22:00:24 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 325M0Nqx013622;
        Sun, 5 Mar 2023 22:00:23 GMT
Received: from t460.home (dhcp-10-175-35-7.vpn.oracle.com [10.175.35.7])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3p4u040ktj-1;
        Sun, 05 Mar 2023 22:00:23 +0000
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Solar Designer <solar@openwall.com>,
        Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Amit Shah <aams@amazon.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH v3 0/7] Documentation/security-bugs: overhaul
Date:   Sun,  5 Mar 2023 23:00:03 +0100
Message-Id: <20230305220010.20895-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.23.0.718.g5ad94255a8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-05_12,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=726
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303050192
X-Proofpoint-GUID: iCJ2Jt-gZINbQ01lc772bGp0xW_IGBA2
X-Proofpoint-ORIG-GUID: iCJ2Jt-gZINbQ01lc772bGp0xW_IGBA2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v3 of clarifying our documentation for reporting security
issues.

The current document is not clear enough, in particular the process of
disclosure and requesting CVEs, and what the roles of the different
lists are and how exactly to report to each of them.

Lots of people have been confused about the 7/14 days of the kernel list
vs. the 7/14 days of the distros list, the fact that these are two
separate lists, etc. Many reporters contact distros first, or submit
their report to both lists at the same time (which has the unfortunate
effect of starting off the disclosure countdown for the distros list
before s@k.o has had a chance to look at the report). I've shared the v2
document with a couple of people who submitted reports and they said
they found it a lot clearer. 

Probably the easiest way to see the end result of this series is to view the
rendered HTML which I've put here:
https://vegard.github.io/security-v3/Documentation/output/process/security-bugs.html

oss-security discussion prompting the change:
https://www.openwall.com/lists/oss-security/2022/05/15/1

v1 submission:
https://lore.kernel.org/all/20220531230309.9290-1-vegard.nossum@oracle.com/

v2 submission:
https://lore.kernel.org/all/20220606194850.26122-1-vegard.nossum@oracle.com/

Changes:

v2: address feedback from Willy Tarreau and Jonathan Corbet

v3: move from admin-guide/ to process/; address feedback from Will
Deacon (including reverting back to some of the original phrasing);
split into multiple patches


Vegard

Vegard Nossum (7):
  Documentation/security-bugs: move from admin-guide/ to process/
  Documentation/security-bugs: misc. improvements
  Documentation/security-bugs: improve security list section
  Documentation/security-bugs: add linux-distros and oss-security
    sections
  Documentation/security-bugs: add table of lists
  Documentation/security-bugs: clarify hardware vs. software
    vulnerabilities
  Documentation/security-bugs: document document design

 Documentation/admin-guide/index.rst           |   1 -
 .../admin-guide/reporting-issues.rst          |   4 +-
 Documentation/admin-guide/security-bugs.rst   |  96 ----------
 Documentation/process/howto.rst               |   2 +-
 Documentation/process/index.rst               |   9 +-
 .../process/researcher-guidelines.rst         |   2 +-
 Documentation/process/security-bugs.rst       | 181 ++++++++++++++++++
 Documentation/process/stable-kernel-rules.rst |   2 +-
 Documentation/process/submitting-patches.rst  |   2 +-
 .../it_IT/admin-guide/security-bugs.rst       |   2 +-
 .../it_IT/process/submitting-patches.rst      |   2 +-
 Documentation/translations/ja_JP/howto.rst    |   2 +-
 Documentation/translations/ko_KR/howto.rst    |   2 +-
 Documentation/translations/sp_SP/howto.rst    |   2 +-
 .../sp_SP/process/submitting-patches.rst      |   2 +-
 .../zh_CN/admin-guide/security-bugs.rst       |   2 +-
 .../translations/zh_CN/process/howto.rst      |   2 +-
 .../zh_TW/admin-guide/security-bugs.rst       |   2 +-
 .../translations/zh_TW/process/howto.rst      |   2 +-
 MAINTAINERS                                   |   4 +-
 20 files changed, 207 insertions(+), 116 deletions(-)
 delete mode 100644 Documentation/admin-guide/security-bugs.rst
 create mode 100644 Documentation/process/security-bugs.rst

-- 
2.40.0.rc1.2.gd15644fe02

