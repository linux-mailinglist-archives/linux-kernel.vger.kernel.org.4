Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442086F2A64
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 21:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjD3TDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 15:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjD3TC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 15:02:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CE9213F
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 12:02:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ptCJk-00010A-PC; Sun, 30 Apr 2023 21:02:40 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ptCJk-000Bkc-63; Sun, 30 Apr 2023 21:02:40 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ptCJi-000CVb-Lo; Sun, 30 Apr 2023 21:02:38 +0200
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
Subject: [PATCH v2 1/3] clk: mediatek: Make mtk_clk_simple_remove() return void
Date:   Sun, 30 Apr 2023 21:02:31 +0200
Message-Id: <20230430190233.878921-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230430190233.878921-1-u.kleine-koenig@pengutronix.de>
References: <20230430190233.878921-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=80773; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=4E56TWYJOpbepgRTffffjI5QlyuOU/OnNLcgrirk5Ac=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkTrtDDA8lQPeRjJg4IbQiQyylHdQw62I9plVTq Thf8y4tNQOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZE67QwAKCRCPgPtYfRL+ TjrhCACiWFewSNZKY0LchOAV4TJ5zkCeC/i+Qpyu3N1XuU6hWQW6EyVHQcGlmaXCZ61sSgDIlSd RN2WVr4gqtAHZhqnFZkOx7qhSz32Aw01p7sMtUEx0/fY0xN7Gh1eimxxHELknkRXZDBIcbeJSy8 nBVk5DqjKB8eFU+KWps1JQT18dxHnrO9EuQrvZbC7NZ9ofHkV+Fpqxv6ziHNEvH5OK2SBc4Uv5b 4x/xOGMJqUvNqygohzSvQrQZFXPeL+RvGPbDs08QY6dG82pn08xn2PltqGGuSWQ/KMCRptJRdG/ OG74N4eLRfgtS7OomqKIVFDOYkP0vvD3DD73OmGylX8NkPQ+
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

__mtk_clk_simple_remove() and so also mtk_clk_simple_remove() return
zero unconditionally. Make them return no value instead and convert the
drivers making use of it to platform_driver's .remove_new().

This makes the semantics in the callers of mtk_clk_simple_remove() clearer
and prepares for the quest to make platform driver's remove function return
void. There is no semantic change.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/clk/mediatek/clk-mt2701-aud.c           |  6 +++---
 drivers/clk/mediatek/clk-mt2701-bdp.c           |  2 +-
 drivers/clk/mediatek/clk-mt2701-eth.c           |  2 +-
 drivers/clk/mediatek/clk-mt2701-g3d.c           |  2 +-
 drivers/clk/mediatek/clk-mt2701-hif.c           |  2 +-
 drivers/clk/mediatek/clk-mt2701-img.c           |  2 +-
 drivers/clk/mediatek/clk-mt2701-vdec.c          |  2 +-
 drivers/clk/mediatek/clk-mt2712-bdp.c           |  2 +-
 drivers/clk/mediatek/clk-mt2712-img.c           |  2 +-
 drivers/clk/mediatek/clk-mt2712-jpgdec.c        |  2 +-
 drivers/clk/mediatek/clk-mt2712-mfg.c           |  2 +-
 drivers/clk/mediatek/clk-mt2712-vdec.c          |  2 +-
 drivers/clk/mediatek/clk-mt2712-venc.c          |  2 +-
 drivers/clk/mediatek/clk-mt2712.c               |  2 +-
 drivers/clk/mediatek/clk-mt6765-audio.c         |  2 +-
 drivers/clk/mediatek/clk-mt6765-cam.c           |  2 +-
 drivers/clk/mediatek/clk-mt6765-img.c           |  2 +-
 drivers/clk/mediatek/clk-mt6765-mipi0a.c        |  2 +-
 drivers/clk/mediatek/clk-mt6765-mm.c            |  2 +-
 drivers/clk/mediatek/clk-mt6765-vcodec.c        |  2 +-
 drivers/clk/mediatek/clk-mt6779-aud.c           |  2 +-
 drivers/clk/mediatek/clk-mt6779-cam.c           |  2 +-
 drivers/clk/mediatek/clk-mt6779-img.c           |  2 +-
 drivers/clk/mediatek/clk-mt6779-ipe.c           |  2 +-
 drivers/clk/mediatek/clk-mt6779-mfg.c           |  2 +-
 drivers/clk/mediatek/clk-mt6779-vdec.c          |  2 +-
 drivers/clk/mediatek/clk-mt6779-venc.c          |  2 +-
 drivers/clk/mediatek/clk-mt6779.c               |  2 +-
 drivers/clk/mediatek/clk-mt6795-mfg.c           |  2 +-
 drivers/clk/mediatek/clk-mt6795-topckgen.c      |  2 +-
 drivers/clk/mediatek/clk-mt6795-vdecsys.c       |  2 +-
 drivers/clk/mediatek/clk-mt6795-vencsys.c       |  2 +-
 drivers/clk/mediatek/clk-mt6797-img.c           |  2 +-
 drivers/clk/mediatek/clk-mt6797-vdec.c          |  2 +-
 drivers/clk/mediatek/clk-mt6797-venc.c          |  2 +-
 drivers/clk/mediatek/clk-mt7622-aud.c           |  6 +++---
 drivers/clk/mediatek/clk-mt7622-eth.c           |  2 +-
 drivers/clk/mediatek/clk-mt7622-hif.c           |  2 +-
 drivers/clk/mediatek/clk-mt7622.c               |  2 +-
 drivers/clk/mediatek/clk-mt7629-hif.c           |  2 +-
 drivers/clk/mediatek/clk-mt7981-eth.c           |  2 +-
 drivers/clk/mediatek/clk-mt7981-infracfg.c      |  2 +-
 drivers/clk/mediatek/clk-mt7981-topckgen.c      |  2 +-
 drivers/clk/mediatek/clk-mt7986-eth.c           |  2 +-
 drivers/clk/mediatek/clk-mt7986-infracfg.c      |  2 +-
 drivers/clk/mediatek/clk-mt7986-topckgen.c      |  2 +-
 drivers/clk/mediatek/clk-mt8135.c               |  2 +-
 drivers/clk/mediatek/clk-mt8167-aud.c           |  2 +-
 drivers/clk/mediatek/clk-mt8167-img.c           |  2 +-
 drivers/clk/mediatek/clk-mt8167-mfgcfg.c        |  2 +-
 drivers/clk/mediatek/clk-mt8167-vdec.c          |  2 +-
 drivers/clk/mediatek/clk-mt8167.c               |  2 +-
 drivers/clk/mediatek/clk-mt8173-img.c           |  2 +-
 drivers/clk/mediatek/clk-mt8173-pericfg.c       |  2 +-
 drivers/clk/mediatek/clk-mt8173-topckgen.c      |  2 +-
 drivers/clk/mediatek/clk-mt8173-vdecsys.c       |  2 +-
 drivers/clk/mediatek/clk-mt8173-vencsys.c       |  2 +-
 drivers/clk/mediatek/clk-mt8183-audio.c         |  6 +++---
 drivers/clk/mediatek/clk-mt8183-cam.c           |  2 +-
 drivers/clk/mediatek/clk-mt8183-img.c           |  2 +-
 drivers/clk/mediatek/clk-mt8183-ipu0.c          |  2 +-
 drivers/clk/mediatek/clk-mt8183-ipu1.c          |  2 +-
 drivers/clk/mediatek/clk-mt8183-ipu_adl.c       |  2 +-
 drivers/clk/mediatek/clk-mt8183-ipu_conn.c      |  2 +-
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c        |  2 +-
 drivers/clk/mediatek/clk-mt8183-vdec.c          |  2 +-
 drivers/clk/mediatek/clk-mt8183-venc.c          |  2 +-
 drivers/clk/mediatek/clk-mt8183.c               |  2 +-
 drivers/clk/mediatek/clk-mt8186-cam.c           |  2 +-
 drivers/clk/mediatek/clk-mt8186-img.c           |  2 +-
 drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c  |  2 +-
 drivers/clk/mediatek/clk-mt8186-infra_ao.c      |  2 +-
 drivers/clk/mediatek/clk-mt8186-ipe.c           |  2 +-
 drivers/clk/mediatek/clk-mt8186-mcu.c           |  2 +-
 drivers/clk/mediatek/clk-mt8186-mdp.c           |  2 +-
 drivers/clk/mediatek/clk-mt8186-mfg.c           |  2 +-
 drivers/clk/mediatek/clk-mt8186-topckgen.c      |  2 +-
 drivers/clk/mediatek/clk-mt8186-vdec.c          |  2 +-
 drivers/clk/mediatek/clk-mt8186-venc.c          |  2 +-
 drivers/clk/mediatek/clk-mt8186-wpe.c           |  2 +-
 drivers/clk/mediatek/clk-mt8188-adsp_audio26m.c |  2 +-
 drivers/clk/mediatek/clk-mt8188-cam.c           |  2 +-
 drivers/clk/mediatek/clk-mt8188-ccu.c           |  2 +-
 drivers/clk/mediatek/clk-mt8188-img.c           |  2 +-
 drivers/clk/mediatek/clk-mt8188-imp_iic_wrap.c  |  2 +-
 drivers/clk/mediatek/clk-mt8188-infra_ao.c      |  2 +-
 drivers/clk/mediatek/clk-mt8188-ipe.c           |  2 +-
 drivers/clk/mediatek/clk-mt8188-mfg.c           |  2 +-
 drivers/clk/mediatek/clk-mt8188-peri_ao.c       |  2 +-
 drivers/clk/mediatek/clk-mt8188-vdec.c          |  2 +-
 drivers/clk/mediatek/clk-mt8188-venc.c          |  2 +-
 drivers/clk/mediatek/clk-mt8188-wpe.c           |  2 +-
 drivers/clk/mediatek/clk-mt8192-aud.c           |  6 +++---
 drivers/clk/mediatek/clk-mt8192-cam.c           |  2 +-
 drivers/clk/mediatek/clk-mt8192-img.c           |  2 +-
 drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c  |  2 +-
 drivers/clk/mediatek/clk-mt8192-ipe.c           |  2 +-
 drivers/clk/mediatek/clk-mt8192-mdp.c           |  2 +-
 drivers/clk/mediatek/clk-mt8192-mfg.c           |  2 +-
 drivers/clk/mediatek/clk-mt8192-msdc.c          |  2 +-
 drivers/clk/mediatek/clk-mt8192-scp_adsp.c      |  2 +-
 drivers/clk/mediatek/clk-mt8192-vdec.c          |  2 +-
 drivers/clk/mediatek/clk-mt8192-venc.c          |  2 +-
 drivers/clk/mediatek/clk-mt8192.c               |  2 +-
 drivers/clk/mediatek/clk-mt8195-cam.c           |  2 +-
 drivers/clk/mediatek/clk-mt8195-ccu.c           |  2 +-
 drivers/clk/mediatek/clk-mt8195-img.c           |  2 +-
 drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c  |  2 +-
 drivers/clk/mediatek/clk-mt8195-infra_ao.c      |  2 +-
 drivers/clk/mediatek/clk-mt8195-ipe.c           |  2 +-
 drivers/clk/mediatek/clk-mt8195-mfg.c           |  2 +-
 drivers/clk/mediatek/clk-mt8195-peri_ao.c       |  2 +-
 drivers/clk/mediatek/clk-mt8195-scp_adsp.c      |  2 +-
 drivers/clk/mediatek/clk-mt8195-vdec.c          |  2 +-
 drivers/clk/mediatek/clk-mt8195-venc.c          |  2 +-
 drivers/clk/mediatek/clk-mt8195-wpe.c           |  2 +-
 drivers/clk/mediatek/clk-mt8365-apu.c           |  2 +-
 drivers/clk/mediatek/clk-mt8365-cam.c           |  2 +-
 drivers/clk/mediatek/clk-mt8365-mfg.c           |  2 +-
 drivers/clk/mediatek/clk-mt8365-vdec.c          |  2 +-
 drivers/clk/mediatek/clk-mt8365-venc.c          |  2 +-
 drivers/clk/mediatek/clk-mt8365.c               |  2 +-
 drivers/clk/mediatek/clk-mt8516-aud.c           |  2 +-
 drivers/clk/mediatek/clk-mt8516.c               |  2 +-
 drivers/clk/mediatek/clk-mtk.c                  | 12 ++++++------
 drivers/clk/mediatek/clk-mtk.h                  |  2 +-
 126 files changed, 139 insertions(+), 139 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701-aud.c b/drivers/clk/mediatek/clk-mt2701-aud.c
