Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408286B681E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjCLQQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjCLQPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:15:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3831F37F30
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:15:36 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOM1-0007ru-D5; Sun, 12 Mar 2023 17:15:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOM0-003f3N-Lm; Sun, 12 Mar 2023 17:15:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLz-004K9d-Sr; Sun, 12 Mar 2023 17:15:23 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 26/30] clk: tegra: Convert to platform remove callback returning void
Date:   Sun, 12 Mar 2023 17:15:08 +0100
Message-Id: <20230312161512.2715500-27-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1980; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=x6okcs6Su+YD3uh5eJbZ5VyDAW7RapD+fKHvx8TVC4A=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkDfp9rzArRWRh7p5ABLZY7wv3BgO+zzrr/0PIT TmIX5WS8WqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZA36fQAKCRDB/BR4rcrs CYAwB/9sx5f5Twyck2oZkwirbVUmDa8bdOpezb6m36WniA/NzZgfYeh6B5WTaPUjQN0+PBWBI5m 2kGMctIojvHOvILTna14KpOF7LYZBM5D/p1NFZae3aV1pku5YOZbRHXvxcYIO8AqBOwDpUGWv6A yeUf2N+58kNeg2xv1/9mQchOfaqMqIV5iep/c6QpwaCv4x/KYmq+wHT/HpFsgjaFRUbdfSw6Z0x eL8bkcHlVxJlyXcWkl67Ch83BCNVTbfd35ZxKSdBPGh4WwfOtXPhwKTi6/XfDz8VrF5U+W1KJNy cKZRM4sVxoYD7Uw3wgOp6B4/p0dTzMgsZup74K7Byi6I/MKX
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
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
index 15c5e14dd82f..2a164e565c86 100644
--- a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
+++ b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
@@ -612,7 +612,7 @@ static int tegra124_dfll_fcpu_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int tegra124_dfll_fcpu_remove(struct platform_device *pdev)
+static void tegra124_dfll_fcpu_remove(struct platform_device *pdev)
 {
 	struct tegra_dfll_soc_data *soc;
 
@@ -622,11 +622,9 @@ static int tegra124_dfll_fcpu_remove(struct platform_device *pdev)
 	 */
 	soc = tegra_dfll_unregister(pdev);
 	if (IS_ERR(soc))
-		return 0;
+		return;
 
 	tegra_cvb_remove_opp_table(soc->dev, soc->cvb, soc->max_freq);
-
-	return 0;
 }
 
 static const struct dev_pm_ops tegra124_dfll_pm_ops = {
@@ -637,7 +635,7 @@ static const struct dev_pm_ops tegra124_dfll_pm_ops = {
 
 static struct platform_driver tegra124_dfll_fcpu_driver = {
 	.probe = tegra124_dfll_fcpu_probe,
-	.remove = tegra124_dfll_fcpu_remove,
+	.remove_new = tegra124_dfll_fcpu_remove,
 	.driver = {
 		.name = "tegra124-dfll",
 		.of_match_table = tegra124_dfll_fcpu_of_match,
-- 
2.39.1

