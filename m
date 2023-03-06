Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E962F6AB6B6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 07:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjCFG6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 01:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjCFG57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 01:57:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603F44C37
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 22:57:58 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ4n1-0003ST-N9; Mon, 06 Mar 2023 07:57:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ4n0-002BSI-Bd; Mon, 06 Mar 2023 07:57:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ4mz-002a99-ME; Mon, 06 Mar 2023 07:57:41 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] spi: imx: Convert to platform remove callback returning void
Date:   Mon,  6 Mar 2023 07:57:33 +0100
Message-Id: <20230306065733.2170662-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230306065733.2170662-1-u.kleine-koenig@pengutronix.de>
References: <20230306065733.2170662-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1744; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=UlDEcAQeTLnDJOo9EVbQwCee+YS5RvPcdkVROdgL1H4=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkBY7YVhL31nvYTd99aigldXesE1RDqhSTJAVB0 AVv8bJV6T+JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAWO2AAKCRDB/BR4rcrs CS4DB/9i6Uj1BsU71AURls85hBXt40HJAxsOaqkZ4eIaaYndCUw8SQPPv+tktmQ/JJrYks9Ngze wTnhDYFLrM5MhZqlGWskGAGEUo1qC05FYCpPeFpEaNM79ZaQcDUs3m3KSvCeSifotnU91f1vZ9q Yaaw8W5RWcmLGstHacw99zBgrlVlU791r8m/jM9yBrSeo2+w9/wVkKOuXxP/YdqX8x2BY1SGC73 uPRgHHrv62WP9ZVkSrF8CbFeOu1rTS5Gx2dAw/mAqRmD0JKwr6DhXe5wY1bV+qax0wyRKhULqKY DGI53oNYLOswCuBwRW4VNO3XfrJEbJrSxvb2ok0UtK6xupke
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
 drivers/spi/spi-imx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 6c9c87cd14ca..f128fb296d49 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1848,7 +1848,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int spi_imx_remove(struct platform_device *pdev)
+static void spi_imx_remove(struct platform_device *pdev)
 {
 	struct spi_controller *controller = platform_get_drvdata(pdev);
 	struct spi_imx_data *spi_imx = spi_controller_get_devdata(controller);
@@ -1867,8 +1867,6 @@ static int spi_imx_remove(struct platform_device *pdev)
 	pm_runtime_disable(spi_imx->dev);
 
 	spi_imx_sdma_exit(spi_imx);
-
-	return 0;
 }
 
 static int __maybe_unused spi_imx_runtime_resume(struct device *dev)
@@ -1930,7 +1928,7 @@ static struct platform_driver spi_imx_driver = {
 		   .pm = &imx_spi_pm,
 	},
 	.probe = spi_imx_probe,
-	.remove = spi_imx_remove,
+	.remove_new = spi_imx_remove,
 };
 module_platform_driver(spi_imx_driver);
 
-- 
2.39.1