index 5cd343b98685..3ce7e71196fd 100644
--- a/drivers/clk/mediatek/clk-mt2701-aud.c
+++ b/drivers/clk/mediatek/clk-mt2701-aud.c
@@ -150,15 +150,15 @@ static int clk_mt2701_aud_probe(struct platform_device *pdev)
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
index 4c5b70d48df9..b25703ec8dc0 100644
--- a/drivers/clk/mediatek/clk-mt2701-bdp.c
+++ b/drivers/clk/mediatek/clk-mt2701-bdp.c
@@ -99,7 +99,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt2701_bdp);
 
 static struct platform_driver clk_mt2701_bdp_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2701-bdp",
 		.of_match_table = of_match_clk_mt2701_bdp,
diff --git a/drivers/clk/mediatek/clk-mt2701-eth.c b/drivers/clk/mediatek/clk-mt2701-eth.c
index 9a1fb0c93964..056d1e8459da 100644
--- a/drivers/clk/mediatek/clk-mt2701-eth.c
+++ b/drivers/clk/mediatek/clk-mt2701-eth.c
@@ -53,7 +53,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt2701_eth);
 
 static struct platform_driver clk_mt2701_eth_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2701-eth",
 		.of_match_table = of_match_clk_mt2701_eth,
diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c b/drivers/clk/mediatek/clk-mt2701-g3d.c
index c0006861a317..e03ac76279ba 100644
--- a/drivers/clk/mediatek/clk-mt2701-g3d.c
+++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
@@ -52,7 +52,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt2701_g3d);
 
 static struct platform_driver clk_mt2701_g3d_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2701-g3d",
 		.of_match_table = of_match_clk_mt2701_g3d,
diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
index ff7c0b3228e4..cbd5ece3e9e9 100644
--- a/drivers/clk/mediatek/clk-mt2701-hif.c
+++ b/drivers/clk/mediatek/clk-mt2701-hif.c
@@ -50,7 +50,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt2701_hif);
 
 static struct platform_driver clk_mt2701_hif_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2701-hif",
 		.of_match_table = of_match_clk_mt2701_hif,
diff --git a/drivers/clk/mediatek/clk-mt2701-img.c b/drivers/clk/mediatek/clk-mt2701-img.c
index baa1194eb01e..2768360b213e 100644
--- a/drivers/clk/mediatek/clk-mt2701-img.c
+++ b/drivers/clk/mediatek/clk-mt2701-img.c
@@ -47,7 +47,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt2701_img);
 
 static struct platform_driver clk_mt2701_img_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2701-img",
 		.of_match_table = of_match_clk_mt2701_img,
diff --git a/drivers/clk/mediatek/clk-mt2701-vdec.c b/drivers/clk/mediatek/clk-mt2701-vdec.c
index b7f97bc51c16..57711b953b7f 100644
--- a/drivers/clk/mediatek/clk-mt2701-vdec.c
+++ b/drivers/clk/mediatek/clk-mt2701-vdec.c
@@ -52,7 +52,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt2701_vdec);
 
 static struct platform_driver clk_mt2701_vdec_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2701-vdec",
 		.of_match_table = of_match_clk_mt2701_vdec,
diff --git a/drivers/clk/mediatek/clk-mt2712-bdp.c b/drivers/clk/mediatek/clk-mt2712-bdp.c
index f78e01819316..1b54b1f3808d 100644
--- a/drivers/clk/mediatek/clk-mt2712-bdp.c
+++ b/drivers/clk/mediatek/clk-mt2712-bdp.c
@@ -69,7 +69,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt2712_bdp);
 
 static struct platform_driver clk_mt2712_bdp_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2712-bdp",
 		.of_match_table = of_match_clk_mt2712_bdp,
diff --git a/drivers/clk/mediatek/clk-mt2712-img.c b/drivers/clk/mediatek/clk-mt2712-img.c
index fbe7084886a0..1fecc0f68f0e 100644
--- a/drivers/clk/mediatek/clk-mt2712-img.c
+++ b/drivers/clk/mediatek/clk-mt2712-img.c
@@ -47,7 +47,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt2712_img);
 
 static struct platform_driver clk_mt2712_img_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2712-img",
 		.of_match_table = of_match_clk_mt2712_img,
diff --git a/drivers/clk/mediatek/clk-mt2712-jpgdec.c b/drivers/clk/mediatek/clk-mt2712-jpgdec.c
index 7e8c2ebcdee0..019080d6d0f0 100644
--- a/drivers/clk/mediatek/clk-mt2712-jpgdec.c
+++ b/drivers/clk/mediatek/clk-mt2712-jpgdec.c
@@ -43,7 +43,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt2712_jpgdec);
 
 static struct platform_driver clk_mt2712_jpgdec_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2712-jpgdec",
 		.of_match_table = of_match_clk_mt2712_jpgdec,
diff --git a/drivers/clk/mediatek/clk-mt2712-mfg.c b/drivers/clk/mediatek/clk-mt2712-mfg.c
index 932ea449d299..39161516cf21 100644
--- a/drivers/clk/mediatek/clk-mt2712-mfg.c
+++ b/drivers/clk/mediatek/clk-mt2712-mfg.c
@@ -42,7 +42,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt2712_mfg);
 
 static struct platform_driver clk_mt2712_mfg_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2712-mfg",
 		.of_match_table = of_match_clk_mt2712_mfg,
diff --git a/drivers/clk/mediatek/clk-mt2712-vdec.c b/drivers/clk/mediatek/clk-mt2712-vdec.c
index 2fc1f82ebf5d..e1dd38fc2b3c 100644
--- a/drivers/clk/mediatek/clk-mt2712-vdec.c
+++ b/drivers/clk/mediatek/clk-mt2712-vdec.c
@@ -55,7 +55,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt2712_vdec);
 
 static struct platform_driver clk_mt2712_vdec_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2712-vdec",
 		.of_match_table = of_match_clk_mt2712_vdec,
diff --git a/drivers/clk/mediatek/clk-mt2712-venc.c b/drivers/clk/mediatek/clk-mt2712-venc.c
index 6d053a00cf95..ef6608a5db38 100644
--- a/drivers/clk/mediatek/clk-mt2712-venc.c
+++ b/drivers/clk/mediatek/clk-mt2712-venc.c
@@ -44,7 +44,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt2712_venc);
 
 static struct platform_driver clk_mt2712_venc_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2712-venc",
 		.of_match_table = of_match_clk_mt2712_venc,
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index 74c529f6163d..c4cc68c47af9 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -995,7 +995,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt2712);
 
 static struct platform_driver clk_mt2712_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2712",
 		.of_match_table = of_match_clk_mt2712,
diff --git a/drivers/clk/mediatek/clk-mt6765-audio.c b/drivers/clk/mediatek/clk-mt6765-audio.c
index 9e98d6997329..901bf793c272 100644
--- a/drivers/clk/mediatek/clk-mt6765-audio.c
+++ b/drivers/clk/mediatek/clk-mt6765-audio.c
@@ -69,7 +69,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt6765_audio);
 
 static struct platform_driver clk_mt6765_audio_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6765-audio",
 		.of_match_table = of_match_clk_mt6765_audio,
