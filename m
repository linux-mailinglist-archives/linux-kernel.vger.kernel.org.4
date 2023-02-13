Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D725694F47
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjBMS0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjBMS00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:26:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7626D1711;
        Mon, 13 Feb 2023 10:26:24 -0800 (PST)
Date:   Mon, 13 Feb 2023 18:26:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676312783;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7LVmk5OQQdIxqEdfNpCuLE9e8cKT+OCZOwBwEjSL6ns=;
        b=Wt8aDdSxK+or/6H7XhtO8FtsJ3szltCy2+AKDwbl5tP3LThQJ+ciicMKPqSc8KPA+JV2RY
        SiZv6JwBQMz2ygL0/l/WIJLkCLV0WQxEzJ1cnrzwTEq1RgaZZae2Pqu7rrpRblU/CwJZ89
        m4zyEw6upjyuOwjEHBsxGduy5DpCJpKDqUdcFh77ZRmi61K8IV7lYap0kyj46KfacH4BIS
        Bs8emVrrZaaBmYpRnwARIH5WgmM4GNBv5vmgzLvm0WpKluVlfHJZh4uWfX1FUkxXUvaCGx
        oWVEbRYALELSBo3i8laIT+7ZBKP7WszrWa+UjNRn9J5B7vzr0QSOHnKrOWaYkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676312783;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7LVmk5OQQdIxqEdfNpCuLE9e8cKT+OCZOwBwEjSL6ns=;
        b=CFTG9ZFcdCCvWYJ3M3RslMq2LCWcTtrRsCZ77s+xPamyK9yJf8AiMFKGQ8tf6Vyuu4uE2j
        WW7T2YYv7rfMoRDA==
From:   "tip-bot2 for Claudiu Beznea" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-microchip-pit64b: Add
 delay timer
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230203130537.1921608-3-claudiu.beznea@microchip.com>
References: <20230203130537.1921608-3-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Message-ID: <167631278275.4906.11516318831901013239.tip-bot2@tip-bot2>
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

Commit-ID:     f3af3dc7cc351bd22742eac992c72c76749ce8c3
Gitweb:        https://git.kernel.org/tip/f3af3dc7cc351bd22742eac992c72c76749ce8c3
Author:        Claudiu Beznea <claudiu.beznea@microchip.com>
AuthorDate:    Fri, 03 Feb 2023 15:05:37 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 13 Feb 2023 13:10:17 +01:00

clocksource/drivers/timer-microchip-pit64b: Add delay timer

Add delay timer.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lore.kernel.org/r/20230203130537.1921608-3-claudiu.beznea@microchip.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-microchip-pit64b.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clocksource/timer-microchip-pit64b.c b/drivers/clocksource/timer-microchip-pit64b.c
index d5f1436..57209bb 100644
--- a/drivers/clocksource/timer-microchip-pit64b.c
+++ b/drivers/clocksource/timer-microchip-pit64b.c
@@ -9,6 +9,7 @@
 
 #include <linux/clk.h>
 #include <linux/clockchips.h>
+#include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -92,6 +93,8 @@ struct mchp_pit64b_clksrc {
 static void __iomem *mchp_pit64b_cs_base;
 /* Default cycles for clockevent timer. */
 static u64 mchp_pit64b_ce_cycles;
+/* Delay timer. */
+static struct delay_timer mchp_pit64b_dt;
 
 static inline u64 mchp_pit64b_cnt_read(void __iomem *base)
 {
@@ -169,6 +172,11 @@ static u64 notrace mchp_pit64b_sched_read_clk(void)
 	return mchp_pit64b_cnt_read(mchp_pit64b_cs_base);
 }
 
+static unsigned long notrace mchp_pit64b_dt_read(void)
+{
+	return mchp_pit64b_cnt_read(mchp_pit64b_cs_base);
+}
+
 static int mchp_pit64b_clkevt_shutdown(struct clock_event_device *cedev)
 {
 	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
@@ -376,6 +384,10 @@ static int __init mchp_pit64b_init_clksrc(struct mchp_pit64b_timer *timer,
 
 	sched_clock_register(mchp_pit64b_sched_read_clk, 64, clk_rate);
 
+	mchp_pit64b_dt.read_current_timer = mchp_pit64b_dt_read;
+	mchp_pit64b_dt.freq = clk_rate;
+	register_current_timer_delay(&mchp_pit64b_dt);
+
 	return 0;
 }
 
