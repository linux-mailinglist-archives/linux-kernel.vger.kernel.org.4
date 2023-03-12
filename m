Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086096B67F6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjCLQPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjCLQP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:15:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A1F360A6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:15:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLx-0007o3-1M; Sun, 12 Mar 2023 17:15:21 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLw-003f1t-Cq; Sun, 12 Mar 2023 17:15:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLv-004K8Q-KQ; Sun, 12 Mar 2023 17:15:19 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/30] clk: axm5516: Convert to platform remove callback returning void
Date:   Sun, 12 Mar 2023 17:14:49 +0100
Message-Id: <20230312161512.2715500-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1476; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Z5GZGSWh1Ob3UU9gNPR0/87sU8eq9KSI3jE46vXFDkE=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkDfosgNnsKcQ5XSf7NAX95edm3ujMAoDJwz6/R Mk2ZKLHpVyJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZA36LAAKCRDB/BR4rcrs CQBWB/98UBHvsgDINIPdwRsZL4ctsKFwArIpzt4SV/h+vGyGnWA7vRU1ZCXRJ7PybolnKOKeRAm ga0pTo0ZXWZIkYqieTwKAmWP3zJVfYTpfi9BuqbPD59JGfLCIFRSWJ4RNTxBXw9t+5cHJL9YfLR aYoghaJHTmF9s2TRa7jviqiY40f0WUV2FLSClIC3v/aQoLblBTDCqqESDZSZ4FfmsDTk7Wg+M4k 9pAN+bfcvKP7RhpCBZPv9ED9jPtvdDQgV7lBPYeg6wKScob/qzLWkIjp+MDOC1xm2RaojFptZ0K KWsa8qoAPRZVGPxHp9WyHe+kfGYEx+NMV/U8QjydRexgF8TG
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
 drivers/clk/clk-axm5516.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-axm5516.c b/drivers/clk/clk-axm5516.c
index 07e80fe8c310..1dff2017ad9d 100644
--- a/drivers/clk/clk-axm5516.c
+++ b/drivers/clk/clk-axm5516.c
@@ -572,15 +572,14 @@ static int axmclk_probe(struct platform_device *pdev)
 	return of_clk_add_hw_provider(dev->of_node, of_clk_axmclk_get, NULL);
 }
 
-static int axmclk_remove(struct platform_device *pdev)
+static void axmclk_remove(struct platform_device *pdev)
 {
 	of_clk_del_provider(pdev->dev.of_node);
-	return 0;
 }
 
 static struct platform_driver axmclk_driver = {
 	.probe		= axmclk_probe,
-	.remove		= axmclk_remove,
+	.remove_new	= axmclk_remove,
 	.driver		= {
 		.name	= "clk-axm5516",
 		.of_match_table = axmclk_match_table,
-- 
2.39.1

