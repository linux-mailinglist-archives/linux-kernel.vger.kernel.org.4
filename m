Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4DA608471
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 07:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJVFNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 01:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiJVFNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 01:13:10 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9D5255925
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 22:13:08 -0700 (PDT)
X-QQ-mid: bizesmtp88t1666415576t0b427zo
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 13:12:54 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: 7DSX613YSL4mStkFXAdukSy9YKyEB26+OxIlPwbiB7rxj/NgdJdNx+niTz0sx
        75j99/ZyPiHWRsj7pTa6ArxQcHR23jnqa05IHb9ccl1D3ZDvw1DkO7zbpcVRUKfICw6O49Z
        pVGzawX9VW5Rh94Vd52d22uZqJyae3ejkmbxWEXtsgPK2XnvYU3h6XjenbQ8c/mSd1H6J3W
        UFpyqoehJl2vaI2yw5Dq29NJf9EbtzBChoYfduTM+vR/ern8dURiQ/a2Ttr+/nuPuom8m+8
        w8xLck0CSg6qODN94GXCd+WPZQJYtVxObweKvnkb90PcFYCmC4gtLCgCVqXtE2HPxk9INJG
        qMCpmvh
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] powerpc/kernel: fix repeated words in comments
Date:   Sat, 22 Oct 2022 13:12:47 +0800
Message-Id: <20221022051247.64377-1-wangjianli@cdjrlc.com>
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
index ee0433809621..ab786da8c30b 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -173,7 +173,7 @@ void giveup_fpu(struct task_struct *tsk)
 EXPORT_SYMBOL(giveup_fpu);
 
 /*
- * Make sure the floating-point register state in the
+ * Make sure the floating-point register state in
  * the thread_struct is up to date for task tsk.
  */
 void flush_fp_to_thread(struct task_struct *tsk)
-- 
2.36.1

