Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C33D6AB2B4
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 23:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjCEWB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 17:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjCEWBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 17:01:44 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C89C1025B;
        Sun,  5 Mar 2023 14:01:43 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 325LvtUB020022;
        Sun, 5 Mar 2023 22:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=2m8H1ke5jWQAt4IxFD9cHEaOxnH7XK15MYG59dTVxBA=;
 b=lnWapAxQhx6qROlmQNLILRj3Lyaenfxxspvjkim7ogFdWZ2BVpHZ92h6GxENzpnZ7TkT
 RcrG8EWdtfztZCe8fJFgsP512afTzaUEvQTTXv7lUtqSWjFMY/EG8hwM4ObqeYsvDYDV
 wVilh1tRS1XFfvSTNefoHeFvbVHLrvibotjS6K4yGF2ElqQ3m1SVG3/n9qx4DwWrjqNQ
 L51UQh6G/L00tVu7PDywEiU0JQ5rv/gW7jHI0mPwdaXLATz46yVOJ390d6CG/U8u3z+q
 KOA5wuZQIgnIGKGCHpvCEbWxvzeP48pzjg2AyfrjNEtL+qhQBW1PAv515d9tfEvCoUSH eg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p418xss7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Mar 2023 22:00:41 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 325IAIjd023468;
        Sun, 5 Mar 2023 22:00:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p4u040mb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Mar 2023 22:00:40 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 325M0Nr3013622;
        Sun, 5 Mar 2023 22:00:40 GMT
Received: from t460.home (dhcp-10-175-35-7.vpn.oracle.com [10.175.35.7])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3p4u040ktj-3;
        Sun, 05 Mar 2023 22:00:39 +0000
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
Subject: [PATCH v3 2/7] Documentation/security-bugs: misc. improvements
Date:   Sun,  5 Mar 2023 23:00:05 +0100
Message-Id: <20230305220010.20895-3-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.23.0.718.g5ad94255a8
In-Reply-To: <20230305220010.20895-1-vegard.nossum@oracle.com>
References: <20230305220010.20895-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-05_12,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303050192
X-Proofpoint-GUID: U5MPE3nB2NxnvuXxJgZF8zImAwqkISXj
X-Proofpoint-ORIG-GUID: U5MPE3nB2NxnvuXxJgZF8zImAwqkISXj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This mostly just clarifies things and moves a few things around in
preparation for the subsequent changes.

Most notably, pull the "security@kernel.org" address up into the first
paragraph as this the most vital piece of information in the whole
document.

Also fix a few markup issues.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/process/security-bugs.rst | 37 ++++++++++++++-----------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/Documentation/process/security-bugs.rst b/Documentation/process/security-bugs.rst
index 82e29837d589..f1326d4e9718 100644
--- a/Documentation/process/security-bugs.rst
+++ b/Documentation/process/security-bugs.rst
@@ -1,36 +1,41 @@
 .. _securitybugs:
 
-Security bugs
-=============
+Reporting security bugs
+=======================
 
 Linux kernel developers take security very seriously.  As such, we'd
 like to know when a security bug is found so that it can be fixed and
 disclosed as quickly as possible.  Please report security bugs to the
-Linux kernel security team.
+Linux kernel security team at security@kernel.org, henceforth
+"the security list".  This is a closed list of trusted developers who
+will help verify the bug report and develop a patch in case none was
+already proposed.
 
-Contact
--------
+While the security list is closed, the security team may bring in extra
+help from the relevant maintainers to understand and fix the security
+vulnerability.
 
-The Linux kernel security team can be contacted by email at
-<security@kernel.org>.  This is a private list of security officers
-who will help verify the bug report and develop and release a fix.
-If you already have a fix, please include it with your report, as
-that can speed up the process considerably.  It is possible that the
-security team will bring in extra help from area maintainers to
-understand and fix the security vulnerability.
+Note that the main interest of the kernel security list is in getting
+bugs fixed and getting patches reviewed, tested, and merged; CVE
+assignment, disclosure to distributions, and public disclosure happen on
+different lists with different people.
+
+Contacting the security list
+----------------------------
 
 As it is with any bug, the more information provided the easier it
 will be to diagnose and fix.  Please review the procedure outlined in
-'Documentation/admin-guide/reporting-issues.rst' if you are unclear about what
+Documentation/admin-guide/reporting-issues.rst if you are unclear about what
 information is helpful.  Any exploit code is very helpful and will not
 be released without consent from the reporter unless it has already been
-made public.
+made public.  Reporters are encouraged to propose patches, participate in the
+discussions of a fix, and test patches.
 
 Please send plain text emails without attachments where possible.
 It is much harder to have a context-quoted discussion about a complex
 issue if all the details are hidden away in attachments.  Think of it like a
-:doc:`regular patch submission <../process/submitting-patches>`
-(even if you don't have a patch yet): describe the problem and impact, list
+regular patch submission (see Documentation/process/submitting-patches.rst)
+even if you don't have a patch yet; describe the problem and impact, list
 reproduction steps, and follow it with a proposed fix, all in plain text.
 
 Disclosure and embargoed information
-- 
2.40.0.rc1.2.gd15644fe02

