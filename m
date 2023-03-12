Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5550C6B681F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjCLQQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjCLQPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:15:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB4F37B5D
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:15:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLw-0007nl-Sw; Sun, 12 Mar 2023 17:15:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLv-003f1X-Co; Sun, 12 Mar 2023 17:15:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLu-004K85-A2; Sun, 12 Mar 2023 17:15:18 +0100
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
Subject: [PATCH 01/30] clk: mediatek: Make mtk_clk_simple_remove() return void
Date:   Sun, 12 Mar 2023 17:14:43 +0100
Message-Id: <20230312161512.2715500-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=65806; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=KsRbqheX8bGJCmbC01rWZIl2ibfXZY+kyfP/fFUm8go=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkDfoVJhBTw1f1/HjTZ0a9gjNMaJuup7459xZ/D TBLrXJQ2x+JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZA36FQAKCRDB/BR4rcrs CSr2CACV3jMpjp8YkAwRgBTOVcgwIponDdsxhzRJcNGNgqC6HCMIM7br4MgeT09UNxMPumWirhJ hAEWldnPn8EeOwdnj9iXTwKycJwijT5n1TC3Bzg5ra2JlHM5OSn2TdTLuSs3gKzrsCAU2xGvUoa TzODX+cyutRzf1BXwz5VBvME8+rKT2nEjUq9P2kS6NPmEoFiX8qhyti5bKpbo58ryNLloIK7GTq e4Y/Ubf6PKOo1vgbWzy5+BdHC8HU8uMo8u54y6pN67OnmXnIyJPCilNsEiqV3tD+rudvXs514Et k7divILLGdQhCcheDZkKSj2UxNob6dL7zEN24CV4YX8WYKSQ
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

mtk_clk_simple_remove() returned zero unconditionally. Make it return no
value instead and convert the respective drivers to .remove_new.

This makes the semantics in the callers of mtk_clk_simple_remove() clearer
and prepares for the quest to make platform driver's remove function return
void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/clk/mediatek/clk-mt2701-aud.c          | 6 +++---
 drivers/clk/mediatek/clk-mt2701-bdp.c          | 2 +-
 drivers/clk/mediatek/clk-mt2701-eth.c          | 2 +-
 drivers/clk/mediatek/clk-mt2701-g3d.c          | 2 +-
 drivers/clk/mediatek/clk-mt2701-hif.c          | 2 +-
 drivers/clk/mediatek/clk-mt2701-img.c          | 2 +-
 drivers/clk/mediatek/clk-mt2701-vdec.c         | 2 +-
 drivers/clk/mediatek/clk-mt2712-bdp.c          | 2 +-
 drivers/clk/mediatek/clk-mt2712-img.c          | 2 +-
 drivers/clk/mediatek/clk-mt2712-jpgdec.c       | 2 +-
 drivers/clk/mediatek/clk-mt2712-mfg.c          | 2 +-
 drivers/clk/mediatek/clk-mt2712-vdec.c         | 2 +-
 drivers/clk/mediatek/clk-mt2712-venc.c         | 2 +-
 drivers/clk/mediatek/clk-mt2712.c              | 2 +-
 drivers/clk/mediatek/clk-mt6765-audio.c        | 2 +-
 drivers/clk/mediatek/clk-mt6765-cam.c          | 2 +-
 drivers/clk/mediatek/clk-mt6765-img.c          | 2 +-
 drivers/clk/mediatek/clk-mt6765-mipi0a.c       | 2 +-
 drivers/clk/mediatek/clk-mt6765-mm.c           | 2 +-
 drivers/clk/mediatek/clk-mt6765-vcodec.c       | 2 +-
 drivers/clk/mediatek/clk-mt6779-aud.c          | 2 +-
 drivers/clk/mediatek/clk-mt6779-cam.c          | 2 +-
 drivers/clk/mediatek/clk-mt6779-img.c          | 2 +-
 drivers/clk/mediatek/clk-mt6779-ipe.c          | 2 +-
 drivers/clk/mediatek/clk-mt6779-mfg.c          | 2 +-
 drivers/clk/mediatek/clk-mt6779-vdec.c         | 2 +-
 drivers/clk/mediatek/clk-mt6779-venc.c         | 2 +-
 drivers/clk/mediatek/clk-mt6779.c              | 2 +-
 drivers/clk/mediatek/clk-mt6795-mfg.c          | 2 +-
 drivers/clk/mediatek/clk-mt6795-topckgen.c     | 2 +-
 drivers/clk/mediatek/clk-mt6795-vdecsys.c      | 2 +-
 drivers/clk/mediatek/clk-mt6795-vencsys.c      | 2 +-
 drivers/clk/mediatek/clk-mt6797-img.c          | 2 +-
 drivers/clk/mediatek/clk-mt6797-vdec.c         | 2 +-
 drivers/clk/mediatek/clk-mt6797-venc.c         | 2 +-
 drivers/clk/mediatek/clk-mt7622-aud.c          | 6 +++---
 drivers/clk/mediatek/clk-mt7622-eth.c          | 2 +-
 drivers/clk/mediatek/clk-mt7622-hif.c          | 2 +-
 drivers/clk/mediatek/clk-mt7629-hif.c          | 2 +-
 drivers/clk/mediatek/clk-mt7981-eth.c          | 2 +-
 drivers/clk/mediatek/clk-mt7981-infracfg.c     | 2 +-
 drivers/clk/mediatek/clk-mt7981-topckgen.c     | 2 +-
 drivers/clk/mediatek/clk-mt7986-topckgen.c     | 2 +-
 drivers/clk/mediatek/clk-mt8173-img.c          | 2 +-
 drivers/clk/mediatek/clk-mt8173-pericfg.c      | 2 +-
 drivers/clk/mediatek/clk-mt8173-topckgen.c     | 2 +-
 drivers/clk/mediatek/clk-mt8173-vdecsys.c      | 2 +-
 drivers/clk/mediatek/clk-mt8173-vencsys.c      | 2 +-
 drivers/clk/mediatek/clk-mt8183-audio.c        | 6 +++---
 drivers/clk/mediatek/clk-mt8183-cam.c          | 2 +-
 drivers/clk/mediatek/clk-mt8183-img.c          | 2 +-
 drivers/clk/mediatek/clk-mt8183-ipu0.c         | 2 +-
 drivers/clk/mediatek/clk-mt8183-ipu1.c         | 2 +-
 drivers/clk/mediatek/clk-mt8183-ipu_adl.c      | 2 +-
 drivers/clk/mediatek/clk-mt8183-ipu_conn.c     | 2 +-
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c       | 2 +-
 drivers/clk/mediatek/clk-mt8183-vdec.c         | 2 +-
 drivers/clk/mediatek/clk-mt8183-venc.c         | 2 +-
 drivers/clk/mediatek/clk-mt8183.c              | 2 +-
 drivers/clk/mediatek/clk-mt8186-cam.c          | 2 +-
 drivers/clk/mediatek/clk-mt8186-img.c          | 2 +-
 drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c | 2 +-
 drivers/clk/mediatek/clk-mt8186-infra_ao.c     | 2 +-
 drivers/clk/mediatek/clk-mt8186-ipe.c          | 2 +-
 drivers/clk/mediatek/clk-mt8186-mdp.c          | 2 +-
 drivers/clk/mediatek/clk-mt8186-mfg.c          | 2 +-
 drivers/clk/mediatek/clk-mt8186-topckgen.c     | 2 +-
 drivers/clk/mediatek/clk-mt8186-vdec.c         | 2 +-
 drivers/clk/mediatek/clk-mt8186-venc.c         | 2 +-
 drivers/clk/mediatek/clk-mt8186-wpe.c          | 2 +-
 drivers/clk/mediatek/clk-mt8192-aud.c          | 6 +++---
 drivers/clk/mediatek/clk-mt8192-cam.c          | 2 +-
 drivers/clk/mediatek/clk-mt8192-img.c          | 2 +-
 drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c | 2 +-
 drivers/clk/mediatek/clk-mt8192-ipe.c          | 2 +-
 drivers/clk/mediatek/clk-mt8192-mdp.c          | 2 +-
 drivers/clk/mediatek/clk-mt8192-mfg.c          | 2 +-
 drivers/clk/mediatek/clk-mt8192-msdc.c         | 2 +-
 drivers/clk/mediatek/clk-mt8192-scp_adsp.c     | 2 +-
 drivers/clk/mediatek/clk-mt8192-vdec.c         | 2 +-
 drivers/clk/mediatek/clk-mt8192-venc.c         | 2 +-
 drivers/clk/mediatek/clk-mt8192.c              | 2 +-
 drivers/clk/mediatek/clk-mt8195-cam.c          | 2 +-
 drivers/clk/mediatek/clk-mt8195-ccu.c          | 2 +-
 drivers/clk/mediatek/clk-mt8195-img.c          | 2 +-
 drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c | 2 +-
 drivers/clk/mediatek/clk-mt8195-infra_ao.c     | 2 +-
 drivers/clk/mediatek/clk-mt8195-ipe.c          | 2 +-
 drivers/clk/mediatek/clk-mt8195-mfg.c          | 2 +-
 drivers/clk/mediatek/clk-mt8195-peri_ao.c      | 2 +-
 drivers/clk/mediatek/clk-mt8195-scp_adsp.c     | 2 +-
 drivers/clk/mediatek/clk-mt8195-vdec.c         | 2 +-
 drivers/clk/mediatek/clk-mt8195-venc.c         | 2 +-
 drivers/clk/mediatek/clk-mt8195-wpe.c          | 2 +-
 drivers/clk/mediatek/clk-mt8365-apu.c          | 2 +-
 drivers/clk/mediatek/clk-mt8365-cam.c          | 2 +-
 drivers/clk/mediatek/clk-mt8365-mfg.c          | 2 +-
 drivers/clk/mediatek/clk-mt8365-vdec.c         | 2 +-
 drivers/clk/mediatek/clk-mt8365-venc.c         | 2 +-
 drivers/clk/mediatek/clk-mtk.c                 | 4 +---
 drivers/clk/mediatek/clk-mtk.h                 | 2 +-
 101 files changed, 109 insertions(+), 111 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701-aud.c b/drivers/clk/mediatek/clk-mt2701-aud.c