diff --git a/drivers/clk/mediatek/clk-mt6765-cam.c b/drivers/clk/mediatek/clk-mt6765-cam.c
index 6f6b29d8b29a..19cedfa832bc 100644
--- a/drivers/clk/mediatek/clk-mt6765-cam.c
+++ b/drivers/clk/mediatek/clk-mt6765-cam.c
@@ -50,7 +50,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt6765_cam);
 
 static struct platform_driver clk_mt6765_cam_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6765-cam",
 		.of_match_table = of_match_clk_mt6765_cam,
diff --git a/drivers/clk/mediatek/clk-mt6765-img.c b/drivers/clk/mediatek/clk-mt6765-img.c
index 984201077a20..16e20c61932e 100644
--- a/drivers/clk/mediatek/clk-mt6765-img.c
+++ b/drivers/clk/mediatek/clk-mt6765-img.c
@@ -46,7 +46,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt6765_img);
 
 static struct platform_driver clk_mt6765_img_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6765-img",
 		.of_match_table = of_match_clk_mt6765_img,
diff --git a/drivers/clk/mediatek/clk-mt6765-mipi0a.c b/drivers/clk/mediatek/clk-mt6765-mipi0a.c
index a47937f4efe5..cc5bb0c95f08 100644
--- a/drivers/clk/mediatek/clk-mt6765-mipi0a.c
+++ b/drivers/clk/mediatek/clk-mt6765-mipi0a.c
@@ -43,7 +43,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt6765_mipi0a);
 
 static struct platform_driver clk_mt6765_mipi0a_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6765-mipi0a",
 		.of_match_table = of_match_clk_mt6765_mipi0a,
diff --git a/drivers/clk/mediatek/clk-mt6765-mm.c b/drivers/clk/mediatek/clk-mt6765-mm.c
index 2b8fc052558e..fc5842e13b78 100644
--- a/drivers/clk/mediatek/clk-mt6765-mm.c
+++ b/drivers/clk/mediatek/clk-mt6765-mm.c
@@ -72,7 +72,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt6765_mm);
 
 static struct platform_driver clk_mt6765_mm_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6765-mm",
 		.of_match_table = of_match_clk_mt6765_mm,
diff --git a/drivers/clk/mediatek/clk-mt6765-vcodec.c b/drivers/clk/mediatek/clk-mt6765-vcodec.c
index 36df9615b1be..d6e036795b0a 100644
--- a/drivers/clk/mediatek/clk-mt6765-vcodec.c
+++ b/drivers/clk/mediatek/clk-mt6765-vcodec.c
@@ -45,7 +45,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt6765_vcodec);
 
 static struct platform_driver clk_mt6765_vcodec_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6765-vcodec",
 		.of_match_table = of_match_clk_mt6765_vcodec,
diff --git a/drivers/clk/mediatek/clk-mt6779-aud.c b/drivers/clk/mediatek/clk-mt6779-aud.c
index 6e3280d3a2e6..a97e1117d30b 100644
--- a/drivers/clk/mediatek/clk-mt6779-aud.c
+++ b/drivers/clk/mediatek/clk-mt6779-aud.c
@@ -106,7 +106,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt6779_aud);
 
 static struct platform_driver clk_mt6779_aud_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6779-aud",
 		.of_match_table = of_match_clk_mt6779_aud,
diff --git a/drivers/clk/mediatek/clk-mt6779-cam.c b/drivers/clk/mediatek/clk-mt6779-cam.c
index b4c4c7248672..7b1a40d891ad 100644
--- a/drivers/clk/mediatek/clk-mt6779-cam.c
+++ b/drivers/clk/mediatek/clk-mt6779-cam.c
@@ -55,7 +55,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt6779_cam);
 
 static struct platform_driver clk_mt6779_cam_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6779-cam",
 		.of_match_table = of_match_clk_mt6779_cam,
diff --git a/drivers/clk/mediatek/clk-mt6779-img.c b/drivers/clk/mediatek/clk-mt6779-img.c
index b760a8af3462..1c53209f60a9 100644
--- a/drivers/clk/mediatek/clk-mt6779-img.c
+++ b/drivers/clk/mediatek/clk-mt6779-img.c
@@ -47,7 +47,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt6779_img);
 
 static struct platform_driver clk_mt6779_img_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6779-img",
 		.of_match_table = of_match_clk_mt6779_img,
diff --git a/drivers/clk/mediatek/clk-mt6779-ipe.c b/drivers/clk/mediatek/clk-mt6779-ipe.c
index 9285a792c59b..784bc08ace5e 100644
--- a/drivers/clk/mediatek/clk-mt6779-ipe.c
+++ b/drivers/clk/mediatek/clk-mt6779-ipe.c
@@ -49,7 +49,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt6779_ipe);
 
 static struct platform_driver clk_mt6779_ipe_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6779-ipe",
 		.of_match_table = of_match_clk_mt6779_ipe,
diff --git a/drivers/clk/mediatek/clk-mt6779-mfg.c b/drivers/clk/mediatek/clk-mt6779-mfg.c
index d20f32d4f827..040e4c45fa5f 100644
--- a/drivers/clk/mediatek/clk-mt6779-mfg.c
+++ b/drivers/clk/mediatek/clk-mt6779-mfg.c
@@ -44,7 +44,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt6779_mfg);
 
 static struct platform_driver clk_mt6779_mfg_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6779-mfg",
 		.of_match_table = of_match_clk_mt6779_mfg,
diff --git a/drivers/clk/mediatek/clk-mt6779-vdec.c b/drivers/clk/mediatek/clk-mt6779-vdec.c
index e062ed5aa45f..a411c23512b7 100644
--- a/drivers/clk/mediatek/clk-mt6779-vdec.c
+++ b/drivers/clk/mediatek/clk-mt6779-vdec.c
@@ -56,7 +56,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt6779_vdec);
 
 static struct platform_driver clk_mt6779_vdec_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6779-vdec",
 		.of_match_table = of_match_clk_mt6779_vdec,
diff --git a/drivers/clk/mediatek/clk-mt6779-venc.c b/drivers/clk/mediatek/clk-mt6779-venc.c
index 0ae8ac28f838..f14512d284d6 100644
--- a/drivers/clk/mediatek/clk-mt6779-venc.c
+++ b/drivers/clk/mediatek/clk-mt6779-venc.c
@@ -47,7 +47,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt6779_venc);
 
 static struct platform_driver clk_mt6779_venc_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6779-venc",
 		.of_match_table = of_match_clk_mt6779_venc,
diff --git a/drivers/clk/mediatek/clk-mt6779.c b/drivers/clk/mediatek/clk-mt6779.c
index 1f5ea1508f61..2d4c73600257 100644
--- a/drivers/clk/mediatek/clk-mt6779.c
+++ b/drivers/clk/mediatek/clk-mt6779.c
@@ -1303,7 +1303,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt6779);
 
 static struct platform_driver clk_mt6779_infra_drv  = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6779-infra",
 		.of_match_table = of_match_clk_mt6779_infra,
diff --git a/drivers/clk/mediatek/clk-mt6795-mfg.c b/drivers/clk/mediatek/clk-mt6795-mfg.c
index 1d658bb19e82..dff6a6ded837 100644
--- a/drivers/clk/mediatek/clk-mt6795-mfg.c
+++ b/drivers/clk/mediatek/clk-mt6795-mfg.c
@@ -43,7 +43,7 @@ static struct platform_driver clk_mt6795_mfg_drv = {
 		.of_match_table = of_match_clk_mt6795_mfg,
 	},
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 };
 module_platform_driver(clk_mt6795_mfg_drv);
 
diff --git a/drivers/clk/mediatek/clk-mt6795-topckgen.c b/drivers/clk/mediatek/clk-mt6795-topckgen.c
index 9c6d63a80b19..be595853a925 100644
--- a/drivers/clk/mediatek/clk-mt6795-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt6795-topckgen.c
@@ -547,7 +547,7 @@ static struct platform_driver clk_mt6795_topckgen_drv = {
 		.of_match_table = of_match_clk_mt6795_topckgen,
 	},
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 };
 module_platform_driver(clk_mt6795_topckgen_drv);
 
diff --git a/drivers/clk/mediatek/clk-mt6795-vdecsys.c b/drivers/clk/mediatek/clk-mt6795-vdecsys.c
index f2968f859dca..9e91d6f7f5bf 100644
--- a/drivers/clk/mediatek/clk-mt6795-vdecsys.c
+++ b/drivers/clk/mediatek/clk-mt6795-vdecsys.c
@@ -44,7 +44,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt6795_vdecsys);
 
 static struct platform_driver clk_mt6795_vdecsys_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6795-vdecsys",
 		.of_match_table = of_match_clk_mt6795_vdecsys,
diff --git a/drivers/clk/mediatek/clk-mt6795-vencsys.c b/drivers/clk/mediatek/clk-mt6795-vencsys.c
index 2f8d48da1a85..bd81e80b744f 100644
--- a/drivers/clk/mediatek/clk-mt6795-vencsys.c
+++ b/drivers/clk/mediatek/clk-mt6795-vencsys.c
@@ -43,7 +43,7 @@ static struct platform_driver clk_mt6795_vencsys_drv = {
 		.of_match_table = of_match_clk_mt6795_vencsys,
 	},
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 };
 module_platform_driver(clk_mt6795_vencsys_drv);
 
