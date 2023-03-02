Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9376A82C9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjCBMxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjCBMxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:53:08 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC1083FD;
        Thu,  2 Mar 2023 04:52:57 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id n5so9990829pfv.11;
        Thu, 02 Mar 2023 04:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRN/MkYkVyLNcqtB6OAlPlQu24Io/GUHW41CMMPteSg=;
        b=YKq3V2RU9yTIBU19bngkEao0jiqAfLDIcB93+oPJRXG1Xim38Q4tdkWd/AYq3Aizj+
         75CtomfDCEkNNueX3+MG0mxF/REpWKv34A1G3O57kURXvJ+foO5wuKAE5igTrUVuCNpx
         JLqnb7OL7kOTwZAqWDx0JNr0n3Mzs/f+wTbHXWmqIkbHzr/4FMmY4ZoXjuXbQcAyrtEE
         kc5kzpq9uH6USZ2l81Sri3I2KORXq17EYH72YW/T2eLRQJfuFJ/0Df3nyQQlmdI0SQy9
         v5/cvVpknxwniqrVHNBUtIOMfYa1wMUwgmXCR5h7/aWA6Mf7Y95ruHIJBMmBnH+mQsob
         ip3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRN/MkYkVyLNcqtB6OAlPlQu24Io/GUHW41CMMPteSg=;
        b=4yrmOseXcFytE2Hojzw7onWAkedVdpVHzc/fsbXYuBuTggLwK7y3qUuS8sjfBJ4vyB
         M5E/1aBGHUqMfo06in8YEmsAakdS8WkWbIelp+D1cySbi4VPXg6XJ8mKNhTAL+qja2Bd
         80bZ9L2uj+3csvmRZkIxMrPX+hQcD59AIQQXL682j0J42c46xSYcxNTUJS0IDMl+muEc
         kfHJuxVy6xjtq+Uv+p4AyJJVYEdZsT6Qei2fXIVH66z5hBPDPTrz6S6GUWCypFqAqHv5
         wYAbVS2VFkTAggCZ5PdagiVb7jkZbrUzrUG4p/OMsG8J3CRixN6iO/6Ra0usRjvAh3F7
         Uxww==
X-Gm-Message-State: AO0yUKUqUIR1um/m1uh+eNtm+S3166uaVPFOa5CBEl3ETzYxF2+cTrTc
        XfxRKn90Bo/mQhNcHbfu9DNObo5CdWQ=
X-Google-Smtp-Source: AK7set/zR6q6un+xxh3TNQG3l99+9yGeiVRrVjHqia3hNZ0sjxfwNiY+Y9zundL6T2/RudydSq6hkg==
X-Received: by 2002:aa7:947d:0:b0:5a8:adc8:6de1 with SMTP id t29-20020aa7947d000000b005a8adc86de1mr9897477pfq.29.1677761576729;
        Thu, 02 Mar 2023 04:52:56 -0800 (PST)
Received: from kelvin-ThinkPad-L14-Gen-1.lan ([223.85.203.147])
        by smtp.gmail.com with ESMTPSA id j7-20020a62e907000000b005aa60d8545esm9791955pfh.61.2023.03.02.04.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 04:52:56 -0800 (PST)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v2 3/5] gpio: loongson1: Introduce ls1x_gpio_chip struct
Date:   Thu,  2 Mar 2023 20:52:13 +0800
Message-Id: <20230302125215.214014-4-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230302125215.214014-1-keguang.zhang@gmail.com>
References: <20230302125215.214014-1-keguang.zhang@gmail.com>
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

This patch introduces and allocates ls1x_gpio_chip struct containing
gpio_chip and reg_base to avoid global gpio_reg_base.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V1 -> V2: Split this change to a separate patch
---
 drivers/gpio/gpio-loongson1.c | 45 +++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/gpio/gpio-loongson1.c b/drivers/gpio/gpio-loongson1.c
