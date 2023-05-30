Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D76F715680
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjE3HTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjE3HTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:19:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67798FA
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:19:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3tda-0006UT-7R; Tue, 30 May 2023 09:19:22 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3tdY-003orP-Dp; Tue, 30 May 2023 09:19:20 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3tdX-009OQx-LX; Tue, 30 May 2023 09:19:19 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 5/6] usb: xhci-tegra: Convert to platform remove callback returning void
Date:   Tue, 30 May 2023 09:19:12 +0200
Message-Id: <20230530071913.2192214-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230530071913.2192214-1-u.kleine-koenig@pengutronix.de>
References: <20230530071913.2192214-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1988; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=D03RaPledHkbDmX3jxjjjIz2QcRcNBKlRdfPy+QWwm4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkdaNtHEwbsEmoBDCMj25ZlRvDNhIjatU2qBWai wGtSKOpjQ2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZHWjbQAKCRCPgPtYfRL+ ToxgCACfJvxTpMm3VLewY6OdSuWp1MRkbZo/35viwLR3ueU/OLqFsZg+kPpusf67m5Uyu9aKaLr gUELWDbxsIUuKI0dRGoN0Y8Cv5m7dU+EtcwXYiOev8/7NGreQlS8XjcZtAezL8wVVG1UDQdftiT KccCp1tjU4DEB5JKSirTqfudX8yKCDL/+dJOJlrWe+joyXan4IQ7S4sp4X1zkiINVpffu3adu0d 40Hhj5AJitqcTjVkJ81Hl+B6eti6iv9MxmymDbKGbqbIsIbjJ4EHNpy4t2kS2bkBWsX2AJdPCxu AUAEGYvRwXAU75ghpFhkFnMrNJJXyX7Wa5MnxpnZB/4UkycR
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

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/usb/host/xhci-tegra.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 393e2c8064bd..f124483044a2 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1912,7 +1912,7 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int tegra_xusb_remove(struct platform_device *pdev)
+static void tegra_xusb_remove(struct platform_device *pdev)
 {
 	struct tegra_xusb *tegra = platform_get_drvdata(pdev);
 	struct xhci_hcd *xhci = hcd_to_xhci(tegra->hcd);
@@ -1942,8 +1942,6 @@ static int tegra_xusb_remove(struct platform_device *pdev)
 	tegra_xusb_clk_disable(tegra);
 	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
 	tegra_xusb_padctl_put(tegra->padctl);
-
-	return 0;
 }
 
 static bool xhci_hub_ports_suspended(struct xhci_hub *hub)
@@ -2653,7 +2651,7 @@ MODULE_DEVICE_TABLE(of, tegra_xusb_of_match);
 
 static struct platform_driver tegra_xusb_driver = {
 	.probe = tegra_xusb_probe,
-	.remove = tegra_xusb_remove,
+	.remove_new = tegra_xusb_remove,
 	.driver = {
 		.name = "tegra-xusb",
 		.pm = &tegra_xusb_pm_ops,
-- 
2.39.2