diff --git a/drivers/clk/mediatek/clk-mt6797-img.c b/drivers/clk/mediatek/clk-mt6797-img.c
index 00fc0a03e646..e1c1ee692a1d 100644
--- a/drivers/clk/mediatek/clk-mt6797-img.c
+++ b/drivers/clk/mediatek/clk-mt6797-img.c
@@ -43,7 +43,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt6797_img);
 
 static struct platform_driver clk_mt6797_img_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6797-img",
 		.of_match_table = of_match_clk_mt6797_img,
diff --git a/drivers/clk/mediatek/clk-mt6797-vdec.c b/drivers/clk/mediatek/clk-mt6797-vdec.c
index 447fe6fa8e15..0ed6710ab88e 100644
--- a/drivers/clk/mediatek/clk-mt6797-vdec.c
+++ b/drivers/clk/mediatek/clk-mt6797-vdec.c
@@ -54,7 +54,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt6797_vdec);
 
 static struct platform_driver clk_mt6797_vdec_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6797-vdec",
 		.of_match_table = of_match_clk_mt6797_vdec,
diff --git a/drivers/clk/mediatek/clk-mt6797-venc.c b/drivers/clk/mediatek/clk-mt6797-venc.c
index 95b89ff8fd19..93d1da7423fe 100644
--- a/drivers/clk/mediatek/clk-mt6797-venc.c
+++ b/drivers/clk/mediatek/clk-mt6797-venc.c
@@ -45,7 +45,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt6797_venc);
 
 static struct platform_driver clk_mt6797_venc_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6797-venc",
 		.of_match_table = of_match_clk_mt6797_venc,
diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
index dd1799dd8435..c3ce65ced902 100644
--- a/drivers/clk/mediatek/clk-mt7622-aud.c
+++ b/drivers/clk/mediatek/clk-mt7622-aud.c
@@ -135,10 +135,10 @@ static int clk_mt7622_aud_probe(struct platform_device *pdev)
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
@@ -149,7 +149,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt7622_aud);
 
 static struct platform_driver clk_mt7622_aud_drv = {
 	.probe = clk_mt7622_aud_probe,
-	.remove = clk_mt7622_aud_remove,
+	.remove_new = clk_mt7622_aud_remove,
 	.driver = {
 		.name = "clk-mt7622-aud",
 		.of_match_table = of_match_clk_mt7622_aud,
diff --git a/drivers/clk/mediatek/clk-mt7622-eth.c b/drivers/clk/mediatek/clk-mt7622-eth.c
index f96b36737029..df81e445026a 100644
--- a/drivers/clk/mediatek/clk-mt7622-eth.c
+++ b/drivers/clk/mediatek/clk-mt7622-eth.c
@@ -81,7 +81,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt7622_eth);
 
 static struct platform_driver clk_mt7622_eth_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt7622-eth",
 		.of_match_table = of_match_clk_mt7622_eth,
diff --git a/drivers/clk/mediatek/clk-mt7622-hif.c b/drivers/clk/mediatek/clk-mt7622-hif.c
index f440943f0d46..9c738d730a7b 100644
--- a/drivers/clk/mediatek/clk-mt7622-hif.c
+++ b/drivers/clk/mediatek/clk-mt7622-hif.c
@@ -93,7 +93,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt7622_hif);
 
 static struct platform_driver clk_mt7622_hif_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt7622-hif",
 		.of_match_table = of_match_clk_mt7622_hif,
diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 274895264427..fa5fb5891a09 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -526,7 +526,7 @@ static struct platform_driver clk_mt7622_drv = {
 		.of_match_table = of_match_clk_mt7622,
 	},
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 };
 module_platform_driver(clk_mt7622_drv)
 
diff --git a/drivers/clk/mediatek/clk-mt7629-hif.c b/drivers/clk/mediatek/clk-mt7629-hif.c
index c89036bee9a7..ec3a71ebb766 100644
--- a/drivers/clk/mediatek/clk-mt7629-hif.c
+++ b/drivers/clk/mediatek/clk-mt7629-hif.c
@@ -88,7 +88,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt7629_hif);
 
 static struct platform_driver clk_mt7629_hif_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt7629-hif",
 		.of_match_table = of_match_clk_mt7629_hif,
diff --git a/drivers/clk/mediatek/clk-mt7981-eth.c b/drivers/clk/mediatek/clk-mt7981-eth.c
index b1f256b5ed4e..6bc509a54e14 100644
--- a/drivers/clk/mediatek/clk-mt7981-eth.c
+++ b/drivers/clk/mediatek/clk-mt7981-eth.c
@@ -109,7 +109,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt7981_eth);
 
 static struct platform_driver clk_mt7981_eth_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt7981-eth",
 		.of_match_table = of_match_clk_mt7981_eth,
diff --git a/drivers/clk/mediatek/clk-mt7981-infracfg.c b/drivers/clk/mediatek/clk-mt7981-infracfg.c
index 293261ef71e6..7e9d3d309151 100644
--- a/drivers/clk/mediatek/clk-mt7981-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7981-infracfg.c
@@ -199,7 +199,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt7981_infracfg);
 
 static struct platform_driver clk_mt7981_infracfg_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt7981-infracfg",
 		.of_match_table = of_match_clk_mt7981_infracfg,
diff --git a/drivers/clk/mediatek/clk-mt7981-topckgen.c b/drivers/clk/mediatek/clk-mt7981-topckgen.c
index 3aba1a9b9a36..a777254c1872 100644
--- a/drivers/clk/mediatek/clk-mt7981-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt7981-topckgen.c
@@ -414,7 +414,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt7981_topckgen);
 
 static struct platform_driver clk_mt7981_topckgen_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt7981-topckgen",
 		.of_match_table = of_match_clk_mt7981_topckgen,
diff --git a/drivers/clk/mediatek/clk-mt7986-eth.c b/drivers/clk/mediatek/clk-mt7986-eth.c
index 0681988960cc..854e2c565041 100644
--- a/drivers/clk/mediatek/clk-mt7986-eth.c
+++ b/drivers/clk/mediatek/clk-mt7986-eth.c
@@ -94,7 +94,7 @@ static struct platform_driver clk_mt7986_eth_drv = {
 		.of_match_table = of_match_clk_mt7986_eth,
 	},
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 };
 module_platform_driver(clk_mt7986_eth_drv);
 
diff --git a/drivers/clk/mediatek/clk-mt7986-infracfg.c b/drivers/clk/mediatek/clk-mt7986-infracfg.c
index b7efa70c2d6c..c576e9fb986c 100644
--- a/drivers/clk/mediatek/clk-mt7986-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7986-infracfg.c
@@ -179,7 +179,7 @@ static struct platform_driver clk_mt7986_infracfg_drv = {
 		.of_match_table = of_match_clk_mt7986_infracfg,
 	},
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 };
 module_platform_driver(clk_mt7986_infracfg_drv);
 
diff --git a/drivers/clk/mediatek/clk-mt7986-topckgen.c b/drivers/clk/mediatek/clk-mt7986-topckgen.c
index fbca3feded8f..f34f078ff2ff 100644
--- a/drivers/clk/mediatek/clk-mt7986-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt7986-topckgen.c
@@ -308,7 +308,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt7986_topckgen);
 
 static struct platform_driver clk_mt7986_topckgen_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt7986-topckgen",
 		.of_match_table = of_match_clk_mt7986_topckgen,
diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index 084e48a554c2..019af88d7f9c 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -558,7 +558,7 @@ static struct platform_driver clk_mt8135_drv = {
 		.of_match_table = of_match_clk_mt8135,
 	},
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 };
 module_platform_driver(clk_mt8135_drv);
 
diff --git a/drivers/clk/mediatek/clk-mt8167-aud.c b/drivers/clk/mediatek/clk-mt8167-aud.c
index 86125635c8a6..b73058edf3d6 100644
--- a/drivers/clk/mediatek/clk-mt8167-aud.c
+++ b/drivers/clk/mediatek/clk-mt8167-aud.c
@@ -56,7 +56,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8167_audsys);
 
 static struct platform_driver clk_mt8167_audsys_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8167-audsys",
 		.of_match_table = of_match_clk_mt8167_audsys,
diff --git a/drivers/clk/mediatek/clk-mt8167-img.c b/drivers/clk/mediatek/clk-mt8167-img.c
index 315b7f64bad6..ba07d20f14b3 100644
--- a/drivers/clk/mediatek/clk-mt8167-img.c
+++ b/drivers/clk/mediatek/clk-mt8167-img.c
@@ -48,7 +48,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8167_imgsys);
 
 static struct platform_driver clk_mt8167_imgsys_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8167-imgsys",
 		.of_match_table = of_match_clk_mt8167_imgsys,
diff --git a/drivers/clk/mediatek/clk-mt8167-mfgcfg.c b/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
index 4851f5bf3a90..5f7dbaf97e96 100644
--- a/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
+++ b/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
@@ -46,7 +46,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8167_mfgcfg);
 
 static struct platform_driver clk_mt8167_mfgcfg_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8167-mfgcfg",
 		.of_match_table = of_match_clk_mt8167_mfgcfg,
diff --git a/drivers/clk/mediatek/clk-mt8167-vdec.c b/drivers/clk/mediatek/clk-mt8167-vdec.c
index 76900f393d31..2f662b3f16a9 100644
--- a/drivers/clk/mediatek/clk-mt8167-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8167-vdec.c
@@ -55,7 +55,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8167_vdec);
 
 static struct platform_driver clk_mt8167_vdec_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8167-vdecsys",
 		.of_match_table = of_match_clk_mt8167_vdec,
diff --git a/drivers/clk/mediatek/clk-mt8167.c b/drivers/clk/mediatek/clk-mt8167.c
index b9041f79cbbd..270221c6e6e8 100644
--- a/drivers/clk/mediatek/clk-mt8167.c
+++ b/drivers/clk/mediatek/clk-mt8167.c
@@ -887,7 +887,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8167);
 
 static struct platform_driver clk_mt8167_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8167",
 		.of_match_table = of_match_clk_mt8167,
