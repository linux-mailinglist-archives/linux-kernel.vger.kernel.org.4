Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14414710952
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240770AbjEYJ4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240747AbjEYJ4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:56:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6251A6
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:56:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q27hv-000884-9M; Thu, 25 May 2023 11:56:31 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q27hu-002h3C-9C; Thu, 25 May 2023 11:56:30 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q27ht-007oDN-Ir; Thu, 25 May 2023 11:56:29 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Philipp Marek <philipp@marek.priv.at>
Subject: [PATCH 2/3] w1: gpio: Drop unused enable_external_pullup from driver data
Date:   Thu, 25 May 2023 11:56:23 +0200
Message-Id: <20230525095624.615350-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525095624.615350-1-u.kleine-koenig@pengutronix.de>
References: <20230525095624.615350-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2219; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=wlk+inFMM6onbNsMp3REBJLwSwRlU4DLnUXy0UUy6ZY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkbzDGZTn3s1FWL0WrHWwKlkcG51UN8vqGmFIrs Jz6JarQPhCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZG8wxgAKCRCPgPtYfRL+ Tqn8B/4xpUWG5boSPk0b/zSVHy/EQND0ai9bQh5ZaH7oOIQ3iQ4nMrw9hJy0n7KkN2HJUa9QjF3 a20Q1/MD89URMBEKkhGT3muNeWQPNd7siBDXBRe5KMTCUttoz4FiRx7Q54aQa6UGskZ1B9w1Edu KZj6vc9iXYflF/JWuNPNeRudcbxRniIw3rJAQEkYyD/a0Zp2p9tjK3Vk8qcvYECxVqpr5LzMONT +FrKQVNTvBbtjbbFfVRoGxeZIS156FeUTUAHc8Sxe9h+GX+qARmHw7kRDwrI9i6wL2Ea7mgmtUO UJKfqB5rJ9Uosqky9S0Y1Loq3bxtjjr2nabOfOgE1CYnyW/F
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This member is always NULL, so drop it. That makes the suspend and
resume callbacks empty, so they can be dropped, too.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/w1/masters/w1-gpio.c | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/drivers/w1/masters/w1-gpio.c b/drivers/w1/masters/w1-gpio.c
index 8d65db65178c..67596428f69b 100644
--- a/drivers/w1/masters/w1-gpio.c
+++ b/drivers/w1/masters/w1-gpio.c
@@ -20,7 +20,6 @@
 struct w1_gpio_ddata {
 	struct gpio_desc *gpiod;
 	struct gpio_desc *pullup_gpiod;
-	void (*enable_external_pullup)(int enable);
 	unsigned int pullup_duration;
 };
 
@@ -134,9 +133,6 @@ static int w1_gpio_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	if (pdata->enable_external_pullup)
-		pdata->enable_external_pullup(1);
-
 	if (pdata->pullup_gpiod)
 		gpiod_set_value(pdata->pullup_gpiod, 1);
 
@@ -150,9 +146,6 @@ static int w1_gpio_remove(struct platform_device *pdev)
 	struct w1_bus_master *master = platform_get_drvdata(pdev);
 	struct w1_gpio_ddata *pdata = master->data;
 
-	if (pdata->enable_external_pullup)
-		pdata->enable_external_pullup(0);
-
 	if (pdata->pullup_gpiod)
 		gpiod_set_value(pdata->pullup_gpiod, 0);
 
@@ -161,34 +154,9 @@ static int w1_gpio_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused w1_gpio_suspend(struct device *dev)
-{
-	struct w1_bus_master *master = dev_get_drvdata(dev);
-	struct w1_gpio_ddata *pdata = master->data;
-
-	if (pdata->enable_external_pullup)
-		pdata->enable_external_pullup(0);
-
-	return 0;
-}
-
-static int __maybe_unused w1_gpio_resume(struct device *dev)
-{
-	struct w1_bus_master *master = dev_get_drvdata(dev);
-	struct w1_gpio_ddata *pdata = master->data;
-
-	if (pdata->enable_external_pullup)
-		pdata->enable_external_pullup(1);
-
-	return 0;
-}
-
-static SIMPLE_DEV_PM_OPS(w1_gpio_pm_ops, w1_gpio_suspend, w1_gpio_resume);
-
 static struct platform_driver w1_gpio_driver = {
 	.driver = {
 		.name	= "w1-gpio",
-		.pm	= &w1_gpio_pm_ops,
 		.of_match_table = of_match_ptr(w1_gpio_dt_ids),
 	},
 	.probe = w1_gpio_probe,
-- 
2.39.2

