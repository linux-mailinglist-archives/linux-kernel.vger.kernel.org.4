Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977FE685F3A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 06:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjBAFs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 00:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjBAFsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 00:48:25 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19760EF83;
        Tue, 31 Jan 2023 21:48:20 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id nm12-20020a17090b19cc00b0022c2155cc0bso910672pjb.4;
        Tue, 31 Jan 2023 21:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hsl33PszSOpzgnvgqkP5N89g+lpbOX6KfA0Skot7YpY=;
        b=HAEliPKT9St4PwoNoXnNB1kdwddUuglLLnirU0BSkHaJG6z0f3fJtpAhkcp1jq+5Yd
         clmhtEsyePEV6cf3EaJtPFgotFUgOvREVROfLar+sPKKW3CNrO4sQFKMoFBRMMtvftbi
         FMFAG9glF0CaLfkPZM0OZFPvd2kEnEVERPO7UtduVsyqWAcFZzLUffXSrxPyo0W3E3Op
         NGngFC5R/eCNdalsGc5mXjMySQxZOEr5qXfN4f7V0Uwz7CPx3KUlCCOuxXGDt8OJWcmb
         0T5wyDNYsX8XjUUjwVAsrG8woRVvMQDwvhHwbhtZzwPCoB+y1vd7LyUL9JOUPyLk5yVk
         HBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hsl33PszSOpzgnvgqkP5N89g+lpbOX6KfA0Skot7YpY=;
        b=dI1w38Ha+DAiacGAfdk8sNiDcpbmOo9QlqzRq9ZgqzS2EogmhPi86Zcn/lyRbrVM7i
         MBZu8gbhUCD6deYqFETgJZ1TXqBxVNZsIHE82tZ29XkuP/liKKowV035XdXrcZp5y11M
         ai8WjPvrmInsA2q28mKeqIolgI13E6AenAh27jzY8iZOvtM/3DMgalrkgr+cbybE3ySA
         2Y/UWi7yQkwD+bIXEWEBrhkgcvVtlzfPKUQo+SVmFWl7pWxIVmnVkUnCg8Ho3Gf61PU4
         9HgchLjePm059hjL68+n5axZsDvtoEGgRooefrV30U4pZDRtPb0Q7wqUzy8WOu+BsDQV
         rCbw==
X-Gm-Message-State: AO0yUKX3ONzNWUW+09lvurZ9kbVGmYJJuT0PoxNm8W+9IUNpWx+1SuB+
        Lr5IwI6LsMMvdEGt7hvpCCg=
X-Google-Smtp-Source: AK7set9F66alILkDznWgRiAwwfagwo8Bv5qtja7GToiU20N3D1BPG+DQ7VnXS78Clgq+8Sps7Uc0+w==
X-Received: by 2002:a17:902:da89:b0:194:6f3b:3aa1 with SMTP id j9-20020a170902da8900b001946f3b3aa1mr18118338plx.55.1675230499431;
        Tue, 31 Jan 2023 21:48:19 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:ce3a:44de:62b3:7a4b])
        by smtp.gmail.com with ESMTPSA id w2-20020a1709027b8200b00196025a34b9sm7461575pll.159.2023.01.31.21.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 21:48:18 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/3] rtc: moxart: switch to using gpiod API
Date:   Tue, 31 Jan 2023 21:48:13 -0800
Message-Id: <20230201054815.4112632-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the driver from legacy gpio API that is deprecated to the newer
gpiod API that respects line polarities described in ACPI/DT.

