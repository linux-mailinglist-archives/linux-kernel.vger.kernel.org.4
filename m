Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052F36AB2B6
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 23:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjCEWCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 17:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjCEWBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 17:01:55 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F1715C87;
        Sun,  5 Mar 2023 14:01:52 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 325Li8bh029218;
        Sun, 5 Mar 2023 22:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=ZJ90aWPPj9zyH+6Oh/z2dY9oamLu7+DAooQEywdRR2k=;
 b=SICo2nL9tZx9cte4XlAj+zXinR5gu7L7nDGiZsK8gB2yCxqc/MD1yufrXT9uZYOPKnXx
 +kabGXjEbYVYBo7oIYHQOJNNrBX6oAxjhb0f4SctHcTpL/fvfV4tXE3Qig71GOJngOnt
 hZO5f95QELZ1nWInN4XUbaUKJDbEegsUCDKAUbhNb+IVAM5ZW05xT1CyiB9AMtH2h7Kx
 nwOJzzJh/U7vlX7ClFBLepvhVtoyEe+TLM1PpiEVtmvHcZzH3jBKdfpuKbkrKPK0Zdv2
 Fi8minNpOTrSGA7Fya98weBgO1IIviN6OAmUOJ0BkMviBs1PNSSu968sP+PicSCUEkhy wQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p4161srk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Mar 2023 22:00:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 325IJ9Aj023424;
        Sun, 5 Mar 2023 22:00:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p4u040mjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Mar 2023 22:00:58 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 325M0Nr9013622;
        Sun, 5 Mar 2023 22:00:58 GMT
Received: from t460.home (dhcp-10-175-35-7.vpn.oracle.com [10.175.35.7])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3p4u040ktj-6;
        Sun, 05 Mar 2023 22:00:57 +0000
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
Subject: [PATCH v3 5/7] Documentation/security-bugs: add table of lists
Date:   Sun,  5 Mar 2023 23:00:08 +0100
Message-Id: <20230305220010.20895-6-vegard.nossum@oracle.com>
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
X-Proofpoint-GUID: N7-WzzRgDuS3YD56U5kcF6iEdSapv_G-
X-Proofpoint-ORIG-GUID: N7-WzzRgDuS3YD56U5kcF6iEdSapv_G-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Give an overview of the full process the start of the document.
This makes it clear 1) in what order the lists should be contacted,
and 2) the purpose of each list.

Thanks to Jonathan Corbet and Mauro Carvalho Chehab for providing
the readable markup for the table.

Link: https://lore.kernel.org/all/20220604014317.79eb23db@sal.lan/
Suggested-by: Jonathan Corbet <corbet@lwn.net>
Suggested-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/process/security-bugs.rst | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/process/security-bugs.rst b/Documentation/process/security-bugs.rst
index 2dd6569a7abb..61742dcfea50 100644
--- a/Documentation/process/security-bugs.rst
+++ b/Documentation/process/security-bugs.rst
@@ -18,7 +18,26 @@ vulnerability.
 Note that the main interest of the kernel security list is in getting
 bugs fixed and getting patches reviewed, tested, and merged; CVE
 assignment, disclosure to distributions, and public disclosure happen on
-different lists with different people.
+different lists with different people, as described below.
+
+Here is a quick overview of the various lists:
+
+ =============================== ===== =================== ===============
+ List address                    Open? Purpose             Members
+ =============================== ===== =================== ===============
+ security@kernel.org                no | Reporting         Trusted kernel
+                                       | Patch development developers
+ ------------------------------- ----- ------------------- ---------------
+ linux-distros@vs.openwall.org      no | Coordination      Distribution
+                                       | CVE assignment    representatives
+                                       | Backporting
+                                       | Testing
+ ------------------------------- ----- ------------------- ---------------
+ oss-security@lists.openwall.com   yes | Disclosure        General public
+ =============================== ===== =================== ===============
+
+The following sections give a step-by-step guide to reporting and
+disclosure.
 
 Contacting the security list
 ----------------------------
-- 
2.40.0.rc1.2.gd15644fe02

