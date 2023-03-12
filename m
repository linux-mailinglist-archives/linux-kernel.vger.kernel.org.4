Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886FC6B6810
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjCLQQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjCLQP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:15:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF55B36FE6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:15:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLz-0007qO-L1; Sun, 12 Mar 2023 17:15:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLz-003f2p-0t; Sun, 12 Mar 2023 17:15:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLx-004K95-PW; Sun, 12 Mar 2023 17:15:21 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 17/30] clk: hisilicon: Convert to platform remove callback returning void
Date:   Sun, 12 Mar 2023 17:14:59 +0100
Message-Id: <20230312161512.2715500-18-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4540; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ye2ciOe3ofcc3K17gZT5m+pVFUUGsOAA71z95jRxpm8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkDfpZYl0t5migPG1PjAdI329B/YUO9BRpg/aQo +sxDkpiF62JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZA36WQAKCRDB/BR4rcrs CchQB/4q6JLHgZDa5Q1lmNGpDZvTaCp3hDH/26zUQyE+2WQC5S2bSle6rZaAY9hvXKgoHosyjbO KW0D2iuC3e6IzZv//VKTgFTH+uiX7IsKMJA254NCW5cRiqg5IJdlELZFkiq20r41SyRAk9p2Dgo Kf4Jl5dD0BKg7TSO60d9JhBxsgnvJhVCwNoOsz1I6w1abrFXw6FMT8V7ulnkaY2OkIr7lqWxVea Gs0+AkUcMh3lS8SFJpJQmoRnPg/E/lNhblOz92FIJb7f54SoKBwm9h9tpJT/pt6N+YbQuLcJ251 k2I31+a6JmBJvgLwLqJxbknc7yLaQlwbVJ/78xd+OLAUZXcx
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
 drivers/clk/hisilicon/clk-hi3519.c      | 5 ++---
 drivers/clk/hisilicon/clk-hi3559a.c     | 5 ++---
 drivers/clk/hisilicon/crg-hi3516cv300.c | 5 ++---
 drivers/clk/hisilicon/crg-hi3798cv200.c | 5 ++---
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3519.c b/drivers/clk/hisilicon/clk-hi3519.c
index ad0c7f350cf0..b871872d9960 100644
--- a/drivers/clk/hisilicon/clk-hi3519.c
+++ b/drivers/clk/hisilicon/clk-hi3519.c
@@ -162,13 +162,12 @@ static int hi3519_clk_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int hi3519_clk_remove(struct platform_device *pdev)
+static void hi3519_clk_remove(struct platform_device *pdev)
 {
 	struct hi3519_crg_data *crg = platform_get_drvdata(pdev);
 
 	hisi_reset_exit(crg->rstc);
 	hi3519_clk_unregister(pdev);
-	return 0;
 }
 
 
@@ -180,7 +179,7 @@ MODULE_DEVICE_TABLE(of, hi3519_clk_match_table);
 
 static struct platform_driver hi3519_clk_driver = {
 	.probe          = hi3519_clk_probe,
-	.remove		= hi3519_clk_remove,
+	.remove_new	= hi3519_clk_remove,
 	.driver         = {
 		.name   = "hi3519-clk",
 		.of_match_table = hi3519_clk_match_table,
diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisilicon/clk-hi3559a.c
index 9ea1a80acbe8..4f97638809b7 100644
--- a/drivers/clk/hisilicon/clk-hi3559a.c
+++ b/drivers/clk/hisilicon/clk-hi3559a.c
@@ -810,18 +810,17 @@ static int hi3559av100_crg_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int hi3559av100_crg_remove(struct platform_device *pdev)
+static void hi3559av100_crg_remove(struct platform_device *pdev)
 {
 	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
 
 	hisi_reset_exit(crg->rstc);
 	crg->funcs->unregister_clks(pdev);
-	return 0;
 }
 
 static struct platform_driver hi3559av100_crg_driver = {
 	.probe		= hi3559av100_crg_probe,
-	.remove		= hi3559av100_crg_remove,
+	.remove_new	= hi3559av100_crg_remove,
 	.driver		= {
 		.name	= "hi3559av100-clock",
 		.of_match_table = hi3559av100_crg_match_table,
diff --git a/drivers/clk/hisilicon/crg-hi3516cv300.c b/drivers/clk/hisilicon/crg-hi3516cv300.c
index 5d4e61c7a429..fe1bd3e3f988 100644
--- a/drivers/clk/hisilicon/crg-hi3516cv300.c
+++ b/drivers/clk/hisilicon/crg-hi3516cv300.c
@@ -284,18 +284,17 @@ static int hi3516cv300_crg_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int hi3516cv300_crg_remove(struct platform_device *pdev)
+static void hi3516cv300_crg_remove(struct platform_device *pdev)
 {
 	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
 
 	hisi_reset_exit(crg->rstc);
 	crg->funcs->unregister_clks(pdev);
-	return 0;
 }
 
 static struct platform_driver hi3516cv300_crg_driver = {
 	.probe          = hi3516cv300_crg_probe,
-	.remove		= hi3516cv300_crg_remove,
+	.remove_new	= hi3516cv300_crg_remove,
 	.driver         = {
 		.name   = "hi3516cv300-crg",
 		.of_match_table = hi3516cv300_crg_match_table,
diff --git a/drivers/clk/hisilicon/crg-hi3798cv200.c b/drivers/clk/hisilicon/crg-hi3798cv200.c
index 08a19ba776e6..a0b16be1e25d 100644
--- a/drivers/clk/hisilicon/crg-hi3798cv200.c
+++ b/drivers/clk/hisilicon/crg-hi3798cv200.c
@@ -367,18 +367,17 @@ static int hi3798cv200_crg_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int hi3798cv200_crg_remove(struct platform_device *pdev)
+static void hi3798cv200_crg_remove(struct platform_device *pdev)
 {
 	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
 
 	hisi_reset_exit(crg->rstc);
 	crg->funcs->unregister_clks(pdev);
-	return 0;
 }
 
 static struct platform_driver hi3798cv200_crg_driver = {
 	.probe          = hi3798cv200_crg_probe,
-	.remove		= hi3798cv200_crg_remove,
+	.remove_new	= hi3798cv200_crg_remove,
 	.driver         = {
 		.name   = "hi3798cv200-crg",
 		.of_match_table = hi3798cv200_crg_match_table,
-- 
2.39.1

