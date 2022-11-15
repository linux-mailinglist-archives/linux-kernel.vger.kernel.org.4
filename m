Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A085C62ADEF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238403AbiKOWMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiKOWL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:11:58 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D183120C;
        Tue, 15 Nov 2022 14:11:56 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso427645pjc.2;
        Tue, 15 Nov 2022 14:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrZfenAnf9sYON4n47hNey76ONHNUDUWnON3//izvEc=;
        b=kiQkSeD9f7oaGu/M9BkH6RjD6Au08SNhthZGu5aQbxMFaUJ5W7YNSXB7Y5t4fx2EN5
         FD/kK2AToQ6cOJeISWZ+H/U9ixFbaJbdlp+noFxYE3AbnaXIGFBYBo3fEaAMxqaz+fjs
         GEb3zHIQSlXeJpslI8BBRyoRnwYfuGSKzB9sXlwcMxku7qGoby//GhXV4pJ7dgney+WQ
         yGS/VNqUR91DmxqRz1g+JK/kRclX9jcE/hl6rVn6DvjcqKXjvMPf9yilCwl+s7U1Wpji
         rBkPsmYXV/7zTu56lTk+r+M372/7FaP7VlGwTPtpAxv1hyOOKMa6arR10oY8KxkudKyE
         Mf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OrZfenAnf9sYON4n47hNey76ONHNUDUWnON3//izvEc=;
        b=MP3X3CZ2bV5tpHJvYdBknV4AqZSH80tIWQS7KcCroazXn3m9KosnBet4vTf3eaCEeG
         UK12klM3Y2RCcuUUgS9LZ4AHPjC29SzPm3giG/lvVwX+K82ldNDu+LJCzRRXo9dA9sDf
         zLZpzlX+V1E3XcXRCsQvgooQiMa60oOoWKQg1wD2JwTAL7gKkEGrWSVrSXjSF4xPV9dm
         yUJGwYfA0rNitpKkCV8T3CZjJbGlkXW2sS1z/VAnCPABvDVVM0fr4K4WarpQ7N5aMwfk
         JDKFB/Hb6w68H/T43wJ58Pqa244aJU14qCweYs+EY9AteAmv95Hj+lqE05WDKr5vkklx
         HgLw==
X-Gm-Message-State: ANoB5pnihnFt658EVT5N4OsPNK6TyMz9UrgRedrcJ9kp0fNLeEwfugUP
        ijsTbxnzhG6mDLxCS40QJ4M=
X-Google-Smtp-Source: AA0mqf5Ki380Wv+k6C4x2tLurD5R1ak3fttiGubwrqktPB2Ra0P8GdTzgDocjTLRs7Dtz1B9cYMyRA==
X-Received: by 2002:a17:902:76c5:b0:187:282c:9b95 with SMTP id j5-20020a17090276c500b00187282c9b95mr6140760plt.41.1668550316213;
        Tue, 15 Nov 2022 14:11:56 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:2d36:e9a0:170b:669f])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090264c100b00178b6ccc8a0sm10400038pli.51.2022.11.15.14.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 14:11:55 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 4/4] media: i2c: s5c73m3: switch to using gpiod API
Date:   Tue, 15 Nov 2022 14:11:45 -0800
Message-Id: <20221115221145.2550572-4-dmitry.torokhov@gmail.com>
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

This patch switches the driver away from legacy gpio/of_gpio API to
gpiod API, and removes use of of_get_named_gpio_flags() which I want to
make private to gpiolib.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/media/i2c/s5c73m3/s5c73m3-core.c | 63 +++++++-----------------
 drivers/media/i2c/s5c73m3/s5c73m3.h      |  7 +--
 2 files changed, 20 insertions(+), 50 deletions(-)

diff --git a/drivers/media/i2c/s5c73m3/s5c73m3-core.c b/drivers/media/i2c/s5c73m3/s5c73m3-core.c
index 561c1a1583ac..f1e073ed5f99 100644
--- a/drivers/media/i2c/s5c73m3/s5c73m3-core.c
+++ b/drivers/media/i2c/s5c73m3/s5c73m3-core.c
@@ -10,12 +10,11 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/firmware.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/media.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
 #include <linux/of_graph.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sizes.h>
