Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FB265970E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 11:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbiL3KA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 05:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiL3KAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 05:00:52 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F4ADF45
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 02:00:50 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id y8so19456671wrl.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 02:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D6o1paQzy9GWzi2tghC+WkZL5u6Vq2O4stEYuPegkxw=;
        b=lAyo7sO45YEXmQBUVpVBxrB6MiwtbORw7OAbBxtheo2O4rVX1oCoG5lr1uk0ptuqaj
         tWY251QxZpySK6X5h88l5L3Lf/JWdcZ2dXd6qx5qixunNtALezN6lJXeurQMzuzoGIGN
         vjr8ieYQnCneuEhafduMhPuGOAqCasPgCDzxkJR/Gfk4stRvJ/NCPF9BhQMWI6f9z8cr
         DivOhgZoGaENTQIWvChk1QPN3Au8irJXMdA8QgrdepiU9UKURsu2n2bjqIkzDRsTn7Ul
         ZxAQnsijgMbblM1+ChRu5d+wUjExAQaKskLoRmz9Y1OMwTtxP6xQvpgZ6sjSebT0146t
         Hstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6o1paQzy9GWzi2tghC+WkZL5u6Vq2O4stEYuPegkxw=;
        b=tIOxIPJU5l75HtwgHRj4b7au2vB+2EWo56r2BK8d52mt6uoYwkNUMFaXnmHm8lARKa
         Bm3CZEz0XH+Polez2Em0uXMpw45LqSbo5DE46LMwY8i3h9NeSt8x5ctGGYNqerFdIgs6
         tSIr0TKGhkNpTrRMK9mfDb4STqoZgA/7v97rSGsyWytr53DPJMjFxoSzFuhu14kP069i
         aqMys4O/BJwU/MoCdBRV4p5gWaC47FTNArvKWPV8lyTkXgHRpOyf/6FRE19rjsGOzwzV
         IsyAsDeQdSgLan1mzFWdEal83gWNlw45LwxkkaKfmXLxXSaM9JXZ27Vy7qwBm2O8IQJi
         gKEw==
X-Gm-Message-State: AFqh2koLAvidQZyA8C+4Svfgw+G386sKN+cTTbu6cajbupJXbfHeX8AD
        Lf1hSOW1xhbKpS24B8jDhKrl/g==
X-Google-Smtp-Source: AMrXdXs2Z58huvYm32CoidjMuwBJkFk/Vzp2tesqu8HOgnByOAra1TI3FJufgZciUUOtse9UpIZm9w==
X-Received: by 2002:adf:e383:0:b0:267:b8df:932b with SMTP id e3-20020adfe383000000b00267b8df932bmr25103279wrm.23.1672394448857;
        Fri, 30 Dec 2022 02:00:48 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:2f6:88f8:7ade:eb1b])
        by smtp.gmail.com with ESMTPSA id e10-20020a5d594a000000b0028663fc8f4csm7309419wri.30.2022.12.30.02.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 02:00:48 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: pca9570: rename platform_data to chip_data
Date:   Fri, 30 Dec 2022 11:00:44 +0100
Message-Id: <20221230100044.23000-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

By convention platform_data refers to structures passed to drivers by
code that registers devices. When talking about model-specific data
structures associated with OF compatibles, we usually call them chip_data.

In order to avoid confusion rename all mentions of platform_data to
chip_data.

Fixes: fbb19fe17eae ("gpio: pca9570: add slg7xl45106 support")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-pca9570.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-pca9570.c b/drivers/gpio/gpio-pca9570.c
index 6c07a8811a7a..6a5a8e593ed5 100644
--- a/drivers/gpio/gpio-pca9570.c
+++ b/drivers/gpio/gpio-pca9570.c
@@ -18,11 +18,11 @@
 #define SLG7XL45106_GPO_REG	0xDB
 
 /**
- * struct pca9570_platform_data - GPIO platformdata
+ * struct pca9570_chip_data - GPIO platformdata
  * @ngpio: no of gpios
  * @command: Command to be sent
  */
-struct pca9570_platform_data {
+struct pca9570_chip_data {
 	u16 ngpio;
 	u32 command;
 };
@@ -36,7 +36,7 @@ struct pca9570_platform_data {
  */
 struct pca9570 {
 	struct gpio_chip chip;
-	const struct pca9570_platform_data *p_data;
+	const struct pca9570_chip_data *chip_data;
 	struct mutex lock;
 	u8 out;
 };
@@ -46,8 +46,8 @@ static int pca9570_read(struct pca9570 *gpio, u8 *value)
 	struct i2c_client *client = to_i2c_client(gpio->chip.parent);
 	int ret;
 
-	if (gpio->p_data->command != 0)
-		ret = i2c_smbus_read_byte_data(client, gpio->p_data->command);
+	if (gpio->chip_data->command != 0)
+		ret = i2c_smbus_read_byte_data(client, gpio->chip_data->command);
 	else
 		ret = i2c_smbus_read_byte(client);
 
@@ -62,8 +62,8 @@ static int pca9570_write(struct pca9570 *gpio, u8 value)
 {
 	struct i2c_client *client = to_i2c_client(gpio->chip.parent);
 
-	if (gpio->p_data->command != 0)
-		return i2c_smbus_write_byte_data(client, gpio->p_data->command, value);
+	if (gpio->chip_data->command != 0)
+		return i2c_smbus_write_byte_data(client, gpio->chip_data->command, value);
 
 	return i2c_smbus_write_byte(client, value);
 }
@@ -127,8 +127,8 @@ static int pca9570_probe(struct i2c_client *client)
 	gpio->chip.get = pca9570_get;
 	gpio->chip.set = pca9570_set;
 	gpio->chip.base = -1;
-	gpio->p_data = device_get_match_data(&client->dev);
-	gpio->chip.ngpio = gpio->p_data->ngpio;
+	gpio->chip_data = device_get_match_data(&client->dev);
+	gpio->chip.ngpio = gpio->chip_data->ngpio;
 	gpio->chip.can_sleep = true;
 
 	mutex_init(&gpio->lock);
@@ -141,15 +141,15 @@ static int pca9570_probe(struct i2c_client *client)
 	return devm_gpiochip_add_data(&client->dev, &gpio->chip, gpio);
 }
 
-static const struct pca9570_platform_data pca9570_gpio = {
+static const struct pca9570_chip_data pca9570_gpio = {
 	.ngpio = 4,
 };
 
-static const struct pca9570_platform_data pca9571_gpio = {
+static const struct pca9570_chip_data pca9571_gpio = {
 	.ngpio = 8,
 };
 
-static const struct pca9570_platform_data slg7xl45106_gpio = {
+static const struct pca9570_chip_data slg7xl45106_gpio = {
 	.ngpio = 8,
 	.command = SLG7XL45106_GPO_REG,
 };
-- 
2.37.2

