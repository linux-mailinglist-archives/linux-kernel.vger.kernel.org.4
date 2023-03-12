Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7880A6B6814
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjCLQQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjCLQPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:15:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE25236448
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:15:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLx-0007nu-KB; Sun, 12 Mar 2023 17:15:21 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLw-003f1n-3R; Sun, 12 Mar 2023 17:15:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLv-004K8I-6o; Sun, 12 Mar 2023 17:15:19 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/30] clk: bcm: Convert to platform remove callback returning void
Date:   Sun, 12 Mar 2023 17:14:47 +0100
Message-Id: <20230312161512.2715500-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3859; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=IanNNGBHrcCJAmWf5mu1sRbucThqze61zMSvuzhO+qA=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkDfolS68+JWJsutAg1Dv7pxwQwnL0jcsu/Rm04 J5EwBXLLl6JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZA36JQAKCRDB/BR4rcrs CSd1B/48w5+aiFjQRF5oReqowqPNI0mVBhXVuagj7eeGlaCXssUqUR9O72JSSo9M5NUJhnk7J0X aWFT4r8hyfXDjK8yzhCL77VqKK61akJEgQ8+qGINvBaHjaZ2kGjRhVAeQ4vKBrM7gWtMmitUt5m FlIGr5Jk4VHkGT9v9iaw8v1Nh0tR/Iz26z9LdIrBa5YNMb7Evf/95vH/+jzC6ijjzPdzMyiVjUQ BOXJdJttA381KWDF+4Tr4FW347AnNeBX2CAefe7T21KjPcagSb2iJZV9pRkDaMNsQjXp2XTtFy1 MbTvxyavrKFKwk0+xBj3JIRVzm31Yh+SDj08vadA4zdwKZSF
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
 drivers/clk/bcm/clk-bcm2711-dvp.c  | 6 ++----
 drivers/clk/bcm/clk-bcm63xx-gate.c | 6 ++----
 drivers/clk/bcm/clk-raspberrypi.c  | 6 ++----
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2711-dvp.c b/drivers/clk/bcm/clk-bcm2711-dvp.c
index e63a42618ac2..e4fbbf3c40fe 100644
--- a/drivers/clk/bcm/clk-bcm2711-dvp.c
+++ b/drivers/clk/bcm/clk-bcm2711-dvp.c
@@ -92,15 +92,13 @@ static int clk_dvp_probe(struct platform_device *pdev)
 	return ret;
 };
 
-static int clk_dvp_remove(struct platform_device *pdev)
+static void clk_dvp_remove(struct platform_device *pdev)
 {
 	struct clk_dvp *dvp = platform_get_drvdata(pdev);
 	struct clk_hw_onecell_data *data = dvp->data;
 
 	clk_hw_unregister_gate(data->hws[1]);
 	clk_hw_unregister_gate(data->hws[0]);
-
-	return 0;
 }
 
 static const struct of_device_id clk_dvp_dt_ids[] = {
@@ -111,7 +109,7 @@ MODULE_DEVICE_TABLE(of, clk_dvp_dt_ids);
 
 static struct platform_driver clk_dvp_driver = {
 	.probe	= clk_dvp_probe,
-	.remove	= clk_dvp_remove,
+	.remove_new = clk_dvp_remove,
 	.driver	= {
 		.name		= "brcm2711-dvp",
 		.of_match_table	= clk_dvp_dt_ids,
diff --git a/drivers/clk/bcm/clk-bcm63xx-gate.c b/drivers/clk/bcm/clk-bcm63xx-gate.c
index 89297c57881e..0769f98767da 100644
--- a/drivers/clk/bcm/clk-bcm63xx-gate.c
+++ b/drivers/clk/bcm/clk-bcm63xx-gate.c
@@ -541,7 +541,7 @@ static int clk_bcm63xx_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int clk_bcm63xx_remove(struct platform_device *pdev)
+static void clk_bcm63xx_remove(struct platform_device *pdev)
 {
 	struct clk_bcm63xx_hw *hw = platform_get_drvdata(pdev);
 	int i;
@@ -552,8 +552,6 @@ static int clk_bcm63xx_remove(struct platform_device *pdev)
 		if (!IS_ERR(hw->data.hws[i]))
 			clk_hw_unregister_gate(hw->data.hws[i]);
 	}
-
-	return 0;
 }
 
 static const struct of_device_id clk_bcm63xx_dt_ids[] = {
@@ -570,7 +568,7 @@ static const struct of_device_id clk_bcm63xx_dt_ids[] = {
 
 static struct platform_driver clk_bcm63xx = {
 	.probe = clk_bcm63xx_probe,
-	.remove = clk_bcm63xx_remove,
+	.remove_new = clk_bcm63xx_remove,
 	.driver = {
 		.name = "bcm63xx-clock",
 		.of_match_table = clk_bcm63xx_dt_ids,
diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index ce2f93479736..eb399a4d141b 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -439,13 +439,11 @@ static int raspberrypi_clk_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int raspberrypi_clk_remove(struct platform_device *pdev)
+static void raspberrypi_clk_remove(struct platform_device *pdev)
 {
 	struct raspberrypi_clk *rpi = platform_get_drvdata(pdev);
 
 	platform_device_unregister(rpi->cpufreq);
-
-	return 0;
 }
 
 static const struct of_device_id raspberrypi_clk_match[] = {
@@ -460,7 +458,7 @@ static struct platform_driver raspberrypi_clk_driver = {
 		.of_match_table = raspberrypi_clk_match,
 	},
 	.probe          = raspberrypi_clk_probe,
-	.remove		= raspberrypi_clk_remove,
+	.remove_new	= raspberrypi_clk_remove,
 };
 module_platform_driver(raspberrypi_clk_driver);
 
-- 
2.39.1

