Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13D36B67E6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjCLQPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjCLQP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:15:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E7934315
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:15:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLz-0007pu-1m; Sun, 12 Mar 2023 17:15:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLy-003f2a-Cn; Sun, 12 Mar 2023 17:15:22 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLx-004K8s-5U; Sun, 12 Mar 2023 17:15:21 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 14/30] clk: s2mps11: Convert to platform remove callback returning void
Date:   Sun, 12 Mar 2023 17:14:56 +0100
Message-Id: <20230312161512.2715500-15-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1740; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Xs0m+ONUFGBzpqo3SPbXN28Ib5a63TFdvYWV7zGlfsI=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkDfpJeN2QBtTOvNJ2F99zBqvIKWPabOgHyKqCE GHByGUriRyJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZA36SQAKCRDB/BR4rcrs CQtxCACghEFEdA2KmcHIGePbaODwj7iMAWEjhR/wD5aQJdtZ+QPkD7iWot+aOH6J2zc72h4xNiz klix6posKc6ApOT3ZNmySv5rOxBBGvEgYgXBlRFhh2tYTMJCNRX6gNcfGd8FXeE/tgeE6cwo2Fe XUt+if/1ZWQVkqGGnjmLkHeD9gddXgMXAS9hQOXJ/7Zp3aKk+OlZHkshhTYLfG06PtHlzUtvBgZ qDlfe7g9ie/Ad7ZUMMcPi5263EwpyuwfoDrHw/YQYPISTvG95md+OuDZm87SItQPHUda+2xH0Ym OVQTdsDDf88Xk31Zg028niO7pIfa+5aYI+hBKGq3Evy3axzm
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/clk/clk-s2mps11.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-s2mps11.c b/drivers/clk/clk-s2mps11.c
index a3e883a9f406..38c456540d1b 100644
--- a/drivers/clk/clk-s2mps11.c
+++ b/drivers/clk/clk-s2mps11.c
@@ -202,7 +202,7 @@ static int s2mps11_clk_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int s2mps11_clk_remove(struct platform_device *pdev)
+static void s2mps11_clk_remove(struct platform_device *pdev)
 {
 	struct s2mps11_clk *s2mps11_clks = platform_get_drvdata(pdev);
 	int i;
@@ -217,8 +217,6 @@ static int s2mps11_clk_remove(struct platform_device *pdev)
 			continue;
 		clkdev_drop(s2mps11_clks[i].lookup);
 	}
-
-	return 0;
 }
 
 static const struct platform_device_id s2mps11_clk_id[] = {
@@ -265,7 +263,7 @@ static struct platform_driver s2mps11_clk_driver = {
 		.name  = "s2mps11-clk",
 	},
 	.probe = s2mps11_clk_probe,
-	.remove = s2mps11_clk_remove,
+	.remove_new = s2mps11_clk_remove,
 	.id_table = s2mps11_clk_id,
 };
 module_platform_driver(s2mps11_clk_driver);
-- 
2.39.1

