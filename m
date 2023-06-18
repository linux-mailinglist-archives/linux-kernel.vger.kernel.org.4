Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98077734851
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 22:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjFRUuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 16:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjFRUuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 16:50:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A154DE49;
        Sun, 18 Jun 2023 13:49:59 -0700 (PDT)
Date:   Sun, 18 Jun 2023 20:49:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687121398;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Lnd9I9JfpsOWa3rbGS3GEORYWctuXHXCskeUPz4dt4=;
        b=pB+wX3XZ7u2kTBcj5MVUMuPzoX4CPj6yZgjKjn08nGE9egrPczBOmA4UPxOMbXPQnaf17F
        1+QdqHbz3ORU6G+mDOcqNtA4IqLvYf8gl2Jk/iFzE96L7YcKxNFrbH4zctfxwWTM5Qw5cu
        ln1BXj3rnHQ17dNe8O2QEKjiN+4qev0eC4TRt5BO4MxJT/rVV4BS/h9bWSQV8+iHirDqGg
        pk6ikPavP6zlrclX9cd5XQ9FQJCW9rDRUN+tIDa7M7zlfLiJ25qCDbCPRYZcwTsX+OAPQE
        oSBQtLnc/5iXAYshPGL+V7eLvs1LcyjPEGz0LOgeIkzJ5OMQ3HFH4/RJ8406TA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687121398;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Lnd9I9JfpsOWa3rbGS3GEORYWctuXHXCskeUPz4dt4=;
        b=81sDHcJz3P01qXX5WcukSc1bK/BSJiVyptYU+amtqGxd1wE3x8x6fgcQgSRHYBuXjDdkvA
        ocCUMcVITeaEW+Cg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Clarify posix_timer_rearm() comment
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230425183313.724863461@linutronix.de>
References: <20230425183313.724863461@linutronix.de>
MIME-Version: 1.0
Message-ID: <168712139782.404.12860532912277348450.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     02972d7955341b711d4c392f14faa9f9cd69d551
Gitweb:        https://git.kernel.org/tip/02972d7955341b711d4c392f14faa9f9cd69d551
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Apr 2023 20:49:22 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 18 Jun 2023 22:41:52 +02:00

posix-timers: Clarify posix_timer_rearm() comment

Yet another incomprehensible piece of art.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230425183313.724863461@linutronix.de

---
 kernel/time/posix-timers.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index c8b0f52..d8d2169 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -275,15 +275,9 @@ static void common_hrtimer_rearm(struct k_itimer *timr)
 }
 
 /*
- * This function is exported for use by the signal deliver code.  It is
- * called just prior to the info block being released and passes that
- * block to us.  It's function is to update the overrun entry AND to
- * restart the timer.  It should only be called if the timer is to be
- * restarted (i.e. we have flagged this in the sys_private entry of the
- * info block).
- *
- * To protect against the timer going away while the interrupt is queued,
- * we require that the it_requeue_pending flag be set.
+ * This function is called from the signal delivery code if
+ * info->si_sys_private is not zero, which indicates that the timer has to
+ * be rearmed. Restart the timer and update info::si_overrun.
  */
 void posixtimer_rearm(struct kernel_siginfo *info)
 {
