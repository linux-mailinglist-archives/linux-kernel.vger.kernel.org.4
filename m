Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9F25BDA81
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 04:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiITC6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 22:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiITC6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 22:58:11 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EDA58514
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 19:58:10 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 3so1209731pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 19:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=1D5qXLe1WAPRApCvIfGpFNULKJL8uLPqslDt4MGWmKc=;
        b=FcJF96wnARQw/7Ye9X492BhO7+gmuFBafL0CjcuOsHdoPko1wwJo13OkjuzHZrE/mR
         0dqISXYA0qd6NLuu+4FKvr2z13C0sZZVnjWSIqTROr2suTnKnmbmues+kiOZ4E6hIHiO
         dGIHeC6fhW+DRgDwQLhB/CA1L2Wo9B5bG+tPNj9/UebzRk8GVCSYvL3DlKas9MeDpSiV
         jbySi2kmsxU97swYKsbdMXjweWew11EtMO94UAJ4eVr/6ahQtwhS13FD5PmjSrrKWoxm
         5iYjc5iitvkfKQFf8FmrbOEs7URP0qPX2NOc2haEOOE7vgB7MIPoyNwVhQpIg5cZxEgl
         0+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1D5qXLe1WAPRApCvIfGpFNULKJL8uLPqslDt4MGWmKc=;
        b=hnfmo83uWMgQNv62zsKtNApVR7jveh3GTPPWh9JpMAYPr0QsfIp17wKqLVx4NxxEVj
         cGS9RvuaZENEedA1goLQUcRGxtXCS6tmXcri1H7pit1lGggUM8Fg2VG1bHVibZ8crSQ+
         uWyS/Mnk+BaB7Czj0i7IJbBPpzqGX86zzzp8A5eSLXqm8zd8EoJZsVU4YGi/+S7sQrgr
         R2MqiPQa4Fe2R33iva45wqgOpZSSyluTbZVKP97G8z8lzUaIj88+0OLDtbJfWnld8obI
         Al6Xf7GF00zF6jegAWF4+roe6OlkZ799MxEj8CoGCXDnSvBuiNyfJUJWSUG7swXeDB6R
         rdIQ==
X-Gm-Message-State: ACrzQf04900tBtxkFBJx1b063G5mUSvtQHOs999vwe355haumbUBIXbC
        SMVA0RhCFpoT9UuhBJ+/OQ+gYImwai0=
X-Google-Smtp-Source: AMsMyM5EZVdp2ZNER6mMbd7+fkvIe2UprHoJr3m3o7ZL+ib7ei/HkzjmwDyNVjMlgPGXBRs7+MXzsQ==
X-Received: by 2002:a05:6a00:99c:b0:54c:27c4:3acb with SMTP id u28-20020a056a00099c00b0054c27c43acbmr15230522pfg.22.1663642689973;
        Mon, 19 Sep 2022 19:58:09 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:b095:5d5d:4c28:8088])
        by smtp.gmail.com with ESMTPSA id z128-20020a626586000000b00542e190f6bcsm147499pfb.102.2022.09.19.19.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 19:58:09 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ASoC: ssm2518: switch to using gpiod API
Date:   Mon, 19 Sep 2022 19:58:04 -0700
Message-Id: <20220920025804.1788667-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220920025804.1788667-1-dmitry.torokhov@gmail.com>
References: <20220920025804.1788667-1-dmitry.torokhov@gmail.com>
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

This patch converts the driver to newer gpiod API, so that we can stop
exporting OF-specific legacy gpio API.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 sound/soc/codecs/ssm2518.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/ssm2518.c b/sound/soc/codecs/ssm2518.c
index feee28207e5d..22cb3b7c8283 100644
--- a/sound/soc/codecs/ssm2518.c
+++ b/sound/soc/codecs/ssm2518.c
@@ -6,13 +6,13 @@
  *  Author: Lars-Peter Clausen <lars@metafoo.de>
  */
 
+#include <linux/err.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
-#include <linux/gpio.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -113,7 +113,7 @@ struct ssm2518 {
 	unsigned int sysclk;
 	const struct snd_pcm_hw_constraint_list *constraints;
 
-	int enable_gpio;
+	struct gpio_desc *enable_gpio;
 };
 
 static const struct reg_default ssm2518_reg_defaults[] = {
@@ -482,8 +482,8 @@ static int ssm2518_set_power(struct ssm2518 *ssm2518, bool enable)
 		regcache_mark_dirty(ssm2518->regmap);
 	}
 
-	if (gpio_is_valid(ssm2518->enable_gpio))
-		gpio_set_value(ssm2518->enable_gpio, enable);
+	if (ssm2518->enable_gpio)
+		gpiod_set_value_cansleep(ssm2518->enable_gpio, enable);
 
 	regcache_cache_only(ssm2518->regmap, !enable);
 
@@ -742,20 +742,14 @@ static int ssm2518_i2c_probe(struct i2c_client *i2c)
 	if (ssm2518 == NULL)
 		return -ENOMEM;
 
-	if (i2c->dev.of_node) {
-		ssm2518->enable_gpio = of_get_gpio(i2c->dev.of_node, 0);
-		if (ssm2518->enable_gpio < 0 && ssm2518->enable_gpio != -ENOENT)
-			return ssm2518->enable_gpio;
-	} else {
-		ssm2518->enable_gpio = -1;
-	}
+	/* Start with enabling the chip */
+	ssm2518->enable_gpio = devm_gpiod_get_optional(&i2c->dev, NULL,
+						       GPIOD_OUT_HIGH);
+	ret = PTR_ERR_OR_ZERO(ssm2518->enable_gpio);
+	if (ret)
+		return ret;
 
-	if (gpio_is_valid(ssm2518->enable_gpio)) {
-		ret = devm_gpio_request_one(&i2c->dev, ssm2518->enable_gpio,
-				GPIOF_OUT_INIT_HIGH, "SSM2518 nSD");
-		if (ret)
-			return ret;
-	}
+	gpiod_set_consumer_name(ssm2518->enable_gpio, "SSM2518 nSD");
 
 	i2c_set_clientdata(i2c, ssm2518);
 
-- 
2.37.3.968.ga6b4b080e4-goog

