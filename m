Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FF76B681D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjCLQQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjCLQPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:15:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CC23803E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:15:36 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOM1-0007sa-Tp; Sun, 12 Mar 2023 17:15:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOM1-003f3a-9C; Sun, 12 Mar 2023 17:15:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOM0-004K9k-BN; Sun, 12 Mar 2023 17:15:24 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 28/30] clk: uniphier: Convert to platform remove callback returning void
Date:   Sun, 12 Mar 2023 17:15:10 +0100
Message-Id: <20230312161512.2715500-29-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1683; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=k2hk+THTHlfsffOg5cgLVPYHlE54dpLVDOQ8OZNammU=; b=owGbwMvMwMV48I9IxdpTbzgZT6slMaTw/mp5stz1XLPr+ZOT7l8LZ7d3b7venXIpVvtw928Hv +yYEyIzOxmNWRgYuRhkxRRZ6oq0xCZIrPlvV7KEG2YQKxPIFAYuTgGYSGMO+z+rn0wFKXFxgrbu m6Il2MOSvs5pesCydlndp7DO8ge9Nl+4ZYyieO+y/7kwb56s36GtUgvLbDetLQjW+d1corfF6XO xuNuW1wYLM4r3KyYkOzj2tqq/yPqe98vVRv5B+y2xF2b3NmrKWAoqpU19lr2f8bmwq9vz01yThE MZ3Zx/bk60Ot+5v/7K0u+/fQ7na0WIRjTeEm5P2/zvd9kDpzBB4VlVRasFQuOEfhpLZ395HH/dc PuKfw4mhiKqu2L3dLt77u9f8GTxmSlJU0IbKqqTs7suepn8q37fuv/pblXd7i8CdmXrThyxqzUL 2p36hFOqdWK126IiyeoYB8mlYky6vKufTuJV1rovGWMDAA==
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
 drivers/clk/uniphier/clk-uniphier-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/uniphier/clk-uniphier-core.c b/drivers/clk/uniphier/clk-uniphier-core.c
index 46c66fac48e6..92f4ddc593db 100644
--- a/drivers/clk/uniphier/clk-uniphier-core.c
+++ b/drivers/clk/uniphier/clk-uniphier-core.c
@@ -91,11 +91,9 @@ static int uniphier_clk_probe(struct platform_device *pdev)
 				      hw_data);
 }
 
-static int uniphier_clk_remove(struct platform_device *pdev)
+static void uniphier_clk_remove(struct platform_device *pdev)
 {
 	of_clk_del_provider(pdev->dev.of_node);
-
-	return 0;
 }
 
 static const struct of_device_id uniphier_clk_match[] = {
@@ -220,7 +218,7 @@ static const struct of_device_id uniphier_clk_match[] = {
 
 static struct platform_driver uniphier_clk_driver = {
 	.probe = uniphier_clk_probe,
-	.remove = uniphier_clk_remove,
+	.remove_new = uniphier_clk_remove,
 	.driver = {
 		.name = "uniphier-clk",
 		.of_match_table = uniphier_clk_match,
-- 
2.39.1

