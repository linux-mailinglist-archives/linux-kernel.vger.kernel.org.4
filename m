Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52ED962ADEE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiKOWMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiKOWLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:11:55 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AB1303F8;
        Tue, 15 Nov 2022 14:11:54 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id gw22so14757890pjb.3;
        Tue, 15 Nov 2022 14:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMGCOoya80Yh9qZLv453WUxet4tv4AcyXFF/KHbcD0s=;
        b=VrAItYOOcUcnfIpE0RT5T8tL0J0dqo2B7Lv2zbYjRBB9Lp2rIr1gBiM1pvxGJXfr7m
         uZGO9agr4dNhf0wDT+REyzcNKZvxa7QHCmQ7AVM4yjedgQyes7LhCuAb6d9n9893Iqh9
         oxgDnepdLbqaNUapW38UiqBxUxPVRv71V/YhvlI1i14PrEEPeWvpG6ng2czmvzcz+XmQ
         BuiU0h/wrrhqP8j0yLICy+5MdAEIJw6i4NcVUZ7vpJSEUUAoMBZDN1FuqAHFLuCPxbRi
         XmsFnQNHlrgruk9BBr0mW0L6ORbqkJBbREYdjTub/TGApQ6N617zuGoge5LzKh7oi0kO
         PyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMGCOoya80Yh9qZLv453WUxet4tv4AcyXFF/KHbcD0s=;
        b=waL4AohePqMYDmJRySDsHJWHHT9Zs0/9trK8qXsu8wi6Eigyx/2sKv/GGvjKHdV0v5
         79bonWTIgSrW5/nUultdpsws47bw1R30jSPGK2nnZXJNPARGj+CX1NZSBYK8TO3VqW3W
         SrbPtSIhdH3TLAjN2kzyv1rN9hQCWbq336h38qMw54H94s8Y4tjuRbdlToeQkp/oZkxh
         s9HnbRIAhOGEpSeFqsZV9bEyLdr5zo3CbfeJk0vW9TvRF4iL2dnPkFSbXatrQVoiJ1/1
         ZzoJDOpE+Od6PX5hF+hAGJi9GXO+1rHeKkqGdd7bTXWe0a43h/Owt/AJTMRbvZ9u3EH7
         wz4Q==
X-Gm-Message-State: ANoB5pl0ORYz6UefZGHyhfO83MW+bu5FMpHvY5TbJzA9LwXflQVrpvZs
        gaUEpIqIWJ8AGgvVm+UV43ThTq/98jk=
X-Google-Smtp-Source: AA0mqf5qNZ0cFI/wDaFRqHE56f9+p0F0elAX863apkQcUtBc69KSE6mb7bg6PTNh5/BgvKxUfw9bXw==
X-Received: by 2002:a17:902:e741:b0:188:572c:b9c3 with SMTP id p1-20020a170902e74100b00188572cb9c3mr6162956plf.53.1668550314211;
        Tue, 15 Nov 2022 14:11:54 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:2d36:e9a0:170b:669f])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090264c100b00178b6ccc8a0sm10400038pli.51.2022.11.15.14.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 14:11:53 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 3/4] media: i2c: s5c73m3: remove support for platform data
Date:   Tue, 15 Nov 2022 14:11:44 -0800
Message-Id: <20221115221145.2550572-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221115221145.2550572-1-dmitry.torokhov@gmail.com>
References: <20221115221145.2550572-1-dmitry.torokhov@gmail.com>
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

There are no existing users of s5c73m3_platform_data in the tree, and
new users shoudl either be using device tree, ACPI, or static device
properties, so let's remove it from the driver.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/media/i2c/s5c73m3/s5c73m3-core.c  | 19 ++------
 drivers/media/i2c/s5c73m3/s5c73m3-ctrls.c |  2 -
 drivers/media/i2c/s5c73m3/s5c73m3.h       |  6 ++-
 include/media/i2c/s5c73m3.h               | 56 -----------------------
 4 files changed, 9 insertions(+), 74 deletions(-)
 delete mode 100644 include/media/i2c/s5c73m3.h

diff --git a/drivers/media/i2c/s5c73m3/s5c73m3-core.c b/drivers/media/i2c/s5c73m3/s5c73m3-core.c
index d96ba58ce1e5..561c1a1583ac 100644
--- a/drivers/media/i2c/s5c73m3/s5c73m3-core.c
+++ b/drivers/media/i2c/s5c73m3/s5c73m3-core.c
@@ -27,7 +27,6 @@
 #include <media/v4l2-device.h>
 #include <media/v4l2-subdev.h>
 #include <media/v4l2-mediabus.h>
-#include <media/i2c/s5c73m3.h>
 #include <media/v4l2-fwnode.h>
 
 #include "s5c73m3.h"
@@ -1592,26 +1591,16 @@ static int s5c73m3_parse_gpios(struct s5c73m3 *state)
 	return 0;
 }
 
