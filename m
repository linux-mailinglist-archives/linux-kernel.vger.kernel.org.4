Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729546361B3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238672AbiKWO07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238006AbiKWO0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:26:15 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66A072101
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:25:25 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id l2so11261239qtq.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhZLl26t1K4wqDWCbzm1vBgYBeX9Zk6z9k1bwDsJlYk=;
        b=MTy5K5zo8j7gHK18KBRdKzLz9qaM5vdifpAmi9F0FqoXgIgJmbqD/PpjYhLGqdefRl
         IZb/mXV7cMrOTD7JH/vQauqQ31HbWc7wT92c3oa+f4qyzreOTWCwtGVUO8+/ngCyA6ca
         2tBYENhbEGQ7q6PxvMEgrheVu99p7Cb4EE2R9SSORQExdOHoBaZqFLObedv6Hcr3MToy
         MfqmZ6PNC4qdFSQATjbjuVhj1Fo4M9uMoz3IemR7AU233tjuw8oXzsqITW8xiMSNConE
         +BeD/8/0bT8/n6hF8Dt/M1GM0pnxYBnGr740t9UPl0WWkp8lTHN7m23op8eM/ZAMtFFs
         wE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhZLl26t1K4wqDWCbzm1vBgYBeX9Zk6z9k1bwDsJlYk=;
        b=OpARgoVszZ3NOIF0/TSMO0RPlL7T27S3iOsaI/4Z4BLJdYDqVXIIPOM3huob+y2UEl
         H0gSvVTW+OCR4HbLpM7gCayXb2RbeWrLgCOeR1mzO1mlyj262T8AqtsIbO06msJEntcA
         ZX1Db9J+UDa6reSe7IkZHJwpg8FNOsGwPwPsWtBe3AliBM7It2u6NH6qwT1NBcU649U+
         qkqs7cL5Mfo7b2GMLWiu0MHqT+EbAu04OPuLqhrVVmroKpSVqm7utxs+v7Ksne0OIYyb
         ytm0IxTuw3zSjVjNL5UcMLS35KDzcjAviyKnTscQUrkOyPWf3ZMXbOo/9GivfUdot9X1
         w5bQ==
X-Gm-Message-State: ANoB5pn2gJYFq5+xsYPHNpibuwvzYNrmJxAdMyPItHl/hqqsqygpw61x
        2PPgBveIYKkNV93tSzxXZKiF5H7Py5VlAg==
X-Google-Smtp-Source: AA0mqf4pIb1cuopipoxpKHIltfz1YML1touHFlcQRSbRhFHfkPFcz9v/FC/fCw3b5NogJNpOIi3fdA==
X-Received: by 2002:a05:622a:1e87:b0:3a5:4cee:6eb1 with SMTP id bz7-20020a05622a1e8700b003a54cee6eb1mr26346925qtb.20.1669213524810;
        Wed, 23 Nov 2022 06:25:24 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id b28-20020a05620a127c00b006f9c2be0b4bsm11718802qkl.135.2022.11.23.06.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 06:25:24 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc, broonie@kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v3 7/9] gpio: 104-dio-48e: Migrate to regmap API
Date:   Tue, 22 Nov 2022 02:11:04 -0500
Message-Id: <79705f8932321afd05df52156ef149dc1c9c632c.1669100542.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1669100542.git.william.gray@linaro.org>
References: <cover.1669100542.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regmap API supports IO port accessors so we can take advantage of
regmap abstractions rather than handling access to the device registers
directly in the driver. The 104-dio-48e module is migrated to the new
i8255 library interface leveraging the gpio-regmap API.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/gpio-104-dio-48e.c | 147 ++------------------------------
 1 file changed, 7 insertions(+), 140 deletions(-)

diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index fcee3dc81902..64f4044150b7 100644
--- a/drivers/gpio/gpio-104-dio-48e.c
+++ b/drivers/gpio/gpio-104-dio-48e.c
@@ -9,7 +9,6 @@
 #include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/err.h>
-#include <linux/gpio/driver.h>
 #include <linux/ioport.h>
 #include <linux/irq.h>
 #include <linux/isa.h>
@@ -42,90 +41,6 @@ MODULE_PARM_DESC(irq, "ACCES 104-DIO-48E interrupt line numbers");
 
 #define DIO48E_NUM_PPI 2
 