This makes driver use standard property name for its gpios
("rtc-*-gpios" vs "gpios-rtc-*"), however there is a quirk in gpiolib
to also recognize legacy names and keep compatibility with older DTSes:
eaf1a29665cd ("gpiolib: of: add a quirk for legacy names in MOXA ART
RTC").

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/rtc/rtc-moxart.c | 89 ++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 53 deletions(-)

diff --git a/drivers/rtc/rtc-moxart.c b/drivers/rtc/rtc-moxart.c
index 6b24ac9e1cfa..2247dd39ee4b 100644
--- a/drivers/rtc/rtc-moxart.c
+++ b/drivers/rtc/rtc-moxart.c
@@ -10,14 +10,15 @@
  * Moxa Technology Co., Ltd. <www.moxa.com>
  */
 
+#include <linux/err.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/rtc.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
-#include <linux/gpio.h>
-#include <linux/of_gpio.h>
+#include <linux/mod_devicetable.h>
+#include <linux/gpio/consumer.h>
 
 #define GPIO_RTC_RESERVED			0x0C
 #define GPIO_RTC_DATA_SET			0x10
@@ -55,7 +56,9 @@
 struct moxart_rtc {
 	struct rtc_device *rtc;
 	spinlock_t rtc_lock;
-	int gpio_data, gpio_sclk, gpio_reset;
+	struct gpio_desc *gpio_data;
+	struct gpio_desc *gpio_sclk;
+	struct gpio_desc *gpio_reset;
 };
 
 static int day_of_year[12] =	{ 0, 31, 59, 90, 120, 151, 181,
@@ -67,10 +70,10 @@ static void moxart_rtc_write_byte(struct device *dev, u8 data)
 	int i;
 
 	for (i = 0; i < 8; i++, data >>= 1) {
-		gpio_set_value(moxart_rtc->gpio_sclk, 0);
-		gpio_set_value(moxart_rtc->gpio_data, ((data & 1) == 1));
+		gpiod_set_value(moxart_rtc->gpio_sclk, 0);
+		gpiod_set_value(moxart_rtc->gpio_data, ((data & 1) == 1));
 		udelay(GPIO_RTC_DELAY_TIME);
-		gpio_set_value(moxart_rtc->gpio_sclk, 1);
+		gpiod_set_value(moxart_rtc->gpio_sclk, 1);
 		udelay(GPIO_RTC_DELAY_TIME);
 	}
 }
@@ -82,11 +85,11 @@ static u8 moxart_rtc_read_byte(struct device *dev)
 	u8 data = 0;
 
 	for (i = 0; i < 8; i++) {
-		gpio_set_value(moxart_rtc->gpio_sclk, 0);
+		gpiod_set_value(moxart_rtc->gpio_sclk, 0);
 		udelay(GPIO_RTC_DELAY_TIME);
-		gpio_set_value(moxart_rtc->gpio_sclk, 1);
+		gpiod_set_value(moxart_rtc->gpio_sclk, 1);
 		udelay(GPIO_RTC_DELAY_TIME);
-		if (gpio_get_value(moxart_rtc->gpio_data))
+		if (gpiod_get_value(moxart_rtc->gpio_data))
 			data |= (1 << i);
 		udelay(GPIO_RTC_DELAY_TIME);
 	}
@@ -101,15 +104,15 @@ static u8 moxart_rtc_read_register(struct device *dev, u8 cmd)
 
 	local_irq_save(flags);
 
-	gpio_direction_output(moxart_rtc->gpio_data, 0);
-	gpio_set_value(moxart_rtc->gpio_reset, 1);
+	gpiod_direction_output(moxart_rtc->gpio_data, 0);
+	gpiod_set_value(moxart_rtc->gpio_reset, 1);
 	udelay(GPIO_RTC_DELAY_TIME);
 	moxart_rtc_write_byte(dev, cmd);
-	gpio_direction_input(moxart_rtc->gpio_data);
+	gpiod_direction_input(moxart_rtc->gpio_data);
 	udelay(GPIO_RTC_DELAY_TIME);
 	data = moxart_rtc_read_byte(dev);
-	gpio_set_value(moxart_rtc->gpio_sclk, 0);
-	gpio_set_value(moxart_rtc->gpio_reset, 0);
+	gpiod_set_value(moxart_rtc->gpio_sclk, 0);
+	gpiod_set_value(moxart_rtc->gpio_reset, 0);
 	udelay(GPIO_RTC_DELAY_TIME);
 
 	local_irq_restore(flags);
@@ -124,13 +127,13 @@ static void moxart_rtc_write_register(struct device *dev, u8 cmd, u8 data)
 
 	local_irq_save(flags);
 
-	gpio_direction_output(moxart_rtc->gpio_data, 0);
-	gpio_set_value(moxart_rtc->gpio_reset, 1);
+	gpiod_direction_output(moxart_rtc->gpio_data, 0);
+	gpiod_set_value(moxart_rtc->gpio_reset, 1);
 	udelay(GPIO_RTC_DELAY_TIME);
 	moxart_rtc_write_byte(dev, cmd);
 	moxart_rtc_write_byte(dev, data);
-	gpio_set_value(moxart_rtc->gpio_sclk, 0);
-	gpio_set_value(moxart_rtc->gpio_reset, 0);
+	gpiod_set_value(moxart_rtc->gpio_sclk, 0);
+	gpiod_set_value(moxart_rtc->gpio_reset, 0);
 	udelay(GPIO_RTC_DELAY_TIME);
 
 	local_irq_restore(flags);
@@ -247,53 +250,33 @@ static int moxart_rtc_probe(struct platform_device *pdev)
 	if (!moxart_rtc)
 		return -ENOMEM;
 
-	moxart_rtc->gpio_data = of_get_named_gpio(pdev->dev.of_node,
-						  "gpio-rtc-data", 0);
-	if (!gpio_is_valid(moxart_rtc->gpio_data)) {
-		dev_err(&pdev->dev, "invalid gpio (data): %d\n",
-			moxart_rtc->gpio_data);
-		return moxart_rtc->gpio_data;
-	}
-
-	moxart_rtc->gpio_sclk = of_get_named_gpio(pdev->dev.of_node,
-						  "gpio-rtc-sclk", 0);
-	if (!gpio_is_valid(moxart_rtc->gpio_sclk)) {
-		dev_err(&pdev->dev, "invalid gpio (sclk): %d\n",
-			moxart_rtc->gpio_sclk);
-		return moxart_rtc->gpio_sclk;
-	}
-
-	moxart_rtc->gpio_reset = of_get_named_gpio(pdev->dev.of_node,
-						   "gpio-rtc-reset", 0);
-	if (!gpio_is_valid(moxart_rtc->gpio_reset)) {
-		dev_err(&pdev->dev, "invalid gpio (reset): %d\n",
-			moxart_rtc->gpio_reset);
-		return moxart_rtc->gpio_reset;
-	}
-
-	spin_lock_init(&moxart_rtc->rtc_lock);
-	platform_set_drvdata(pdev, moxart_rtc);
-
-	ret = devm_gpio_request(&pdev->dev, moxart_rtc->gpio_data, "rtc_data");
+	moxart_rtc->gpio_data = devm_gpiod_get(&pdev->dev, "rtc-data",
+					       GPIOD_IN);
+	ret = PTR_ERR_OR_ZERO(moxart_rtc->gpio_data);
 	if (ret) {
-		dev_err(&pdev->dev, "can't get rtc_data gpio\n");
+		dev_err(&pdev->dev, "can't get rtc data gpio: %d\n", ret);
 		return ret;
 	}
 
-	ret = devm_gpio_request_one(&pdev->dev, moxart_rtc->gpio_sclk,
-				    GPIOF_DIR_OUT, "rtc_sclk");
+	moxart_rtc->gpio_sclk = devm_gpiod_get(&pdev->dev, "rtc-sclk",
+					       GPIOD_ASIS);
+	ret = PTR_ERR_OR_ZERO(moxart_rtc->gpio_sclk);
 	if (ret) {
-		dev_err(&pdev->dev, "can't get rtc_sclk gpio\n");
+		dev_err(&pdev->dev, "can't get rtc sclk gpio: %d\n", ret);
 		return ret;
 	}
 
-	ret = devm_gpio_request_one(&pdev->dev, moxart_rtc->gpio_reset,
-				    GPIOF_DIR_OUT, "rtc_reset");
+	moxart_rtc->gpio_reset = devm_gpiod_get(&pdev->dev, "rtc-reset",
+						GPIOD_ASIS);
+	ret = PTR_ERR_OR_ZERO(moxart_rtc->gpio_reset);
 	if (ret) {
-		dev_err(&pdev->dev, "can't get rtc_reset gpio\n");
+		dev_err(&pdev->dev, "can't get rtc reset gpio: %d\n", ret);
 		return ret;
 	}
 
+	spin_lock_init(&moxart_rtc->rtc_lock);
+	platform_set_drvdata(pdev, moxart_rtc);
+
 	moxart_rtc->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
 						   &moxart_rtc_ops,
 						   THIS_MODULE);
-- 
2.39.1.456.gfc5497dd1b-goog