index b6c11caa3ade..3ac9e49e7efb 100644
--- a/drivers/gpio/gpio-loongson1.c
+++ b/drivers/gpio/gpio-loongson1.c
@@ -16,15 +16,19 @@
 #define GPIO_DATA		0x20
 #define GPIO_OUTPUT		0x30
 
-static void __iomem *gpio_reg_base;
+struct ls1x_gpio_chip {
+	struct gpio_chip gc;
+	void __iomem *reg_base;
+};
 
 static int ls1x_gpio_request(struct gpio_chip *gc, unsigned int offset)
 {
+	struct ls1x_gpio_chip *ls1x_gc = gpiochip_get_data(gc);
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
-	writel(readl(gpio_reg_base + GPIO_CFG) | BIT(offset),
-	       gpio_reg_base + GPIO_CFG);
+	writel(readl(ls1x_gc->reg_base + GPIO_CFG) | BIT(offset),
+	       ls1x_gc->reg_base + GPIO_CFG);
 	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 
 	return 0;
@@ -32,44 +36,45 @@ static int ls1x_gpio_request(struct gpio_chip *gc, unsigned int offset)
 
 static void ls1x_gpio_free(struct gpio_chip *gc, unsigned int offset)
 {
+	struct ls1x_gpio_chip *ls1x_gc = gpiochip_get_data(gc);
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
-	writel(readl(gpio_reg_base + GPIO_CFG) & ~BIT(offset),
-	       gpio_reg_base + GPIO_CFG);
+	writel(readl(ls1x_gc->reg_base + GPIO_CFG) & ~BIT(offset),
+	       ls1x_gc->reg_base + GPIO_CFG);
 	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }
 
 static int ls1x_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct gpio_chip *gc;
+	struct ls1x_gpio_chip *ls1x_gc;
 	int ret;
 
-	gc = devm_kzalloc(dev, sizeof(*gc), GFP_KERNEL);
-	if (!gc)
+	ls1x_gc = devm_kzalloc(dev, sizeof(*ls1x_gc), GFP_KERNEL);
+	if (!ls1x_gc)
 		return -ENOMEM;
 
-	gpio_reg_base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(gpio_reg_base))
-		return PTR_ERR(gpio_reg_base);
+	ls1x_gc->reg_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ls1x_gc->reg_base))
+		return PTR_ERR(ls1x_gc->reg_base);
 
-	ret = bgpio_init(gc, dev, 4, gpio_reg_base + GPIO_DATA,
-			 gpio_reg_base + GPIO_OUTPUT, NULL,
-			 NULL, gpio_reg_base + GPIO_DIR, 0);
+	ret = bgpio_init(&ls1x_gc->gc, dev, 4, ls1x_gc->reg_base + GPIO_DATA,
+			 ls1x_gc->reg_base + GPIO_OUTPUT, NULL,
+			 NULL, ls1x_gc->reg_base + GPIO_DIR, 0);
 	if (ret)
 		goto err;
 
-	gc->owner = THIS_MODULE;
-	gc->request = ls1x_gpio_request;
-	gc->free = ls1x_gpio_free;
-	gc->base = pdev->id * 32;
+	ls1x_gc->gc.owner = THIS_MODULE;
+	ls1x_gc->gc.request = ls1x_gpio_request;
+	ls1x_gc->gc.free = ls1x_gpio_free;
+	ls1x_gc->gc.base = pdev->id * 32;
 
-	ret = devm_gpiochip_add_data(dev, gc, NULL);
+	ret = devm_gpiochip_add_data(dev, &ls1x_gc->gc, ls1x_gc);
 	if (ret)
 		goto err;
 
-	platform_set_drvdata(pdev, gc);
+	platform_set_drvdata(pdev, ls1x_gc);
 	dev_info(dev, "Loongson1 GPIO driver registered\n");
 
 	return 0;
-- 
2.34.1

