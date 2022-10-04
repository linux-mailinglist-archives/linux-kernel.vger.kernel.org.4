Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C6C5F3FBA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiJDJb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiJDJ1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:27:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC1DE0AB;
        Tue,  4 Oct 2022 02:27:20 -0700 (PDT)
Date:   Tue, 04 Oct 2022 09:27:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664875638;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PjDtI2H0f2cYvKKRL3aKi6qysAW1k1IKqFfML8NnfkE=;
        b=bOmsdiZKuKnu5qBsLcjq8yt2DyL/jpRw136zjYr6ZsoAv8G6bisVX7XlnHaUgEtr8RazQ3
        XVBzfKhGculGQQvsMyrdPg9V5AGCnbbwI1bGe3W1b1diAbC3oNGuYeDDDgMgBMuiYEIC7T
        eCxssWJMzyD6R+2OB1yltjo0EEaE/lXRY8zttuz9jBLrnO6BVeIUOcnk36anBUIi5KWeAl
        yzDc8UsR9p7y6FE0keImozGCxBERJhfwFmg4BQK4CSf3dVbwBXuaYiLs8zZiIsMqh7bWNH
        0nsUg6bwnMYg9HvSUmwarnKobdimbzN/rlfdN5ux4lRgR3udSIXKGFDuoVL/jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664875638;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PjDtI2H0f2cYvKKRL3aKi6qysAW1k1IKqFfML8NnfkE=;
        b=m4+PWJjpoPoM3Y769v9QG2WIoRY4XWawXGy8wK94VFGZzOmK8mrMzfoGhztDINGQQqb7/J
        tNKOj7LYy0Pz3JAw==
From:   "tip-bot2 for Tony Lindgren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Drop unused functions
Cc:     Tony Lindgren <tony@atomide.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220815131250.34603-2-tony@atomide.com>
References: <20220815131250.34603-2-tony@atomide.com>
MIME-Version: 1.0
Message-ID: <166487563743.401.1562936476000850152.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     caa590067efd659d8811ad8904489536912ebc53
Gitweb:        https://git.kernel.org/tip/caa590067efd659d8811ad8904489536912ebc53
Author:        Tony Lindgren <tony@atomide.com>
AuthorDate:    Mon, 15 Aug 2022 16:12:42 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 20 Sep 2022 10:49:45 +02:00

clocksource/drivers/timer-ti-dm: Drop unused functions

We still have some unused functions left, let's drop them.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Link: https://lore.kernel.org/r/20220815131250.34603-2-tony@atomide.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-ti-dm.c | 51 +------------------------------
 include/clocksource/timer-ti-dm.h |  7 +----
 2 files changed, 58 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 469f7c9..b8f8c11 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -388,16 +388,6 @@ static inline u32 omap_dm_timer_reserved_systimer(int id)
 	return (omap_reserved_systimers & (1 << (id - 1))) ? 1 : 0;
 }
 
-int omap_dm_timer_reserve_systimer(int id)
-{
-	if (omap_dm_timer_reserved_systimer(id))
-		return -ENODEV;
-
-	omap_reserved_systimers |= (1 << (id - 1));
-
-	return 0;
-}
-
 static struct omap_dm_timer *_omap_dm_timer_request(int req_type, void *data)
 {
 	struct omap_dm_timer *timer = NULL, *t;
@@ -500,20 +490,6 @@ static struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 }
 
 /**
- * omap_dm_timer_request_by_cap - Request a timer by capability
- * @cap:	Bit mask of capabilities to match
- *
- * Find a timer based upon capabilities bit mask. Callers of this function
- * should use the definitions found in the plat/dmtimer.h file under the
- * comment "timer capabilities used in hwmod database". Returns pointer to
- * timer handle on success and a NULL pointer on failure.
- */
-struct omap_dm_timer *omap_dm_timer_request_by_cap(u32 cap)
-{
-	return _omap_dm_timer_request(REQUEST_BY_CAP, &cap);
-}
-
-/**
  * omap_dm_timer_request_by_node - Request a timer by device-tree node
  * @np:		Pointer to device-tree timer node
  *
@@ -606,17 +582,6 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 
 #endif
 
-int omap_dm_timer_trigger(struct omap_dm_timer *timer)
-{
-	if (unlikely(!timer || !atomic_read(&timer->enabled))) {
-		pr_err("%s: timer not available or enabled.\n", __func__);
-		return -EINVAL;
-	}
-
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
-	return 0;
-}
-
 static int omap_dm_timer_start(struct omap_dm_timer *timer)
 {
 	u32 l;
@@ -833,22 +798,6 @@ static int omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int
 	return 0;
 }
 
-int omap_dm_timers_active(void)
-{
-	struct omap_dm_timer *timer;
-
-	list_for_each_entry(timer, &omap_timer_list, node) {
-		if (!timer->reserved)
-			continue;
-
-		if (omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG) &
-		    OMAP_TIMER_CTRL_ST) {
-			return 1;
-		}
-	}
-	return 0;
-}
-
 static int __maybe_unused omap_dm_timer_runtime_suspend(struct device *dev)
 {
 	struct omap_dm_timer *timer = dev_get_drvdata(dev);
diff --git a/include/clocksource/timer-ti-dm.h b/include/clocksource/timer-ti-dm.h
index b0f80cf..4142bf7 100644
--- a/include/clocksource/timer-ti-dm.h
+++ b/include/clocksource/timer-ti-dm.h
@@ -119,17 +119,10 @@ struct omap_dm_timer {
 	struct notifier_block nb;
 };
 
-int omap_dm_timer_reserve_systimer(int id);
-struct omap_dm_timer *omap_dm_timer_request_by_cap(u32 cap);
-
 int omap_dm_timer_get_irq(struct omap_dm_timer *timer);
 
 u32 omap_dm_timer_modify_idlect_mask(u32 inputmask);
 
-int omap_dm_timer_trigger(struct omap_dm_timer *timer);
-
-int omap_dm_timers_active(void);
-
 /*
  * Do not use the defines below, they are not needed. They should be only
  * used by dmtimer.c and sys_timer related code.
