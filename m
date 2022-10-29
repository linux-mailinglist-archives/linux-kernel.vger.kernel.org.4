Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B34D6120D9
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 09:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJ2HIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 03:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiJ2HIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 03:08:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14399C894E
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 00:08:16 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 29T6xO7u000407;
        Sat, 29 Oct 2022 07:07:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ozRIBq8khuXfivYdnN4dsz+dO0ybT2PvT9yXf5udRpk=;
 b=Q3fDnGlqZJYa32cAx1HXdlpSPooi7WMjD2pq+ZZkbzuqS3dsbK7Gl+PFuIy3qkEUjUAb
 jlKZsmr5GhdnEMM+6geGAylrhAmCKyzAMsCbcn3He9lohXeTH9lldrU0U1E53WSw3bvk
 jBCk522UiC/ZbWOiI8D5uX61k0z8rgktzP4nXo+kjWF/OrDkUCLymcCIwQee9T7gj47r
 bLpTqDCCI/Mwak4hhZSA/fYiabjHSmmOfm7eS+iHzNZrBdbZERg7shka3AKZfarO8RRd
 ODaQaVkMCB1BfP1UEjabfzZfVeg+Sk0139DZqy3umL6RmluJtOmwATig456LJlgG/xou Kw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kgwh10dr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Oct 2022 07:07:59 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29T77wto006906
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Oct 2022 07:07:58 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Sat, 29 Oct 2022 00:07:55 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH] arm64: entry: Fix typo
Date:   Sat, 29 Oct 2022 12:37:48 +0530
Message-ID: <1667027268-1255-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wjC1bOhpjIyNodZWnzHRetDqG8oMPFvK
X-Proofpoint-GUID: wjC1bOhpjIyNodZWnzHRetDqG8oMPFvK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-29_02,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=972 spamscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210290038
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following typo in entry-common.c
intrumentable => instrumentable

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 arch/arm64/kernel/entry-common.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 9173fad..b694d8f 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -30,7 +30,7 @@
 /*
  * Handle IRQ/context state management when entering from kernel mode.
  * Before this function is called it is not safe to call regular kernel code,
- * intrumentable code, or any code which may trigger an exception.
+ * instrumentable code, or any code which may trigger an exception.
  *
  * This is intended to match the logic in irqentry_enter(), handling the kernel
  * mode transitions only.
@@ -63,7 +63,7 @@ static void noinstr enter_from_kernel_mode(struct pt_regs *regs)
 /*
  * Handle IRQ/context state management when exiting to kernel mode.
  * After this function returns it is not safe to call regular kernel code,
- * intrumentable code, or any code which may trigger an exception.
+ * instrumentable code, or any code which may trigger an exception.
  *
  * This is intended to match the logic in irqentry_exit(), handling the kernel
  * mode transitions only, and with preemption handled elsewhere.
@@ -97,7 +97,7 @@ static void noinstr exit_to_kernel_mode(struct pt_regs *regs)
 /*
  * Handle IRQ/context state management when entering from user mode.
  * Before this function is called it is not safe to call regular kernel code,
- * intrumentable code, or any code which may trigger an exception.
+ * instrumentable code, or any code which may trigger an exception.
  */
 static __always_inline void __enter_from_user_mode(void)
 {
@@ -116,7 +116,7 @@ static __always_inline void enter_from_user_mode(struct pt_regs *regs)
 /*
  * Handle IRQ/context state management when exiting to user mode.
  * After this function returns it is not safe to call regular kernel code,
- * intrumentable code, or any code which may trigger an exception.
+ * instrumentable code, or any code which may trigger an exception.
  */
 static __always_inline void __exit_to_user_mode(void)
 {
@@ -152,7 +152,7 @@ asmlinkage void noinstr asm_exit_to_user_mode(struct pt_regs *regs)
 /*
  * Handle IRQ/context state management when entering an NMI from user/kernel
  * mode. Before this function is called it is not safe to call regular kernel
- * code, intrumentable code, or any code which may trigger an exception.
+ * code, instrumentable code, or any code which may trigger an exception.
  */
 static void noinstr arm64_enter_nmi(struct pt_regs *regs)
 {
@@ -170,7 +170,7 @@ static void noinstr arm64_enter_nmi(struct pt_regs *regs)
 /*
  * Handle IRQ/context state management when exiting an NMI from user/kernel
  * mode. After this function returns it is not safe to call regular kernel
- * code, intrumentable code, or any code which may trigger an exception.
+ * code, instrumentable code, or any code which may trigger an exception.
  */
 static void noinstr arm64_exit_nmi(struct pt_regs *regs)
 {
@@ -192,7 +192,7 @@ static void noinstr arm64_exit_nmi(struct pt_regs *regs)
 /*
  * Handle IRQ/context state management when entering a debug exception from
  * kernel mode. Before this function is called it is not safe to call regular
- * kernel code, intrumentable code, or any code which may trigger an exception.
+ * kernel code, instrumentable code, or any code which may trigger an exception.
  */
 static void noinstr arm64_enter_el1_dbg(struct pt_regs *regs)
 {
@@ -207,7 +207,7 @@ static void noinstr arm64_enter_el1_dbg(struct pt_regs *regs)
 /*
  * Handle IRQ/context state management when exiting a debug exception from
  * kernel mode. After this function returns it is not safe to call regular
- * kernel code, intrumentable code, or any code which may trigger an exception.
+ * kernel code, instrumentable code, or any code which may trigger an exception.
  */
 static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs)
 {
-- 
2.7.4