@@ -1348,20 +1347,20 @@ static int s5c73m3_oif_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
 
 static int s5c73m3_gpio_set_value(struct s5c73m3 *priv, int id, u32 val)
 {
-	if (!gpio_is_valid(priv->gpio[id].gpio))
+	if (!priv->gpio[id])
 		return 0;
-	gpio_set_value(priv->gpio[id].gpio, !!val);
+	gpiod_set_value_cansleep(priv->gpio[id], val);
 	return 1;
 }
 
 static int s5c73m3_gpio_assert(struct s5c73m3 *priv, int id)
 {
-	return s5c73m3_gpio_set_value(priv, id, priv->gpio[id].level);
+	return s5c73m3_gpio_set_value(priv, id, 1);
 }
 
 static int s5c73m3_gpio_deassert(struct s5c73m3 *priv, int id)
 {
-	return s5c73m3_gpio_set_value(priv, id, !priv->gpio[id].level);
+	return s5c73m3_gpio_set_value(priv, id, 0);
 }
 
 static int __s5c73m3_power_on(struct s5c73m3 *state)
@@ -1544,49 +1543,29 @@ static const struct v4l2_subdev_ops oif_subdev_ops = {
 
 static int s5c73m3_configure_gpios(struct s5c73m3 *state)
 {
-	static const char * const gpio_names[] = {
-		"S5C73M3_STBY", "S5C73M3_RST"
-	};
+	static const char * const name[] = { "standby", "xshutdown" };
+	static const char * const label[] = { "S5C73M3_STBY", "S5C73M3_RST" };
 	struct i2c_client *c = state->i2c_client;
-	struct s5c73m3_gpio *g = state->gpio;
+	struct gpio_desc *gpio;
 	int ret, i;
 
 	for (i = 0; i < GPIO_NUM; ++i) {
-		unsigned int flags = GPIOF_DIR_OUT;
-		if (g[i].level)
-			flags |= GPIOF_INIT_HIGH;
-		ret = devm_gpio_request_one(&c->dev, g[i].gpio, flags,
-					    gpio_names[i]);
+		gpio = devm_gpiod_get(&c->dev, name[i], GPIOD_OUT_HIGH);
+		ret = PTR_ERR_OR_ZERO(gpio);
 		if (ret) {
-			v4l2_err(c, "failed to request gpio %s\n",
-				 gpio_names[i]);
+			v4l2_err(c, "failed to request gpio %s: %d\n",
+				 name[i], ret);
 			return ret;
 		}
-	}
-	return 0;
-}
-
-static int s5c73m3_parse_gpios(struct s5c73m3 *state)
-{
-	static const char * const prop_names[] = {
-		"standby-gpios", "xshutdown-gpios",
-	};
-	struct device *dev = &state->i2c_client->dev;
-	struct device_node *node = dev->of_node;
-	int ret, i;
 
-	for (i = 0; i < GPIO_NUM; ++i) {
-		enum of_gpio_flags of_flags;
-
-		ret = of_get_named_gpio_flags(node, prop_names[i],
-					      0, &of_flags);
-		if (ret < 0) {
-			dev_err(dev, "failed to parse %s DT property\n",
-				prop_names[i]);
-			return -EINVAL;
+		ret = gpiod_set_consumer_name(gpio, label[i]);
+		if (ret) {
+			v4l2_err(c, "failed to set up name for gpio %s: %d\n",
+				 name[i], ret);
+			return ret;
 		}
-		state->gpio[i].gpio = ret;
-		state->gpio[i].level = !(of_flags & OF_GPIO_ACTIVE_LOW);
+
+		state->gpio[i] = gpio;
 	}
 	return 0;
 }
@@ -1613,10 +1592,6 @@ static int s5c73m3_get_dt_data(struct s5c73m3 *state)
 					state->mclk_frequency);
 	}
 
-	ret = s5c73m3_parse_gpios(state);
-	if (ret < 0)
-		return -EINVAL;
-
 	node_ep = of_graph_get_next_endpoint(node, NULL);
 	if (!node_ep) {
 		dev_warn(dev, "no endpoint defined for node: %pOF\n", node);
diff --git a/drivers/media/i2c/s5c73m3/s5c73m3.h b/drivers/media/i2c/s5c73m3/s5c73m3.h
index d68528898249..9887d03fcdeb 100644
--- a/drivers/media/i2c/s5c73m3/s5c73m3.h
+++ b/drivers/media/i2c/s5c73m3/s5c73m3.h
@@ -356,11 +356,6 @@ enum s5c73m3_gpio_id {
 	GPIO_NUM,
 };
 
-struct s5c73m3_gpio {
-	int gpio;
-	int level;
-};
-
 enum s5c73m3_resolution_types {
 	RES_ISP,
 	RES_JPEG,
@@ -387,7 +382,7 @@ struct s5c73m3 {
 	u32 i2c_read_address;
 
 	struct regulator_bulk_data supplies[S5C73M3_MAX_SUPPLIES];
-	struct s5c73m3_gpio gpio[GPIO_NUM];
+	struct gpio_desc *gpio[GPIO_NUM];
 
 	struct clk *clock;
 
-- 
2.38.1.431.g37b22c650d-goog