-static int s5c73m3_get_platform_data(struct s5c73m3 *state)
+static int s5c73m3_get_dt_data(struct s5c73m3 *state)
 {
 	struct device *dev = &state->i2c_client->dev;
-	const struct s5c73m3_platform_data *pdata = dev->platform_data;
 	struct device_node *node = dev->of_node;
 	struct device_node *node_ep;
 	struct v4l2_fwnode_endpoint ep = { .bus_type = 0 };
 	int ret;
 
-	if (!node) {
-		if (!pdata) {
-			dev_err(dev, "Platform data not specified\n");
-			return -EINVAL;
-		}
-
-		state->mclk_frequency = pdata->mclk_frequency;
-		state->gpio[STBY] = pdata->gpio_stby;
-		state->gpio[RSET] = pdata->gpio_reset;
-		return 0;
-	}
+	if (!node)
+		return -EINVAL;
 
 	state->clock = devm_clk_get(dev, S5C73M3_CLK_NAME);
 	if (IS_ERR(state->clock))
@@ -1666,7 +1655,7 @@ static int s5c73m3_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	state->i2c_client = client;
-	ret = s5c73m3_get_platform_data(state);
+	ret = s5c73m3_get_dt_data(state);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/media/i2c/s5c73m3/s5c73m3-ctrls.c b/drivers/media/i2c/s5c73m3/s5c73m3-ctrls.c
index 141ad0ba7f5a..1c8103670fa2 100644
--- a/drivers/media/i2c/s5c73m3/s5c73m3-ctrls.c
+++ b/drivers/media/i2c/s5c73m3/s5c73m3-ctrls.c
@@ -10,7 +10,6 @@
 #include <linux/sizes.h>
 #include <linux/delay.h>
 #include <linux/firmware.h>
-#include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/media.h>
@@ -24,7 +23,6 @@
 #include <media/v4l2-device.h>
 #include <media/v4l2-subdev.h>
 #include <media/v4l2-mediabus.h>
-#include <media/i2c/s5c73m3.h>
 
 #include "s5c73m3.h"
 
diff --git a/drivers/media/i2c/s5c73m3/s5c73m3.h b/drivers/media/i2c/s5c73m3/s5c73m3.h
index c3fcfdd3ea66..d68528898249 100644
--- a/drivers/media/i2c/s5c73m3/s5c73m3.h
+++ b/drivers/media/i2c/s5c73m3/s5c73m3.h
@@ -15,7 +15,6 @@
 #include <media/v4l2-common.h>
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-subdev.h>
-#include <media/i2c/s5c73m3.h>
 
 #define DRIVER_NAME			"S5C73M3"
 
@@ -357,6 +356,11 @@ enum s5c73m3_gpio_id {
 	GPIO_NUM,
 };
 
+struct s5c73m3_gpio {
+	int gpio;
+	int level;
+};
+
 enum s5c73m3_resolution_types {
 	RES_ISP,
 	RES_JPEG,
diff --git a/include/media/i2c/s5c73m3.h b/include/media/i2c/s5c73m3.h
deleted file mode 100644
index a51f1025ba1c..000000000000
--- a/include/media/i2c/s5c73m3.h
+++ /dev/null
@@ -1,56 +0,0 @@
-/*
- * Samsung LSI S5C73M3 8M pixel camera driver
- *
- * Copyright (C) 2012, Samsung Electronics, Co., Ltd.
- * Sylwester Nawrocki <s.nawrocki@samsung.com>
- * Andrzej Hajda <a.hajda@samsung.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-#ifndef MEDIA_S5C73M3__
-#define MEDIA_S5C73M3__
-
-#include <linux/videodev2.h>
-#include <media/v4l2-mediabus.h>
-
-/**
- * struct s5c73m3_gpio - data structure describing a GPIO
- * @gpio:  GPIO number
- * @level: indicates active state of the @gpio
- */
-struct s5c73m3_gpio {
-	int gpio;
-	int level;
-};
-
-/**
- * struct s5c73m3_platform_data - s5c73m3 driver platform data
- * @mclk_frequency: sensor's master clock frequency in Hz
- * @gpio_reset:  GPIO driving RESET pin
- * @gpio_stby:   GPIO driving STBY pin
- * @bus_type:    bus type
- * @nlanes:      maximum number of MIPI-CSI lanes used
- * @horiz_flip:  default horizontal image flip value, non zero to enable
- * @vert_flip:   default vertical image flip value, non zero to enable
- */
-
-struct s5c73m3_platform_data {
-	unsigned long mclk_frequency;
-
-	struct s5c73m3_gpio gpio_reset;
-	struct s5c73m3_gpio gpio_stby;
-
-	enum v4l2_mbus_type bus_type;
-	u8 nlanes;
-	u8 horiz_flip;
-	u8 vert_flip;
-};
-
-#endif /* MEDIA_S5C73M3__ */
-- 
2.38.1.431.g37b22c650d-goog

