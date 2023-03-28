Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A016CBBDF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjC1KGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjC1KGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:06:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8E27D8C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:06:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ph6DW-0005iK-PO; Tue, 28 Mar 2023 12:06:14 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ph6DV-007Hd1-Ue; Tue, 28 Mar 2023 12:06:13 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ph6DV-008eq9-4b; Tue, 28 Mar 2023 12:06:13 +0200
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
Subject: [PATCH 2/3] clk: imx: Drop inclustion of unused header <soc/imx/timer.h>
Date:   Tue, 28 Mar 2023 12:05:30 +0200
Message-Id: <20230328100531.879485-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328100531.879485-1-u.kleine-koenig@pengutronix.de>
References: <20230328100531.879485-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1814; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=uXRQfFQp+F1M7S5Rm4xzM2YMPoddvEE/MywZUAEyot8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkIrvp97+qKATUOb/7e3tgwXpLodHp9mRmDCezx akiJyZYV0eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZCK76QAKCRCPgPtYfRL+ ThazB/0cZkwVjmAR2a1bQmL55xhdU0ulkeQa9snh5S8dBmSw+EGVqCgGzjWgIjWpSm4rjCJ8QG7 7xY4il43AQlzsNzDBaJ3fxykVSqdymlAoIX5bqrdnsOn7vl53LUBlMwFwC+v1n8E4NPzxEw4UAP TYtvmsvB1v0LB02IjyKqTzpl6xjPMo5Y5UidEjWhlQ8ScD3Mxs2Boj+1JKJARcTx/151oQW/IQ1 bNeDZSuSvH0M3xhVjwrXdtWu5e8bFQtl0iu6p89XB8boj1geSRE3ej07TfkkKpRRH/9299AtXy4 dE+Efx5sNFsuBsFSZXg86iSA39vO1CgsBz8tZtTwi/p7tf8F
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

The clk drivers use none of the symbols defined in <soc/imx/timer.h>.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/clk/imx/clk-imx1.c  | 1 -
 drivers/clk/imx/clk-imx27.c | 1 -
 drivers/clk/imx/clk-imx31.c | 1 -
 drivers/clk/imx/clk-imx35.c | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx1.c b/drivers/clk/imx/clk-imx1.c
index 22fc7491ba00..f6ea7e5052d5 100644
--- a/drivers/clk/imx/clk-imx1.c
+++ b/drivers/clk/imx/clk-imx1.c
@@ -10,7 +10,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <dt-bindings/clock/imx1-clock.h>
-#include <soc/imx/timer.h>
 #include <asm/irq.h>
 
 #include "clk.h"
diff --git a/drivers/clk/imx/clk-imx27.c b/drivers/clk/imx/clk-imx27.c
index 5d177125728d..99618ded0939 100644
--- a/drivers/clk/imx/clk-imx27.c
+++ b/drivers/clk/imx/clk-imx27.c
@@ -8,7 +8,6 @@
 #include <linux/of_address.h>
 #include <dt-bindings/clock/imx27-clock.h>
 #include <soc/imx/revision.h>
-#include <soc/imx/timer.h>
 #include <asm/irq.h>
 
 #include "clk.h"
diff --git a/drivers/clk/imx/clk-imx31.c b/drivers/clk/imx/clk-imx31.c
index c44e18c6f63f..4c8d9ff0b2ad 100644
--- a/drivers/clk/imx/clk-imx31.c
+++ b/drivers/clk/imx/clk-imx31.c
@@ -11,7 +11,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <soc/imx/revision.h>
-#include <soc/imx/timer.h>
 #include <asm/irq.h>
 
 #include "clk.h"
diff --git a/drivers/clk/imx/clk-imx35.c b/drivers/clk/imx/clk-imx35.c
index 7dcbaea3fea3..3b6fdb4e0be7 100644
--- a/drivers/clk/imx/clk-imx35.c
+++ b/drivers/clk/imx/clk-imx35.c
@@ -10,7 +10,6 @@
 #include <linux/of.h>
 #include <linux/err.h>
 #include <soc/imx/revision.h>
-#include <soc/imx/timer.h>
 #include <asm/irq.h>
 
 #include "clk.h"
-- 
2.39.2

