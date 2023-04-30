Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023B96F2A68
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 21:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjD3TCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 15:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjD3TCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 15:02:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403902D73
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 12:02:49 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ptCJk-000108-FN; Sun, 30 Apr 2023 21:02:40 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ptCJj-000BkW-LO; Sun, 30 Apr 2023 21:02:39 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ptCJi-000CVe-UR; Sun, 30 Apr 2023 21:02:38 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH v2 2/3] clk: mediatek: Make mtk_clk_pdev_remove() return void
Date:   Sun, 30 Apr 2023 21:02:32 +0200
Message-Id: <20230430190233.878921-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230430190233.878921-1-u.kleine-koenig@pengutronix.de>
References: <20230430190233.878921-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=12347; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=aUsgTS46EtHAYcEl/Bgf8o+QH2+TUajr86WZB+b5XP4=; b=owGbwMvMwMXY3/A7olbonx/jabUkhhS/3S55SjX6p7im3Jy8do6q46RFHqvqY9KfFOZvPGm2o 1ZMfev9TkZjFgZGLgZZMUUW+8Y1mVZVcpGda/9dhhnEygQyhYGLUwAmctic/X/+5MyoNy73WNKX Z+SdqGRnWqt2tfv8PwulJdZMocazlX2/sxkquRtFfb9WVjHJisskyqqNndfr8iX9vO+JTRP3LQ7 UyrZd6DHV6k3p5A9K9lNVCz43vJoj9HJG5cTUDo5HPVvNDB5rTOX8wLfx7b8l1o4KaQyOvupFPf yPtr/y/Xc5eOOCWibFowvbjBNOuvsV6y18+3DidteQtOa2XkeTxYwaEUaLUnbvF3olws9TN7nmi tfXxNbaufZLLCadLJDalHXB0bA49q3G+wix6olvYg87y6vfXOnfoHKw/Xh0y5VFczIeJmts1XjZ yZ27wSLxNV9d/aT9Vyuv6xxQifZS3FS/Ld1np3rIqkhGAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function returns 0 unconditionally. Make it return no value instead
and convert the drivers making use of it to platform_driver's
.remove_new().

This makes the semantics in the callers of mtk_clk_simple_remove() clearer
and prepares for the quest to make platform driver's remove function return
void. There is no semantic change.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/clk/mediatek/clk-mt2701-mm.c   | 2 +-
 drivers/clk/mediatek/clk-mt2712-mm.c   | 2 +-
 drivers/clk/mediatek/clk-mt6779-mm.c   | 2 +-
 drivers/clk/mediatek/clk-mt6795-mm.c   | 2 +-
 drivers/clk/mediatek/clk-mt6797-mm.c   | 2 +-
 drivers/clk/mediatek/clk-mt8167-mm.c   | 2 +-
 drivers/clk/mediatek/clk-mt8173-mm.c   | 2 +-
 drivers/clk/mediatek/clk-mt8183-mm.c   | 2 +-
 drivers/clk/mediatek/clk-mt8186-mm.c   | 2 +-
 drivers/clk/mediatek/clk-mt8188-vdo0.c | 2 +-
 drivers/clk/mediatek/clk-mt8188-vdo1.c | 2 +-
 drivers/clk/mediatek/clk-mt8188-vpp0.c | 2 +-
 drivers/clk/mediatek/clk-mt8188-vpp1.c | 2 +-
 drivers/clk/mediatek/clk-mt8192-mm.c   | 2 +-
 drivers/clk/mediatek/clk-mt8195-vdo0.c | 2 +-
 drivers/clk/mediatek/clk-mt8195-vdo1.c | 2 +-
 drivers/clk/mediatek/clk-mt8195-vpp0.c | 2 +-
 drivers/clk/mediatek/clk-mt8195-vpp1.c | 2 +-
 drivers/clk/mediatek/clk-mt8365-mm.c   | 2 +-
 drivers/clk/mediatek/clk-mtk.c         | 4 +---
 drivers/clk/mediatek/clk-mtk.h         | 2 +-
 21 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701-mm.c b/drivers/clk/mediatek/clk-mt2701-mm.c