diff --git a/drivers/clk/mediatek/clk-mt8173-img.c b/drivers/clk/mediatek/clk-mt8173-img.c
index 6db2b9ab2bc9..1011b9ab3dad 100644
--- a/drivers/clk/mediatek/clk-mt8173-img.c
+++ b/drivers/clk/mediatek/clk-mt8173-img.c
@@ -44,7 +44,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8173_imgsys);
 
 static struct platform_driver clk_mt8173_vdecsys_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8173-imgsys",
 		.of_match_table = of_match_clk_mt8173_imgsys,
diff --git a/drivers/clk/mediatek/clk-mt8173-pericfg.c b/drivers/clk/mediatek/clk-mt8173-pericfg.c
index bebda74d0f43..783efed3f254 100644
--- a/drivers/clk/mediatek/clk-mt8173-pericfg.c
+++ b/drivers/clk/mediatek/clk-mt8173-pericfg.c
@@ -115,7 +115,7 @@ static struct platform_driver clk_mt8173_pericfg_drv = {
 		.of_match_table = of_match_clk_mt8173_pericfg,
 	},
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 };
 module_platform_driver(clk_mt8173_pericfg_drv);
 
diff --git a/drivers/clk/mediatek/clk-mt8173-topckgen.c b/drivers/clk/mediatek/clk-mt8173-topckgen.c
index baa8fd6cb312..977d6a3c9880 100644
--- a/drivers/clk/mediatek/clk-mt8173-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8173-topckgen.c
@@ -646,7 +646,7 @@ static struct platform_driver clk_mt8173_topckgen_drv = {
 		.of_match_table = of_match_clk_mt8173_topckgen,
 	},
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 };
 module_platform_driver(clk_mt8173_topckgen_drv);
 
diff --git a/drivers/clk/mediatek/clk-mt8173-vdecsys.c b/drivers/clk/mediatek/clk-mt8173-vdecsys.c
index 625ca0b09cc2..011e3812156f 100644
--- a/drivers/clk/mediatek/clk-mt8173-vdecsys.c
+++ b/drivers/clk/mediatek/clk-mt8173-vdecsys.c
@@ -46,7 +46,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8173_vdecsys);
 
 static struct platform_driver clk_mt8173_vdecsys_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8173-vdecsys",
 		.of_match_table = of_match_clk_mt8173_vdecsys,
diff --git a/drivers/clk/mediatek/clk-mt8173-vencsys.c b/drivers/clk/mediatek/clk-mt8173-vencsys.c
index 87755dd1a337..1bf84ae6a0bc 100644
--- a/drivers/clk/mediatek/clk-mt8173-vencsys.c
+++ b/drivers/clk/mediatek/clk-mt8173-vencsys.c
@@ -57,7 +57,7 @@ static struct platform_driver clk_mt8173_vencsys_drv = {
 		.of_match_table = of_match_clk_mt8173_vencsys,
 	},
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 };
 module_platform_driver(clk_mt8173_vencsys_drv);
 
diff --git a/drivers/clk/mediatek/clk-mt8183-audio.c b/drivers/clk/mediatek/clk-mt8183-audio.c
index 9938c6466e76..716b26825ef0 100644
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
@@ -101,7 +101,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8183_audio);
 
 static struct platform_driver clk_mt8183_audio_drv = {
 	.probe = clk_mt8183_audio_probe,
-	.remove = clk_mt8183_audio_remove,
+	.remove_new = clk_mt8183_audio_remove,
 	.driver = {
 		.name = "clk-mt8183-audio",
 		.of_match_table = of_match_clk_mt8183_audio,
diff --git a/drivers/clk/mediatek/clk-mt8183-cam.c b/drivers/clk/mediatek/clk-mt8183-cam.c
index c0719624004f..b0f8e4242a63 100644
--- a/drivers/clk/mediatek/clk-mt8183-cam.c
+++ b/drivers/clk/mediatek/clk-mt8183-cam.c
@@ -51,7 +51,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8183_cam);
 
 static struct platform_driver clk_mt8183_cam_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8183-cam",
 		.of_match_table = of_match_clk_mt8183_cam,
diff --git a/drivers/clk/mediatek/clk-mt8183-img.c b/drivers/clk/mediatek/clk-mt8183-img.c
index 55fc80615724..6e177d2e8872 100644
--- a/drivers/clk/mediatek/clk-mt8183-img.c
+++ b/drivers/clk/mediatek/clk-mt8183-img.c
@@ -51,7 +51,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8183_img);
 
 static struct platform_driver clk_mt8183_img_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8183-img",
 		.of_match_table = of_match_clk_mt8183_img,
diff --git a/drivers/clk/mediatek/clk-mt8183-ipu0.c b/drivers/clk/mediatek/clk-mt8183-ipu0.c
index 59255eab6fe2..0b61c7af8aea 100644
--- a/drivers/clk/mediatek/clk-mt8183-ipu0.c
+++ b/drivers/clk/mediatek/clk-mt8183-ipu0.c
@@ -44,7 +44,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8183_ipu_core0);
 
 static struct platform_driver clk_mt8183_ipu_core0_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8183-ipu_core0",
 		.of_match_table = of_match_clk_mt8183_ipu_core0,
diff --git a/drivers/clk/mediatek/clk-mt8183-ipu1.c b/drivers/clk/mediatek/clk-mt8183-ipu1.c
index c4baa052c809..544b1ca0e1c5 100644
--- a/drivers/clk/mediatek/clk-mt8183-ipu1.c
+++ b/drivers/clk/mediatek/clk-mt8183-ipu1.c
@@ -44,7 +44,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8183_ipu_core1);
 
 static struct platform_driver clk_mt8183_ipu_core1_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8183-ipu_core1",
 		.of_match_table = of_match_clk_mt8183_ipu_core1,
diff --git a/drivers/clk/mediatek/clk-mt8183-ipu_adl.c b/drivers/clk/mediatek/clk-mt8183-ipu_adl.c
index 74866e9c50d7..7f53674f393c 100644
--- a/drivers/clk/mediatek/clk-mt8183-ipu_adl.c
+++ b/drivers/clk/mediatek/clk-mt8183-ipu_adl.c
@@ -42,7 +42,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8183_ipu_adl);
 
 static struct platform_driver clk_mt8183_ipu_adl_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8183-ipu_adl",
 		.of_match_table = of_match_clk_mt8183_ipu_adl,
diff --git a/drivers/clk/mediatek/clk-mt8183-ipu_conn.c b/drivers/clk/mediatek/clk-mt8183-ipu_conn.c
index bd7303105357..fb03ad2d8f6a 100644
--- a/drivers/clk/mediatek/clk-mt8183-ipu_conn.c
+++ b/drivers/clk/mediatek/clk-mt8183-ipu_conn.c
@@ -111,7 +111,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8183_ipu_conn);
 
 static struct platform_driver clk_mt8183_ipu_conn_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8183-ipu_conn",
 		.of_match_table = of_match_clk_mt8183_ipu_conn,
diff --git a/drivers/clk/mediatek/clk-mt8183-mfgcfg.c b/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
index 816ecf1191ee..ba504e19d420 100644
--- a/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
+++ b/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
@@ -43,7 +43,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8183_mfg);
 
 static struct platform_driver clk_mt8183_mfg_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8183-mfg",
 		.of_match_table = of_match_clk_mt8183_mfg,
diff --git a/drivers/clk/mediatek/clk-mt8183-vdec.c b/drivers/clk/mediatek/clk-mt8183-vdec.c
index 513b7956cbea..8c99ae89834f 100644
--- a/drivers/clk/mediatek/clk-mt8183-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8183-vdec.c
@@ -55,7 +55,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8183_vdec);
 
 static struct platform_driver clk_mt8183_vdec_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8183-vdec",
 		.of_match_table = of_match_clk_mt8183_vdec,
diff --git a/drivers/clk/mediatek/clk-mt8183-venc.c b/drivers/clk/mediatek/clk-mt8183-venc.c
index 532f6e12a561..a8e0220902ae 100644
--- a/drivers/clk/mediatek/clk-mt8183-venc.c
+++ b/drivers/clk/mediatek/clk-mt8183-venc.c
@@ -47,7 +47,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8183_venc);
 
 static struct platform_driver clk_mt8183_venc_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8183-venc",
 		.of_match_table = of_match_clk_mt8183_venc,
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 2336a1b69c09..e0a00b34f4c2 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -872,7 +872,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8183);
 
 static struct platform_driver clk_mt8183_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8183",
 		.of_match_table = of_match_clk_mt8183,
diff --git a/drivers/clk/mediatek/clk-mt8186-cam.c b/drivers/clk/mediatek/clk-mt8186-cam.c
index 656d9e6f3ee2..effd2900d2e8 100644
--- a/drivers/clk/mediatek/clk-mt8186-cam.c
+++ b/drivers/clk/mediatek/clk-mt8186-cam.c
@@ -82,7 +82,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8186_cam);
 
 static struct platform_driver clk_mt8186_cam_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8186-cam",
 		.of_match_table = of_match_clk_mt8186_cam,
diff --git a/drivers/clk/mediatek/clk-mt8186-img.c b/drivers/clk/mediatek/clk-mt8186-img.c
index 754b27f03817..71b0571e6351 100644
--- a/drivers/clk/mediatek/clk-mt8186-img.c
+++ b/drivers/clk/mediatek/clk-mt8186-img.c
@@ -60,7 +60,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8186_img);
 
 static struct platform_driver clk_mt8186_img_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8186-img",
 		.of_match_table = of_match_clk_mt8186_img,
diff --git a/drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c
index 7619c357b150..640ccb553274 100644
--- a/drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c
+++ b/drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c
@@ -59,7 +59,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8186_imp_iic_wrap);
 
 static struct platform_driver clk_mt8186_imp_iic_wrap_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8186-imp_iic_wrap",
 		.of_match_table = of_match_clk_mt8186_imp_iic_wrap,
