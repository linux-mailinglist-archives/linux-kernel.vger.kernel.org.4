Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED001710955
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240803AbjEYJ4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240762AbjEYJ4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:56:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6FB1A7
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:56:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q27hv-000885-Ei; Thu, 25 May 2023 11:56:31 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q27hu-002h3F-O0; Thu, 25 May 2023 11:56:30 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q27ht-007oDQ-Ot; Thu, 25 May 2023 11:56:29 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Philipp Marek <philipp@marek.priv.at>
Subject: [PATCH 3/3] w1: gpio: rename pointer to driver data from pdata to ddata
Date:   Thu, 25 May 2023 11:56:24 +0200
Message-Id: <20230525095624.615350-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525095624.615350-1-u.kleine-koenig@pengutronix.de>
References: <20230525095624.615350-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4335; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=AL8CVkR6GSrHzRoCdksK3js8JGBEqMjHRgMeJ1Oggjc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkbzDH0KELSukdPftEo8RAgyLRMStfIcT+5PD0R yJ4FlQUnNeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZG8wxwAKCRCPgPtYfRL+ ToyTCAC5m+tHjJxbk2R67TK+LYh2Xcq/tl4oYbKBVtVdT9GRgTeCH5PBijr9h8emMFaGOZt032S vFroEkvptDgSa/UakxeJVBExfQvq7GS8PDcNdqICsyszxT2GAWK4FDp688PrOu3uz3DXhirTSjw cM717ggqNsWD2HmTYZ95Ixc1GYGj4jPEx1cPoGwPi5gSjVOGmT/RuK/CLTNmHFOZd+XEm1U/gyQ EJDuKcTd4yWHQRhJr9Md/FOKyqbY/sSrGwvyuXqSKJjVTedqG0B422+mcdAneA9xV6WUDgSXUUH pxUmsPDMtQoG1R+uwOwzFcdAO+AOhliX4SM9ZtoCwvEnEcKP
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

pdata is a relict when this was still platform data.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/w1/masters/w1-gpio.c | 54 ++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/w1/masters/w1-gpio.c b/drivers/w1/masters/w1-gpio.c
index 67596428f69b..0956ea857226 100644
--- a/drivers/w1/masters/w1-gpio.c
+++ b/drivers/w1/masters/w1-gpio.c
@@ -25,25 +25,25 @@ struct w1_gpio_ddata {
 
 static u8 w1_gpio_set_pullup(void *data, int delay)
 {
-	struct w1_gpio_ddata *pdata = data;
+	struct w1_gpio_ddata *ddata = data;
 
 	if (delay) {
-		pdata->pullup_duration = delay;
+		ddata->pullup_duration = delay;
 	} else {
-		if (pdata->pullup_duration) {
+		if (ddata->pullup_duration) {
 			/*
 			 * This will OVERRIDE open drain emulation and force-pull
 			 * the line high for some time.
 			 */
-			gpiod_set_raw_value(pdata->gpiod, 1);
-			msleep(pdata->pullup_duration);
+			gpiod_set_raw_value(ddata->gpiod, 1);
+			msleep(ddata->pullup_duration);
 			/*
 			 * This will simply set the line as input since we are doing
 			 * open drain emulation in the GPIO library.
 			 */
-			gpiod_set_value(pdata->gpiod, 1);
+			gpiod_set_value(ddata->gpiod, 1);
 		}
-		pdata->pullup_duration = 0;
+		ddata->pullup_duration = 0;
 	}
 
 	return 0;
@@ -51,16 +51,16 @@ static u8 w1_gpio_set_pullup(void *data, int delay)
 
 static void w1_gpio_write_bit(void *data, u8 bit)
 {
-	struct w1_gpio_ddata *pdata = data;
+	struct w1_gpio_ddata *ddata = data;
 
-	gpiod_set_value(pdata->gpiod, bit);
+	gpiod_set_value(ddata->gpiod, bit);
 }
 
 static u8 w1_gpio_read_bit(void *data)
 {
-	struct w1_gpio_ddata *pdata = data;
+	struct w1_gpio_ddata *ddata = data;
 
-	return gpiod_get_value(pdata->gpiod) ? 1 : 0;
+	return gpiod_get_value(ddata->gpiod) ? 1 : 0;
 }
 
 #if defined(CONFIG_OF)
@@ -74,15 +74,15 @@ MODULE_DEVICE_TABLE(of, w1_gpio_dt_ids);
 static int w1_gpio_probe(struct platform_device *pdev)
 {
 	struct w1_bus_master *master;
-	struct w1_gpio_ddata *pdata;
+	struct w1_gpio_ddata *ddata;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	/* Enforce open drain mode by default */
 	enum gpiod_flags gflags = GPIOD_OUT_LOW_OPEN_DRAIN;
 	int err;
 
-	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
+	ddata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!ddata)
 		return -ENOMEM;
 
 	/*
@@ -99,23 +99,23 @@ static int w1_gpio_probe(struct platform_device *pdev)
 	if (!master)
 		return -ENOMEM;
 
-	pdata->gpiod = devm_gpiod_get_index(dev, NULL, 0, gflags);
-	if (IS_ERR(pdata->gpiod)) {
+	ddata->gpiod = devm_gpiod_get_index(dev, NULL, 0, gflags);
+	if (IS_ERR(ddata->gpiod)) {
 		dev_err(dev, "gpio_request (pin) failed\n");
-		return PTR_ERR(pdata->gpiod);
+		return PTR_ERR(ddata->gpiod);
 	}
 
-	pdata->pullup_gpiod =
+	ddata->pullup_gpiod =
 		devm_gpiod_get_index_optional(dev, NULL, 1, GPIOD_OUT_LOW);
-	if (IS_ERR(pdata->pullup_gpiod)) {
+	if (IS_ERR(ddata->pullup_gpiod)) {
 		dev_err(dev, "gpio_request_one "
 			"(ext_pullup_enable_pin) failed\n");
-		return PTR_ERR(pdata->pullup_gpiod);
+		return PTR_ERR(ddata->pullup_gpiod);
 	}
 
-	master->data = pdata;
+	master->data = ddata;
 	master->read_bit = w1_gpio_read_bit;
-	gpiod_direction_output(pdata->gpiod, 1);
+	gpiod_direction_output(ddata->gpiod, 1);
 	master->write_bit = w1_gpio_write_bit;
 
 	/*
@@ -133,8 +133,8 @@ static int w1_gpio_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	if (pdata->pullup_gpiod)
-		gpiod_set_value(pdata->pullup_gpiod, 1);
+	if (ddata->pullup_gpiod)
+		gpiod_set_value(ddata->pullup_gpiod, 1);
 
 	platform_set_drvdata(pdev, master);
 
@@ -144,10 +144,10 @@ static int w1_gpio_probe(struct platform_device *pdev)
 static int w1_gpio_remove(struct platform_device *pdev)
 {
 	struct w1_bus_master *master = platform_get_drvdata(pdev);
-	struct w1_gpio_ddata *pdata = master->data;
+	struct w1_gpio_ddata *ddata = master->data;
 
-	if (pdata->pullup_gpiod)
-		gpiod_set_value(pdata->pullup_gpiod, 0);
+	if (ddata->pullup_gpiod)
+		gpiod_set_value(ddata->pullup_gpiod, 0);
 
 	w1_remove_master_device(master);
 
-- 
2.39.2