index c62c56fd2b7e..2b990b5a0422 100644
--- a/drivers/clk/mediatek/clk-mt2701-mm.c
+++ b/drivers/clk/mediatek/clk-mt2701-mm.c
@@ -80,7 +80,7 @@ MODULE_DEVICE_TABLE(platform, clk_mt2701_mm_id_table);
 
 static struct platform_driver clk_mt2701_mm_drv = {
 	.probe = mtk_clk_pdev_probe,
-	.remove = mtk_clk_pdev_remove,
+	.remove_new = mtk_clk_pdev_remove,
 	.driver = {
 		.name = "clk-mt2701-mm",
 	},
diff --git a/drivers/clk/mediatek/clk-mt2712-mm.c b/drivers/clk/mediatek/clk-mt2712-mm.c
index 204a3eae08dc..15cb61fe2d2f 100644
--- a/drivers/clk/mediatek/clk-mt2712-mm.c
+++ b/drivers/clk/mediatek/clk-mt2712-mm.c
@@ -121,7 +121,7 @@ MODULE_DEVICE_TABLE(platform, clk_mt2712_mm_id_table);
 
 static struct platform_driver clk_mt2712_mm_drv = {
 	.probe = mtk_clk_pdev_probe,
-	.remove = mtk_clk_pdev_remove,
+	.remove_new = mtk_clk_pdev_remove,
 	.driver = {
 		.name = "clk-mt2712-mm",
 	},
diff --git a/drivers/clk/mediatek/clk-mt6779-mm.c b/drivers/clk/mediatek/clk-mt6779-mm.c
index c2f700ae6c2c..5e17e441f679 100644
--- a/drivers/clk/mediatek/clk-mt6779-mm.c
+++ b/drivers/clk/mediatek/clk-mt6779-mm.c
@@ -98,7 +98,7 @@ MODULE_DEVICE_TABLE(platform, clk_mt6779_mm_id_table);
 
 static struct platform_driver clk_mt6779_mm_drv = {
 	.probe = mtk_clk_pdev_probe,
-	.remove = mtk_clk_pdev_remove,
+	.remove_new = mtk_clk_pdev_remove,
 	.driver = {
 		.name = "clk-mt6779-mm",
 	},
diff --git a/drivers/clk/mediatek/clk-mt6795-mm.c b/drivers/clk/mediatek/clk-mt6795-mm.c
index 8acc9cad2875..ced6e310d694 100644
--- a/drivers/clk/mediatek/clk-mt6795-mm.c
+++ b/drivers/clk/mediatek/clk-mt6795-mm.c
@@ -93,7 +93,7 @@ static struct platform_driver clk_mt6795_mm_drv = {
 	},
 	.id_table = clk_mt6795_mm_id_table,
 	.probe = mtk_clk_pdev_probe,
-	.remove = mtk_clk_pdev_remove,
+	.remove_new = mtk_clk_pdev_remove,
 };
 module_platform_driver(clk_mt6795_mm_drv);
 
diff --git a/drivers/clk/mediatek/clk-mt6797-mm.c b/drivers/clk/mediatek/clk-mt6797-mm.c
index caacfa40a5bc..5b0a77530b62 100644
--- a/drivers/clk/mediatek/clk-mt6797-mm.c
+++ b/drivers/clk/mediatek/clk-mt6797-mm.c
@@ -93,7 +93,7 @@ MODULE_DEVICE_TABLE(platform, clk_mt6797_mm_id_table);
 
 static struct platform_driver clk_mt6797_mm_drv = {
 	.probe = mtk_clk_pdev_probe,
-	.remove = mtk_clk_pdev_remove,
+	.remove_new = mtk_clk_pdev_remove,
 	.driver = {
 		.name = "clk-mt6797-mm",
 	},
diff --git a/drivers/clk/mediatek/clk-mt8167-mm.c b/drivers/clk/mediatek/clk-mt8167-mm.c
index 4e053c61315d..6472e76567a5 100644
--- a/drivers/clk/mediatek/clk-mt8167-mm.c
+++ b/drivers/clk/mediatek/clk-mt8167-mm.c
@@ -87,7 +87,7 @@ MODULE_DEVICE_TABLE(platform, clk_mt8167_mm_id_table);
 
 static struct platform_driver clk_mt8167_mm_drv = {
 	.probe = mtk_clk_pdev_probe,
-	.remove = mtk_clk_pdev_remove,
+	.remove_new = mtk_clk_pdev_remove,
 	.driver = {
 		.name = "clk-mt8167-mm",
 	},
diff --git a/drivers/clk/mediatek/clk-mt8173-mm.c b/drivers/clk/mediatek/clk-mt8173-mm.c
index 18e466dbf610..ffed6c5bfde2 100644
--- a/drivers/clk/mediatek/clk-mt8173-mm.c
+++ b/drivers/clk/mediatek/clk-mt8173-mm.c
@@ -106,7 +106,7 @@ static struct platform_driver clk_mt8173_mm_drv = {
 	},
 	.id_table = clk_mt8173_mm_id_table,
 	.probe = mtk_clk_pdev_probe,
-	.remove = mtk_clk_pdev_remove,
+	.remove_new = mtk_clk_pdev_remove,
 };
 module_platform_driver(clk_mt8173_mm_drv);
 
diff --git a/drivers/clk/mediatek/clk-mt8183-mm.c b/drivers/clk/mediatek/clk-mt8183-mm.c
index 2f99828bff1b..8aaddcfee568 100644
--- a/drivers/clk/mediatek/clk-mt8183-mm.c
+++ b/drivers/clk/mediatek/clk-mt8183-mm.c
@@ -95,7 +95,7 @@ MODULE_DEVICE_TABLE(platform, clk_mt8183_mm_id_table);
 
 static struct platform_driver clk_mt8183_mm_drv = {
 	.probe = mtk_clk_pdev_probe,
-	.remove = mtk_clk_pdev_remove,
+	.remove_new = mtk_clk_pdev_remove,
 	.driver = {
 		.name = "clk-mt8183-mm",
 	},
diff --git a/drivers/clk/mediatek/clk-mt8186-mm.c b/drivers/clk/mediatek/clk-mt8186-mm.c
index fc3bb6d1f714..44ed504a8069 100644
--- a/drivers/clk/mediatek/clk-mt8186-mm.c
+++ b/drivers/clk/mediatek/clk-mt8186-mm.c
@@ -71,7 +71,7 @@ MODULE_DEVICE_TABLE(platform, clk_mt8186_mm_id_table);
 
 static struct platform_driver clk_mt8186_mm_drv = {
 	.probe = mtk_clk_pdev_probe,
-	.remove = mtk_clk_pdev_remove,
+	.remove_new = mtk_clk_pdev_remove,
 	.driver = {
 		.name = "clk-mt8186-mm",
 	},
diff --git a/drivers/clk/mediatek/clk-mt8188-vdo0.c b/drivers/clk/mediatek/clk-mt8188-vdo0.c
index d2be44c2f3f5..d252e198678c 100644
--- a/drivers/clk/mediatek/clk-mt8188-vdo0.c
+++ b/drivers/clk/mediatek/clk-mt8188-vdo0.c
@@ -97,7 +97,7 @@ MODULE_DEVICE_TABLE(platform, clk_mt8188_vdo0_id_table);
 
 static struct platform_driver clk_mt8188_vdo0_drv = {
 	.probe = mtk_clk_pdev_probe,
-	.remove = mtk_clk_pdev_remove,
+	.remove_new = mtk_clk_pdev_remove,
 	.driver = {
 		.name = "clk-mt8188-vdo0",
 	},
diff --git a/drivers/clk/mediatek/clk-mt8188-vdo1.c b/drivers/clk/mediatek/clk-mt8188-vdo1.c
index 2ef8cae2e16e..7b72d54086db 100644
--- a/drivers/clk/mediatek/clk-mt8188-vdo1.c
+++ b/drivers/clk/mediatek/clk-mt8188-vdo1.c
@@ -144,7 +144,7 @@ MODULE_DEVICE_TABLE(platform, clk_mt8188_vdo1_id_table);
 
 static struct platform_driver clk_mt8188_vdo1_drv = {
 	.probe = mtk_clk_pdev_probe,
-	.remove = mtk_clk_pdev_remove,
+	.remove_new = mtk_clk_pdev_remove,
 	.driver = {
 		.name = "clk-mt8188-vdo1",
 	},
diff --git a/drivers/clk/mediatek/clk-mt8188-vpp0.c b/drivers/clk/mediatek/clk-mt8188-vpp0.c
index 07bdedf6a21a..e7b02b26fefb 100644
--- a/drivers/clk/mediatek/clk-mt8188-vpp0.c
+++ b/drivers/clk/mediatek/clk-mt8188-vpp0.c
@@ -104,7 +104,7 @@ MODULE_DEVICE_TABLE(platform, clk_mt8188_vpp0_id_table);
 
 static struct platform_driver clk_mt8188_vpp0_drv = {
 	.probe = mtk_clk_pdev_probe,
-	.remove = mtk_clk_pdev_remove,
+	.remove_new = mtk_clk_pdev_remove,
 	.driver = {
 		.name = "clk-mt8188-vpp0",
 	},
diff --git a/drivers/clk/mediatek/clk-mt8188-vpp1.c b/drivers/clk/mediatek/clk-mt8188-vpp1.c
index d4e66b240573..e8f0f7eca097 100644
--- a/drivers/clk/mediatek/clk-mt8188-vpp1.c
+++ b/drivers/clk/mediatek/clk-mt8188-vpp1.c
@@ -99,7 +99,7 @@ MODULE_DEVICE_TABLE(platform, clk_mt8188_vpp1_id_table);
 
 static struct platform_driver clk_mt8188_vpp1_drv = {
 	.probe = mtk_clk_pdev_probe,
-	.remove = mtk_clk_pdev_remove,
+	.remove_new = mtk_clk_pdev_remove,
 	.driver = {
 		.name = "clk-mt8188-vpp1",
 	},
diff --git a/drivers/clk/mediatek/clk-mt8192-mm.c b/drivers/clk/mediatek/clk-mt8192-mm.c
index 47335d517714..b294184c5183 100644
--- a/drivers/clk/mediatek/clk-mt8192-mm.c
+++ b/drivers/clk/mediatek/clk-mt8192-mm.c
@@ -93,7 +93,7 @@ MODULE_DEVICE_TABLE(platform, clk_mt8192_mm_id_table);
 
 static struct platform_driver clk_mt8192_mm_drv = {
 	.probe = mtk_clk_pdev_probe,
-	.remove = mtk_clk_pdev_remove,
+	.remove_new = mtk_clk_pdev_remove,
 	.driver = {
 		.name = "clk-mt8192-mm",
 	},
diff --git a/drivers/clk/mediatek/clk-mt8195-vdo0.c b/drivers/clk/mediatek/clk-mt8195-vdo0.c
index 509780750e43..34fc318c146c 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdo0.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdo0.c
@@ -106,7 +106,7 @@ MODULE_DEVICE_TABLE(platform, clk_mt8195_vdo0_id_table);
 
 static struct platform_driver clk_mt8195_vdo0_drv = {
 	.probe = mtk_clk_pdev_probe,
-	.remove = mtk_clk_pdev_remove,
+	.remove_new = mtk_clk_pdev_remove,
 	.driver = {
 		.name = "clk-mt8195-vdo0",
 	},
diff --git a/drivers/clk/mediatek/clk-mt8195-vdo1.c b/drivers/clk/mediatek/clk-mt8195-vdo1.c
index 0a5214a1ed25..e400631e1dbe 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdo1.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdo1.c
@@ -133,7 +133,7 @@ MODULE_DEVICE_TABLE(platform, clk_mt8195_vdo1_id_table);
 
 static struct platform_driver clk_mt8195_vdo1_drv = {
 	.probe = mtk_clk_pdev_probe,
-	.remove = mtk_clk_pdev_remove,
+	.remove_new = mtk_clk_pdev_remove,
 	.driver = {
 		.name = "clk-mt8195-vdo1",
 	},
diff --git a/drivers/clk/mediatek/clk-mt8195-vpp0.c b/drivers/clk/mediatek/clk-mt8195-vpp0.c
index 1a98fb9a25e8..81725fcb3a72 100644
--- a/drivers/clk/mediatek/clk-mt8195-vpp0.c
+++ b/drivers/clk/mediatek/clk-mt8195-vpp0.c
@@ -99,7 +99,7 @@ MODULE_DEVICE_TABLE(platform, clk_mt8195_vpp0_id_table);
 
 static struct platform_driver clk_mt8195_vpp0_drv = {
 	.probe = mtk_clk_pdev_probe,
-	.remove = mtk_clk_pdev_remove,
+	.remove_new = mtk_clk_pdev_remove,
 	.driver = {
 		.name = "clk-mt8195-vpp0",
 	},
diff --git a/drivers/clk/mediatek/clk-mt8195-vpp1.c b/drivers/clk/mediatek/clk-mt8195-vpp1.c
index c2d5b582f53a..867fde4e575b 100644
--- a/drivers/clk/mediatek/clk-mt8195-vpp1.c
+++ b/drivers/clk/mediatek/clk-mt8195-vpp1.c
@@ -97,7 +97,7 @@ MODULE_DEVICE_TABLE(platform, clk_mt8195_vpp1_id_table);
 
 static struct platform_driver clk_mt8195_vpp1_drv = {
 	.probe = mtk_clk_pdev_probe,
-	.remove = mtk_clk_pdev_remove,
+	.remove_new = mtk_clk_pdev_remove,
 	.driver = {
 		.name = "clk-mt8195-vpp1",
 	},
diff --git a/drivers/clk/mediatek/clk-mt8365-mm.c b/drivers/clk/mediatek/clk-mt8365-mm.c
index 44427120846f..01a2ef8f594e 100644
--- a/drivers/clk/mediatek/clk-mt8365-mm.c
+++ b/drivers/clk/mediatek/clk-mt8365-mm.c
@@ -85,7 +85,7 @@ MODULE_DEVICE_TABLE(platform, clk_mt8365_mm_id_table);
 
 static struct platform_driver clk_mt8365_mm_drv = {
 	.probe = mtk_clk_pdev_probe,
-	.remove = mtk_clk_pdev_remove,
+	.remove_new = mtk_clk_pdev_remove,
 	.driver = {
 		.name = "clk-mt8365-mm",
 	},
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 4816da9c6da4..cf3514c8e97e 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -648,14 +648,12 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(mtk_clk_simple_probe);
 
-int mtk_clk_pdev_remove(struct platform_device *pdev)
+void mtk_clk_pdev_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
 
 	__mtk_clk_simple_remove(pdev, node);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(mtk_clk_pdev_remove);
 
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index cc8070a133a4..22096501a60a 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -240,7 +240,7 @@ struct mtk_clk_desc {
 };
 
 int mtk_clk_pdev_probe(struct platform_device *pdev);
-int mtk_clk_pdev_remove(struct platform_device *pdev);
+void mtk_clk_pdev_remove(struct platform_device *pdev);
 int mtk_clk_simple_probe(struct platform_device *pdev);
 void mtk_clk_simple_remove(struct platform_device *pdev);
 
-- 
2.39.2

