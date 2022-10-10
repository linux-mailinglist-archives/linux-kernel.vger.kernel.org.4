Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546A15FA1C8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiJJQV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiJJQVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:21:24 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBF073936
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 09:21:20 -0700 (PDT)
X-QQ-mid: bizesmtp83t1665418871tvs9zsly
Received: from localhost.localdomain ( [182.148.13.78])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 11 Oct 2022 00:21:09 +0800 (CST)
X-QQ-SSF: 01000000002000C0E000B00A0000000
X-QQ-FEAT: lj50s4tNr7r9OVSLH0oBgczjg+4dztI/UblukmQTC+KCNz8v/qlUickKb7X6W
        ZIbIPLeZX6uLu9k+s4J7mfCzTlVRd/ctiGKWL+SBNsAC/6nizA5MDv0rMeQGTbGRtVrqgAu
        m+BCO4YmKfUF/60bcDBwXWpuGs2FEPZ2cRGWa5fJf69e4tLYcp9WKCjFjNw9jVGRZw2ABkR
        Xs8xSSl9e83ycOE4AUd4R9AJGB+8V3aAKSIpfvin+rKfHwNdt4P7dOAloHLdfFzEhoYnhp0
        0msoAh3JGlMffbmEO/slGNV2lniu8qNTvfLnOVrcHejsKbkk/1A3omlJAUt04YYFqGOQwA4
        Kl01q2o
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] powerpc/kernel: fix repeated words in comments
Date:   Tue, 11 Oct 2022 00:20:53 +0800
Message-Id: <20221010162053.6708-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 406d7ee9e322..7a6e54e4f1d8 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -176,7 +176,7 @@ void giveup_fpu(struct task_struct *tsk)
 EXPORT_SYMBOL(giveup_fpu);
 
 /*
- * Make sure the floating-point register state in the
+ * Make sure the floating-point register state in
  * the thread_struct is up to date for task tsk.
  */
 void flush_fp_to_thread(struct task_struct *tsk)
-- 
2.36.1

