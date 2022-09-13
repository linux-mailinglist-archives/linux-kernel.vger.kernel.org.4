Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C655B789F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbiIMRpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbiIMRpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:45:07 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C7F7F110;
        Tue, 13 Sep 2022 09:41:10 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id a80so3718155pfa.4;
        Tue, 13 Sep 2022 09:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=flmsIEbMJVaOU2duL6ZI4DormffxlXc3pT4gpX1YVyY=;
        b=oJJympb8sMAda6Xe65RluPDRWqjg1x6o7LcFrt9uHz2+NW1k1V7RYr9YoGKRBv/wSu
         ++W8Jl1WsbjgihEENvCBk9QIYRkkw7h0HXk+9+1gNzwpQG9BkcIcnPVMGlNCkG8UdJ9X
         5O36eSqVORvrezGRv4/Y0AzpPIrHU52FgALIqjzPZ7K67QHalZmod9pUv2PTxuTOD1yQ
         aMmRNoHjp5CP9sukegIrzpZ7r3hjQz8NWyVafL6+QimJNU35XMT/XR1FCi6XA1uDOn72
         bowo1DfGyVp10HIpqeit4l0X5Hf2KfsAmmc5eCVPMx7EHH8G2/1r1K57uBj91ubRgDbK
         zb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=flmsIEbMJVaOU2duL6ZI4DormffxlXc3pT4gpX1YVyY=;
        b=Ww24LJGpLItvprPxNKeXFgWAyQNVJtA4GFXyJj/tBqKcU3yz53u4lb4cZnkvu4ytrY
         Fiyh3lB69DGHLjYnVd/GZiBHU4EnfWJxOITFUFV1RA/TXFqWaXk8ZWOSvHBb8oInPLdI
         L0oQsUNmIw4uNy8oZJh/k1N5+7ZLxse5Dj08px8Z8f43xAdcHwKDUL+DdibVWzL7+c7M
         IY1OYWs1AZX0T8UBKuDST/Rb1lNn9GBS572MfDAvfLF6BsVEUoenaKCszU7upprecHND
         lO27T9MVF+gd09o279oEixFuE7mR3R1RFbgpIv6DXrDkMCIJgvbUIEKaQD4TQxT53jVo
         SY8g==
X-Gm-Message-State: ACgBeo3BKCmR+Txrrg17+rcjzln0NUPpjN4w4Crn6R9Ece1bX7ocI/O7
        75FwwW46ZMu/vFibEV+llIc=
X-Google-Smtp-Source: AA6agR7dbwTHN0hiiTca6RAq94QQYffu8spociGapyfiLX7vgcK24At969jRtTFzo15NXaz20VfOOA==
X-Received: by 2002:a63:2c4c:0:b0:434:e001:89fd with SMTP id s73-20020a632c4c000000b00434e00189fdmr28188426pgs.444.1663087270291;
        Tue, 13 Sep 2022 09:41:10 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:b126:15e1:55ae:d9eb])
        by smtp.gmail.com with ESMTPSA id g3-20020aa79f03000000b005465ffaa89dsm1798449pfr.184.2022.09.13.09.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 09:41:09 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] media: i2c: s5k6a3: switch to using gpiod API
Date:   Tue, 13 Sep 2022 09:41:04 -0700
Message-Id: <20220913164104.203957-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220913164104.203957-1-dmitry.torokhov@gmail.com>
References: <20220913164104.203957-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch switches the driver away from legacy gpio/of_gpio API to
gpiod API, and removes one of the last uses of of_get_gpio_flags().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/media/i2c/s5k6a3.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/media/i2c/s5k6a3.c b/drivers/media/i2c/s5k6a3.c
index a4efd6d10b43..ef6673b10580 100644
--- a/drivers/media/i2c/s5k6a3.c
+++ b/drivers/media/i2c/s5k6a3.c
@@ -9,12 +9,12 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/errno.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
@@ -59,7 +59,7 @@ struct s5k6a3 {
 	struct v4l2_subdev subdev;
 	struct media_pad pad;
 	struct regulator_bulk_data supplies[S5K6A3_NUM_SUPPLIES];
-	int gpio_reset;
+	struct gpio_desc *gpio_reset;
 	struct mutex lock;
 	struct v4l2_mbus_framefmt format;
 	struct clk *clock;
@@ -216,11 +216,11 @@ static int __s5k6a3_power_on(struct s5k6a3 *sensor)
 			goto error_clk;
 	}
 
-	gpio_set_value(sensor->gpio_reset, 1);
+	gpiod_set_value_cansleep(sensor->gpio_reset, 0);
 	usleep_range(600, 800);
-	gpio_set_value(sensor->gpio_reset, 0);
+	gpiod_set_value_cansleep(sensor->gpio_reset, 1);
 	usleep_range(600, 800);
-	gpio_set_value(sensor->gpio_reset, 1);
+	gpiod_set_value_cansleep(sensor->gpio_reset, 0);
 
 	/* Delay needed for the sensor initialization */
 	msleep(20);
@@ -240,7 +240,7 @@ static int __s5k6a3_power_off(struct s5k6a3 *sensor)
 {
 	int i;
 
-	gpio_set_value(sensor->gpio_reset, 0);
+	gpiod_set_value_cansleep(sensor->gpio_reset, 1);
 
 	for (i = S5K6A3_NUM_SUPPLIES - 1; i >= 0; i--)
 		regulator_disable(sensor->supplies[i].consumer);
@@ -285,32 +285,24 @@ static int s5k6a3_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct s5k6a3 *sensor;
 	struct v4l2_subdev *sd;
-	int gpio, i, ret;
+	int i, ret;
 
 	sensor = devm_kzalloc(dev, sizeof(*sensor), GFP_KERNEL);
 	if (!sensor)
 		return -ENOMEM;
 
 	mutex_init(&sensor->lock);
-	sensor->gpio_reset = -EINVAL;
-	sensor->clock = ERR_PTR(-EINVAL);
 	sensor->dev = dev;
 
 	sensor->clock = devm_clk_get(sensor->dev, S5K6A3_CLK_NAME);
 	if (IS_ERR(sensor->clock))
 		return PTR_ERR(sensor->clock);
 
-	gpio = of_get_gpio_flags(dev->of_node, 0, NULL);
-	if (!gpio_is_valid(gpio))
-		return gpio;
-
-	ret = devm_gpio_request_one(dev, gpio, GPIOF_OUT_INIT_LOW,
-						S5K6A3_DRV_NAME);
-	if (ret < 0)
+	sensor->gpio_reset = devm_gpiod_get(dev, NULL, GPIOD_OUT_HIGH);
+	ret = PTR_ERR_OR_ZERO(sensor->gpio_reset);
+	if (ret)
 		return ret;
 
-	sensor->gpio_reset = gpio;
-
 	if (of_property_read_u32(dev->of_node, "clock-frequency",
 				 &sensor->clock_frequency)) {
 		sensor->clock_frequency = S5K6A3_DEFAULT_CLK_FREQ;
-- 
2.37.2.789.g6183377224-goog

