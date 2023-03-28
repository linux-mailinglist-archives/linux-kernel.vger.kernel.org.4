Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939F36CBBE1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjC1KG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjC1KGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:06:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9A77D8B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:06:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ph6DW-0005iL-QO; Tue, 28 Mar 2023 12:06:14 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ph6DW-007Hd4-3G; Tue, 28 Mar 2023 12:06:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ph6DV-008eqC-DX; Tue, 28 Mar 2023 12:06:13 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] clocksource/drivers/imx-gpt: Fold <soc/imx/timer.h> into its only user
Date:   Tue, 28 Mar 2023 12:05:31 +0200
Message-Id: <20230328100531.879485-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328100531.879485-1-u.kleine-koenig@pengutronix.de>
References: <20230328100531.879485-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1790; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=4FtKZGWE7QEs+SiwKtlTDYTMbd0vZfDdvhQ65J0qa1o=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkIrvqaD5udDZuqv55KVpmanjLuFTnZXggqT1/C ttOvyfatzKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZCK76gAKCRCPgPtYfRL+ TnSlB/0TCSm28OvliqaBh9+V1ig+6sD4JbkmveYJkW6Rx750KHS0p/gthePMZDds5w8j+M2Zu94 pLTyoZ9tXfsEAkZ0gQEHXdm7U3hAGXvcmS+JGJujEEaO4J9PLZArEDESXLfa9AH7TQ9HbDpn3Q1 5Je6Usfg3fJpe02hF8kfpxDKWO3euePsDk8bPE/6frCRMhEjGcxG6sfswilk/T6ZvqBck3h31+v 4lCkBIXkuQCepaApaA+tTV9xHNKHw33/qN4/IjZtanpykukp9i0zyz2NDiZ1Nojz7TWk/X2mr+D i7hxMixdqLLncgwf5pjKWj3MScSSee6MoB3RZxK1NoBxxPmq
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only the imx-gpt timer driver makes use of enum imx_gpt_type that is
otherwise unused. Move its definition into the timer-imx-gpt driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/clocksource/timer-imx-gpt.c |  7 ++++++-
 include/soc/imx/timer.h             | 16 ----------------
 2 files changed, 6 insertions(+), 17 deletions(-)
 delete mode 100644 include/soc/imx/timer.h

diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
index 83cefff2bec1..28ab4f1a7c71 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -16,7 +16,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <soc/imx/timer.h>
 
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
 
 /* defines common for all i.MX */
 #define MXC_TCTL		0x00
diff --git a/include/soc/imx/timer.h b/include/soc/imx/timer.h
deleted file mode 100644
index 25f29c6bbd0b..000000000000
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
-- 
2.39.2

