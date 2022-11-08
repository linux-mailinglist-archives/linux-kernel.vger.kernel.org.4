Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E436621E9A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 22:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiKHVfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 16:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKHVfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 16:35:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63105C755;
        Tue,  8 Nov 2022 13:35:22 -0800 (PST)
Date:   Tue, 08 Nov 2022 21:35:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667943320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dwI1cOu1CAqRFRpZ/qAxaAT22s+X8nsjOxog7of8jq0=;
        b=EOtfLMR0iqmpcRvEzNg//JD7cRfag+8Qu+/LsrUI+gMHur0Zk7ocE5nDXrqKfUXqAbfBPI
        0JIOTydxex7m7fn4p+k4v/QSIA7eVihFzKNOgHrAbbTIo41O9fSuD6v2YUIpjgw5ych5jC
        rH4boX4ntxS6qJrwd506cBdxJ2w06z1+9ezCyuYgXsMFSmT4wL7n5/0xdK/f4zF7jjAlhY
        1gaqXfztCbJ15VU47sAVocqeyvQn4oS8K48LThRHby2hAu3SRz8URzBqY+2nnlCwdYNnx6
        SZiuv9+VCnlFU2O4rBQwosB5e92GEegDot8z/cPWEQllW4vIVMOe/XhkW2yyxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667943320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dwI1cOu1CAqRFRpZ/qAxaAT22s+X8nsjOxog7of8jq0=;
        b=5Bq666RNTfL0TNiI79i5Xpl0vmE3SVtornf/3yQIUw2O1HouSp9HEP3muBIe7g9G9BJ0l0
        kYxWSgbvcnenFjAA==
From:   "tip-bot2 for Jiapeng Chong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: Fix misc small issues
Cc:     Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1620902768-53822-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1620902768-53822-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <166794331892.4906.5411586974851313804.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     6426773410fd829c15b59575afe531d66abc7201
Gitweb:        https://git.kernel.org/tip/6426773410fd829c15b59575afe531d66abc7201
Author:        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
AuthorDate:    Tue, 08 Nov 2022 22:09:51 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 08 Nov 2022 22:16:08 +01:00

x86: Fix misc small issues

Fix:

  ./arch/x86/kernel/traps.c: asm/proto.h is included more than once.

  ./arch/x86/kernel/alternative.c:1610:2-3: Unneeded semicolon.

  [ bp: Merge into a single patch. ]

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/1620902768-53822-1-git-send-email-jiapeng.chong@linux.alibaba.com
Link: https://lore.kernel.org/r/20220926054628.116957-1-jiapeng.chong@linux.alibaba.com
---
 arch/x86/kernel/alternative.c | 2 +-
 arch/x86/kernel/traps.c       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 5cadcea..d5f1e13 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1608,7 +1608,7 @@ static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
 
 	default:
 		BUG_ON(len != insn.length);
-	};
+	}
 
 
 	switch (tp->opcode) {
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 178015a..c3bff64 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -67,13 +67,13 @@
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
-#include <asm/proto.h>
 #else
 #include <asm/processor-flags.h>
 #include <asm/setup.h>
-#include <asm/proto.h>
 #endif
 
+#include <asm/proto.h>
+
 DECLARE_BITMAP(system_vectors, NR_VECTORS);
 
 static inline void cond_local_irq_enable(struct pt_regs *regs)
