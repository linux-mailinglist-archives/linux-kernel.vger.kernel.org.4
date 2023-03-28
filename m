Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A9B6CBBED
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjC1KHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjC1KGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:06:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91C872B8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:06:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ph6DW-0005iJ-PL; Tue, 28 Mar 2023 12:06:14 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ph6DV-007Hcx-Jf; Tue, 28 Mar 2023 12:06:13 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ph6DU-008eq6-UT; Tue, 28 Mar 2023 12:06:12 +0200
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
Subject: [PATCH 1/3] clocksource/drivers/imx-gpt: Drop unused function mxc_timer_init()
Date:   Tue, 28 Mar 2023 12:05:29 +0200
Message-Id: <20230328100531.879485-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1912; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=MNiFfnPjNelQGtWmkJxxEiSBIxcpNj1d/YkHfhNwz1A=; b=owGbwMvMwMXY3/A7olbonx/jabUkhhSl3S8CpKZrFCjuEXsWmNguofRxdRurwiajKp0Lt10e/ lVds8euk9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJfFLnYFgX4rvDwlVR44L+ RffFVpO0ngut3dZjdWirv2fPk7PFC37br1d71iyqe4Nv0cLN/T4hFoGeRbbup3gCd0s1T/20IyH k0x/3sC4BmV0xInXflOUzOHJ9SrhluGylva4sWN2x/8E8uTOmLNaFW/bzP+X5tWGZyYLEzEXuFr yHs0/nbrBe6O0l8enC07qIqcmtTnIXZCfGhQnm3w3IeSMssvJBTcFhh/Y9x8u/fMr/pHd2io2Pd I3F3gtszLzuZW6Hd20XXRr6oPJfRNHENFtT30a9EJUrvapnDXfsKOhb/7bCWL/mGX8N15kFMmeT P87TizZbkiU1X8T3JZe9GM/HG64bJJi97neI7P+vtjkQAA==
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

The last caller is gone since v5.10-rc1~28.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/clocksource/timer-imx-gpt.c | 19 -------------------
 include/soc/imx/timer.h             |  7 -------
 2 files changed, 26 deletions(-)

diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
index 8ad0bda42029..83cefff2bec1 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -414,25 +414,6 @@ static int __init _mxc_timer_init(struct imx_timer *imxtm)
 	return mxc_clockevent_init(imxtm);
 }
 
-void __init mxc_timer_init(unsigned long pbase, int irq, enum imx_gpt_type type)
-{
-	struct imx_timer *imxtm;
-
-	imxtm = kzalloc(sizeof(*imxtm), GFP_KERNEL);
-	BUG_ON(!imxtm);
-
-	imxtm->clk_per = clk_get_sys("imx-gpt.0", "per");
-	imxtm->clk_ipg = clk_get_sys("imx-gpt.0", "ipg");
-
-	imxtm->base = ioremap(pbase, SZ_4K);
-	BUG_ON(!imxtm->base);
-
-	imxtm->type = type;
-	imxtm->irq = irq;
-
-	_mxc_timer_init(imxtm);
-}
-
 static int __init mxc_timer_init_dt(struct device_node *np,  enum imx_gpt_type type)
 {
 	struct imx_timer *imxtm;
diff --git a/include/soc/imx/timer.h b/include/soc/imx/timer.h
index b888d5076b4d..25f29c6bbd0b 100644
--- a/include/soc/imx/timer.h
+++ b/include/soc/imx/timer.h
@@ -13,11 +13,4 @@ enum imx_gpt_type {
 	GPT_TYPE_IMX6DL,	/* i.MX6DL/SX/SL */
 };
 
-/*
- * This is a stop-gap solution for clock drivers like imx1/imx21 which call
- * mxc_timer_init() to initialize timer for non-DT boot.  It can be removed
- * when these legacy non-DT support is converted or dropped.
- */
-void mxc_timer_init(unsigned long pbase, int irq, enum imx_gpt_type type);
-
 #endif  /* __SOC_IMX_TIMER_H__ */

base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
prerequisite-patch-id: 016070a969cd4648b6a1dfffaa1bf334acc984ea
-- 
2.39.2

