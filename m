Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509416B6819
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjCLQQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjCLQPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:15:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD6B37F2C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:15:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLz-0007qV-P1; Sun, 12 Mar 2023 17:15:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLz-003f2s-4x; Sun, 12 Mar 2023 17:15:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLy-004K9B-98; Sun, 12 Mar 2023 17:15:22 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 19/30] clk: mediatek: Convert to platform remove callback returning void
Date:   Sun, 12 Mar 2023 17:15:01 +0100
Message-Id: <20230312161512.2715500-20-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=21166; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=KF+g9q1reJzWvdfls8YQVm2+v74wmRfuk2qSt/B8rws=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkDfpgnE5WTo2JCisMSxXG7j3+1kmXNntVdUCGa 5XDf1fISXqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZA36YAAKCRDB/BR4rcrs CQwkCACMFMdOG/RNM5hmU7yU4BGAeo0YkT1YIkJOfIKLlR6HwBXC22ShIEh63ElG8h/qqfdgTCB oTpIK/GxS5MMXlUb9FaH16mzoNNVU9nmQnasx/SoatovMVM0EjN3AkkhNIv7cCRE9Rfk+e9zw4W xAoy+AUQ/K3GYssGZ8EAqPb+7HYriWhSiuNzzcKqobbLqUHxEyjju4px/PRsANH5HUN6UfGQch/ ozWZQTNuBA8EzApqFlvzxT1fLWUhzVYVFtadg1pr3/emQa2YY3Y1WXKuNNvo9GksGW0cjMkGjeR phuOBEJ+5ckvW9g+x7izXeq4+a4d+Ix0fvIQz6pB27zcgqN9
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
 drivers/clk/mediatek/clk-mt6795-apmixedsys.c | 6 ++----
 drivers/clk/mediatek/clk-mt6795-infracfg.c   | 6 ++----
 drivers/clk/mediatek/clk-mt6795-mm.c         | 6 ++----
 drivers/clk/mediatek/clk-mt6795-pericfg.c    | 6 ++----
 drivers/clk/mediatek/clk-mt8173-apmixedsys.c | 6 ++----
 drivers/clk/mediatek/clk-mt8173-infracfg.c   | 6 ++----
 drivers/clk/mediatek/clk-mt8173-mm.c         | 6 ++----
 drivers/clk/mediatek/clk-mt8186-apmixedsys.c | 6 ++----
 drivers/clk/mediatek/clk-mt8186-mcu.c        | 6 ++----
 drivers/clk/mediatek/clk-mt8186-mm.c         | 6 ++----
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c | 6 ++----
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c | 6 ++----
 drivers/clk/mediatek/clk-mt8195-topckgen.c   | 6 ++----
 drivers/clk/mediatek/clk-mt8195-vdo0.c       | 6 ++----
 drivers/clk/mediatek/clk-mt8195-vdo1.c       | 6 ++----
 drivers/clk/mediatek/clk-mt8195-vpp0.c       | 6 ++----
 drivers/clk/mediatek/clk-mt8195-vpp1.c       | 6 ++----
 17 files changed, 34 insertions(+), 68 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt6795-apmixedsys.c b/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
