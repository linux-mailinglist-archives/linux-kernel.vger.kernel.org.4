Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429366A8488
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjCBOsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjCBOrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:47:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827FE474E3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:47:49 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDb-0003rJ-BC; Thu, 02 Mar 2023 15:47:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDa-001LrC-Bs; Thu, 02 Mar 2023 15:47:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDZ-001Zpi-Kt; Thu, 02 Mar 2023 15:47:37 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Santosh Kumar Yadav <santoshkumar.yadav@barco.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/29] platform/x86: barco-p50-gpio: Convert to platform remove callback returning void
Date:   Thu,  2 Mar 2023 15:47:10 +0100
Message-Id: <20230302144732.1903781-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
References: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1730; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=3SITRhRSsSiq5nNlw0cLw6UVXc4FMRsIXWa8cM62MP8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkALade3Gi1p/sJd8H8iXfaMV7bNpT7R16FeAlt mHVTQ9i3e+JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAC2nQAKCRDB/BR4rcrs CYxWB/0T9N2ZDz5pxanXc2jdn15Ou5okIo+OA378H8eFhJmwvYWT8z4crokjCAlcWEzwa4cv+3P +rZX9fAQRiNbIBH8+1OCOBVoPTZ5k9omOFb0s2QMgmXfEgi/daEjB5wJmBGpaCZVYw92pbn5D7A qKn1YLoQctNI8bhW9gbeLMNaG0IwGNHMGywnxwYb7ruLPvybqYBRSqLRJz7Mcal0jXC/D0djcPz tShBXQRNLFixNR4CiyoKY5vkLOn0YIYt8Wt8cXDxU3SLtxsyUM74CIsVAonZCEdNUeJRGYFVhOy bv6cuIeSpFDjQOK/272o5cD/s88jM+6NiCRI3Wxy0lhvfase
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
 drivers/platform/x86/barco-p50-gpio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/barco-p50-gpio.c b/drivers/platform/x86/barco-p50-gpio.c
index 8dd672339485..af566f712057 100644
--- a/drivers/platform/x86/barco-p50-gpio.c
+++ b/drivers/platform/x86/barco-p50-gpio.c
@@ -370,7 +370,7 @@ static int p50_gpio_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int p50_gpio_remove(struct platform_device *pdev)
+static void p50_gpio_remove(struct platform_device *pdev)
 {
 	struct p50_gpio *p50 = platform_get_drvdata(pdev);
 
@@ -378,8 +378,6 @@ static int p50_gpio_remove(struct platform_device *pdev)
 	platform_device_unregister(p50->leds_pdev);
 
 	gpiod_remove_lookup_table(&p50_gpio_led_table);
-
-	return 0;
 }
 
 static struct platform_driver p50_gpio_driver = {
@@ -387,7 +385,7 @@ static struct platform_driver p50_gpio_driver = {
 		.name = DRIVER_NAME,
 	},
 	.probe = p50_gpio_probe,
-	.remove = p50_gpio_remove,
+	.remove_new = p50_gpio_remove,
 };
 
 /* Board setup */
-- 
2.39.1

