Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D996AB2BC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 23:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCEWCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 17:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjCEWCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 17:02:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6291D199D8;
        Sun,  5 Mar 2023 14:01:58 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 325LvTMH004167;
        Sun, 5 Mar 2023 22:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=3x2IB5WMGDPKO44R1fstih3EObkOoy7v9hScUddrClo=;
 b=lGQ4t8w0S/jxZuyK9DHUQGBV0K+JKgoJ6hbXwpxQ77A4neO8YFrByUK8fd62dQYgnyw4
 4j6HDXyhZhOV9bTlIn3qLFDhSAB/dfJUZSGCtm0+juKdO/MbSDNWGgpnNd1+HoHF9CqH
 MYi4gVFH1X+YJvhYWF9CL3ekaPSa14VCNgpuFFoF2jeEAQ3iUFMNPPiUtbpxOtxSDwgt
 Yxmu+6yq94sRdjZewBsGLs1Cb9Tnp55+gS65EI0btySSzkgSPnH6VF2hfS1nZXKaSpM2
 NuT+LU9guDBo9bnt/991cTuLqQNW5lYTZQ0MqmkqCmD6/LSa1iKuu/PQUs75jSzDziXd 8w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p417c9rjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Mar 2023 22:00:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 325IAIji023468;
        Sun, 5 Mar 2023 22:00:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p4u040mgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Mar 2023 22:00:52 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 325M0Nr7013622;
        Sun, 5 Mar 2023 22:00:51 GMT
Received: from t460.home (dhcp-10-175-35-7.vpn.oracle.com [10.175.35.7])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3p4u040ktj-5;
        Sun, 05 Mar 2023 22:00:51 +0000
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
Subject: [PATCH v3 4/7] Documentation/security-bugs: add linux-distros and oss-security sections
Date:   Sun,  5 Mar 2023 23:00:07 +0100
Message-Id: <20230305220010.20895-5-vegard.nossum@oracle.com>
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
X-Proofpoint-GUID: pVldTcCYvm2QtnxvReBedPNPIgluSSxC
X-Proofpoint-ORIG-GUID: pVldTcCYvm2QtnxvReBedPNPIgluSSxC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing information about CVE assignment requests and coordinated
disclosure fits much better in these new sections, since that's what these
lists are for.

Keep just a reminder in the security list section.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/process/security-bugs.rst | 92 ++++++++++++++++++-------
 1 file changed, 67 insertions(+), 25 deletions(-)

diff --git a/Documentation/process/security-bugs.rst b/Documentation/process/security-bugs.rst
index fb156d146c42..2dd6569a7abb 100644
--- a/Documentation/process/security-bugs.rst
+++ b/Documentation/process/security-bugs.rst
@@ -31,6 +31,10 @@ be released without consent from the reporter unless it has already been
 made public.  Reporters are encouraged to propose patches, participate in the
 discussions of a fix, and test patches.
 
+The security team does not assign CVEs, nor does it require them for reports
+or fixes.  CVEs may be requested when the issue is reported to the
+linux-distros list.
+
 **Disclosure.** Once a robust patch or patchset has been developed, the
 release process starts.  The security list strongly prefers to have these
 posted for review and testing on public mailing lists and merged into the
@@ -68,28 +72,66 @@ embargo has been lifted, in perpetuity.
 The Linux kernel security team is not a formal body and therefore unable
 to enter any non-disclosure agreements.
 
-Coordination
-------------
-
-Fixes for sensitive bugs, such as those that might lead to privilege
-escalations, may need to be coordinated with the private
-<linux-distros@vs.openwall.org> mailing list so that distribution vendors
-are well prepared to issue a fixed kernel upon public disclosure of the
-upstream fix. Distros will need some time to test the proposed patch and
-will generally request at least a few days of embargo, and vendor update
-publication prefers to happen Tuesday through Thursday. When appropriate,
-the security team can assist with this coordination, or the reporter can
-include linux-distros from the start. In this case, remember to prefix
-the email Subject line with "[vs]" as described in the linux-distros wiki:
-<http://oss-security.openwall.org/wiki/mailing-lists/distros#how-to-use-the-lists>
-
-CVE assignment
---------------
-
-The security team does not normally assign CVEs, nor do we require them
-for reports or fixes, as this can needlessly complicate the process and
-may delay the bug handling. If a reporter wishes to have a CVE identifier
-assigned ahead of public disclosure, they will need to contact the private
-linux-distros list, described above. When such a CVE identifier is known
-before a patch is provided, it is desirable to mention it in the commit
-message if the reporter agrees.
+Once a patch has been developed, you are encouraged to contact the
+linux-distros list.
+
+Contacting the linux-distros list
+---------------------------------
+
+Fixes for particularly sensitive bugs (such as those that might lead to
+privilege escalations) may need to be coordinated with the private
+linux-distros mailing list (linux-distros@vs.openwall.org) so that
+distribution vendors are well prepared to release a fixed kernel as soon as
+possible after the public disclosure of the upstream fix.  This includes
+verifying the reported issue, testing proposed fixes, developing a fix (if
+none is known yet), and backporting to older kernels and other versions.
+
+The linux-distros list can also help with assigning a CVE for your issue.
+
+**Disclosure.** The linux-distros list has a strict policy of requiring
+reporters to post about the security issue on oss-security within 14
+calendar days of the list being contacted regardless of whether a patch is
+available or not.  It is therefore preferable that you don't send your
+initial bug report to the linux-distros list unless you already have a patch
+for the issue.
+
+**List rules.** The main rules to be aware of when contacting the
+linux-distros list are:
+
+* Don't post about issues that are already public. If your issue has a
+  public patch, but the security impact is not generally known, then you may
+  still post about it.
+
+* The submitter can suggest an embargo end-date, but as a rule, embargoes
+  should not be longer than 7 calendar days, or at most 14 calendar days in
+  exceptional cases. Keep in mind that vendors may prefer to release new
+  kernel packages and/or updates Tuesday through Thursday.
+
+* When the embargo ends, the issue must be disclosed immediately on the
+  oss-security list (see below).
+
+* Prefix your subject with the string "[vs]" to avoid getting rejected by
+  the spam filter.
+
+For the full list of rules, see:
+https://oss-security.openwall.org/wiki/mailing-lists/distros#list-policy-and-instructions-for-reporters
+
+**Confidentiality.** Please note that, as opposed to the security list, any
+and all material submitted to the list must be made public once the security
+issue is publicly disclosed, so please do not post information to the
+linux-distros list that cannot be made public.
+
+Contacting the oss-security list
+--------------------------------
+
+When your security issue is public, or you wish to make your issue public,
+you can write to the oss-security list (oss-security@lists.openwall.com).
+This is a public list (anybody can subscribe and view the list archives) and
+it is not restricted to Linux kernel issues.
+
+The oss-security list typically does not assign CVEs or accept requests for
+CVE assignments.
+
+**List rules.** Please do not cross-post to other lists when writing to this
+list. Make sure to read the other list rules before posting:
+https://oss-security.openwall.org/wiki/mailing-lists/oss-security.
-- 
2.40.0.rc1.2.gd15644fe02