index 1a32d8b7db84..218c7586983a 100644
--- a/drivers/clk/mediatek/clk-mt2701-aud.c
+++ b/drivers/clk/mediatek/clk-mt2701-aud.c
@@ -173,15 +173,15 @@ static int clk_mt2701_aud_probe(struct platform_device *pdev)
 	return r;
 }
 
-static int clk_mt2701_aud_remove(struct platform_device *pdev)
+static void clk_mt2701_aud_remove(struct platform_device *pdev)
 {
 	of_platform_depopulate(&pdev->dev);
-	return mtk_clk_simple_remove(pdev);
+	mtk_clk_simple_remove(pdev);
 }
 
 static struct platform_driver clk_mt2701_aud_drv = {
 	.probe = clk_mt2701_aud_probe,
-	.remove = clk_mt2701_aud_remove,
+	.remove_new = clk_mt2701_aud_remove,
 	.driver = {
 		.name = "clk-mt2701-aud",
 		.of_match_table = of_match_clk_mt2701_aud,
diff --git a/drivers/clk/mediatek/clk-mt2701-bdp.c b/drivers/clk/mediatek/clk-mt2701-bdp.c
index 435ed4819d56..cf6a07de5dcb 100644
--- a/drivers/clk/mediatek/clk-mt2701-bdp.c
+++ b/drivers/clk/mediatek/clk-mt2701-bdp.c
@@ -110,7 +110,7 @@ static const struct of_device_id of_match_clk_mt2701_bdp[] = {
 
 static struct platform_driver clk_mt2701_bdp_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2701-bdp",
 		.of_match_table = of_match_clk_mt2701_bdp,
diff --git a/drivers/clk/mediatek/clk-mt2701-eth.c b/drivers/clk/mediatek/clk-mt2701-eth.c
index f3cb78e7f6e9..92576bdb8a5b 100644
--- a/drivers/clk/mediatek/clk-mt2701-eth.c
+++ b/drivers/clk/mediatek/clk-mt2701-eth.c
@@ -58,7 +58,7 @@ static const struct of_device_id of_match_clk_mt2701_eth[] = {
 
 static struct platform_driver clk_mt2701_eth_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2701-eth",
 		.of_match_table = of_match_clk_mt2701_eth,
diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c b/drivers/clk/mediatek/clk-mt2701-g3d.c
index 499a170ba5f9..e5ba06c1b6c4 100644
--- a/drivers/clk/mediatek/clk-mt2701-g3d.c
+++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
@@ -57,7 +57,7 @@ static const struct of_device_id of_match_clk_mt2701_g3d[] = {
 
 static struct platform_driver clk_mt2701_g3d_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2701-g3d",
 		.of_match_table = of_match_clk_mt2701_g3d,
diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
index d5465d782993..466829edd490 100644
--- a/drivers/clk/mediatek/clk-mt2701-hif.c
+++ b/drivers/clk/mediatek/clk-mt2701-hif.c
@@ -55,7 +55,7 @@ static const struct of_device_id of_match_clk_mt2701_hif[] = {
 
 static struct platform_driver clk_mt2701_hif_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2701-hif",
 		.of_match_table = of_match_clk_mt2701_hif,
diff --git a/drivers/clk/mediatek/clk-mt2701-img.c b/drivers/clk/mediatek/clk-mt2701-img.c
index 7e53deb7f990..44df1addc9f5 100644
--- a/drivers/clk/mediatek/clk-mt2701-img.c
+++ b/drivers/clk/mediatek/clk-mt2701-img.c
@@ -52,7 +52,7 @@ static const struct of_device_id of_match_clk_mt2701_img[] = {
 
 static struct platform_driver clk_mt2701_img_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2701-img",
 		.of_match_table = of_match_clk_mt2701_img,
diff --git a/drivers/clk/mediatek/clk-mt2701-vdec.c b/drivers/clk/mediatek/clk-mt2701-vdec.c
index d3089da0ab62..923c43ddee30 100644
--- a/drivers/clk/mediatek/clk-mt2701-vdec.c
+++ b/drivers/clk/mediatek/clk-mt2701-vdec.c
@@ -63,7 +63,7 @@ static const struct of_device_id of_match_clk_mt2701_vdec[] = {
 
 static struct platform_driver clk_mt2701_vdec_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2701-vdec",
 		.of_match_table = of_match_clk_mt2701_vdec,
diff --git a/drivers/clk/mediatek/clk-mt2712-bdp.c b/drivers/clk/mediatek/clk-mt2712-bdp.c
index 684d03e9f6de..3c42427c765a 100644
--- a/drivers/clk/mediatek/clk-mt2712-bdp.c
+++ b/drivers/clk/mediatek/clk-mt2712-bdp.c
@@ -74,7 +74,7 @@ static const struct of_device_id of_match_clk_mt2712_bdp[] = {
 
 static struct platform_driver clk_mt2712_bdp_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2712-bdp",
 		.of_match_table = of_match_clk_mt2712_bdp,
diff --git a/drivers/clk/mediatek/clk-mt2712-img.c b/drivers/clk/mediatek/clk-mt2712-img.c
index 335049cdc856..41c928024e75 100644
--- a/drivers/clk/mediatek/clk-mt2712-img.c
+++ b/drivers/clk/mediatek/clk-mt2712-img.c
@@ -52,7 +52,7 @@ static const struct of_device_id of_match_clk_mt2712_img[] = {
 
 static struct platform_driver clk_mt2712_img_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2712-img",
 		.of_match_table = of_match_clk_mt2712_img,
diff --git a/drivers/clk/mediatek/clk-mt2712-jpgdec.c b/drivers/clk/mediatek/clk-mt2712-jpgdec.c
index 07ba7c5e80af..af133ab42296 100644
--- a/drivers/clk/mediatek/clk-mt2712-jpgdec.c
+++ b/drivers/clk/mediatek/clk-mt2712-jpgdec.c
@@ -48,7 +48,7 @@ static const struct of_device_id of_match_clk_mt2712_jpgdec[] = {
 
 static struct platform_driver clk_mt2712_jpgdec_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2712-jpgdec",
 		.of_match_table = of_match_clk_mt2712_jpgdec,
diff --git a/drivers/clk/mediatek/clk-mt2712-mfg.c b/drivers/clk/mediatek/clk-mt2712-mfg.c
index 42f8cf3ecf4c..d20b7d025e47 100644
--- a/drivers/clk/mediatek/clk-mt2712-mfg.c
+++ b/drivers/clk/mediatek/clk-mt2712-mfg.c
@@ -47,7 +47,7 @@ static const struct of_device_id of_match_clk_mt2712_mfg[] = {
 
 static struct platform_driver clk_mt2712_mfg_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2712-mfg",
 		.of_match_table = of_match_clk_mt2712_mfg,
diff --git a/drivers/clk/mediatek/clk-mt2712-vdec.c b/drivers/clk/mediatek/clk-mt2712-vdec.c
index 6296ed5c5b55..74ebe298c52e 100644
--- a/drivers/clk/mediatek/clk-mt2712-vdec.c
+++ b/drivers/clk/mediatek/clk-mt2712-vdec.c
@@ -66,7 +66,7 @@ static const struct of_device_id of_match_clk_mt2712_vdec[] = {
 
 static struct platform_driver clk_mt2712_vdec_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2712-vdec",
 		.of_match_table = of_match_clk_mt2712_vdec,
diff --git a/drivers/clk/mediatek/clk-mt2712-venc.c b/drivers/clk/mediatek/clk-mt2712-venc.c
index b9bfc35de629..64cda87875ce 100644
--- a/drivers/clk/mediatek/clk-mt2712-venc.c
+++ b/drivers/clk/mediatek/clk-mt2712-venc.c
@@ -49,7 +49,7 @@ static const struct of_device_id of_match_clk_mt2712_venc[] = {
 
 static struct platform_driver clk_mt2712_venc_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2712-venc",
 		.of_match_table = of_match_clk_mt2712_venc,
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index 94f8fc2a4f7b..07f5cf8b0040 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1446,7 +1446,7 @@ static const struct of_device_id of_match_clk_mt2712_simple[] = {
 
 static struct platform_driver clk_mt2712_simple_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2712-simple",
 		.of_match_table = of_match_clk_mt2712_simple,
diff --git a/drivers/clk/mediatek/clk-mt6765-audio.c b/drivers/clk/mediatek/clk-mt6765-audio.c
index 0aa6c0d352ca..504812cf4647 100644
--- a/drivers/clk/mediatek/clk-mt6765-audio.c
+++ b/drivers/clk/mediatek/clk-mt6765-audio.c
@@ -80,7 +80,7 @@ static const struct of_device_id of_match_clk_mt6765_audio[] = {
 
 static struct platform_driver clk_mt6765_audio_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6765-audio",
 		.of_match_table = of_match_clk_mt6765_audio,
diff --git a/drivers/clk/mediatek/clk-mt6765-cam.c b/drivers/clk/mediatek/clk-mt6765-cam.c
index 25f2bef38126..1e0de9422aaa 100644
--- a/drivers/clk/mediatek/clk-mt6765-cam.c
+++ b/drivers/clk/mediatek/clk-mt6765-cam.c
@@ -55,7 +55,7 @@ static const struct of_device_id of_match_clk_mt6765_cam[] = {
 
 static struct platform_driver clk_mt6765_cam_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6765-cam",
 		.of_match_table = of_match_clk_mt6765_cam,
diff --git a/drivers/clk/mediatek/clk-mt6765-img.c b/drivers/clk/mediatek/clk-mt6765-img.c
index a62303ef4f41..284133aac909 100644
--- a/drivers/clk/mediatek/clk-mt6765-img.c
+++ b/drivers/clk/mediatek/clk-mt6765-img.c
@@ -51,7 +51,7 @@ static const struct of_device_id of_match_clk_mt6765_img[] = {
 
 static struct platform_driver clk_mt6765_img_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6765-img",
 		.of_match_table = of_match_clk_mt6765_img,
diff --git a/drivers/clk/mediatek/clk-mt6765-mipi0a.c b/drivers/clk/mediatek/clk-mt6765-mipi0a.c
index 25c829fc3866..ad543b601023 100644
--- a/drivers/clk/mediatek/clk-mt6765-mipi0a.c
+++ b/drivers/clk/mediatek/clk-mt6765-mipi0a.c
@@ -48,7 +48,7 @@ static const struct of_device_id of_match_clk_mt6765_mipi0a[] = {
 
 static struct platform_driver clk_mt6765_mipi0a_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6765-mipi0a",
 		.of_match_table = of_match_clk_mt6765_mipi0a,
diff --git a/drivers/clk/mediatek/clk-mt6765-mm.c b/drivers/clk/mediatek/clk-mt6765-mm.c
index bda774668a36..ef05a7283b4d 100644
--- a/drivers/clk/mediatek/clk-mt6765-mm.c
+++ b/drivers/clk/mediatek/clk-mt6765-mm.c
@@ -77,7 +77,7 @@ static const struct of_device_id of_match_clk_mt6765_mm[] = {
 
 static struct platform_driver clk_mt6765_mm_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6765-mm",
 		.of_match_table = of_match_clk_mt6765_mm,
diff --git a/drivers/clk/mediatek/clk-mt6765-vcodec.c b/drivers/clk/mediatek/clk-mt6765-vcodec.c
index 2bc1fbde87da..87ddfdafaa7a 100644
--- a/drivers/clk/mediatek/clk-mt6765-vcodec.c
+++ b/drivers/clk/mediatek/clk-mt6765-vcodec.c
@@ -50,7 +50,7 @@ static const struct of_device_id of_match_clk_mt6765_vcodec[] = {
 
 static struct platform_driver clk_mt6765_vcodec_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6765-vcodec",
 		.of_match_table = of_match_clk_mt6765_vcodec,
diff --git a/drivers/clk/mediatek/clk-mt6779-aud.c b/drivers/clk/mediatek/clk-mt6779-aud.c
index 6e473ae1fd90..03a258682ff7 100644
--- a/drivers/clk/mediatek/clk-mt6779-aud.c
+++ b/drivers/clk/mediatek/clk-mt6779-aud.c
@@ -105,7 +105,7 @@ static const struct of_device_id of_match_clk_mt6779_aud[] = {
 
 static struct platform_driver clk_mt6779_aud_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6779-aud",
 		.of_match_table = of_match_clk_mt6779_aud,
diff --git a/drivers/clk/mediatek/clk-mt6779-cam.c b/drivers/clk/mediatek/clk-mt6779-cam.c
index 7be3db90fa4a..b57f577e28dd 100644
--- a/drivers/clk/mediatek/clk-mt6779-cam.c
+++ b/drivers/clk/mediatek/clk-mt6779-cam.c
@@ -54,7 +54,7 @@ static const struct of_device_id of_match_clk_mt6779_cam[] = {
 
 static struct platform_driver clk_mt6779_cam_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6779-cam",
 		.of_match_table = of_match_clk_mt6779_cam,
diff --git a/drivers/clk/mediatek/clk-mt6779-img.c b/drivers/clk/mediatek/clk-mt6779-img.c
index 9bc51fc82dbd..468c254be1cc 100644
--- a/drivers/clk/mediatek/clk-mt6779-img.c
+++ b/drivers/clk/mediatek/clk-mt6779-img.c
@@ -46,7 +46,7 @@ static const struct of_device_id of_match_clk_mt6779_img[] = {
 
 static struct platform_driver clk_mt6779_img_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6779-img",
 		.of_match_table = of_match_clk_mt6779_img,
diff --git a/drivers/clk/mediatek/clk-mt6779-ipe.c b/drivers/clk/mediatek/clk-mt6779-ipe.c
index 92e9d1ade422..b7d3c25f6f8e 100644
--- a/drivers/clk/mediatek/clk-mt6779-ipe.c
+++ b/drivers/clk/mediatek/clk-mt6779-ipe.c
@@ -48,7 +48,7 @@ static const struct of_device_id of_match_clk_mt6779_ipe[] = {
 
 static struct platform_driver clk_mt6779_ipe_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6779-ipe",
 		.of_match_table = of_match_clk_mt6779_ipe,
diff --git a/drivers/clk/mediatek/clk-mt6779-mfg.c b/drivers/clk/mediatek/clk-mt6779-mfg.c
index efc793a1969a..b60868e03d63 100644
--- a/drivers/clk/mediatek/clk-mt6779-mfg.c
+++ b/drivers/clk/mediatek/clk-mt6779-mfg.c
@@ -43,7 +43,7 @@ static const struct of_device_id of_match_clk_mt6779_mfg[] = {
 
 static struct platform_driver clk_mt6779_mfg_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6779-mfg",
 		.of_match_table = of_match_clk_mt6779_mfg,
diff --git a/drivers/clk/mediatek/clk-mt6779-vdec.c b/drivers/clk/mediatek/clk-mt6779-vdec.c
index 3209a6518d5b..24e8064795bd 100644
--- a/drivers/clk/mediatek/clk-mt6779-vdec.c
+++ b/drivers/clk/mediatek/clk-mt6779-vdec.c
@@ -55,7 +55,7 @@ static const struct of_device_id of_match_clk_mt6779_vdec[] = {
 
 static struct platform_driver clk_mt6779_vdec_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6779-vdec",
 		.of_match_table = of_match_clk_mt6779_vdec,
diff --git a/drivers/clk/mediatek/clk-mt6779-venc.c b/drivers/clk/mediatek/clk-mt6779-venc.c
index c25035c0f334..f51e1299ce26 100644
--- a/drivers/clk/mediatek/clk-mt6779-venc.c
+++ b/drivers/clk/mediatek/clk-mt6779-venc.c
@@ -46,7 +46,7 @@ static const struct of_device_id of_match_clk_mt6779_venc[] = {
 
 static struct platform_driver clk_mt6779_venc_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6779-venc",
 		.of_match_table = of_match_clk_mt6779_venc,
diff --git a/drivers/clk/mediatek/clk-mt6779.c b/drivers/clk/mediatek/clk-mt6779.c
index 827025d127d9..63b7d68de13b 100644
--- a/drivers/clk/mediatek/clk-mt6779.c
+++ b/drivers/clk/mediatek/clk-mt6779.c
@@ -1302,7 +1302,7 @@ static const struct of_device_id of_match_clk_mt6779_infra[] = {
 
 static struct platform_driver clk_mt6779_infra_drv  = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6779-infra",
 		.of_match_table = of_match_clk_mt6779_infra,
diff --git a/drivers/clk/mediatek/clk-mt6795-mfg.c b/drivers/clk/mediatek/clk-mt6795-mfg.c
index ee7aab24eb24..239c2a286cc4 100644
--- a/drivers/clk/mediatek/clk-mt6795-mfg.c
+++ b/drivers/clk/mediatek/clk-mt6795-mfg.c
@@ -42,7 +42,7 @@ static struct platform_driver clk_mt6795_mfg_drv = {
 		.of_match_table = of_match_clk_mt6795_mfg,
 	},
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 };
 module_platform_driver(clk_mt6795_mfg_drv);
 
diff --git a/drivers/clk/mediatek/clk-mt6795-topckgen.c b/drivers/clk/mediatek/clk-mt6795-topckgen.c
index e80fa588e309..7e54233e7b19 100644
--- a/drivers/clk/mediatek/clk-mt6795-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt6795-topckgen.c
@@ -546,7 +546,7 @@ static struct platform_driver clk_mt6795_topckgen_drv = {
 		.of_match_table = of_match_clk_mt6795_topckgen,
 	},
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 };
 module_platform_driver(clk_mt6795_topckgen_drv);
 
diff --git a/drivers/clk/mediatek/clk-mt6795-vdecsys.c b/drivers/clk/mediatek/clk-mt6795-vdecsys.c
index d85d04e0d016..bbc800512ac5 100644
--- a/drivers/clk/mediatek/clk-mt6795-vdecsys.c
+++ b/drivers/clk/mediatek/clk-mt6795-vdecsys.c
@@ -43,7 +43,7 @@ static const struct of_device_id of_match_clk_mt6795_vdecsys[] = {
 
 static struct platform_driver clk_mt6795_vdecsys_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6795-vdecsys",
 		.of_match_table = of_match_clk_mt6795_vdecsys,
diff --git a/drivers/clk/mediatek/clk-mt6795-vencsys.c b/drivers/clk/mediatek/clk-mt6795-vencsys.c
index de40a982ca96..5eb6fd540d13 100644
--- a/drivers/clk/mediatek/clk-mt6795-vencsys.c
+++ b/drivers/clk/mediatek/clk-mt6795-vencsys.c
@@ -42,7 +42,7 @@ static struct platform_driver clk_mt6795_vencsys_drv = {
 		.of_match_table = of_match_clk_mt6795_vencsys,
 	},
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 };
 module_platform_driver(clk_mt6795_vencsys_drv);
 
diff --git a/drivers/clk/mediatek/clk-mt6797-img.c b/drivers/clk/mediatek/clk-mt6797-img.c
index 7c6a53fbb8be..eddf9ab1d443 100644
--- a/drivers/clk/mediatek/clk-mt6797-img.c
+++ b/drivers/clk/mediatek/clk-mt6797-img.c
@@ -48,7 +48,7 @@ static const struct of_device_id of_match_clk_mt6797_img[] = {
 
 static struct platform_driver clk_mt6797_img_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6797-img",
 		.of_match_table = of_match_clk_mt6797_img,
diff --git a/drivers/clk/mediatek/clk-mt6797-vdec.c b/drivers/clk/mediatek/clk-mt6797-vdec.c
index 6120fccc859f..983471d71d0e 100644
--- a/drivers/clk/mediatek/clk-mt6797-vdec.c
+++ b/drivers/clk/mediatek/clk-mt6797-vdec.c
@@ -65,7 +65,7 @@ static const struct of_device_id of_match_clk_mt6797_vdec[] = {
 
 static struct platform_driver clk_mt6797_vdec_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6797-vdec",
 		.of_match_table = of_match_clk_mt6797_vdec,
diff --git a/drivers/clk/mediatek/clk-mt6797-venc.c b/drivers/clk/mediatek/clk-mt6797-venc.c
index 834d3834d2bb..1120e25ef10f 100644
--- a/drivers/clk/mediatek/clk-mt6797-venc.c
+++ b/drivers/clk/mediatek/clk-mt6797-venc.c
@@ -50,7 +50,7 @@ static const struct of_device_id of_match_clk_mt6797_venc[] = {
 
 static struct platform_driver clk_mt6797_venc_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6797-venc",
 		.of_match_table = of_match_clk_mt6797_venc,
diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
index b8aabfeb1cba..663680f6f1cd 100644
--- a/drivers/clk/mediatek/clk-mt7622-aud.c
+++ b/drivers/clk/mediatek/clk-mt7622-aud.c
@@ -159,10 +159,10 @@ static int clk_mt7622_aud_probe(struct platform_device *pdev)
 	return r;
 }
 
-static int clk_mt7622_aud_remove(struct platform_device *pdev)
+static void clk_mt7622_aud_remove(struct platform_device *pdev)
 {
 	of_platform_depopulate(&pdev->dev);
-	return mtk_clk_simple_remove(pdev);
+	mtk_clk_simple_remove(pdev);
 }
 
 static const struct of_device_id of_match_clk_mt7622_aud[] = {
@@ -172,7 +172,7 @@ static const struct of_device_id of_match_clk_mt7622_aud[] = {
 
 static struct platform_driver clk_mt7622_aud_drv = {
 	.probe = clk_mt7622_aud_probe,
-	.remove = clk_mt7622_aud_remove,
+	.remove_new = clk_mt7622_aud_remove,
 	.driver = {
 		.name = "clk-mt7622-aud",
 		.of_match_table = of_match_clk_mt7622_aud,
diff --git a/drivers/clk/mediatek/clk-mt7622-eth.c b/drivers/clk/mediatek/clk-mt7622-eth.c
index aee583fa77d0..bb98c3d21968 100644
--- a/drivers/clk/mediatek/clk-mt7622-eth.c
+++ b/drivers/clk/mediatek/clk-mt7622-eth.c
@@ -92,7 +92,7 @@ static const struct of_device_id of_match_clk_mt7622_eth[] = {
 
 static struct platform_driver clk_mt7622_eth_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt7622-eth",
 		.of_match_table = of_match_clk_mt7622_eth,
diff --git a/drivers/clk/mediatek/clk-mt7622-hif.c b/drivers/clk/mediatek/clk-mt7622-hif.c
index ab5cad0c2b1c..b3673838b04b 100644
--- a/drivers/clk/mediatek/clk-mt7622-hif.c
+++ b/drivers/clk/mediatek/clk-mt7622-hif.c
@@ -104,7 +104,7 @@ static const struct of_device_id of_match_clk_mt7622_hif[] = {
 
 static struct platform_driver clk_mt7622_hif_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt7622-hif",
 		.of_match_table = of_match_clk_mt7622_hif,
diff --git a/drivers/clk/mediatek/clk-mt7629-hif.c b/drivers/clk/mediatek/clk-mt7629-hif.c
index c3eb09ea6036..879c449be122 100644
--- a/drivers/clk/mediatek/clk-mt7629-hif.c
+++ b/drivers/clk/mediatek/clk-mt7629-hif.c
@@ -99,7 +99,7 @@ static const struct of_device_id of_match_clk_mt7629_hif[] = {
 
 static struct platform_driver clk_mt7629_hif_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt7629-hif",
 		.of_match_table = of_match_clk_mt7629_hif,
diff --git a/drivers/clk/mediatek/clk-mt7981-eth.c b/drivers/clk/mediatek/clk-mt7981-eth.c
index 773350911be2..8c95713e0e32 100644
--- a/drivers/clk/mediatek/clk-mt7981-eth.c
+++ b/drivers/clk/mediatek/clk-mt7981-eth.c
@@ -108,7 +108,7 @@ static const struct of_device_id of_match_clk_mt7981_eth[] = {
 
 static struct platform_driver clk_mt7981_eth_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt7981-eth",
 		.of_match_table = of_match_clk_mt7981_eth,
diff --git a/drivers/clk/mediatek/clk-mt7981-infracfg.c b/drivers/clk/mediatek/clk-mt7981-infracfg.c
index 8cf5057419e8..15b84919afe0 100644
--- a/drivers/clk/mediatek/clk-mt7981-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7981-infracfg.c
@@ -198,7 +198,7 @@ static const struct of_device_id of_match_clk_mt7981_infracfg[] = {
 
 static struct platform_driver clk_mt7981_infracfg_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt7981-infracfg",
 		.of_match_table = of_match_clk_mt7981_infracfg,
diff --git a/drivers/clk/mediatek/clk-mt7981-topckgen.c b/drivers/clk/mediatek/clk-mt7981-topckgen.c
index 74634d65f5f6..7ed7d8bff245 100644
--- a/drivers/clk/mediatek/clk-mt7981-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt7981-topckgen.c
@@ -413,7 +413,7 @@ static const struct of_device_id of_match_clk_mt7981_topckgen[] = {
 
 static struct platform_driver clk_mt7981_topckgen_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt7981-topckgen",
 		.of_match_table = of_match_clk_mt7981_topckgen,
diff --git a/drivers/clk/mediatek/clk-mt7986-topckgen.c b/drivers/clk/mediatek/clk-mt7986-topckgen.c
index dff9976fa689..ac793027c903 100644
--- a/drivers/clk/mediatek/clk-mt7986-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt7986-topckgen.c
@@ -307,7 +307,7 @@ static const struct of_device_id of_match_clk_mt7986_topckgen[] = {
 
 static struct platform_driver clk_mt7986_topckgen_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt7986-topckgen",
 		.of_match_table = of_match_clk_mt7986_topckgen,
diff --git a/drivers/clk/mediatek/clk-mt8173-img.c b/drivers/clk/mediatek/clk-mt8173-img.c
index 7b50ffb7a8a5..f5fe7b6bd066 100644
--- a/drivers/clk/mediatek/clk-mt8173-img.c
+++ b/drivers/clk/mediatek/clk-mt8173-img.c
@@ -43,7 +43,7 @@ static const struct of_device_id of_match_clk_mt8173_imgsys[] = {
 
 static struct platform_driver clk_mt8173_vdecsys_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8173-imgsys",
 		.of_match_table = of_match_clk_mt8173_imgsys,
diff --git a/drivers/clk/mediatek/clk-mt8173-pericfg.c b/drivers/clk/mediatek/clk-mt8173-pericfg.c
index e87294b72c2c..a8f7b744af60 100644
--- a/drivers/clk/mediatek/clk-mt8173-pericfg.c
+++ b/drivers/clk/mediatek/clk-mt8173-pericfg.c
@@ -114,7 +114,7 @@ static struct platform_driver clk_mt8173_pericfg_drv = {
 		.of_match_table = of_match_clk_mt8173_pericfg,
 	},
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 };
 module_platform_driver(clk_mt8173_pericfg_drv);
 
diff --git a/drivers/clk/mediatek/clk-mt8173-topckgen.c b/drivers/clk/mediatek/clk-mt8173-topckgen.c
index 257961528fe2..32d5d8a822f5 100644
--- a/drivers/clk/mediatek/clk-mt8173-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8173-topckgen.c
@@ -645,7 +645,7 @@ static struct platform_driver clk_mt8173_topckgen_drv = {
 		.of_match_table = of_match_clk_mt8173_topckgen,
 	},
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 };
 module_platform_driver(clk_mt8173_topckgen_drv);
 
diff --git a/drivers/clk/mediatek/clk-mt8173-vdecsys.c b/drivers/clk/mediatek/clk-mt8173-vdecsys.c
index 5105b8e0969d..0d3f1eb1c3d1 100644
--- a/drivers/clk/mediatek/clk-mt8173-vdecsys.c
+++ b/drivers/clk/mediatek/clk-mt8173-vdecsys.c
@@ -45,7 +45,7 @@ static const struct of_device_id of_match_clk_mt8173_vdecsys[] = {
 
 static struct platform_driver clk_mt8173_vdecsys_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8173-vdecsys",
 		.of_match_table = of_match_clk_mt8173_vdecsys,
diff --git a/drivers/clk/mediatek/clk-mt8173-vencsys.c b/drivers/clk/mediatek/clk-mt8173-vencsys.c
index ff4f1cb735de..aefd9a46e991 100644
--- a/drivers/clk/mediatek/clk-mt8173-vencsys.c
+++ b/drivers/clk/mediatek/clk-mt8173-vencsys.c
@@ -56,7 +56,7 @@ static struct platform_driver clk_mt8173_vencsys_drv = {
 		.of_match_table = of_match_clk_mt8173_vencsys,
 	},
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 };
 module_platform_driver(clk_mt8173_vencsys_drv);
 
diff --git a/drivers/clk/mediatek/clk-mt8183-audio.c b/drivers/clk/mediatek/clk-mt8183-audio.c
index 3f1630290b93..b53ec528bf8f 100644
--- a/drivers/clk/mediatek/clk-mt8183-audio.c
+++ b/drivers/clk/mediatek/clk-mt8183-audio.c
@@ -87,10 +87,10 @@ static int clk_mt8183_audio_probe(struct platform_device *pdev)
 	return r;
 }
 
-static int clk_mt8183_audio_remove(struct platform_device *pdev)
+static void clk_mt8183_audio_remove(struct platform_device *pdev)
 {
 	of_platform_depopulate(&pdev->dev);
-	return mtk_clk_simple_remove(pdev);
+	mtk_clk_simple_remove(pdev);
 }
 
 static const struct of_device_id of_match_clk_mt8183_audio[] = {
@@ -100,7 +100,7 @@ static const struct of_device_id of_match_clk_mt8183_audio[] = {
 
 static struct platform_driver clk_mt8183_audio_drv = {
 	.probe = clk_mt8183_audio_probe,
-	.remove = clk_mt8183_audio_remove,
+	.remove_new = clk_mt8183_audio_remove,
 	.driver = {
 		.name = "clk-mt8183-audio",
 		.of_match_table = of_match_clk_mt8183_audio,
diff --git a/drivers/clk/mediatek/clk-mt8183-cam.c b/drivers/clk/mediatek/clk-mt8183-cam.c
index 6907b1a6a824..d3f41f7017e2 100644
--- a/drivers/clk/mediatek/clk-mt8183-cam.c
+++ b/drivers/clk/mediatek/clk-mt8183-cam.c
@@ -50,7 +50,7 @@ static const struct of_device_id of_match_clk_mt8183_cam[] = {
 
 static struct platform_driver clk_mt8183_cam_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8183-cam",
 		.of_match_table = of_match_clk_mt8183_cam,
diff --git a/drivers/clk/mediatek/clk-mt8183-img.c b/drivers/clk/mediatek/clk-mt8183-img.c
index 8d884425d79f..8561c8c46481 100644
--- a/drivers/clk/mediatek/clk-mt8183-img.c
+++ b/drivers/clk/mediatek/clk-mt8183-img.c
@@ -50,7 +50,7 @@ static const struct of_device_id of_match_clk_mt8183_img[] = {
 
 static struct platform_driver clk_mt8183_img_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8183-img",
 		.of_match_table = of_match_clk_mt8183_img,
diff --git a/drivers/clk/mediatek/clk-mt8183-ipu0.c b/drivers/clk/mediatek/clk-mt8183-ipu0.c
index 953a8a33d048..0076998307b7 100644
--- a/drivers/clk/mediatek/clk-mt8183-ipu0.c
+++ b/drivers/clk/mediatek/clk-mt8183-ipu0.c
@@ -43,7 +43,7 @@ static const struct of_device_id of_match_clk_mt8183_ipu_core0[] = {
 
 static struct platform_driver clk_mt8183_ipu_core0_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8183-ipu_core0",
 		.of_match_table = of_match_clk_mt8183_ipu_core0,
diff --git a/drivers/clk/mediatek/clk-mt8183-ipu1.c b/drivers/clk/mediatek/clk-mt8183-ipu1.c
index 221d12265974..b92d177d9473 100644
--- a/drivers/clk/mediatek/clk-mt8183-ipu1.c
+++ b/drivers/clk/mediatek/clk-mt8183-ipu1.c
@@ -43,7 +43,7 @@ static const struct of_device_id of_match_clk_mt8183_ipu_core1[] = {
 
 static struct platform_driver clk_mt8183_ipu_core1_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8183-ipu_core1",
 		.of_match_table = of_match_clk_mt8183_ipu_core1,
diff --git a/drivers/clk/mediatek/clk-mt8183-ipu_adl.c b/drivers/clk/mediatek/clk-mt8183-ipu_adl.c
index 8c4fd96df821..ac12b4febddd 100644
--- a/drivers/clk/mediatek/clk-mt8183-ipu_adl.c
+++ b/drivers/clk/mediatek/clk-mt8183-ipu_adl.c
@@ -41,7 +41,7 @@ static const struct of_device_id of_match_clk_mt8183_ipu_adl[] = {
 
 static struct platform_driver clk_mt8183_ipu_adl_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8183-ipu_adl",
 		.of_match_table = of_match_clk_mt8183_ipu_adl,
diff --git a/drivers/clk/mediatek/clk-mt8183-ipu_conn.c b/drivers/clk/mediatek/clk-mt8183-ipu_conn.c
index 14a4c3ff82a1..528729fa62e2 100644
--- a/drivers/clk/mediatek/clk-mt8183-ipu_conn.c
+++ b/drivers/clk/mediatek/clk-mt8183-ipu_conn.c
@@ -110,7 +110,7 @@ static const struct of_device_id of_match_clk_mt8183_ipu_conn[] = {
 
 static struct platform_driver clk_mt8183_ipu_conn_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8183-ipu_conn",
 		.of_match_table = of_match_clk_mt8183_ipu_conn,
diff --git a/drivers/clk/mediatek/clk-mt8183-mfgcfg.c b/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
index 730c9ae5ea12..fc23ac2b2d17 100644
--- a/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
+++ b/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
@@ -42,7 +42,7 @@ static const struct of_device_id of_match_clk_mt8183_mfg[] = {
 
 static struct platform_driver clk_mt8183_mfg_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8183-mfg",
 		.of_match_table = of_match_clk_mt8183_mfg,
diff --git a/drivers/clk/mediatek/clk-mt8183-vdec.c b/drivers/clk/mediatek/clk-mt8183-vdec.c
index c294e50b96b7..9c1c325ee513 100644
--- a/drivers/clk/mediatek/clk-mt8183-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8183-vdec.c
@@ -54,7 +54,7 @@ static const struct of_device_id of_match_clk_mt8183_vdec[] = {
 
 static struct platform_driver clk_mt8183_vdec_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8183-vdec",
 		.of_match_table = of_match_clk_mt8183_vdec,
diff --git a/drivers/clk/mediatek/clk-mt8183-venc.c b/drivers/clk/mediatek/clk-mt8183-venc.c
index 0051c5d92fc5..da883ed74ea6 100644
--- a/drivers/clk/mediatek/clk-mt8183-venc.c
+++ b/drivers/clk/mediatek/clk-mt8183-venc.c
@@ -46,7 +46,7 @@ static const struct of_device_id of_match_clk_mt8183_venc[] = {
 
 static struct platform_driver clk_mt8183_venc_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8183-venc",
 		.of_match_table = of_match_clk_mt8183_venc,
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 722d913f0b4d..41581715a951 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -1254,7 +1254,7 @@ static const struct of_device_id of_match_clk_mt8183_simple[] = {
 
 static struct platform_driver clk_mt8183_simple_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8183-simple",
 		.of_match_table = of_match_clk_mt8183_simple,
diff --git a/drivers/clk/mediatek/clk-mt8186-cam.c b/drivers/clk/mediatek/clk-mt8186-cam.c
index 9ec345a2ce66..7b1b9455b2c8 100644
--- a/drivers/clk/mediatek/clk-mt8186-cam.c
+++ b/drivers/clk/mediatek/clk-mt8186-cam.c
@@ -81,7 +81,7 @@ static const struct of_device_id of_match_clk_mt8186_cam[] = {
 
 static struct platform_driver clk_mt8186_cam_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8186-cam",
 		.of_match_table = of_match_clk_mt8186_cam,
diff --git a/drivers/clk/mediatek/clk-mt8186-img.c b/drivers/clk/mediatek/clk-mt8186-img.c
index 08a625475aee..dd9ae2891556 100644
--- a/drivers/clk/mediatek/clk-mt8186-img.c
+++ b/drivers/clk/mediatek/clk-mt8186-img.c
@@ -59,7 +59,7 @@ static const struct of_device_id of_match_clk_mt8186_img[] = {
 
 static struct platform_driver clk_mt8186_img_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8186-img",
 		.of_match_table = of_match_clk_mt8186_img,
diff --git a/drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c
index 47f2e480a05e..d2933d69cc1c 100644
--- a/drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c
+++ b/drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c
@@ -58,7 +58,7 @@ static const struct of_device_id of_match_clk_mt8186_imp_iic_wrap[] = {
 
 static struct platform_driver clk_mt8186_imp_iic_wrap_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8186-imp_iic_wrap",
 		.of_match_table = of_match_clk_mt8186_imp_iic_wrap,
diff --git a/drivers/clk/mediatek/clk-mt8186-infra_ao.c b/drivers/clk/mediatek/clk-mt8186-infra_ao.c
index df2a6bd1aefa..49a7fb24ac1b 100644
--- a/drivers/clk/mediatek/clk-mt8186-infra_ao.c
+++ b/drivers/clk/mediatek/clk-mt8186-infra_ao.c
@@ -230,7 +230,7 @@ static const struct of_device_id of_match_clk_mt8186_infra_ao[] = {
 
 static struct platform_driver clk_mt8186_infra_ao_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8186-infra-ao",
 		.of_match_table = of_match_clk_mt8186_infra_ao,
diff --git a/drivers/clk/mediatek/clk-mt8186-ipe.c b/drivers/clk/mediatek/clk-mt8186-ipe.c
index 8fca148effa6..1530614c0668 100644
--- a/drivers/clk/mediatek/clk-mt8186-ipe.c
+++ b/drivers/clk/mediatek/clk-mt8186-ipe.c
@@ -46,7 +46,7 @@ static const struct of_device_id of_match_clk_mt8186_ipe[] = {
 
 static struct platform_driver clk_mt8186_ipe_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8186-ipe",
 		.of_match_table = of_match_clk_mt8186_ipe,
diff --git a/drivers/clk/mediatek/clk-mt8186-mdp.c b/drivers/clk/mediatek/clk-mt8186-mdp.c
index 05174088ef20..32b5a69cd310 100644
--- a/drivers/clk/mediatek/clk-mt8186-mdp.c
+++ b/drivers/clk/mediatek/clk-mt8186-mdp.c
@@ -71,7 +71,7 @@ static const struct of_device_id of_match_clk_mt8186_mdp[] = {
 
 static struct platform_driver clk_mt8186_mdp_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8186-mdp",
 		.of_match_table = of_match_clk_mt8186_mdp,
diff --git a/drivers/clk/mediatek/clk-mt8186-mfg.c b/drivers/clk/mediatek/clk-mt8186-mfg.c
index 0142d741053a..f58919bd47ac 100644
--- a/drivers/clk/mediatek/clk-mt8186-mfg.c
+++ b/drivers/clk/mediatek/clk-mt8186-mfg.c
@@ -40,7 +40,7 @@ static const struct of_device_id of_match_clk_mt8186_mfg[] = {
 
 static struct platform_driver clk_mt8186_mfg_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8186-mfg",
 		.of_match_table = of_match_clk_mt8186_mfg,
diff --git a/drivers/clk/mediatek/clk-mt8186-topckgen.c b/drivers/clk/mediatek/clk-mt8186-topckgen.c
index c6786c8b315f..632d54bcb1b3 100644
--- a/drivers/clk/mediatek/clk-mt8186-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8186-topckgen.c
@@ -724,7 +724,7 @@ static const struct of_device_id of_match_clk_mt8186_topck[] = {
 
 static struct platform_driver clk_mt8186_topck_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8186-topck",
 		.of_match_table = of_match_clk_mt8186_topck,
diff --git a/drivers/clk/mediatek/clk-mt8186-vdec.c b/drivers/clk/mediatek/clk-mt8186-vdec.c
index 5ad7e1ae0bac..4379fc958408 100644
--- a/drivers/clk/mediatek/clk-mt8186-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8186-vdec.c
@@ -79,7 +79,7 @@ static const struct of_device_id of_match_clk_mt8186_vdec[] = {
 
 static struct platform_driver clk_mt8186_vdec_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8186-vdec",
 		.of_match_table = of_match_clk_mt8186_vdec,
diff --git a/drivers/clk/mediatek/clk-mt8186-venc.c b/drivers/clk/mediatek/clk-mt8186-venc.c
index f5519f794c45..ec502adfadad 100644
--- a/drivers/clk/mediatek/clk-mt8186-venc.c
+++ b/drivers/clk/mediatek/clk-mt8186-venc.c
@@ -42,7 +42,7 @@ static const struct of_device_id of_match_clk_mt8186_venc[] = {
 
 static struct platform_driver clk_mt8186_venc_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8186-venc",
 		.of_match_table = of_match_clk_mt8186_venc,
diff --git a/drivers/clk/mediatek/clk-mt8186-wpe.c b/drivers/clk/mediatek/clk-mt8186-wpe.c
index 8db3e9178a1e..23a47fcb2782 100644
--- a/drivers/clk/mediatek/clk-mt8186-wpe.c
+++ b/drivers/clk/mediatek/clk-mt8186-wpe.c
@@ -42,7 +42,7 @@ static const struct of_device_id of_match_clk_mt8186_wpe[] = {
 
 static struct platform_driver clk_mt8186_wpe_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8186-wpe",
 		.of_match_table = of_match_clk_mt8186_wpe,
diff --git a/drivers/clk/mediatek/clk-mt8192-aud.c b/drivers/clk/mediatek/clk-mt8192-aud.c
index 29affb68e854..8b8c4057c82f 100644
--- a/drivers/clk/mediatek/clk-mt8192-aud.c
+++ b/drivers/clk/mediatek/clk-mt8192-aud.c
@@ -97,10 +97,10 @@ static int clk_mt8192_aud_probe(struct platform_device *pdev)
 	return r;
 }
 
-static int clk_mt8192_aud_remove(struct platform_device *pdev)
+static void clk_mt8192_aud_remove(struct platform_device *pdev)
 {
 	of_platform_depopulate(&pdev->dev);
-	return mtk_clk_simple_remove(pdev);
+	mtk_clk_simple_remove(pdev);
 }
 
 static const struct of_device_id of_match_clk_mt8192_aud[] = {
@@ -110,7 +110,7 @@ static const struct of_device_id of_match_clk_mt8192_aud[] = {
 
 static struct platform_driver clk_mt8192_aud_drv = {
 	.probe = clk_mt8192_aud_probe,
-	.remove = clk_mt8192_aud_remove,
+	.remove_new = clk_mt8192_aud_remove,
 	.driver = {
 		.name = "clk-mt8192-aud",
 		.of_match_table = of_match_clk_mt8192_aud,
diff --git a/drivers/clk/mediatek/clk-mt8192-cam.c b/drivers/clk/mediatek/clk-mt8192-cam.c
index 90b57d46eef7..eb5052a9b149 100644
--- a/drivers/clk/mediatek/clk-mt8192-cam.c
+++ b/drivers/clk/mediatek/clk-mt8192-cam.c
@@ -98,7 +98,7 @@ static const struct of_device_id of_match_clk_mt8192_cam[] = {
 
 static struct platform_driver clk_mt8192_cam_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-cam",
 		.of_match_table = of_match_clk_mt8192_cam,
diff --git a/drivers/clk/mediatek/clk-mt8192-img.c b/drivers/clk/mediatek/clk-mt8192-img.c
index da82d65a7650..de69711ad09d 100644
--- a/drivers/clk/mediatek/clk-mt8192-img.c
+++ b/drivers/clk/mediatek/clk-mt8192-img.c
@@ -61,7 +61,7 @@ static const struct of_device_id of_match_clk_mt8192_img[] = {
 
 static struct platform_driver clk_mt8192_img_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-img",
 		.of_match_table = of_match_clk_mt8192_img,
diff --git a/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
index ff8e20bb44bb..f9473d6c4c14 100644
--- a/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
+++ b/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
@@ -110,7 +110,7 @@ static const struct of_device_id of_match_clk_mt8192_imp_iic_wrap[] = {
 
 static struct platform_driver clk_mt8192_imp_iic_wrap_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-imp_iic_wrap",
 		.of_match_table = of_match_clk_mt8192_imp_iic_wrap,
diff --git a/drivers/clk/mediatek/clk-mt8192-ipe.c b/drivers/clk/mediatek/clk-mt8192-ipe.c
index 0225abe4170a..823bdf49735e 100644
--- a/drivers/clk/mediatek/clk-mt8192-ipe.c
+++ b/drivers/clk/mediatek/clk-mt8192-ipe.c
@@ -48,7 +48,7 @@ static const struct of_device_id of_match_clk_mt8192_ipe[] = {
 
 static struct platform_driver clk_mt8192_ipe_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-ipe",
 		.of_match_table = of_match_clk_mt8192_ipe,
diff --git a/drivers/clk/mediatek/clk-mt8192-mdp.c b/drivers/clk/mediatek/clk-mt8192-mdp.c
index 4675788d7816..50ee62829bd7 100644
--- a/drivers/clk/mediatek/clk-mt8192-mdp.c
+++ b/drivers/clk/mediatek/clk-mt8192-mdp.c
@@ -73,7 +73,7 @@ static const struct of_device_id of_match_clk_mt8192_mdp[] = {
 
 static struct platform_driver clk_mt8192_mdp_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-mdp",
 		.of_match_table = of_match_clk_mt8192_mdp,
diff --git a/drivers/clk/mediatek/clk-mt8192-mfg.c b/drivers/clk/mediatek/clk-mt8192-mfg.c
index ec5b44ffa458..3f4274e25103 100644
--- a/drivers/clk/mediatek/clk-mt8192-mfg.c
+++ b/drivers/clk/mediatek/clk-mt8192-mfg.c
@@ -43,7 +43,7 @@ static const struct of_device_id of_match_clk_mt8192_mfg[] = {
 
 static struct platform_driver clk_mt8192_mfg_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-mfg",
 		.of_match_table = of_match_clk_mt8192_mfg,
diff --git a/drivers/clk/mediatek/clk-mt8192-msdc.c b/drivers/clk/mediatek/clk-mt8192-msdc.c
index a72e1b73fce8..971c7259857a 100644
--- a/drivers/clk/mediatek/clk-mt8192-msdc.c
+++ b/drivers/clk/mediatek/clk-mt8192-msdc.c
@@ -55,7 +55,7 @@ static const struct of_device_id of_match_clk_mt8192_msdc[] = {
 
 static struct platform_driver clk_mt8192_msdc_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-msdc",
 		.of_match_table = of_match_clk_mt8192_msdc,
diff --git a/drivers/clk/mediatek/clk-mt8192-scp_adsp.c b/drivers/clk/mediatek/clk-mt8192-scp_adsp.c
index 18a8679108b8..60cb7f64f8b5 100644
--- a/drivers/clk/mediatek/clk-mt8192-scp_adsp.c
+++ b/drivers/clk/mediatek/clk-mt8192-scp_adsp.c
@@ -41,7 +41,7 @@ static const struct of_device_id of_match_clk_mt8192_scp_adsp[] = {
 
 static struct platform_driver clk_mt8192_scp_adsp_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-scp_adsp",
 		.of_match_table = of_match_clk_mt8192_scp_adsp,
diff --git a/drivers/clk/mediatek/clk-mt8192-vdec.c b/drivers/clk/mediatek/clk-mt8192-vdec.c
index e149962dbbf9..5aaf31f24483 100644
--- a/drivers/clk/mediatek/clk-mt8192-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8192-vdec.c
@@ -85,7 +85,7 @@ static const struct of_device_id of_match_clk_mt8192_vdec[] = {
 
 static struct platform_driver clk_mt8192_vdec_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-vdec",
 		.of_match_table = of_match_clk_mt8192_vdec,
diff --git a/drivers/clk/mediatek/clk-mt8192-venc.c b/drivers/clk/mediatek/clk-mt8192-venc.c
index 80b8bb170996..be301abad23c 100644
--- a/drivers/clk/mediatek/clk-mt8192-venc.c
+++ b/drivers/clk/mediatek/clk-mt8192-venc.c
@@ -44,7 +44,7 @@ static const struct of_device_id of_match_clk_mt8192_venc[] = {
 
 static struct platform_driver clk_mt8192_venc_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-venc",
 		.of_match_table = of_match_clk_mt8192_venc,
diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index 61299960d28a..d370bcb69be0 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -1154,7 +1154,7 @@ static const struct of_device_id of_match_clk_mt8192_simple[] = {
 
 static struct platform_driver clk_mt8192_simple_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-simple",
 		.of_match_table = of_match_clk_mt8192_simple,
diff --git a/drivers/clk/mediatek/clk-mt8195-cam.c b/drivers/clk/mediatek/clk-mt8195-cam.c
index e4d00fe6e757..a105e0ca6c12 100644
--- a/drivers/clk/mediatek/clk-mt8195-cam.c
+++ b/drivers/clk/mediatek/clk-mt8195-cam.c
@@ -134,7 +134,7 @@ static const struct of_device_id of_match_clk_mt8195_cam[] = {
 
 static struct platform_driver clk_mt8195_cam_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-cam",
 		.of_match_table = of_match_clk_mt8195_cam,
diff --git a/drivers/clk/mediatek/clk-mt8195-ccu.c b/drivers/clk/mediatek/clk-mt8195-ccu.c
index 4e326b6301ba..b378e1d89bde 100644
--- a/drivers/clk/mediatek/clk-mt8195-ccu.c
+++ b/drivers/clk/mediatek/clk-mt8195-ccu.c
@@ -42,7 +42,7 @@ static const struct of_device_id of_match_clk_mt8195_ccu[] = {
 
 static struct platform_driver clk_mt8195_ccu_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-ccu",
 		.of_match_table = of_match_clk_mt8195_ccu,
diff --git a/drivers/clk/mediatek/clk-mt8195-img.c b/drivers/clk/mediatek/clk-mt8195-img.c
index 12f5c436d075..f09719a4275b 100644
--- a/drivers/clk/mediatek/clk-mt8195-img.c
+++ b/drivers/clk/mediatek/clk-mt8195-img.c
@@ -88,7 +88,7 @@ static const struct of_device_id of_match_clk_mt8195_img[] = {
 
 static struct platform_driver clk_mt8195_img_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-img",
 		.of_match_table = of_match_clk_mt8195_img,
diff --git a/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
index fbc809d05072..e1f86d7d1495 100644
--- a/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
+++ b/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
@@ -58,7 +58,7 @@ static const struct of_device_id of_match_clk_mt8195_imp_iic_wrap[] = {
 
 static struct platform_driver clk_mt8195_imp_iic_wrap_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-imp_iic_wrap",
 		.of_match_table = of_match_clk_mt8195_imp_iic_wrap,
diff --git a/drivers/clk/mediatek/clk-mt8195-infra_ao.c b/drivers/clk/mediatek/clk-mt8195-infra_ao.c
index fcd410461d3b..e62e8f5f446a 100644
--- a/drivers/clk/mediatek/clk-mt8195-infra_ao.c
+++ b/drivers/clk/mediatek/clk-mt8195-infra_ao.c
@@ -232,7 +232,7 @@ static const struct of_device_id of_match_clk_mt8195_infra_ao[] = {
 
 static struct platform_driver clk_mt8195_infra_ao_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-infra_ao",
 		.of_match_table = of_match_clk_mt8195_infra_ao,
diff --git a/drivers/clk/mediatek/clk-mt8195-ipe.c b/drivers/clk/mediatek/clk-mt8195-ipe.c
index b0d745cf7752..13a81353438c 100644
--- a/drivers/clk/mediatek/clk-mt8195-ipe.c
+++ b/drivers/clk/mediatek/clk-mt8195-ipe.c
@@ -43,7 +43,7 @@ static const struct of_device_id of_match_clk_mt8195_ipe[] = {
 
 static struct platform_driver clk_mt8195_ipe_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-ipe",
 		.of_match_table = of_match_clk_mt8195_ipe,
diff --git a/drivers/clk/mediatek/clk-mt8195-mfg.c b/drivers/clk/mediatek/clk-mt8195-mfg.c
index c94cb71bd9b9..4a696e86083a 100644
--- a/drivers/clk/mediatek/clk-mt8195-mfg.c
+++ b/drivers/clk/mediatek/clk-mt8195-mfg.c
@@ -41,7 +41,7 @@ static const struct of_device_id of_match_clk_mt8195_mfg[] = {
 
 static struct platform_driver clk_mt8195_mfg_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-mfg",
 		.of_match_table = of_match_clk_mt8195_mfg,
diff --git a/drivers/clk/mediatek/clk-mt8195-peri_ao.c b/drivers/clk/mediatek/clk-mt8195-peri_ao.c
index 2f6b3bb657db..140d0fad8342 100644
--- a/drivers/clk/mediatek/clk-mt8195-peri_ao.c
+++ b/drivers/clk/mediatek/clk-mt8195-peri_ao.c
@@ -54,7 +54,7 @@ static const struct of_device_id of_match_clk_mt8195_peri_ao[] = {
 
 static struct platform_driver clk_mt8195_peri_ao_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-peri_ao",
 		.of_match_table = of_match_clk_mt8195_peri_ao,
diff --git a/drivers/clk/mediatek/clk-mt8195-scp_adsp.c b/drivers/clk/mediatek/clk-mt8195-scp_adsp.c
index e16c383f631b..dfd9e159150a 100644
--- a/drivers/clk/mediatek/clk-mt8195-scp_adsp.c
+++ b/drivers/clk/mediatek/clk-mt8195-scp_adsp.c
@@ -39,7 +39,7 @@ static const struct of_device_id of_match_clk_mt8195_scp_adsp[] = {
 
 static struct platform_driver clk_mt8195_scp_adsp_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-scp_adsp",
 		.of_match_table = of_match_clk_mt8195_scp_adsp,
diff --git a/drivers/clk/mediatek/clk-mt8195-vdec.c b/drivers/clk/mediatek/clk-mt8195-vdec.c
index a1446b666385..224c479f5cf9 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdec.c
@@ -96,7 +96,7 @@ static const struct of_device_id of_match_clk_mt8195_vdec[] = {
 
 static struct platform_driver clk_mt8195_vdec_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-vdec",
 		.of_match_table = of_match_clk_mt8195_vdec,
diff --git a/drivers/clk/mediatek/clk-mt8195-venc.c b/drivers/clk/mediatek/clk-mt8195-venc.c
index 622f57804f96..d489e419ad87 100644
--- a/drivers/clk/mediatek/clk-mt8195-venc.c
+++ b/drivers/clk/mediatek/clk-mt8195-venc.c
@@ -61,7 +61,7 @@ static const struct of_device_id of_match_clk_mt8195_venc[] = {
 
 static struct platform_driver clk_mt8195_venc_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-venc",
 		.of_match_table = of_match_clk_mt8195_venc,
diff --git a/drivers/clk/mediatek/clk-mt8195-wpe.c b/drivers/clk/mediatek/clk-mt8195-wpe.c
index b483fab10e18..ec4efe542566 100644
--- a/drivers/clk/mediatek/clk-mt8195-wpe.c
+++ b/drivers/clk/mediatek/clk-mt8195-wpe.c
@@ -135,7 +135,7 @@ static const struct of_device_id of_match_clk_mt8195_wpe[] = {
 
 static struct platform_driver clk_mt8195_wpe_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-wpe",
 		.of_match_table = of_match_clk_mt8195_wpe,
diff --git a/drivers/clk/mediatek/clk-mt8365-apu.c b/drivers/clk/mediatek/clk-mt8365-apu.c
index 91ffe89d9721..dd785668c241 100644
--- a/drivers/clk/mediatek/clk-mt8365-apu.c
+++ b/drivers/clk/mediatek/clk-mt8365-apu.c
@@ -45,7 +45,7 @@ static const struct of_device_id of_match_clk_mt8365_apu[] = {
 
 static struct platform_driver clk_mt8365_apu_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8365-apu",
 		.of_match_table = of_match_clk_mt8365_apu,
diff --git a/drivers/clk/mediatek/clk-mt8365-cam.c b/drivers/clk/mediatek/clk-mt8365-cam.c
index 31d5b5cd6de1..3757ef43bbf0 100644
--- a/drivers/clk/mediatek/clk-mt8365-cam.c
+++ b/drivers/clk/mediatek/clk-mt8365-cam.c
@@ -47,7 +47,7 @@ static const struct of_device_id of_match_clk_mt8365_cam[] = {
 
 static struct platform_driver clk_mt8365_cam_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8365-cam",
 		.of_match_table = of_match_clk_mt8365_cam,
diff --git a/drivers/clk/mediatek/clk-mt8365-mfg.c b/drivers/clk/mediatek/clk-mt8365-mfg.c
index 587b49128b03..a63e289ddfa6 100644
--- a/drivers/clk/mediatek/clk-mt8365-mfg.c
+++ b/drivers/clk/mediatek/clk-mt8365-mfg.c
@@ -53,7 +53,7 @@ static const struct of_device_id of_match_clk_mt8365_mfg[] = {
 
 static struct platform_driver clk_mt8365_mfg_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8365-mfg",
 		.of_match_table = of_match_clk_mt8365_mfg,
diff --git a/drivers/clk/mediatek/clk-mt8365-vdec.c b/drivers/clk/mediatek/clk-mt8365-vdec.c
index cdc678e8941c..780c4c6887c7 100644
--- a/drivers/clk/mediatek/clk-mt8365-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8365-vdec.c
@@ -53,7 +53,7 @@ static const struct of_device_id of_match_clk_mt8365_vdec[] = {
 
 static struct platform_driver clk_mt8365_vdec_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8365-vdec",
 		.of_match_table = of_match_clk_mt8365_vdec,
diff --git a/drivers/clk/mediatek/clk-mt8365-venc.c b/drivers/clk/mediatek/clk-mt8365-venc.c
index 0e080c22119d..5bc81f5468c1 100644
--- a/drivers/clk/mediatek/clk-mt8365-venc.c
+++ b/drivers/clk/mediatek/clk-mt8365-venc.c
@@ -42,7 +42,7 @@ static const struct of_device_id of_match_clk_mt8365_venc[] = {
 
 static struct platform_driver clk_mt8365_venc_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8365-venc",
 		.of_match_table = of_match_clk_mt8365_venc,
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 14e8b64a32a3..388bd0843930 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -584,7 +584,7 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(mtk_clk_simple_probe);
 
-int mtk_clk_simple_remove(struct platform_device *pdev)
+void mtk_clk_simple_remove(struct platform_device *pdev)
 {
 	const struct mtk_clk_desc *mcd = of_device_get_match_data(&pdev->dev);
 	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
@@ -606,8 +606,6 @@ int mtk_clk_simple_remove(struct platform_device *pdev)
 		mtk_clk_unregister_fixed_clks(mcd->fixed_clks,
 					      mcd->num_fixed_clks, clk_data);
 	mtk_free_clk_data(clk_data);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(mtk_clk_simple_remove);
 
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 41f4fa3b0c21..3c14dc1030e1 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -237,6 +237,6 @@ struct mtk_clk_desc {
 };
 
 int mtk_clk_simple_probe(struct platform_device *pdev);
-int mtk_clk_simple_remove(struct platform_device *pdev);
+void mtk_clk_simple_remove(struct platform_device *pdev);
 
 #endif /* __DRV_CLK_MTK_H */
-- 
2.39.1

