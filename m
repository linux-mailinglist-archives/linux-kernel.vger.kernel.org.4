Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6B26B6823
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjCLQRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjCLQP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:15:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADF14D60C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:15:40 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOM1-0007sF-MD; Sun, 12 Mar 2023 17:15:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOM1-003f3V-1m; Sun, 12 Mar 2023 17:15:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLz-004K9X-FH; Sun, 12 Mar 2023 17:15:23 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 24/30] clk: samsung: Convert to platform remove callback returning void
Date:   Sun, 12 Mar 2023 17:15:06 +0100
Message-Id: <20230312161512.2715500-25-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2861; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=0bilTxa4+zSBLpmHRbO43HSFtmhsJJR54/nSVpjT6CU=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkDfp33a+QojCuZuGcyKQe/zyREOQcQiZLkaYkO 1zTaalvIpWJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZA36dwAKCRDB/BR4rcrs CWa3B/9uCDZNpKz0bWJK4NR6fMbLQuKSkByFGwyKd5FLjS7hubG1x0d4xFK/UxgwKaOIHbjSOMA PAjyC658mFqfbJ1htuQzO6XzlVOJETd6oeFufpHoF6Pc/BLWd6FMamZsHk7azYci6b6epvQU04r 1wdc9R84iIYNEZHpnkzK5TvU1JzYEnVH5m/LdjO4tK1jpGV8hFlapZ+uJEn6Ftzuy4XT9umon+l DSu8sTfjUpoiMIBDYwYktF2VYdZc0ofcCCZzjmVrEneNVkqp+H2rgSqYA46/vQrRQogEVLAI72G X3noRP6MSJU7os/yUVHmcmIIek0/tDSrj/hrdhhuPm3ViAzz
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
 drivers/clk/samsung/clk-exynos-audss.c  | 6 ++----
 drivers/clk/samsung/clk-exynos-clkout.c | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos-audss.c b/drivers/clk/samsung/clk-exynos-audss.c
index 9cc127a162ad..7626dff41f6f 100644
--- a/drivers/clk/samsung/clk-exynos-audss.c
+++ b/drivers/clk/samsung/clk-exynos-audss.c
@@ -268,7 +268,7 @@ static int exynos_audss_clk_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int exynos_audss_clk_remove(struct platform_device *pdev)
+static void exynos_audss_clk_remove(struct platform_device *pdev)
 {
 	of_clk_del_provider(pdev->dev.of_node);
 
@@ -277,8 +277,6 @@ static int exynos_audss_clk_remove(struct platform_device *pdev)
 
 	if (!IS_ERR(epll))
 		clk_disable_unprepare(epll);
-
-	return 0;
 }
 
 static const struct dev_pm_ops exynos_audss_clk_pm_ops = {
@@ -295,7 +293,7 @@ static struct platform_driver exynos_audss_clk_driver = {
 		.pm = &exynos_audss_clk_pm_ops,
 	},
 	.probe = exynos_audss_clk_probe,
-	.remove = exynos_audss_clk_remove,
+	.remove_new = exynos_audss_clk_remove,
 };
 
 module_platform_driver(exynos_audss_clk_driver);
diff --git a/drivers/clk/samsung/clk-exynos-clkout.c b/drivers/clk/samsung/clk-exynos-clkout.c
index e6d6cbf8c4e6..0cff1c94c35e 100644
--- a/drivers/clk/samsung/clk-exynos-clkout.c
+++ b/drivers/clk/samsung/clk-exynos-clkout.c
@@ -196,15 +196,13 @@ static int exynos_clkout_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int exynos_clkout_remove(struct platform_device *pdev)
+static void exynos_clkout_remove(struct platform_device *pdev)
 {
 	struct exynos_clkout *clkout = platform_get_drvdata(pdev);
 
 	of_clk_del_provider(clkout->np);
 	clk_hw_unregister(clkout->data.hws[0]);
 	iounmap(clkout->reg);
-
-	return 0;
 }
 
 static int __maybe_unused exynos_clkout_suspend(struct device *dev)
@@ -235,7 +233,7 @@ static struct platform_driver exynos_clkout_driver = {
 		.pm = &exynos_clkout_pm_ops,
 	},
 	.probe = exynos_clkout_probe,
-	.remove = exynos_clkout_remove,
+	.remove_new = exynos_clkout_remove,
 };
 module_platform_driver(exynos_clkout_driver);
 
-- 
2.39.1

