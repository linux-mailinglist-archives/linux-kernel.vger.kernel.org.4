Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E7C715683
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjE3HUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjE3HTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:19:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1277B185
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:19:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3tda-0006UR-VG; Tue, 30 May 2023 09:19:23 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3tdY-003orL-BX; Tue, 30 May 2023 09:19:20 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3tdX-009OQq-6I; Tue, 30 May 2023 09:19:19 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v2 3/6] usb: xhci-mtk: Convert to platform remove callback returning void
Date:   Tue, 30 May 2023 09:19:10 +0200
Message-Id: <20230530071913.2192214-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230530071913.2192214-1-u.kleine-koenig@pengutronix.de>
References: <20230530071913.2192214-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1962; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=RinVfZYjAScwU7jEpi6Dz9/WO/ViUXjuFQrBaAhOb1w=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkdaNrHSUjvY7u/dQD2YJ/vxI2vJy7rtRQ7QLtD qNgRQmQVyKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZHWjawAKCRCPgPtYfRL+ TnkrB/9LiRr878SVBC3p+kwbWsp4YeWJUwXVWtY6TnRl+gt29oeuPcTuXlXau7LXhDf5/NIQBi/ fVD2KW3vabRfI2tkjSDFTvNVW8yE27rdQenfmn0eI08GZpUygumXtVJlotokQqTlLSmbqco2Lh4 fWvhlob6tyk5cc+NzlMLa0qZFm09SDAhtPmCb7jTFsBYjUvTskWOU5aJebYvRGc35KNJURDMyvZ P9FCeVWVqT715HfyPLsSRZ7pvpwyUs2iTA0mhJRXz72LAD9H7B0bNXhAtTQrp3cSCb5irOJmuHj kJrXxHBq9I/U4DEpa5IdPl5dRx0vh2cHF9tzpSDa+IQbyWN5
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

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart from
emitting a warning) and this typically results in resource leaks. To improve
here there is a quest to make the remove callback return void. In the first
step of this quest all drivers are converted to .remove_new() which already
returns void. Eventually after all drivers are converted, .remove_new() is
renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/usb/host/xhci-mtk.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 90cf40d6d0c3..8d9a55b0281b 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -673,7 +673,7 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int xhci_mtk_remove(struct platform_device *pdev)
+static void xhci_mtk_remove(struct platform_device *pdev)
 {
 	struct xhci_hcd_mtk *mtk = platform_get_drvdata(pdev);
 	struct usb_hcd	*hcd = mtk->hcd;
@@ -703,8 +703,6 @@ static int xhci_mtk_remove(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);
 	pm_runtime_set_suspended(dev);
-
-	return 0;
 }
 
 static int __maybe_unused xhci_mtk_suspend(struct device *dev)
@@ -824,7 +822,7 @@ MODULE_DEVICE_TABLE(of, mtk_xhci_of_match);
 
 static struct platform_driver mtk_xhci_driver = {
 	.probe	= xhci_mtk_probe,
-	.remove	= xhci_mtk_remove,
+	.remove_new = xhci_mtk_remove,
 	.driver	= {
 		.name = "xhci-mtk",
 		.pm = DEV_PM_OPS,
-- 
2.39.2

