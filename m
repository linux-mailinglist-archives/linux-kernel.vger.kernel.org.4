Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B68F73DAFD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjFZJN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjFZJNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:13:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADE5D2;
        Mon, 26 Jun 2023 02:11:39 -0700 (PDT)
Date:   Mon, 26 Jun 2023 09:11:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687770697;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5+sDAiDbyn2N+b8+X/R3hqWk/7HM1+Lcsl3RKbtVzI8=;
        b=1Z6IqPii50AXbf5CATFyeRf/c68vn5rGHlZdt1AJpzIcLi/OQEoijELT91QvYkvwO3k/p5
        G5GeDFttjG5/A/4+THZ7jUKFiIqbmsVISyg5pxIRLnSaS3L5n81myFezm6zMG77tkIFjUa
        dgJ5wWp1GY7QYsmpZILurAiRHYvCw5RRUuCwgdg7pNWfiTKhSrGXAOt1drNJSVT9ObzBUU
        2BCRJqz6eBsG+WgqfVzYmkYpoH2S2nZPI00c0RnhdJkW/HIvpnMaYXC9K8Q2NZqgJZ2hGu
        vQKlEFDfynmRJ3wclxyrhTEnyyamEqGlWLW1dDaGjT5biubA1FUO54Y83AC3pA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687770697;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5+sDAiDbyn2N+b8+X/R3hqWk/7HM1+Lcsl3RKbtVzI8=;
        b=mgV/5yFBWLYBjLqfoqYCmtbQRvm2xAniTritpM9M7gAkFWmw05kfW3wLC2cfaYtFWpYAcd
        iatyrHnWwnXbiSBw==
From:   tip-bot2 for Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/imx-gpt: Fold
 <soc/imx/timer.h> into its only user
Cc:     u.kleine-koenig@pengutronix.de,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230328100531.879485-3-u.kleine-koenig@pengutronix.de>
References: <20230328100531.879485-3-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Message-ID: <168777069743.404.1171447631326767889.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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

Commit-ID:     281bf6b94aec092096d788b56c106a8c9c2a432a
Gitweb:        https://git.kernel.org/tip/281bf6b94aec092096d788b56c106a8c9c2=
a432a
Author:        Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
AuthorDate:    Tue, 28 Mar 2023 12:05:31 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 23 Jun 2023 09:33:43 +02:00

clocksource/drivers/imx-gpt: Fold <soc/imx/timer.h> into its only user

Only the imx-gpt timer driver makes use of enum imx_gpt_type that is
otherwise unused. Move its definition into the timer-imx-gpt driver.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230328100531.879485-3-u.kleine-koenig@pengu=
tronix.de
---
 drivers/clocksource/timer-imx-gpt.c |  7 ++++++-
 include/soc/imx/timer.h             | 16 ----------------
 2 files changed, 6 insertions(+), 17 deletions(-)
 delete mode 100644 include/soc/imx/timer.h

diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-=
imx-gpt.c
index 83cefff..28ab4f1 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -16,7 +16,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <soc/imx/timer.h>
=20
 /*
  * There are 4 versions of the timer hardware on Freescale MXC hardware.
@@ -25,6 +24,12 @@
  *  - MX25, MX31, MX35, MX37, MX51, MX6Q(rev1.0)
  *  - MX6DL, MX6SX, MX6Q(rev1.1+)
  */
+enum imx_gpt_type {
+	GPT_TYPE_IMX1,		/* i.MX1 */
+	GPT_TYPE_IMX21,		/* i.MX21/27 */
+	GPT_TYPE_IMX31,		/* i.MX31/35/25/37/51/6Q */
+	GPT_TYPE_IMX6DL,	/* i.MX6DL/SX/SL */
+};
=20
 /* defines common for all i.MX */
 #define MXC_TCTL		0x00
diff --git a/include/soc/imx/timer.h b/include/soc/imx/timer.h
deleted file mode 100644
index 25f29c6..0000000
--- a/include/soc/imx/timer.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright 2015 Linaro Ltd.
- */
-
-#ifndef __SOC_IMX_TIMER_H__
-#define __SOC_IMX_TIMER_H__
-
-enum imx_gpt_type {
-	GPT_TYPE_IMX1,		/* i.MX1 */
-	GPT_TYPE_IMX21,		/* i.MX21/27 */
-	GPT_TYPE_IMX31,		/* i.MX31/35/25/37/51/6Q */
-	GPT_TYPE_IMX6DL,	/* i.MX6DL/SX/SL */
-};
-
-#endif  /* __SOC_IMX_TIMER_H__ */
