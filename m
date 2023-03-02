Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73CD6A8477
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjCBOsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjCBOru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:47:50 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A62F46081
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:47:48 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDb-0003rU-85; Thu, 02 Mar 2023 15:47:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDa-001LrI-Jk; Thu, 02 Mar 2023 15:47:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDZ-001Zpm-R3; Thu, 02 Mar 2023 15:47:37 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Cezary Jackiewicz <cezary.jackiewicz@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/29] platform/x86: compal-laptop: Convert to platform remove callback returning void
Date:   Thu,  2 Mar 2023 15:47:11 +0100
Message-Id: <20230302144732.1903781-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
References: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1864; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=2FcRCflJvaecUEGlqoFBbAQbmPoh+cHoMH2b86C4p0s=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkALahfyGEbwyFIZ/2N0J3qj3ymTNB0KR+nuX8B LhaekOFqSKJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAC2oQAKCRDB/BR4rcrs CWw6B/0SqxTeIkpbjeLgeQn8QgLD1ZpxFqsb+bXQ27zzQLCQtd9LZfgQJooPS71cLRZBGxZRj7b oOg2tNB4Kz4YnTB4C2rO4QzPcGUbwTXJAep9yZUPvY+1DSbKRrbfM8VbjT1DctOXnr2T6NVHz24 /WXcZJSHCkeDyVR+6pF05Ya9VEE1MjGnqvhAf2fsef5HSnUoAPK/i5Od/NobCYHal2/lVx+V9Hx 5JXgoNCzyusPjbvAyD8/1whKljMWg6DPkpT/eAvJnltCvBr1bVa/IrkAStsJD/RNmmu/glYLaJP zyYZUFpVOARSzTCTYPDtr+5dnutCmfmaQIFNdtsDMt97C8BJ
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
 drivers/platform/x86/compal-laptop.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/compal-laptop.c b/drivers/platform/x86/compal-laptop.c
index e10d2f64dfad..61c745490d71 100644
--- a/drivers/platform/x86/compal-laptop.c
+++ b/drivers/platform/x86/compal-laptop.c
@@ -1003,12 +1003,12 @@ static int compal_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int compal_remove(struct platform_device *pdev)
+static void compal_remove(struct platform_device *pdev)
 {
 	struct compal_data *data;
 
 	if (!extra_features)
-		return 0;
+		return;
 
 	pr_info("Unloading: resetting fan control to motherboard\n");
 	pwm_disable_control();
@@ -1017,8 +1017,6 @@ static int compal_remove(struct platform_device *pdev)
 	power_supply_unregister(data->psy);
 
 	sysfs_remove_group(&pdev->dev.kobj, &compal_platform_attr_group);
-
-	return 0;
 }
 
 static struct platform_driver compal_driver = {
@@ -1026,7 +1024,7 @@ static struct platform_driver compal_driver = {
 		.name = DRIVER_NAME,
 	},
 	.probe	= compal_probe,
-	.remove	= compal_remove,
+	.remove_new = compal_remove,
 };
 
 static int __init compal_init(void)
-- 
2.39.1

