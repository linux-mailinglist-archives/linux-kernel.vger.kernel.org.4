Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A62C6AB2B3
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 23:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjCEWBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 17:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCEWBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 17:01:43 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BECCDE9;
        Sun,  5 Mar 2023 14:01:42 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 325LjBdc030101;
        Sun, 5 Mar 2023 22:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=s5QEM3O9yco3rfSMLPvmSRUwpK8LPcoIhYEXAZCgp2Q=;
 b=cB/utHz/zVlpMJsBcOrRJmkT+ohGekJrNDV5Hl+nGcxETn9+GdYyeq58OnSHdV8X3861
 n/XmL8nFQy6UGVABYgYC220JxJ2lJn8vPTbfnm0un6cwWQ1zqU7J2AWpB/Dl262L60Bg
 +/+bpu0E0pVxhONQjiOpc9aUeYMBhX7EqF8oD4+MkhUqt8SRFFxP5RSBPo2sH4FacT3s
 VS82tQp0zY8NWMKFegKM2NZh0Q44aXC0FnFCS0OjTBqXjdP3iYcMqGAzKJ6Vsj1FJ+pA
 iT/JcjRhK+0BjAJommzGAokqTIJdIDXpDcBRQ66q/HXpsAyURxbCsRlm1kYNnGBRjTna Pw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p4161srk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Mar 2023 22:00:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 325IHbd4024351;
        Sun, 5 Mar 2023 22:00:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p4u040me5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Mar 2023 22:00:47 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 325M0Nr5013622;
        Sun, 5 Mar 2023 22:00:46 GMT
Received: from t460.home (dhcp-10-175-35-7.vpn.oracle.com [10.175.35.7])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3p4u040ktj-4;
        Sun, 05 Mar 2023 22:00:46 +0000
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
Subject: [PATCH v3 3/7] Documentation/security-bugs: improve security list section
Date:   Sun,  5 Mar 2023 23:00:06 +0100
Message-Id: <20230305220010.20895-4-vegard.nossum@oracle.com>
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
X-Proofpoint-GUID: nrEHFdUaOsNn5k35GpBZd05EQv--aiOV
X-Proofpoint-ORIG-GUID: nrEHFdUaOsNn5k35GpBZd05EQv--aiOV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make this section about the security list easier to parse by:

1) reordering the content to make more sense,

2) adding "paragraph names" to make it visually easier to
   find exactly the information that you need for a given step (this
   will also be applied to the other sections for consistency in
   subsequent patches),

3) pulling some of the information that is relevant to contacting
   security@kernel.org specifically into the section about that list.

The remaining sections are about CVE assignment, coordinated
disclosure, etc., which are things the security list _doesn't_ deal
with. (These sections will be expanded and clarified in subsequent
patches.)

This patch is not meant to introduce any semantic changes, so in
case of a dispute the previous version will be authoritative.

Link: https://lore.kernel.org/all/20220601031254.GB26318@1wt.eu/
Link: https://lore.kernel.org/all/20220607090726.GB32282@willie-the-truck/
Cc: Willy Tarreau <w@1wt.eu>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/process/security-bugs.rst | 76 ++++++++++++-------------
 1 file changed, 35 insertions(+), 41 deletions(-)

diff --git a/Documentation/process/security-bugs.rst b/Documentation/process/security-bugs.rst
index f1326d4e9718..fb156d146c42 100644
--- a/Documentation/process/security-bugs.rst
+++ b/Documentation/process/security-bugs.rst
@@ -31,42 +31,42 @@ be released without consent from the reporter unless it has already been
 made public.  Reporters are encouraged to propose patches, participate in the
 discussions of a fix, and test patches.
 
-Please send plain text emails without attachments where possible.
-It is much harder to have a context-quoted discussion about a complex
-issue if all the details are hidden away in attachments.  Think of it like a
-regular patch submission (see Documentation/process/submitting-patches.rst)
-even if you don't have a patch yet; describe the problem and impact, list
-reproduction steps, and follow it with a proposed fix, all in plain text.
+**Disclosure.** Once a robust patch or patchset has been developed, the
+release process starts.  The security list strongly prefers to have these
+posted for review and testing on public mailing lists and merged into the
+appropriate public git repository as soon as possible.  However, you or an
+affected party may request that the patch be withheld for some days; as a
+rule, the maximum is 7 calendar days.  An exceptional extension to 14
+calendar days is possible if it is agreed that the criticality of the bug
+requires more time.  The only valid reason for deferring the publication
+of a fix is to accomodate the logistics of QA and large scale rollouts
+which require release coordination.
+
+Please note that although a fix is public, there may still be value in
+withholding the details of its security relevance and/or how to exploit
+it for another while; see below for when and how to properly disclose
+the security impact of your findings publicly.
+
+**List rules.** Please send plain text emails without attachments where
+possible.  It is much harder to have a context-quoted discussion about a
+complex issue if all the details are hidden away in attachments.  Think
+of it like regular patch submission (see
+Documentation/process/submitting-patches.rst) even if you don't have a
+patch yet; describe the problem and impact, list reproduction steps, and
+follow it with a proposed fix, all in plain text.
+
+**Confidentiality.** While embargoed information may be shared with
+trusted individuals in order to develop a fix, such information will not
+be published alongside the fix or on any other disclosure channel
+without the permission of the reporter.  This includes but is not
+limited to the original bug report and followup discussions (if any),
+exploits, CVE information or the identity of the reporter.  All such
+other information submitted to the security list and any follow-up
+discussions of the report are treated confidentially even after the
+embargo has been lifted, in perpetuity.
 
-Disclosure and embargoed information
-------------------------------------
-
-The security list is not a disclosure channel.  For that, see Coordination
-below.
-
-Once a robust fix has been developed, the release process starts.  Fixes
-for publicly known bugs are released immediately.
-
-Although our preference is to release fixes for publicly undisclosed bugs
-as soon as they become available, this may be postponed at the request of
-the reporter or an affected party for up to 7 calendar days from the start
-of the release process, with an exceptional extension to 14 calendar days
-if it is agreed that the criticality of the bug requires more time.  The
-only valid reason for deferring the publication of a fix is to accommodate
-the logistics of QA and large scale rollouts which require release
-coordination.
-
-While embargoed information may be shared with trusted individuals in
-order to develop a fix, such information will not be published alongside
-the fix or on any other disclosure channel without the permission of the
-reporter.  This includes but is not limited to the original bug report
-and followup discussions (if any), exploits, CVE information or the
-identity of the reporter.
-
-In other words our only interest is in getting bugs fixed.  All other
-information submitted to the security list and any followup discussions
-of the report are treated confidentially even after the embargo has been
-lifted, in perpetuity.
+The Linux kernel security team is not a formal body and therefore unable
+to enter any non-disclosure agreements.
 
 Coordination
 ------------
@@ -93,9 +93,3 @@ assigned ahead of public disclosure, they will need to contact the private
 linux-distros list, described above. When such a CVE identifier is known
 before a patch is provided, it is desirable to mention it in the commit
 message if the reporter agrees.
-
-Non-disclosure agreements
--------------------------
-
-The Linux kernel security team is not a formal body and therefore unable
-to enter any non-disclosure agreements.
-- 
2.40.0.rc1.2.gd15644fe02