index 59761c72d3bc..d71784f82d85 100644
--- a/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
@@ -130,7 +130,7 @@ static int clk_mt6795_apmixed_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int clk_mt6795_apmixed_remove(struct platform_device *pdev)
+static void clk_mt6795_apmixed_remove(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
@@ -139,13 +139,11 @@ static int clk_mt6795_apmixed_remove(struct platform_device *pdev)
 	mtk_clk_unregister_ref2usb_tx(clk_data->hws[CLK_APMIXED_REF2USB_TX]);
 	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
 	mtk_free_clk_data(clk_data);
-
-	return 0;
 }
 
 static struct platform_driver clk_mt6795_apmixed_drv = {
 	.probe = clk_mt6795_apmixed_probe,
-	.remove = clk_mt6795_apmixed_remove,
+	.remove_new = clk_mt6795_apmixed_remove,
 	.driver = {
 		.name = "clk-mt6795-apmixed",
 		.of_match_table = of_match_clk_mt6795_apmixed,
diff --git a/drivers/clk/mediatek/clk-mt6795-infracfg.c b/drivers/clk/mediatek/clk-mt6795-infracfg.c
index 23d9fc057e61..e74902d51db7 100644
--- a/drivers/clk/mediatek/clk-mt6795-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt6795-infracfg.c
@@ -126,7 +126,7 @@ static int clk_mt6795_infracfg_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int clk_mt6795_infracfg_remove(struct platform_device *pdev)
+static void clk_mt6795_infracfg_remove(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
@@ -135,8 +135,6 @@ static int clk_mt6795_infracfg_remove(struct platform_device *pdev)
 	mtk_clk_unregister_cpumuxes(cpu_muxes, ARRAY_SIZE(cpu_muxes), clk_data);
 	mtk_clk_unregister_gates(infra_gates, ARRAY_SIZE(infra_gates), clk_data);
 	mtk_free_clk_data(clk_data);
-
-	return 0;
 }
 
 static struct platform_driver clk_mt6795_infracfg_drv = {
@@ -145,7 +143,7 @@ static struct platform_driver clk_mt6795_infracfg_drv = {
 		.of_match_table = of_match_clk_mt6795_infracfg,
 	},
 	.probe = clk_mt6795_infracfg_probe,
-	.remove = clk_mt6795_infracfg_remove,
+	.remove_new = clk_mt6795_infracfg_remove,
 };
 module_platform_driver(clk_mt6795_infracfg_drv);
 
diff --git a/drivers/clk/mediatek/clk-mt6795-mm.c b/drivers/clk/mediatek/clk-mt6795-mm.c
index eebb6143ada2..426f9897877d 100644
--- a/drivers/clk/mediatek/clk-mt6795-mm.c
+++ b/drivers/clk/mediatek/clk-mt6795-mm.c
@@ -107,7 +107,7 @@ static int clk_mt6795_mm_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int clk_mt6795_mm_remove(struct platform_device *pdev)
+static void clk_mt6795_mm_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
@@ -116,8 +116,6 @@ static int clk_mt6795_mm_remove(struct platform_device *pdev)
 	of_clk_del_provider(node);
 	mtk_clk_unregister_gates(mm_gates, ARRAY_SIZE(mm_gates), clk_data);
 	mtk_free_clk_data(clk_data);
-
-	return 0;
 }
 
 static struct platform_driver clk_mt6795_mm_drv = {
@@ -125,7 +123,7 @@ static struct platform_driver clk_mt6795_mm_drv = {
 		.name = "clk-mt6795-mm",
 	},
 	.probe = clk_mt6795_mm_probe,
-	.remove = clk_mt6795_mm_remove,
+	.remove_new = clk_mt6795_mm_remove,
 };
 module_platform_driver(clk_mt6795_mm_drv);
 
diff --git a/drivers/clk/mediatek/clk-mt6795-pericfg.c b/drivers/clk/mediatek/clk-mt6795-pericfg.c
index 08aaa9b09c36..9e30d8d186a2 100644
--- a/drivers/clk/mediatek/clk-mt6795-pericfg.c
+++ b/drivers/clk/mediatek/clk-mt6795-pericfg.c
@@ -135,7 +135,7 @@ static int clk_mt6795_pericfg_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int clk_mt6795_pericfg_remove(struct platform_device *pdev)
+static void clk_mt6795_pericfg_remove(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
@@ -144,8 +144,6 @@ static int clk_mt6795_pericfg_remove(struct platform_device *pdev)
 	mtk_clk_unregister_composites(peri_clks, ARRAY_SIZE(peri_clks), clk_data);
 	mtk_clk_unregister_gates(peri_gates, ARRAY_SIZE(peri_gates), clk_data);
 	mtk_free_clk_data(clk_data);
-
-	return 0;
 }
 
 static struct platform_driver clk_mt6795_pericfg_drv = {
@@ -154,7 +152,7 @@ static struct platform_driver clk_mt6795_pericfg_drv = {
 		.of_match_table = of_match_clk_mt6795_pericfg,
 	},
 	.probe = clk_mt6795_pericfg_probe,
-	.remove = clk_mt6795_pericfg_remove,
+	.remove_new = clk_mt6795_pericfg_remove,
 };
 module_platform_driver(clk_mt6795_pericfg_drv);
 
diff --git a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
index a56c5845d07a..b7ca15949fd1 100644
--- a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
@@ -130,7 +130,7 @@ static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
 	return r;
 }
 