diff --git a/drivers/clk/mediatek/clk-mt8186-infra_ao.c b/drivers/clk/mediatek/clk-mt8186-infra_ao.c
index a907a5def5b8..837304cd0ed7 100644
--- a/drivers/clk/mediatek/clk-mt8186-infra_ao.c
+++ b/drivers/clk/mediatek/clk-mt8186-infra_ao.c
@@ -231,7 +231,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8186_infra_ao);
 
 static struct platform_driver clk_mt8186_infra_ao_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8186-infra-ao",
 		.of_match_table = of_match_clk_mt8186_infra_ao,
diff --git a/drivers/clk/mediatek/clk-mt8186-ipe.c b/drivers/clk/mediatek/clk-mt8186-ipe.c
index 50e340035aa7..60739e225cb6 100644
--- a/drivers/clk/mediatek/clk-mt8186-ipe.c
+++ b/drivers/clk/mediatek/clk-mt8186-ipe.c
@@ -47,7 +47,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8186_ipe);
 
 static struct platform_driver clk_mt8186_ipe_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8186-ipe",
 		.of_match_table = of_match_clk_mt8186_ipe,
diff --git a/drivers/clk/mediatek/clk-mt8186-mcu.c b/drivers/clk/mediatek/clk-mt8186-mcu.c
index d1640e4dc2ad..eb54ccb77b74 100644
--- a/drivers/clk/mediatek/clk-mt8186-mcu.c
+++ b/drivers/clk/mediatek/clk-mt8186-mcu.c
@@ -60,7 +60,7 @@ static struct platform_driver clk_mt8186_mcu_drv = {
 		.of_match_table = of_match_clk_mt8186_mcu,
 	},
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 };
 module_platform_driver(clk_mt8186_mcu_drv);
 
diff --git a/drivers/clk/mediatek/clk-mt8186-mdp.c b/drivers/clk/mediatek/clk-mt8186-mdp.c
index e1d19007e375..9a335f2285ce 100644
--- a/drivers/clk/mediatek/clk-mt8186-mdp.c
+++ b/drivers/clk/mediatek/clk-mt8186-mdp.c
@@ -72,7 +72,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8186_mdp);
 
 static struct platform_driver clk_mt8186_mdp_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8186-mdp",
 		.of_match_table = of_match_clk_mt8186_mdp,
diff --git a/drivers/clk/mediatek/clk-mt8186-mfg.c b/drivers/clk/mediatek/clk-mt8186-mfg.c
index aeb098b54585..7618dad9e0e0 100644
--- a/drivers/clk/mediatek/clk-mt8186-mfg.c
+++ b/drivers/clk/mediatek/clk-mt8186-mfg.c
@@ -41,7 +41,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8186_mfg);
 
 static struct platform_driver clk_mt8186_mfg_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8186-mfg",
 		.of_match_table = of_match_clk_mt8186_mfg,
diff --git a/drivers/clk/mediatek/clk-mt8186-topckgen.c b/drivers/clk/mediatek/clk-mt8186-topckgen.c
index 1a0340a20beb..3a8f594683bc 100644
--- a/drivers/clk/mediatek/clk-mt8186-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8186-topckgen.c
@@ -725,7 +725,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8186_topck);
 
 static struct platform_driver clk_mt8186_topck_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8186-topck",
 		.of_match_table = of_match_clk_mt8186_topck,
diff --git a/drivers/clk/mediatek/clk-mt8186-vdec.c b/drivers/clk/mediatek/clk-mt8186-vdec.c
index 9bf3b8632870..0b814e8e107f 100644
--- a/drivers/clk/mediatek/clk-mt8186-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8186-vdec.c
@@ -80,7 +80,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8186_vdec);
 
 static struct platform_driver clk_mt8186_vdec_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8186-vdec",
 		.of_match_table = of_match_clk_mt8186_vdec,
diff --git a/drivers/clk/mediatek/clk-mt8186-venc.c b/drivers/clk/mediatek/clk-mt8186-venc.c
index 0c1bc94e84cf..9493e51af3e2 100644
--- a/drivers/clk/mediatek/clk-mt8186-venc.c
+++ b/drivers/clk/mediatek/clk-mt8186-venc.c
@@ -43,7 +43,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8186_venc);
 
 static struct platform_driver clk_mt8186_venc_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8186-venc",
 		.of_match_table = of_match_clk_mt8186_venc,
diff --git a/drivers/clk/mediatek/clk-mt8186-wpe.c b/drivers/clk/mediatek/clk-mt8186-wpe.c
index c4727b1cb64d..a0174eabef4a 100644
--- a/drivers/clk/mediatek/clk-mt8186-wpe.c
+++ b/drivers/clk/mediatek/clk-mt8186-wpe.c
@@ -43,7 +43,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8186_wpe);
 
 static struct platform_driver clk_mt8186_wpe_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8186-wpe",
 		.of_match_table = of_match_clk_mt8186_wpe,
diff --git a/drivers/clk/mediatek/clk-mt8188-adsp_audio26m.c b/drivers/clk/mediatek/clk-mt8188-adsp_audio26m.c
index 808f2ad3b7ee..1dc3d2bad42d 100644
--- a/drivers/clk/mediatek/clk-mt8188-adsp_audio26m.c
+++ b/drivers/clk/mediatek/clk-mt8188-adsp_audio26m.c
@@ -40,7 +40,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8188_adsp_audio26m);
 
 static struct platform_driver clk_mt8188_adsp_audio26m_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8188-adsp_audio26m",
 		.of_match_table = of_match_clk_mt8188_adsp_audio26m,
diff --git a/drivers/clk/mediatek/clk-mt8188-cam.c b/drivers/clk/mediatek/clk-mt8188-cam.c
index c5a3856bd223..f78f564aa27e 100644
--- a/drivers/clk/mediatek/clk-mt8188-cam.c
+++ b/drivers/clk/mediatek/clk-mt8188-cam.c
@@ -109,7 +109,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8188_cam);
 
 static struct platform_driver clk_mt8188_cam_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8188-cam",
 		.of_match_table = of_match_clk_mt8188_cam,
diff --git a/drivers/clk/mediatek/clk-mt8188-ccu.c b/drivers/clk/mediatek/clk-mt8188-ccu.c
index ebc0d3aeee11..428dcc4818c2 100644
--- a/drivers/clk/mediatek/clk-mt8188-ccu.c
+++ b/drivers/clk/mediatek/clk-mt8188-ccu.c
@@ -39,7 +39,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8188_ccu);
 
 static struct platform_driver clk_mt8188_ccu_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8188-ccu",
 		.of_match_table = of_match_clk_mt8188_ccu,
diff --git a/drivers/clk/mediatek/clk-mt8188-img.c b/drivers/clk/mediatek/clk-mt8188-img.c
index b4622875e14c..76c64a8992a4 100644
--- a/drivers/clk/mediatek/clk-mt8188-img.c
+++ b/drivers/clk/mediatek/clk-mt8188-img.c
@@ -101,7 +101,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8188_imgsys_main);
 
 static struct platform_driver clk_mt8188_imgsys_main_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8188-imgsys_main",
 		.of_match_table = of_match_clk_mt8188_imgsys_main,
diff --git a/drivers/clk/mediatek/clk-mt8188-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8188-imp_iic_wrap.c
index da41a3c59919..66946784cdba 100644
--- a/drivers/clk/mediatek/clk-mt8188-imp_iic_wrap.c
+++ b/drivers/clk/mediatek/clk-mt8188-imp_iic_wrap.c
@@ -71,7 +71,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8188_imp_iic_wrap);
 
 static struct platform_driver clk_mt8188_imp_iic_wrap_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8188-imp_iic_wrap",
 		.of_match_table = of_match_clk_mt8188_imp_iic_wrap,
diff --git a/drivers/clk/mediatek/clk-mt8188-infra_ao.c b/drivers/clk/mediatek/clk-mt8188-infra_ao.c
index 91c35db40b4e..a38ddc7b6a88 100644
--- a/drivers/clk/mediatek/clk-mt8188-infra_ao.c
+++ b/drivers/clk/mediatek/clk-mt8188-infra_ao.c
@@ -189,7 +189,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8188_infra_ao);
 
 static struct platform_driver clk_mt8188_infra_ao_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8188-infra_ao",
 		.of_match_table = of_match_clk_mt8188_infra_ao,
diff --git a/drivers/clk/mediatek/clk-mt8188-ipe.c b/drivers/clk/mediatek/clk-mt8188-ipe.c
index c07afbd1429e..54fe6b689b47 100644
--- a/drivers/clk/mediatek/clk-mt8188-ipe.c
+++ b/drivers/clk/mediatek/clk-mt8188-ipe.c
@@ -41,7 +41,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8188_ipe);
 
 static struct platform_driver clk_mt8188_ipe_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8188-ipe",
 		.of_match_table = of_match_clk_mt8188_ipe,
diff --git a/drivers/clk/mediatek/clk-mt8188-mfg.c b/drivers/clk/mediatek/clk-mt8188-mfg.c
index e5a6eaf84672..1c8ef4c6820f 100644
--- a/drivers/clk/mediatek/clk-mt8188-mfg.c
+++ b/drivers/clk/mediatek/clk-mt8188-mfg.c
@@ -38,7 +38,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8188_mfgcfg);
 
 static struct platform_driver clk_mt8188_mfgcfg_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8188-mfgcfg",
 		.of_match_table = of_match_clk_mt8188_mfgcfg,
