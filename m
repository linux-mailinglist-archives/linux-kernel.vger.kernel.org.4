Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1356B6808
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjCLQPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjCLQP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:15:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A8E34F6E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:15:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLw-0007nq-TQ; Sun, 12 Mar 2023 17:15:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLv-003f1f-VK; Sun, 12 Mar 2023 17:15:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLv-004K8F-0R; Sun, 12 Mar 2023 17:15:19 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/30] clk: axs10x: Convert to platform remove callback returning void
Date:   Sun, 12 Mar 2023 17:14:46 +0100
Message-Id: <20230312161512.2715500-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2548; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=2+AKW+R5wH4GK/jKdVXZCGQtxTtTB3ZfwzT0vCy4l2Y=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkDfohCZeQbQcyatfA51UEI5TxekIaUWA95adcy p2NyIHnOz2JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZA36IQAKCRDB/BR4rcrs CY/mB/0WQIPWqZ53K/EQqG+hwp2fYUlyTZEsHehWIeMopqBKPAPHnhiYAwcqjGohu2VzZ12XoUD 4omlGnxcU2kvZWKcPSX5oXuj3iyfxtUykePqa4Lpam8EbDNPz82AKj+sx2HnQYGeAH+NOW4bmT2 2u/SZWzo8zh1efVFFsqOBQnHlvjmhr2ATVI5/klRxPXvjdf19/UhgIobUuVpUFiM179njMmthkV t+SD0EoKqLVvVpUit3AcDC/Zp/6zIZ2KB6O6+ZZIjwasunMTa5Vu8wksds4CcUDrs/9jbNvhLfy mJGgXfG3jH0bXg0lhfuFLy+AoDmFA6inhNmNPt8w5aYl76X7
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
 drivers/clk/axs10x/i2s_pll_clock.c | 5 ++---
 drivers/clk/axs10x/pll_clock.c     | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/axs10x/i2s_pll_clock.c b/drivers/clk/axs10x/i2s_pll_clock.c
index e1fda6ad5cd5..2334e6c334cf 100644
--- a/drivers/clk/axs10x/i2s_pll_clock.c
+++ b/drivers/clk/axs10x/i2s_pll_clock.c
@@ -198,10 +198,9 @@ static int i2s_pll_clk_probe(struct platform_device *pdev)
 	return of_clk_add_provider(node, of_clk_src_simple_get, clk);
 }
 
-static int i2s_pll_clk_remove(struct platform_device *pdev)
+static void i2s_pll_clk_remove(struct platform_device *pdev)
 {
 	of_clk_del_provider(pdev->dev.of_node);
-	return 0;
 }
 
 static const struct of_device_id i2s_pll_clk_id[] = {
@@ -216,7 +215,7 @@ static struct platform_driver i2s_pll_clk_driver = {
 		.of_match_table = i2s_pll_clk_id,
 	},
 	.probe = i2s_pll_clk_probe,
-	.remove = i2s_pll_clk_remove,
+	.remove_new = i2s_pll_clk_remove,
 };
 module_platform_driver(i2s_pll_clk_driver);
 
diff --git a/drivers/clk/axs10x/pll_clock.c b/drivers/clk/axs10x/pll_clock.c
index 90fb0e6ff573..dbbfa12e530d 100644
--- a/drivers/clk/axs10x/pll_clock.c
+++ b/drivers/clk/axs10x/pll_clock.c
@@ -257,10 +257,9 @@ static int axs10x_pll_clk_probe(struct platform_device *pdev)
 			&pll_clk->hw);
 }
 
-static int axs10x_pll_clk_remove(struct platform_device *pdev)
+static void axs10x_pll_clk_remove(struct platform_device *pdev)
 {
 	of_clk_del_provider(pdev->dev.of_node);
-	return 0;
 }
 
 static void __init of_axs10x_pll_clk_setup(struct device_node *node)
@@ -332,7 +331,7 @@ static struct platform_driver axs10x_pll_clk_driver = {
 		.of_match_table = axs10x_pll_clk_id,
 	},
 	.probe = axs10x_pll_clk_probe,
-	.remove = axs10x_pll_clk_remove,
+	.remove_new = axs10x_pll_clk_remove,
 };
 builtin_platform_driver(axs10x_pll_clk_driver);
 
-- 
2.39.1