-static int clk_mt8173_apmixed_remove(struct platform_device *pdev)
+static void clk_mt8173_apmixed_remove(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
@@ -139,13 +139,11 @@ static int clk_mt8173_apmixed_remove(struct platform_device *pdev)
 	mtk_clk_unregister_ref2usb_tx(clk_data->hws[CLK_APMIXED_REF2USB_TX]);
 	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
 	mtk_free_clk_data(clk_data);
-
-	return 0;
 }
 
 static struct platform_driver clk_mt8173_apmixed_drv = {
 	.probe = clk_mt8173_apmixed_probe,
-	.remove = clk_mt8173_apmixed_remove,
+	.remove_new = clk_mt8173_apmixed_remove,
 	.driver = {
 		.name = "clk-mt8173-apmixed",
 		.of_match_table = of_match_clk_mt8173_apmixed,
diff --git a/drivers/clk/mediatek/clk-mt8173-infracfg.c b/drivers/clk/mediatek/clk-mt8173-infracfg.c
index 729b3c408c7b..c71c0e5c607d 100644
--- a/drivers/clk/mediatek/clk-mt8173-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt8173-infracfg.c
@@ -128,7 +128,7 @@ static int clk_mt8173_infracfg_probe(struct platform_device *pdev)
 	return r;
 }
 
-static int clk_mt8173_infracfg_remove(struct platform_device *pdev)
+static void clk_mt8173_infracfg_remove(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
@@ -137,8 +137,6 @@ static int clk_mt8173_infracfg_remove(struct platform_device *pdev)
 	mtk_clk_unregister_cpumuxes(cpu_muxes, ARRAY_SIZE(cpu_muxes), clk_data);
 	mtk_clk_unregister_gates(infra_gates, ARRAY_SIZE(infra_gates), clk_data);
 	mtk_free_clk_data(clk_data);
-
-	return 0;
 }
 
 static struct platform_driver clk_mt8173_infracfg_drv = {
@@ -147,7 +145,7 @@ static struct platform_driver clk_mt8173_infracfg_drv = {
 		.of_match_table = of_match_clk_mt8173_infracfg,
 	},
 	.probe = clk_mt8173_infracfg_probe,
-	.remove = clk_mt8173_infracfg_remove,
+	.remove_new = clk_mt8173_infracfg_remove,
 };
 module_platform_driver(clk_mt8173_infracfg_drv);
 
diff --git a/drivers/clk/mediatek/clk-mt8173-mm.c b/drivers/clk/mediatek/clk-mt8173-mm.c
index 315430ad1581..a941b4c688a5 100644
--- a/drivers/clk/mediatek/clk-mt8173-mm.c
+++ b/drivers/clk/mediatek/clk-mt8173-mm.c
@@ -136,7 +136,7 @@ static int clk_mt8173_mm_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int clk_mt8173_mm_remove(struct platform_device *pdev)
+static void clk_mt8173_mm_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
@@ -146,8 +146,6 @@ static int clk_mt8173_mm_remove(struct platform_device *pdev)
 	of_clk_del_provider(node);
 	mtk_clk_unregister_gates(data->gates_clk, data->gates_num, clk_data);
 	mtk_free_clk_data(clk_data);
-
-	return 0;
 }
 
 static struct platform_driver clk_mt8173_mm_drv = {
@@ -155,7 +153,7 @@ static struct platform_driver clk_mt8173_mm_drv = {
 		.name = "clk-mt8173-mm",
 	},
 	.probe = clk_mt8173_mm_probe,
-	.remove = clk_mt8173_mm_remove,
+	.remove_new = clk_mt8173_mm_remove,
 };
 
 builtin_platform_driver(clk_mt8173_mm_drv);
