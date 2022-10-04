Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53575F3FB8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiJDJbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiJDJ15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:27:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656D213DEB;
        Tue,  4 Oct 2022 02:27:27 -0700 (PDT)
Date:   Tue, 04 Oct 2022 09:27:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664875646;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ml4OOFcagJAoUccDOT1irjLZTvqP8A5/rTSbDf8zAlQ=;
        b=1t5lIz5d6QXngBY997LYFo44JBxfFpkHwMSEz6OXPjp33xCz+6pXJbhAbFuSAuGEXh8R4W
        NiNMXeXqzywH/29N1B6Z3x0aNqohG2vu0/ndWydy98Dg9v6CvwIgSw/bvPpmm9GETbqAbS
        dvURg9MM/4VEfs1ZAgWfkjd0FTrBoFG3kdZG6YzIkC/NcOgM+6o4ORlQ9x93LOhmRLjjCx
        R6W/WdNO6iXF7U2sGbycoP7CKOWPkjxRVQNJJPrVJCP0KTkIytoDOkTNavfnpM1rGMBhRi
        f/COhSeouapxvHFiz3YN1SIw3UY83uXYUIwAvJ/CAmiDpP3AnVDWVBRLC8xB2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664875646;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ml4OOFcagJAoUccDOT1irjLZTvqP8A5/rTSbDf8zAlQ=;
        b=1URIxLRoqzDDnDkKUZ+XLT1WYTTH7/ZFX7kfXr8vOn1Bt8u29M8T9do+/9O+Z594ITKH3x
        l+5nwS4WA9pfdqCQ==
From:   "tip-bot2 for Victor Hassan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/sun4i: Add definition of clear
 interrupt
Cc:     Victor Hassan <victor@allwinnertech.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220906052056.43404-1-victor@allwinnertech.com>
References: <20220906052056.43404-1-victor@allwinnertech.com>
MIME-Version: 1.0
Message-ID: <166487564484.401.3287396501442788993.tip-bot2@tip-bot2>
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

Commit-ID:     4364044c326cbf2ad09e9fa99a9a28a342fecce6
Gitweb:        https://git.kernel.org/tip/4364044c326cbf2ad09e9fa99a9a28a342fecce6
Author:        Victor Hassan <victor@allwinnertech.com>
AuthorDate:    Tue, 06 Sep 2022 13:20:56 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 20 Sep 2022 10:49:39 +02:00

clocksource/drivers/sun4i: Add definition of clear interrupt

To prevent misunderstanding, use TIMER_IRQ_CLEAR instead of TIMER_IRQ_EN
in function sun4i_timer_clear_interrupt.

Signed-off-by: Victor Hassan <victor@allwinnertech.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Link: https://lore.kernel.org/r/20220906052056.43404-1-victor@allwinnertech.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-sun4i.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-sun4i.c b/drivers/clocksource/timer-sun4i.c
index 94dc6e4..e5a70aa 100644
--- a/drivers/clocksource/timer-sun4i.c
+++ b/drivers/clocksource/timer-sun4i.c
@@ -26,6 +26,7 @@
 #define TIMER_IRQ_EN_REG	0x00
 #define TIMER_IRQ_EN(val)		BIT(val)
 #define TIMER_IRQ_ST_REG	0x04
+#define TIMER_IRQ_CLEAR(val)		BIT(val)
 #define TIMER_CTL_REG(val)	(0x10 * val + 0x10)
 #define TIMER_CTL_ENABLE		BIT(0)
 #define TIMER_CTL_RELOAD		BIT(1)
@@ -123,7 +124,7 @@ static int sun4i_clkevt_next_event(unsigned long evt,
 
 static void sun4i_timer_clear_interrupt(void __iomem *base)
 {
-	writel(TIMER_IRQ_EN(0), base + TIMER_IRQ_ST_REG);
+	writel(TIMER_IRQ_CLEAR(0), base + TIMER_IRQ_ST_REG);
 }
 
 static irqreturn_t sun4i_timer_interrupt(int irq, void *dev_id)
