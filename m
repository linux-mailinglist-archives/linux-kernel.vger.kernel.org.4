Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913816B681C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjCLQQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjCLQPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:15:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179A537F25
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:15:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOM2-0007sv-AH; Sun, 12 Mar 2023 17:15:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOM1-003f3l-Lj; Sun, 12 Mar 2023 17:15:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOM0-004K9s-OY; Sun, 12 Mar 2023 17:15:24 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 30/30] clk: xilinx: Convert to platform remove callback returning void
Date:   Sun, 12 Mar 2023 17:15:12 +0100
Message-Id: <20230312161512.2715500-31-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2836; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=/rDzIBzAtm47A0FxuDgmfod8dN7hBzvdh87gyR+Fj/4=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkDfqMeEK/Vobkf/pVhqxwG+ebhdSRP3oQMNj38 1vbndIn9E6JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZA36jAAKCRDB/BR4rcrs CXpUCACNQrNswFWo36ck3lJDYrbCZWoN+NTLA8bb7Lnp5R518DWanFyN7Ob2xVR+cm7JbRBnUt6 +SHI2YkPMJhU4kyoqmKi6++mJNF4H+si9Za3s4K4b2Rc2QFf3dIPuXnJB7kBXdJ8f59WNcREX6Z bEnw7wr5DPw6HlsXs2nbPV7KfDYOQ8m9mygkhVfzBN4XFg1FDtP0WQUtJ8MkiY8I0bF5DpcR/Yl JJVrDMs3A5o2hV06M++8YQQgv7f0DY6F0yU8HMBDkT8+edEXBokTBP8btq11qqmd3cNLifEGvjz 7Z+UysCJaWNU0ym20N6wgFHIY+/7sNcT9HfT2+lEc05uAU8l
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
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c | 6 ++----
 drivers/clk/xilinx/xlnx_vcu.c              | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
index eb1dfe7ecc1b..fa829c01a444 100644
--- a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
@@ -593,7 +593,7 @@ static int clk_wzrd_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int clk_wzrd_remove(struct platform_device *pdev)
+static void clk_wzrd_remove(struct platform_device *pdev)
 {
 	int i;
 	struct clk_wzrd *clk_wzrd = platform_get_drvdata(pdev);
@@ -611,8 +611,6 @@ static int clk_wzrd_remove(struct platform_device *pdev)
 	}
 
 	clk_disable_unprepare(clk_wzrd->axi_clk);
-
-	return 0;
 }
 
 static const struct of_device_id clk_wzrd_ids[] = {
@@ -630,7 +628,7 @@ static struct platform_driver clk_wzrd_driver = {
 		.pm = &clk_wzrd_dev_pm_ops,
 	},
 	.probe = clk_wzrd_probe,
-	.remove = clk_wzrd_remove,
+	.remove_new = clk_wzrd_remove,
 };
 module_platform_driver(clk_wzrd_driver);
 
diff --git a/drivers/clk/xilinx/xlnx_vcu.c b/drivers/clk/xilinx/xlnx_vcu.c
index 54b44debfd3e..0786f15ebbe8 100644
--- a/drivers/clk/xilinx/xlnx_vcu.c
+++ b/drivers/clk/xilinx/xlnx_vcu.c
@@ -702,7 +702,7 @@ static int xvcu_probe(struct platform_device *pdev)
  * Return:	Returns 0 on success
  *		Negative error code otherwise
  */
-static int xvcu_remove(struct platform_device *pdev)
+static void xvcu_remove(struct platform_device *pdev)
 {
 	struct xvcu_device *xvcu;
 
@@ -714,8 +714,6 @@ static int xvcu_remove(struct platform_device *pdev)
 	regmap_write(xvcu->logicore_reg_ba, VCU_GASKET_INIT, 0);
 
 	clk_disable_unprepare(xvcu->aclk);
-
-	return 0;
 }
 
 static const struct of_device_id xvcu_of_id_table[] = {
@@ -731,7 +729,7 @@ static struct platform_driver xvcu_driver = {
 		.of_match_table = xvcu_of_id_table,
 	},
 	.probe                  = xvcu_probe,
-	.remove                 = xvcu_remove,
+	.remove_new             = xvcu_remove,
 };
 
 module_platform_driver(xvcu_driver);
-- 
2.39.1

