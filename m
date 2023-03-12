Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C3C6B6818
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjCLQQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjCLQPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:15:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E6A38013
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:15:32 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOM1-0007s2-Bk; Sun, 12 Mar 2023 17:15:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOM0-003f3O-Mu; Sun, 12 Mar 2023 17:15:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLz-004K9a-MQ; Sun, 12 Mar 2023 17:15:23 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-clk@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 25/30] clk: stm32: Convert to platform remove callback returning void
Date:   Sun, 12 Mar 2023 17:15:07 +0100
Message-Id: <20230312161512.2715500-26-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1789; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=YSdgKydMUmqqeYG946UQat08kJ/q2KTOaGSGnm0gse0=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkDfp6xwsITcqTQd1LtV6bSmWobY11RcAQyBADL isAsR//OeaJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZA36egAKCRDB/BR4rcrs CS0HCACeU/irJ0xObgGaUABt1LhZ3HhEP2AcWllEyHGs4VYMe2fhsL6WkHa1Xb0Zm2QIOi4pOSU cIsBOQHJzzeKxQxycQxnZ+t+iPAhaaorEtHf6W0eBtCTEW2XWK0usG5SGO1Je1QzetwHujE4Zei FfIlcwx2jmvEZpNK9kQLzYxLKzy3Xwv3SRoCHMh0+ZLjHiMIktVPFK8UE/X6YT7cnzN+IJA/P34 01tCWyMZmvUw46b6Ghm/LyOqfyoS/dPFqLK1A4vjJuQkuDOwOJ/m7kIj5zhZ3M9rRxNt0Y5nYKY vao6Xw+ru12lquwaUV1yM5TyB9xaMilvr1ASZYLqoM39TwrS
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/clk/stm32/clk-stm32mp13.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/stm32/clk-stm32mp13.c b/drivers/clk/stm32/clk-stm32mp13.c
index 1192eee8abe4..c4a737482fe5 100644
--- a/drivers/clk/stm32/clk-stm32mp13.c
+++ b/drivers/clk/stm32/clk-stm32mp13.c
@@ -1593,15 +1593,13 @@ static int stm32mp1_rcc_clocks_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int stm32mp1_rcc_clocks_remove(struct platform_device *pdev)
+static void stm32mp1_rcc_clocks_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *child, *np = dev_of_node(dev);
 
 	for_each_available_child_of_node(np, child)
 		of_clk_del_provider(child);
-
-	return 0;
 }
 
 static struct platform_driver stm32mp13_rcc_clocks_driver = {
@@ -1610,7 +1608,7 @@ static struct platform_driver stm32mp13_rcc_clocks_driver = {
 		.of_match_table = stm32mp13_match_data,
 	},
 	.probe = stm32mp1_rcc_clocks_probe,
-	.remove = stm32mp1_rcc_clocks_remove,
+	.remove_new = stm32mp1_rcc_clocks_remove,
 };
 
 static int __init stm32mp13_clocks_init(void)
-- 
2.39.1

