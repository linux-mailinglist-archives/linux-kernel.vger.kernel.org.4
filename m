Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8304D6E0CD1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjDMLjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjDMLja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:39:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622D59ED6;
        Thu, 13 Apr 2023 04:39:05 -0700 (PDT)
Date:   Thu, 13 Apr 2023 11:39:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681385941;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=h1miRuxVLEJWCzY17MzDkYMAEk04/eft8GCJsO//SM0=;
        b=dpSSq5HwrYbaYb/VQGcJ+CSWChYFL+rIRpz7xkCbOMA4Qhv06j2ixwwjvZFBO5TZcBtyT8
        oTr9nHq9Go6eak6spZPOo8hxZauUK0eCUpFUt3MleUQzsRWaiVZksQm7g+EUC6faEYCtvt
        lKc9pcPSqIIiAw1FheKKhz5nWWqsTNEEpjrlleVcrcA6PW8+YiqBsfP6z7/Oe/wcBN6Yj3
        w2PlZPCck9E2HEZzY7Sqm76SjpQd0OHaM6Ay00eMEsWHjMOQAiRrTIjTzGKGvwWfEbM4Gh
        zvSohbwW81LgOFKhAPbkKqKfuwOHSO124nRK5J2k4A7fWhuqooH++EKg6RKftg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681385941;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=h1miRuxVLEJWCzY17MzDkYMAEk04/eft8GCJsO//SM0=;
        b=D+oj3NKx/YGBo/yd17NYSYqKKGlYv5bKQ3/e/I5Q5NsbsysI/vSOnYthXVW8YLQCqeFsfC
        FIPb0AZ9fOUDqoAw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Make sched_dynamic_mutex static
Cc:     kernel test robot <lkp@intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168138594070.404.3020542064246927502.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9b8e17813aeccc29c2f9f2e6e68997a6eac2d26d
Gitweb:        https://git.kernel.org/tip/9b8e17813aeccc29c2f9f2e6e68997a6eac2d26d
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 11 Apr 2023 22:26:41 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 Apr 2023 16:46:31 +02:00

sched/core: Make sched_dynamic_mutex static

The sched_dynamic_mutex is only used within the file.  Make it static.

Fixes: e3ff7c609f39 ("livepatch,sched: Add livepatch task switching to cond_resched()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/oe-kbuild-all/202304062335.tNuUjgsl-lkp@intel.com/
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b9616f1..d861db8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8674,7 +8674,7 @@ int sched_dynamic_mode(const char *str)
 #error "Unsupported PREEMPT_DYNAMIC mechanism"
 #endif
 
-DEFINE_MUTEX(sched_dynamic_mutex);
+static DEFINE_MUTEX(sched_dynamic_mutex);
 static bool klp_override;
 
 static void __sched_dynamic_update(int mode)