diff --git a/drivers/clk/mediatek/clk-mt8188-peri_ao.c b/drivers/clk/mediatek/clk-mt8188-peri_ao.c
index b00e1ae8bd26..a8214e42b8e5 100644
--- a/drivers/clk/mediatek/clk-mt8188-peri_ao.c
+++ b/drivers/clk/mediatek/clk-mt8188-peri_ao.c
@@ -49,7 +49,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8188_peri_ao);
 
 static struct platform_driver clk_mt8188_peri_ao_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8188-peri_ao",
 		.of_match_table = of_match_clk_mt8188_peri_ao,
diff --git a/drivers/clk/mediatek/clk-mt8188-vdec.c b/drivers/clk/mediatek/clk-mt8188-vdec.c
index 8c3d76531753..db5855d133ac 100644
--- a/drivers/clk/mediatek/clk-mt8188-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8188-vdec.c
@@ -81,7 +81,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8188_vdec);
 
 static struct platform_driver clk_mt8188_vdec_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8188-vdec",
 		.of_match_table = of_match_clk_mt8188_vdec,
diff --git a/drivers/clk/mediatek/clk-mt8188-venc.c b/drivers/clk/mediatek/clk-mt8188-venc.c
index 245367f33fa5..5b1713908ed2 100644
--- a/drivers/clk/mediatek/clk-mt8188-venc.c
+++ b/drivers/clk/mediatek/clk-mt8188-venc.c
@@ -45,7 +45,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8188_venc1);
 
 static struct platform_driver clk_mt8188_venc1_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8188-venc1",
 		.of_match_table = of_match_clk_mt8188_venc1,
diff --git a/drivers/clk/mediatek/clk-mt8188-wpe.c b/drivers/clk/mediatek/clk-mt8188-wpe.c
index 393ac38a2172..f394ec049872 100644
--- a/drivers/clk/mediatek/clk-mt8188-wpe.c
+++ b/drivers/clk/mediatek/clk-mt8188-wpe.c
@@ -94,7 +94,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8188_wpe);
 
 static struct platform_driver clk_mt8188_wpe_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8188-wpe",
 		.of_match_table = of_match_clk_mt8188_wpe,
diff --git a/drivers/clk/mediatek/clk-mt8192-aud.c b/drivers/clk/mediatek/clk-mt8192-aud.c
index ee251492d4f1..5bce67bf701d 100644
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
@@ -111,7 +111,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8192_aud);
 
 static struct platform_driver clk_mt8192_aud_drv = {
 	.probe = clk_mt8192_aud_probe,
-	.remove = clk_mt8192_aud_remove,
+	.remove_new = clk_mt8192_aud_remove,
 	.driver = {
 		.name = "clk-mt8192-aud",
 		.of_match_table = of_match_clk_mt8192_aud,
diff --git a/drivers/clk/mediatek/clk-mt8192-cam.c b/drivers/clk/mediatek/clk-mt8192-cam.c
index 7befd6ee8c79..7b9327eba924 100644
--- a/drivers/clk/mediatek/clk-mt8192-cam.c
+++ b/drivers/clk/mediatek/clk-mt8192-cam.c
@@ -99,7 +99,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8192_cam);
 
 static struct platform_driver clk_mt8192_cam_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-cam",
 		.of_match_table = of_match_clk_mt8192_cam,
diff --git a/drivers/clk/mediatek/clk-mt8192-img.c b/drivers/clk/mediatek/clk-mt8192-img.c
index a7505150a9d0..0208030c31a0 100644
--- a/drivers/clk/mediatek/clk-mt8192-img.c
+++ b/drivers/clk/mediatek/clk-mt8192-img.c
@@ -62,7 +62,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8192_img);
 
 static struct platform_driver clk_mt8192_img_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-img",
 		.of_match_table = of_match_clk_mt8192_img,
diff --git a/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
index cd5d00a7c54b..275581f8c710 100644
--- a/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
+++ b/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
@@ -111,7 +111,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8192_imp_iic_wrap);
 
 static struct platform_driver clk_mt8192_imp_iic_wrap_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-imp_iic_wrap",
 		.of_match_table = of_match_clk_mt8192_imp_iic_wrap,
diff --git a/drivers/clk/mediatek/clk-mt8192-ipe.c b/drivers/clk/mediatek/clk-mt8192-ipe.c
index dee671ae38e6..f3656c3b9573 100644
--- a/drivers/clk/mediatek/clk-mt8192-ipe.c
+++ b/drivers/clk/mediatek/clk-mt8192-ipe.c
@@ -49,7 +49,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8192_ipe);
 
 static struct platform_driver clk_mt8192_ipe_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-ipe",
 		.of_match_table = of_match_clk_mt8192_ipe,
diff --git a/drivers/clk/mediatek/clk-mt8192-mdp.c b/drivers/clk/mediatek/clk-mt8192-mdp.c
index f7b27264e378..5385ac95533a 100644
--- a/drivers/clk/mediatek/clk-mt8192-mdp.c
+++ b/drivers/clk/mediatek/clk-mt8192-mdp.c
@@ -74,7 +74,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8192_mdp);
 
 static struct platform_driver clk_mt8192_mdp_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-mdp",
 		.of_match_table = of_match_clk_mt8192_mdp,
diff --git a/drivers/clk/mediatek/clk-mt8192-mfg.c b/drivers/clk/mediatek/clk-mt8192-mfg.c
index 85f76a2bbac4..0ac7045cf5d1 100644
--- a/drivers/clk/mediatek/clk-mt8192-mfg.c
+++ b/drivers/clk/mediatek/clk-mt8192-mfg.c
@@ -44,7 +44,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8192_mfg);
 
 static struct platform_driver clk_mt8192_mfg_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-mfg",
 		.of_match_table = of_match_clk_mt8192_mfg,
diff --git a/drivers/clk/mediatek/clk-mt8192-msdc.c b/drivers/clk/mediatek/clk-mt8192-msdc.c
index 60d65f96d39a..9da647c5b8b3 100644
--- a/drivers/clk/mediatek/clk-mt8192-msdc.c
+++ b/drivers/clk/mediatek/clk-mt8192-msdc.c
@@ -56,7 +56,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8192_msdc);
 
 static struct platform_driver clk_mt8192_msdc_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-msdc",
 		.of_match_table = of_match_clk_mt8192_msdc,
diff --git a/drivers/clk/mediatek/clk-mt8192-scp_adsp.c b/drivers/clk/mediatek/clk-mt8192-scp_adsp.c
index 6aad57797c39..44091147c813 100644
--- a/drivers/clk/mediatek/clk-mt8192-scp_adsp.c
+++ b/drivers/clk/mediatek/clk-mt8192-scp_adsp.c
@@ -42,7 +42,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8192_scp_adsp);
 
 static struct platform_driver clk_mt8192_scp_adsp_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-scp_adsp",
 		.of_match_table = of_match_clk_mt8192_scp_adsp,
diff --git a/drivers/clk/mediatek/clk-mt8192-vdec.c b/drivers/clk/mediatek/clk-mt8192-vdec.c
index 473afd58495c..d82dee8317b2 100644
--- a/drivers/clk/mediatek/clk-mt8192-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8192-vdec.c
@@ -86,7 +86,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8192_vdec);
 
 static struct platform_driver clk_mt8192_vdec_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-vdec",
 		.of_match_table = of_match_clk_mt8192_vdec,
diff --git a/drivers/clk/mediatek/clk-mt8192-venc.c b/drivers/clk/mediatek/clk-mt8192-venc.c
index 57b1b16e2310..b0ef242991e5 100644
--- a/drivers/clk/mediatek/clk-mt8192-venc.c
+++ b/drivers/clk/mediatek/clk-mt8192-venc.c
@@ -45,7 +45,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8192_venc);
 
 static struct platform_driver clk_mt8192_venc_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-venc",
 		.of_match_table = of_match_clk_mt8192_venc,
diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index aa11291463f7..85edbe3c9baf 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -1027,7 +1027,7 @@ static struct platform_driver clk_mt8192_drv = {
 		.of_match_table = of_match_clk_mt8192,
 	},
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 };
 module_platform_driver(clk_mt8192_drv);
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-cam.c b/drivers/clk/mediatek/clk-mt8195-cam.c
index 77e608be579a..24cd6a2092b6 100644
--- a/drivers/clk/mediatek/clk-mt8195-cam.c
+++ b/drivers/clk/mediatek/clk-mt8195-cam.c
@@ -135,7 +135,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8195_cam);
 
 static struct platform_driver clk_mt8195_cam_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-cam",
 		.of_match_table = of_match_clk_mt8195_cam,
diff --git a/drivers/clk/mediatek/clk-mt8195-ccu.c b/drivers/clk/mediatek/clk-mt8195-ccu.c
index bdc2e6f3e9ce..24dab128507a 100644
--- a/drivers/clk/mediatek/clk-mt8195-ccu.c
+++ b/drivers/clk/mediatek/clk-mt8195-ccu.c
@@ -43,7 +43,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8195_ccu);
 
 static struct platform_driver clk_mt8195_ccu_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-ccu",
 		.of_match_table = of_match_clk_mt8195_ccu,
diff --git a/drivers/clk/mediatek/clk-mt8195-img.c b/drivers/clk/mediatek/clk-mt8195-img.c
index d853e0e63d87..c7dc3e9d133d 100644
--- a/drivers/clk/mediatek/clk-mt8195-img.c
+++ b/drivers/clk/mediatek/clk-mt8195-img.c
@@ -89,7 +89,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8195_img);
 
 static struct platform_driver clk_mt8195_img_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-img",
 		.of_match_table = of_match_clk_mt8195_img,
diff --git a/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
index 1d808876f5c5..94912d45509e 100644
--- a/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
+++ b/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
@@ -59,7 +59,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8195_imp_iic_wrap);
 
 static struct platform_driver clk_mt8195_imp_iic_wrap_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-imp_iic_wrap",
 		.of_match_table = of_match_clk_mt8195_imp_iic_wrap,
