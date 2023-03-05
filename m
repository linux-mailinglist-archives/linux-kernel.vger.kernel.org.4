Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8526AB2BE
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 23:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjCEWCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 17:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjCEWCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 17:02:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB6B166DA;
        Sun,  5 Mar 2023 14:02:07 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 325KWTxZ008283;
        Sun, 5 Mar 2023 22:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=lOlMiJgwc+kBqQXXTCcgaFuxE3qu5j6thK/9P2DSJx4=;
 b=zSrye9ymLu00GaO+u0li0nC+/tmt9DptGSP+v6plVBabrP6Vn4euoW80iFL4SDNYj9U8
 xFHTaXdSTzFW+muJ9Q5FFRSINa6vbXFyRlzZtM+ggVHyWWDn/BF2vWl+t/SCyAV3ihiG
 HdyMzR1ZuZhUN3IztBx6Xuig62CPDueXWm+SnUQ8CPvOSCd1iegXmw/x61v58EkVhp4w
 gQrpAbPn1BpeWhVUm5vcimBftLSMk6JBuE8Rlt777CFO1lPLty+FWyKGQiP/0s9aoqHs
 StEkFyuAhlq6r6jtOCADTa07ip6K2NZq7OQifiVfMZIWGOdRGT5Er0/TgOFjaazF51nA UA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p4180sr34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Mar 2023 22:01:09 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 325I8Al5023260;
        Sun, 5 Mar 2023 22:01:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p4u040mpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Mar 2023 22:01:08 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 325M0NrD013622;
        Sun, 5 Mar 2023 22:01:08 GMT
Received: from t460.home (dhcp-10-175-35-7.vpn.oracle.com [10.175.35.7])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3p4u040ktj-8;
        Sun, 05 Mar 2023 22:01:07 +0000
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
Subject: [PATCH v3 7/7] Documentation/security-bugs: document document design
Date:   Sun,  5 Mar 2023 23:00:10 +0100
Message-Id: <20230305220010.20895-8-vegard.nossum@oracle.com>
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
X-Proofpoint-ORIG-GUID: G2DtmlHrWbALHEC_iI446HGKZlSc_dr1
X-Proofpoint-GUID: G2DtmlHrWbALHEC_iI446HGKZlSc_dr1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think there is value in expressing the high-level design of this
document so that it will not get lost with future revisions.

This section is an rST comment and will not be part of rendered
documentation (e.g. the html version).

Link: https://lore.kernel.org/all/87ilpk5wsi.fsf@meer.lwn.net/
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/process/security-bugs.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/process/security-bugs.rst b/Documentation/process/security-bugs.rst
index 7bd59587332a..8d9adc02cd49 100644
--- a/Documentation/process/security-bugs.rst
+++ b/Documentation/process/security-bugs.rst
@@ -158,3 +158,24 @@ CVE assignments.
 **List rules.** Please do not cross-post to other lists when writing to this
 list. Make sure to read the other list rules before posting:
 https://oss-security.openwall.org/wiki/mailing-lists/oss-security.
+
+..
+    If you modify this document, please consider the following:
+    
+    1) The most important information should be at the top (preferably in
+    the opening paragraph). This means contacting <security@kernel.org>;
+    if somebody doesn't read any further than that, at least the security
+    team will have the report.
+    
+    2) Make the differences between the lists extremely clear. The old
+    version did make an attempt at this, but the lines were not drawn
+    clearly enough.
+    
+    3) Emphasize some of the posting rules which can be confusing to new
+    people (e.g. the fact that posting to linux-distros means you must
+    propose an embargo date and that this cannot under any circumstances
+    be more than 14 days).
+    
+    4) The document should be a "step-by-step process" as much as possible,
+    so that you can use it as a guide while reporting an issue instead of
+    having to search back and forth for the thing you're looking for.
-- 
2.40.0.rc1.2.gd15644fe02

