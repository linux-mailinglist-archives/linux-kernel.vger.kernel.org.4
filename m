Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593236267E5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 08:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbiKLH7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 02:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKLH7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 02:59:01 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53CB13DE2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 23:58:52 -0800 (PST)
X-QQ-mid: bizesmtp81t1668239923t2v1yf82
Received: from localhost.localdomain ( [182.148.14.167])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 12 Nov 2022 15:58:41 +0800 (CST)
X-QQ-SSF: 01000000002000C0F000B00A0000000
X-QQ-FEAT: SFhf6fKhx/+csOBMGXrjySirmdkRZtfKQtvBEBQ5l9HtTY3Q3EubEtJjYwE9j
        uDhvIXf7jkrzqgWYK4w3kPbKwn+V1FC/7q710JgFktbNicUsW8OGqSaHaYcS4WJI/k2seig
        QhydBQJ7/esfVpmBR19TwS3RO7fdfdYdMtNusrVcxV/iq5Z9rkQNjL17Yv/PZrF1ZD8IjAn
        7NF7jUuUAcMEAOBpl/3rqKf07dz1hOjBavVzCykpkM9N3nQ+kn63cJ9Ah1ZbSNYH2v2aNLt
        Xwma55Gwg2toEzM3RWxgDMXxdaAWsZBNMsCYk9IxP0W7MjiPJG1fcNHEqBvvp/v2vL/wMoO
        ltXgj8gjaV65Z/DMb4=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] powerpc/kernel: fix repeated words in comments
Date:   Sat, 12 Nov 2022 15:58:33 +0800
Message-Id: <20221112075833.37730-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 arch/powerpc/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index ab786da8c30b..6fa4ddec6c11 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -281,7 +281,7 @@ void enable_kernel_altivec(void)
 EXPORT_SYMBOL(enable_kernel_altivec);
 
 /*
- * Make sure the VMX/Altivec register state in the
+ * Make sure the VMX/Altivec register state in
  * the thread_struct is up to date for task tsk.
  */
 void flush_altivec_to_thread(struct task_struct *tsk)
-- 
2.36.1