diff --git a/drivers/clk/mediatek/clk-mt8195-infra_ao.c b/drivers/clk/mediatek/clk-mt8195-infra_ao.c
index f3ee4390707d..dfba6eb61ccf 100644
--- a/drivers/clk/mediatek/clk-mt8195-infra_ao.c
+++ b/drivers/clk/mediatek/clk-mt8195-infra_ao.c
@@ -233,7 +233,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8195_infra_ao);
 
 static struct platform_driver clk_mt8195_infra_ao_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-infra_ao",
 		.of_match_table = of_match_clk_mt8195_infra_ao,
diff --git a/drivers/clk/mediatek/clk-mt8195-ipe.c b/drivers/clk/mediatek/clk-mt8195-ipe.c
index 4c47f6521275..21e76e5ad376 100644
--- a/drivers/clk/mediatek/clk-mt8195-ipe.c
+++ b/drivers/clk/mediatek/clk-mt8195-ipe.c
@@ -44,7 +44,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8195_ipe);
 
 static struct platform_driver clk_mt8195_ipe_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-ipe",
 		.of_match_table = of_match_clk_mt8195_ipe,
diff --git a/drivers/clk/mediatek/clk-mt8195-mfg.c b/drivers/clk/mediatek/clk-mt8195-mfg.c
index 038acf0b1167..4951574abf2a 100644
--- a/drivers/clk/mediatek/clk-mt8195-mfg.c
+++ b/drivers/clk/mediatek/clk-mt8195-mfg.c
@@ -42,7 +42,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8195_mfg);
 
 static struct platform_driver clk_mt8195_mfg_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-mfg",
 		.of_match_table = of_match_clk_mt8195_mfg,
diff --git a/drivers/clk/mediatek/clk-mt8195-peri_ao.c b/drivers/clk/mediatek/clk-mt8195-peri_ao.c
index 0de162593c01..39069aaf6bcd 100644
--- a/drivers/clk/mediatek/clk-mt8195-peri_ao.c
+++ b/drivers/clk/mediatek/clk-mt8195-peri_ao.c
@@ -55,7 +55,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8195_peri_ao);
 
 static struct platform_driver clk_mt8195_peri_ao_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-peri_ao",
 		.of_match_table = of_match_clk_mt8195_peri_ao,
diff --git a/drivers/clk/mediatek/clk-mt8195-scp_adsp.c b/drivers/clk/mediatek/clk-mt8195-scp_adsp.c
index d0d3e3b09780..2b94d75be295 100644
--- a/drivers/clk/mediatek/clk-mt8195-scp_adsp.c
+++ b/drivers/clk/mediatek/clk-mt8195-scp_adsp.c
@@ -40,7 +40,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8195_scp_adsp);
 
 static struct platform_driver clk_mt8195_scp_adsp_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-scp_adsp",
 		.of_match_table = of_match_clk_mt8195_scp_adsp,
diff --git a/drivers/clk/mediatek/clk-mt8195-vdec.c b/drivers/clk/mediatek/clk-mt8195-vdec.c
index 2bcbceb10326..d266a6d3b603 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdec.c
@@ -97,7 +97,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8195_vdec);
 
 static struct platform_driver clk_mt8195_vdec_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-vdec",
 		.of_match_table = of_match_clk_mt8195_vdec,
diff --git a/drivers/clk/mediatek/clk-mt8195-venc.c b/drivers/clk/mediatek/clk-mt8195-venc.c
index 0991a6968765..93093fadfd0d 100644
--- a/drivers/clk/mediatek/clk-mt8195-venc.c
+++ b/drivers/clk/mediatek/clk-mt8195-venc.c
@@ -62,7 +62,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8195_venc);
 
 static struct platform_driver clk_mt8195_venc_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-venc",
 		.of_match_table = of_match_clk_mt8195_venc,
diff --git a/drivers/clk/mediatek/clk-mt8195-wpe.c b/drivers/clk/mediatek/clk-mt8195-wpe.c
index 289896cb2f6c..7324738179a4 100644
--- a/drivers/clk/mediatek/clk-mt8195-wpe.c
+++ b/drivers/clk/mediatek/clk-mt8195-wpe.c
@@ -136,7 +136,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8195_wpe);
 
 static struct platform_driver clk_mt8195_wpe_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-wpe",
 		.of_match_table = of_match_clk_mt8195_wpe,
diff --git a/drivers/clk/mediatek/clk-mt8365-apu.c b/drivers/clk/mediatek/clk-mt8365-apu.c
index 74f7fb22c87f..4f10ce1531d2 100644
--- a/drivers/clk/mediatek/clk-mt8365-apu.c
+++ b/drivers/clk/mediatek/clk-mt8365-apu.c
@@ -46,7 +46,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8365_apu);
 
 static struct platform_driver clk_mt8365_apu_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8365-apu",
 		.of_match_table = of_match_clk_mt8365_apu,
diff --git a/drivers/clk/mediatek/clk-mt8365-cam.c b/drivers/clk/mediatek/clk-mt8365-cam.c
index 61516e19acd1..fe428a4f1d37 100644
--- a/drivers/clk/mediatek/clk-mt8365-cam.c
+++ b/drivers/clk/mediatek/clk-mt8365-cam.c
@@ -48,7 +48,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8365_cam);
 
 static struct platform_driver clk_mt8365_cam_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8365-cam",
 		.of_match_table = of_match_clk_mt8365_cam,
diff --git a/drivers/clk/mediatek/clk-mt8365-mfg.c b/drivers/clk/mediatek/clk-mt8365-mfg.c
index 4c836c69db4f..4a590284f7e2 100644
--- a/drivers/clk/mediatek/clk-mt8365-mfg.c
+++ b/drivers/clk/mediatek/clk-mt8365-mfg.c
@@ -54,7 +54,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8365_mfg);
 
 static struct platform_driver clk_mt8365_mfg_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8365-mfg",
 		.of_match_table = of_match_clk_mt8365_mfg,
diff --git a/drivers/clk/mediatek/clk-mt8365-vdec.c b/drivers/clk/mediatek/clk-mt8365-vdec.c
index b51571e9da00..233924837c3b 100644
--- a/drivers/clk/mediatek/clk-mt8365-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8365-vdec.c
@@ -54,7 +54,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8365_vdec);
 
 static struct platform_driver clk_mt8365_vdec_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8365-vdec",
 		.of_match_table = of_match_clk_mt8365_vdec,
diff --git a/drivers/clk/mediatek/clk-mt8365-venc.c b/drivers/clk/mediatek/clk-mt8365-venc.c
index 572344645c86..cc063f18e56b 100644
--- a/drivers/clk/mediatek/clk-mt8365-venc.c
+++ b/drivers/clk/mediatek/clk-mt8365-venc.c
@@ -43,7 +43,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8365_venc);
 
 static struct platform_driver clk_mt8365_venc_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8365-venc",
 		.of_match_table = of_match_clk_mt8365_venc,
diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index 6b4e193f648d..e10134dac34b 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -799,7 +799,7 @@ static struct platform_driver clk_mt8365_drv = {
 		.of_match_table = of_match_clk_mt8365,
 	},
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 };
 module_platform_driver(clk_mt8365_drv);
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8516-aud.c b/drivers/clk/mediatek/clk-mt8516-aud.c
index 48340fc7430d..d1e848e78fd5 100644
--- a/drivers/clk/mediatek/clk-mt8516-aud.c
+++ b/drivers/clk/mediatek/clk-mt8516-aud.c
@@ -55,7 +55,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8516_aud);
 
 static struct platform_driver clk_mt8516_aud_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8516-aud",
 		.of_match_table = of_match_clk_mt8516_aud,
diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index 21eb052b0a53..b8ae837c59dc 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -669,7 +669,7 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8516);
 
 static struct platform_driver clk_mt8516_drv = {
 	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
+	.remove_new = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8516",
 		.of_match_table = of_match_clk_mt8516,
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index fd2214c3242f..4816da9c6da4 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -604,7 +604,7 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
 	return r;
 }
 
-static int __mtk_clk_simple_remove(struct platform_device *pdev,
+static void __mtk_clk_simple_remove(struct platform_device *pdev,
 				   struct device_node *node)
 {
 	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
@@ -629,8 +629,6 @@ static int __mtk_clk_simple_remove(struct platform_device *pdev,
 		mtk_clk_unregister_fixed_clks(mcd->fixed_clks,
 					      mcd->num_fixed_clks, clk_data);
 	mtk_free_clk_data(clk_data);
-
-	return 0;
 }
 
 int mtk_clk_pdev_probe(struct platform_device *pdev)
@@ -655,13 +653,15 @@ int mtk_clk_pdev_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
 
-	return __mtk_clk_simple_remove(pdev, node);
+	__mtk_clk_simple_remove(pdev, node);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(mtk_clk_pdev_remove);
 
-int mtk_clk_simple_remove(struct platform_device *pdev)
+void mtk_clk_simple_remove(struct platform_device *pdev)
 {
-	return __mtk_clk_simple_remove(pdev, pdev->dev.of_node);
+	__mtk_clk_simple_remove(pdev, pdev->dev.of_node);
 }
 EXPORT_SYMBOL_GPL(mtk_clk_simple_remove);
 
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index b7a751861fce..cc8070a133a4 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -242,6 +242,6 @@ struct mtk_clk_desc {
 int mtk_clk_pdev_probe(struct platform_device *pdev);
 int mtk_clk_pdev_remove(struct platform_device *pdev);
 int mtk_clk_simple_probe(struct platform_device *pdev);
-int mtk_clk_simple_remove(struct platform_device *pdev);
+void mtk_clk_simple_remove(struct platform_device *pdev);
 
 #endif /* __DRV_CLK_MTK_H */
-- 
2.39.2