-/**
- * struct dio48e_reg - device register structure
- * @ppi:		Programmable Peripheral Interface groups
- */
-struct dio48e_reg {
-	struct i8255 ppi[DIO48E_NUM_PPI];
-};
-
-/**
- * struct dio48e_gpio - GPIO device private data structure
- * @chip:		instance of the gpio_chip
- * @ppi_state:		PPI device states
- * @reg:		I/O address offset for the device registers
- */
-struct dio48e_gpio {
-	struct gpio_chip chip;
-	struct i8255_state ppi_state[DIO48E_NUM_PPI];
-	struct dio48e_reg __iomem *reg;
-};
-
-static int dio48e_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
-{
-	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
-
-	if (i8255_get_direction(dio48egpio->ppi_state, offset))
-		return GPIO_LINE_DIRECTION_IN;
-
-	return GPIO_LINE_DIRECTION_OUT;
-}
-
-static int dio48e_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
-{
-	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
-
-	i8255_direction_input(dio48egpio->reg->ppi, dio48egpio->ppi_state,
-			      offset);
-
-	return 0;
-}
-
-static int dio48e_gpio_direction_output(struct gpio_chip *chip, unsigned int offset,
-					int value)
-{
-	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
-
-	i8255_direction_output(dio48egpio->reg->ppi, dio48egpio->ppi_state,
-			       offset, value);
-
-	return 0;
-}
-
-static int dio48e_gpio_get(struct gpio_chip *chip, unsigned int offset)
-{
-	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
-
-	return i8255_get(dio48egpio->reg->ppi, offset);
-}
-
-static int dio48e_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
-	unsigned long *bits)
-{
-	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
-
-	i8255_get_multiple(dio48egpio->reg->ppi, mask, bits, chip->ngpio);
-
-	return 0;
-}
-
-static void dio48e_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
-{
-	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
-
-	i8255_set(dio48egpio->reg->ppi, dio48egpio->ppi_state, offset, value);
-}
-
-static void dio48e_gpio_set_multiple(struct gpio_chip *chip,
-	unsigned long *mask, unsigned long *bits)
-{
-	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
-
-	i8255_set_multiple(dio48egpio->reg->ppi, dio48egpio->ppi_state, mask,
-			   bits, chip->ngpio);
-}
-
 static const struct regmap_range dio48e_wr_ranges[] = {
 	regmap_reg_range(0x0, 0x9), regmap_reg_range(0xB, 0xB),
 	regmap_reg_range(0xD, 0xD), regmap_reg_range(0xF, 0xF),
@@ -237,35 +152,10 @@ static const char *dio48e_names[DIO48E_NGPIO] = {
 	"PPI Group 1 Port C 5", "PPI Group 1 Port C 6", "PPI Group 1 Port C 7"
 };
 
-static int dio48e_irq_init_hw(struct gpio_chip *gc)
-{
-	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(gc);
-
-	/* Disable IRQ by default */
-	ioread8(&dio48egpio->reg->enable_interrupt);
-
-	return 0;
-}
-
-static void dio48e_init_ppi(struct i8255 __iomem *const ppi,
-			    struct i8255_state *const ppi_state)
-{
-	const unsigned long ngpio = 24;
-	const unsigned long mask = GENMASK(ngpio - 1, 0);
-	const unsigned long bits = 0;
-	unsigned long i;
-
-	/* Initialize all GPIO to output 0 */
-	for (i = 0; i < DIO48E_NUM_PPI; i++) {
-		i8255_mode0_output(&ppi[i]);
-		i8255_set_multiple(&ppi[i], &ppi_state[i], &mask, &bits, ngpio);
-	}
-}
-
 static int dio48e_probe(struct device *dev, unsigned int id)
 {
-	struct dio48e_gpio *dio48egpio;
 	const char *const name = dev_name(dev);
+	struct i8255_regmap_config config = {0};
 	void __iomem *regs;
 	struct regmap *map;
 	unsigned int val;
@@ -274,10 +164,6 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 	unsigned int irq_mask;
 	struct regmap_irq_chip_data *chip_data;
 
-	dio48egpio = devm_kzalloc(dev, sizeof(*dio48egpio), GFP_KERNEL);
-	if (!dio48egpio)
-		return -ENOMEM;
-
 	if (!devm_request_region(dev, base[id], DIO48E_EXTENT, name)) {
 		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
 			base[id], base[id] + DIO48E_EXTENT);
@@ -287,7 +173,6 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 	regs = devm_ioport_map(dev, base[id], DIO48E_EXTENT);
 	if (!regs)
 		return -ENOMEM;
-	dio48egpio->reg = regs;
 
 	map = devm_regmap_init_mmio(dev, regs, &dio48e_regmap_config);
 	if (IS_ERR(map))
@@ -324,31 +209,13 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 		return err;
 	}
 
-	dio48egpio->chip.label = name;
-	dio48egpio->chip.parent = dev;
-	dio48egpio->chip.owner = THIS_MODULE;
-	dio48egpio->chip.base = -1;
-	dio48egpio->chip.ngpio = DIO48E_NGPIO;
-	dio48egpio->chip.names = dio48e_names;
-	dio48egpio->chip.get_direction = dio48e_gpio_get_direction;
-	dio48egpio->chip.direction_input = dio48e_gpio_direction_input;
-	dio48egpio->chip.direction_output = dio48e_gpio_direction_output;
-	dio48egpio->chip.get = dio48e_gpio_get;
-	dio48egpio->chip.get_multiple = dio48e_gpio_get_multiple;
-	dio48egpio->chip.set = dio48e_gpio_set;
-	dio48egpio->chip.set_multiple = dio48e_gpio_set_multiple;
-
-	i8255_state_init(dio48egpio->ppi_state, DIO48E_NUM_PPI);
-	dio48e_init_ppi(dio48egpio->reg->ppi, dio48egpio->ppi_state);
-
-	err = devm_gpiochip_add_data(dev, &dio48egpio->chip, dio48egpio);
-	if (err) {
-		dev_err(dev, "GPIO registering failed (%d)\n", err);
-		return err;
-	}
+	config.parent = dev;
+	config.map = map;
+	config.num_ppi = DIO48E_NUM_PPI;
+	config.names = dio48e_names;
+	config.domain = regmap_irq_get_domain(chip_data);
 
-	return gpiochip_irqchip_add_domain(&dio48egpio->chip,
-					   regmap_irq_get_domain(chip_data));
+	return devm_i8255_regmap_register(dev, &config);
 }
 
 static struct isa_driver dio48e_driver = {
-- 
2.38.1