diff --git a/drivers/clk/mediatek/clk-mt8186-apmixedsys.c b/drivers/clk/mediatek/clk-mt8186-apmixedsys.c
index 1d673c6278a9..392ffc1acb05 100644
--- a/drivers/clk/mediatek/clk-mt8186-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8186-apmixedsys.c
@@ -169,7 +169,7 @@ static int clk_mt8186_apmixed_probe(struct platform_device *pdev)
 	return r;
 }
 
-static int clk_mt8186_apmixed_remove(struct platform_device *pdev)
+static void clk_mt8186_apmixed_remove(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
@@ -178,13 +178,11 @@ static int clk_mt8186_apmixed_remove(struct platform_device *pdev)
 	mtk_clk_unregister_pllfhs(plls, ARRAY_SIZE(plls), pllfhs,
 				  ARRAY_SIZE(pllfhs), clk_data);
 	mtk_free_clk_data(clk_data);
-
-	return 0;
 }
 
 static struct platform_driver clk_mt8186_apmixed_drv = {
 	.probe = clk_mt8186_apmixed_probe,
-	.remove = clk_mt8186_apmixed_remove,
+	.remove_new = clk_mt8186_apmixed_remove,
 	.driver = {
 		.name = "clk-mt8186-apmixed",
 		.of_match_table = of_match_clk_mt8186_apmixed,
diff --git a/drivers/clk/mediatek/clk-mt8186-mcu.c b/drivers/clk/mediatek/clk-mt8186-mcu.c
index e52a2d986c99..e36519996873 100644
--- a/drivers/clk/mediatek/clk-mt8186-mcu.c
+++ b/drivers/clk/mediatek/clk-mt8186-mcu.c
@@ -86,7 +86,7 @@ static int clk_mt8186_mcu_probe(struct platform_device *pdev)
 	return r;
 }
 
-static int clk_mt8186_mcu_remove(struct platform_device *pdev)
+static void clk_mt8186_mcu_remove(struct platform_device *pdev)
 {
 	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
 	struct device_node *node = pdev->dev.of_node;
@@ -94,13 +94,11 @@ static int clk_mt8186_mcu_remove(struct platform_device *pdev)
 	of_clk_del_provider(node);
 	mtk_clk_unregister_composites(mcu_muxes, ARRAY_SIZE(mcu_muxes), clk_data);
 	mtk_free_clk_data(clk_data);
-
-	return 0;
 }
 
 static struct platform_driver clk_mt8186_mcu_drv = {
 	.probe = clk_mt8186_mcu_probe,
-	.remove = clk_mt8186_mcu_remove,
+	.remove_new = clk_mt8186_mcu_remove,
 	.driver = {
 		.name = "clk-mt8186-mcu",
 		.of_match_table = of_match_clk_mt8186_mcu,
diff --git a/drivers/clk/mediatek/clk-mt8186-mm.c b/drivers/clk/mediatek/clk-mt8186-mm.c
index 0b72607777fa..bd54f13939a9 100644
--- a/drivers/clk/mediatek/clk-mt8186-mm.c
+++ b/drivers/clk/mediatek/clk-mt8186-mm.c
@@ -89,7 +89,7 @@ static int clk_mt8186_mm_probe(struct platform_device *pdev)
 	return r;
 }
 
-static int clk_mt8186_mm_remove(struct platform_device *pdev)
+static void clk_mt8186_mm_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
@@ -98,13 +98,11 @@ static int clk_mt8186_mm_remove(struct platform_device *pdev)
 	of_clk_del_provider(node);
 	mtk_clk_unregister_gates(mm_clks, ARRAY_SIZE(mm_clks), clk_data);
 	mtk_free_clk_data(clk_data);
-
-	return 0;
 }
 
 static struct platform_driver clk_mt8186_mm_drv = {
 	.probe = clk_mt8186_mm_probe,
-	.remove = clk_mt8186_mm_remove,
+	.remove_new = clk_mt8186_mm_remove,
 	.driver = {
 		.name = "clk-mt8186-mm",
 	},
diff --git a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
index 1bc917f2667e..232781c70df2 100644
--- a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
@@ -146,7 +146,7 @@ static int clk_mt8195_apmixed_probe(struct platform_device *pdev)
 	return r;
 }
 
-static int clk_mt8195_apmixed_remove(struct platform_device *pdev)
+static void clk_mt8195_apmixed_remove(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
@@ -155,13 +155,11 @@ static int clk_mt8195_apmixed_remove(struct platform_device *pdev)
 	mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
 	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
 	mtk_free_clk_data(clk_data);
-
-	return 0;
 }
 
 static struct platform_driver clk_mt8195_apmixed_drv = {
 	.probe = clk_mt8195_apmixed_probe,
-	.remove = clk_mt8195_apmixed_remove,
+	.remove_new = clk_mt8195_apmixed_remove,
 	.driver = {
 		.name = "clk-mt8195-apmixed",
 		.of_match_table = of_match_clk_mt8195_apmixed,
diff --git a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
index 0b52f6a009c4..d8ba3c5a5942 100644
--- a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
+++ b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
@@ -85,7 +85,7 @@ static int clk_mt8195_apusys_pll_probe(struct platform_device *pdev)
 	return r;
 }
 
-static int clk_mt8195_apusys_pll_remove(struct platform_device *pdev)
+static void clk_mt8195_apusys_pll_remove(struct platform_device *pdev)
 {
 	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
 	struct device_node *node = pdev->dev.of_node;
@@ -93,8 +93,6 @@ static int clk_mt8195_apusys_pll_remove(struct platform_device *pdev)
 	of_clk_del_provider(node);
 	mtk_clk_unregister_plls(apusys_plls, ARRAY_SIZE(apusys_plls), clk_data);
 	mtk_free_clk_data(clk_data);
-
-	return 0;
 }
 
 static const struct of_device_id of_match_clk_mt8195_apusys_pll[] = {
@@ -104,7 +102,7 @@ static const struct of_device_id of_match_clk_mt8195_apusys_pll[] = {
 
 static struct platform_driver clk_mt8195_apusys_pll_drv = {
 	.probe = clk_mt8195_apusys_pll_probe,
-	.remove = clk_mt8195_apusys_pll_remove,
+	.remove_new = clk_mt8195_apusys_pll_remove,
 	.driver = {
 		.name = "clk-mt8195-apusys_pll",
 		.of_match_table = of_match_clk_mt8195_apusys_pll,
diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk/mediatek/clk-mt8195-topckgen.c
index cf520f85de73..c970cdd13c0b 100644
--- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
@@ -1316,7 +1316,7 @@ static int clk_mt8195_topck_probe(struct platform_device *pdev)
 	return r;
 }
 
-static int clk_mt8195_topck_remove(struct platform_device *pdev)
+static void clk_mt8195_topck_remove(struct platform_device *pdev)
 {
 	struct clk_hw_onecell_data *top_clk_data = platform_get_drvdata(pdev);
 	struct device_node *node = pdev->dev.of_node;
@@ -1328,13 +1328,11 @@ static int clk_mt8195_topck_remove(struct platform_device *pdev)
 	mtk_clk_unregister_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
 	mtk_clk_unregister_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks), top_clk_data);
 	mtk_free_clk_data(top_clk_data);
-
-	return 0;
 }
 
 static struct platform_driver clk_mt8195_topck_drv = {
 	.probe = clk_mt8195_topck_probe,
-	.remove = clk_mt8195_topck_remove,
+	.remove_new = clk_mt8195_topck_remove,
 	.driver = {
 		.name = "clk-mt8195-topck",
 		.of_match_table = of_match_clk_mt8195_topck,
diff --git a/drivers/clk/mediatek/clk-mt8195-vdo0.c b/drivers/clk/mediatek/clk-mt8195-vdo0.c
index 839b730688ac..86663db54a72 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdo0.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdo0.c
@@ -124,7 +124,7 @@ static int clk_mt8195_vdo0_probe(struct platform_device *pdev)
 	return r;
 }
 
-static int clk_mt8195_vdo0_remove(struct platform_device *pdev)
+static void clk_mt8195_vdo0_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
@@ -133,13 +133,11 @@ static int clk_mt8195_vdo0_remove(struct platform_device *pdev)
 	of_clk_del_provider(node);
 	mtk_clk_unregister_gates(vdo0_clks, ARRAY_SIZE(vdo0_clks), clk_data);
 	mtk_free_clk_data(clk_data);
-
-	return 0;
 }
 
 static struct platform_driver clk_mt8195_vdo0_drv = {
 	.probe = clk_mt8195_vdo0_probe,
-	.remove = clk_mt8195_vdo0_remove,
+	.remove_new = clk_mt8195_vdo0_remove,
 	.driver = {
 		.name = "clk-mt8195-vdo0",
 	},
diff --git a/drivers/clk/mediatek/clk-mt8195-vdo1.c b/drivers/clk/mediatek/clk-mt8195-vdo1.c
index 7df695b28925..05119b31077d 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdo1.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdo1.c
@@ -151,7 +151,7 @@ static int clk_mt8195_vdo1_probe(struct platform_device *pdev)
 	return r;
 }
 
-static int clk_mt8195_vdo1_remove(struct platform_device *pdev)
+static void clk_mt8195_vdo1_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
@@ -160,13 +160,11 @@ static int clk_mt8195_vdo1_remove(struct platform_device *pdev)
 	of_clk_del_provider(node);
 	mtk_clk_unregister_gates(vdo1_clks, ARRAY_SIZE(vdo1_clks), clk_data);
 	mtk_free_clk_data(clk_data);
-
-	return 0;
 }
 
 static struct platform_driver clk_mt8195_vdo1_drv = {
 	.probe = clk_mt8195_vdo1_probe,
-	.remove = clk_mt8195_vdo1_remove,
+	.remove_new = clk_mt8195_vdo1_remove,
 	.driver = {
 		.name = "clk-mt8195-vdo1",
 	},
diff --git a/drivers/clk/mediatek/clk-mt8195-vpp0.c b/drivers/clk/mediatek/clk-mt8195-vpp0.c
index e19664af09b6..fdb9f0507e52 100644
--- a/drivers/clk/mediatek/clk-mt8195-vpp0.c
+++ b/drivers/clk/mediatek/clk-mt8195-vpp0.c
@@ -116,7 +116,7 @@ static int clk_mt8195_vpp0_probe(struct platform_device *pdev)
 	return r;
 }
 
-static int clk_mt8195_vpp0_remove(struct platform_device *pdev)
+static void clk_mt8195_vpp0_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
@@ -125,13 +125,11 @@ static int clk_mt8195_vpp0_remove(struct platform_device *pdev)
 	of_clk_del_provider(node);
 	mtk_clk_unregister_gates(vpp0_clks, ARRAY_SIZE(vpp0_clks), clk_data);
 	mtk_free_clk_data(clk_data);
-
-	return 0;
 }
 
 static struct platform_driver clk_mt8195_vpp0_drv = {
 	.probe = clk_mt8195_vpp0_probe,
-	.remove = clk_mt8195_vpp0_remove,
+	.remove_new = clk_mt8195_vpp0_remove,
 	.driver = {
 		.name = "clk-mt8195-vpp0",
 	},
diff --git a/drivers/clk/mediatek/clk-mt8195-vpp1.c b/drivers/clk/mediatek/clk-mt8195-vpp1.c
index e6c458fc1531..075c569867d1 100644
--- a/drivers/clk/mediatek/clk-mt8195-vpp1.c
+++ b/drivers/clk/mediatek/clk-mt8195-vpp1.c
@@ -114,7 +114,7 @@ static int clk_mt8195_vpp1_probe(struct platform_device *pdev)
 	return r;
 }
 
-static int clk_mt8195_vpp1_remove(struct platform_device *pdev)
+static void clk_mt8195_vpp1_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
@@ -123,13 +123,11 @@ static int clk_mt8195_vpp1_remove(struct platform_device *pdev)
 	of_clk_del_provider(node);
 	mtk_clk_unregister_gates(vpp1_clks, ARRAY_SIZE(vpp1_clks), clk_data);
 	mtk_free_clk_data(clk_data);
-
-	return 0;
 }
 
 static struct platform_driver clk_mt8195_vpp1_drv = {
 	.probe = clk_mt8195_vpp1_probe,
-	.remove = clk_mt8195_vpp1_remove,
+	.remove_new = clk_mt8195_vpp1_remove,
 	.driver = {
 		.name = "clk-mt8195-vpp1",
 	},
-- 
2.39.1

