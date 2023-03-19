Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AE06C04C8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 21:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjCSUXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 16:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjCSUXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 16:23:33 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FB2D52B
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 13:23:30 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id jl13so6557756qvb.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 13:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679257409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PA40N4sIrOYaOFCgvWKC9d1yluKGfi81EEUURsGXfK8=;
        b=FOzNkOw2Ppa5fdBuK8eVohFEz6faUSJo0ZgUjkCvKvDR74G53NWcw5SSeX8bvOYY+6
         DSUeABrY69+9KRLTaxP11L9K+51Ardje75EE4FNnnKqvc3qztbsXEkt1tTHg3iQNDt9P
         KyoYu4aD5Lp360gcA9q83vaEepkTzNpWaSxrSnNLEga8ae2yAGw4l3FGdz6+tbu+DVfU
         pSCA+mP6oBWvxVPJcI+ELKCQrJBHpu1Px5Jp98a/adicFjMhWJQUdQPNwY1kDGr499nz
         KPE9KSU1UlFLjLmjRkTyApeHLmGaNt8Cb69KMNMA1SsPjbmDT6L5nNn7Pk1nkmV2I2dT
         UJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679257409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PA40N4sIrOYaOFCgvWKC9d1yluKGfi81EEUURsGXfK8=;
        b=LX5LpAHf1Lf9kNEAMtgg2nG17R5VKIOdKJl3Z84o7c4Ma7oLe8o6ms/GiHtdzNWZgO
         6SOGdNP9z0OC1kF4hmQl63zmqdSg1DZH5PCMbXZJ4xEwy+ulIkzMkolsQXxIiVSsy89z
         /9T7f4FNPEi7ktqTlB47ieRd3UIV1yUvgGWURIQVxWIxTJm/X3QWbXwkEcxsGTvwWBzh
         rAMIt14Bk1qOtxQmwCzcLLz/YW/ZPvviFsRVMf0J9fLOOp5PtLkresTjLny3HxHNXcHi
         mkpsBVpMnW13RdXcNlM7hXWBigtAMWkDNfsGDyoYfMceqqxcxszIESjXYf6T8+WeHrGq
         ImYw==
X-Gm-Message-State: AO0yUKW3IN0fYS8+GrfLsBjMC+xfy0OWFVcborqClXYShCKBLDvBW4z1
        +TRC0ZlQRyv/Lx2lo4/nQz7CLw==
X-Google-Smtp-Source: AK7set/oai7qJWPzgx5+u5E8XkABsP3aFR0EZrzw4VvanWI3a/uM2SfTZjC45RCOlLAFFDBYNo7N3w==
X-Received: by 2002:a05:6214:c67:b0:5b9:173d:bfb3 with SMTP id t7-20020a0562140c6700b005b9173dbfb3mr17412887qvj.23.1679257409118;
        Sun, 19 Mar 2023 13:23:29 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id c23-20020a379a17000000b007436d0e9408sm916186qke.127.2023.03.19.13.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 13:23:28 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] iio: addac: stx104: Migrate to the regmap API
Date:   Sun, 19 Mar 2023 16:22:56 -0400
Message-Id: <20230319202256.352939-1-william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regmap API supports IO port accessors so we can take advantage of
regmap abstractions rather than handling access to the device registers
directly in the driver.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/iio/addac/Kconfig  |   2 +
 drivers/iio/addac/stx104.c | 422 ++++++++++++++++++++-----------------
 2 files changed, 231 insertions(+), 193 deletions(-)

diff --git a/drivers/iio/addac/Kconfig b/drivers/iio/addac/Kconfig
index 2843fcb70e24..877f9124803c 100644
--- a/drivers/iio/addac/Kconfig
+++ b/drivers/iio/addac/Kconfig
@@ -35,7 +35,9 @@ config STX104
 	tristate "Apex Embedded Systems STX104 driver"
 	depends on PC104 && X86
 	select ISA_BUS_API
+	select REGMAP_MMIO
 	select GPIOLIB
+	select GPIO_REGMAP
 	help
 	  Say yes here to build support for the Apex Embedded Systems STX104
 	  integrated analog PC/104 card.
diff --git a/drivers/iio/addac/stx104.c b/drivers/iio/addac/stx104.c
index e45b70aa5bb7..7e15410d3100 100644
--- a/drivers/iio/addac/stx104.c
+++ b/drivers/iio/addac/stx104.c
@@ -3,19 +3,18 @@
  * IIO driver for the Apex Embedded Systems STX104
  * Copyright (C) 2016 William Breathitt Gray
  */
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/device.h>
-#include <linux/errno.h>
-#include <linux/gpio/driver.h>
+#include <linux/err.h>
+#include <linux/gpio/regmap.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/types.h>
-#include <linux/io.h>
-#include <linux/ioport.h>
 #include <linux/isa.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/spinlock.h>
+#include <linux/regmap.h>
 #include <linux/types.h>
 
 #define STX104_OUT_CHAN(chan) {				\
@@ -45,101 +44,190 @@ static unsigned int num_stx104;
 module_param_hw_array(base, uint, ioport, &num_stx104, 0);
 MODULE_PARM_DESC(base, "Apex Embedded Systems STX104 base addresses");
 
-/**
- * struct stx104_reg - device register structure
- * @ssr_ad:	Software Strobe Register and ADC Data
- * @achan:	ADC Channel
- * @dio:	Digital I/O
- * @dac:	DAC Channels
- * @cir_asr:	Clear Interrupts and ADC Status
- * @acr:	ADC Control
- * @pccr_fsh:	Pacer Clock Control and FIFO Status MSB
- * @acfg:	ADC Configuration
- */
-struct stx104_reg {
-	u16 ssr_ad;
-	u8 achan;
-	u8 dio;
-	u16 dac[2];
-	u8 cir_asr;
-	u8 acr;
-	u8 pccr_fsh;
-	u8 acfg;
+#define AIO_BASE 0x0
+#define SOFTWARE_STROBE AIO_BASE
+#define ADC_DATA AIO_BASE
+#define ADC_CHANNEL (AIO_BASE + 0x2)
+#define DIO_REG (AIO_BASE + 0x3)
+#define DAC_BASE (AIO_BASE + 0x4)
+#define ADC_STATUS (AIO_BASE + 0x8)
+#define ADC_CONTROL (AIO_BASE + 0x9)
+#define ADC_CONFIGURATION (AIO_BASE + 0x11)
+
+#define AIO_DATA_STRIDE 2
+#define DAC_OFFSET(_channel) (DAC_BASE + AIO_DATA_STRIDE * (_channel))
+
+/* ADC Channel */
+#define FC GENMASK(3, 0)
+#define LC GENMASK(7, 4)
+#define SAME_CHANNEL(_channel) (FIELD_PREP(FC, _channel) | FIELD_PREP(LC, _channel))
+
+/* ADC Status */
+#define SD BIT(5)
+#define CNV BIT(7)
+#define DIFFERENTIAL 1
+
+/* ADC Control */
+#define ALSS GENMASK(1, 0)
+#define SOFTWARE_TRIGGER 0
+
+/* ADC Configuration */
+#define GAIN GENMASK(1, 0)
+#define ADBU BIT(2)
+#define BIPOLAR 0
+#define GAIN_X1 0
+#define GAIN_X2 1
+#define GAIN_X4 2
+#define GAIN_X8 3
+
+static const struct regmap_range aio_ctl_wr_ranges[] = {
+	regmap_reg_range(0x0, 0x0), regmap_reg_range(0x2, 0x2), regmap_reg_range(0x9, 0x9),
+	regmap_reg_range(0x11, 0x11),
+};
+static const struct regmap_range aio_ctl_rd_ranges[] = {
+	regmap_reg_range(0x2, 0x2), regmap_reg_range(0x8, 0x9), regmap_reg_range(0x11, 0x11),
+};
+static const struct regmap_range aio_ctl_volatile_ranges[] = {
+	regmap_reg_range(0x8, 0x8),
+};
+static const struct regmap_access_table aio_ctl_wr_table = {
+	.yes_ranges = aio_ctl_wr_ranges,
+	.n_yes_ranges = ARRAY_SIZE(aio_ctl_wr_ranges),
+};
+static const struct regmap_access_table aio_ctl_rd_table = {
+	.yes_ranges = aio_ctl_rd_ranges,
+	.n_yes_ranges = ARRAY_SIZE(aio_ctl_rd_ranges),
+};
+static const struct regmap_access_table aio_ctl_volatile_table = {
+	.yes_ranges = aio_ctl_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(aio_ctl_volatile_ranges),
 };
 
-/**
- * struct stx104_iio - IIO device private data structure
- * @chan_out_states:	channels' output states
- * @reg:		I/O address offset for the device registers
- */
-struct stx104_iio {
-	unsigned int chan_out_states[STX104_NUM_OUT_CHAN];
-	struct stx104_reg __iomem *reg;
+static const struct regmap_config aio_ctl_regmap_config = {
+	.name = "aio_ctl",
+	.reg_bits = 8,
+	.reg_stride = 1,
+	.val_bits = 8,
+	.io_port = true,
+	.max_register = 0x11,
+	.wr_table = &aio_ctl_wr_table,
+	.rd_table = &aio_ctl_rd_table,
+	.volatile_table = &aio_ctl_volatile_table,
+	.cache_type = REGCACHE_FLAT,
+};
+
+static const struct regmap_range aio_data_wr_ranges[] = {
+	regmap_reg_range(0x4, 0x7),
+};
+static const struct regmap_range aio_data_rd_ranges[] = {
+	regmap_reg_range(0x0, 0x1),
+};
+static const struct regmap_access_table aio_data_wr_table = {
+	.yes_ranges = aio_data_wr_ranges,
+	.n_yes_ranges = ARRAY_SIZE(aio_data_wr_ranges),
+};
+static const struct regmap_access_table aio_data_rd_table = {
+	.yes_ranges = aio_data_rd_ranges,
+	.n_yes_ranges = ARRAY_SIZE(aio_data_rd_ranges),
+};
+
+static const struct regmap_config aio_data_regmap_config = {
+	.name = "aio_data",
+	.reg_bits = 16,
+	.reg_stride = AIO_DATA_STRIDE,
+	.val_bits = 16,
+	.io_port = true,
+	.max_register = 0x7,
+	.wr_table = &aio_data_wr_table,
+	.rd_table = &aio_data_rd_table,
+	.volatile_table = &aio_data_rd_table,
+	.cache_type = REGCACHE_FLAT,
+};
+
+static const struct regmap_config dio_regmap_config = {
+	.name = "dio",
+	.reg_bits = 8,
+	.reg_stride = 1,
+	.val_bits = 8,
+	.io_port = true,
+	.max_register = 0x0,
 };
 
 /**
- * struct stx104_gpio - GPIO device private data structure
- * @chip:	instance of the gpio_chip
- * @lock:	synchronization lock to prevent I/O race conditions
- * @base:	base port address of the GPIO device
- * @out_state:	output bits state
+ * struct stx104_iio - IIO device private data structure
+ * @aio_data_map: Regmap for analog I/O data
+ * @aio_ctl_map: Regmap for analog I/O control
  */
-struct stx104_gpio {
-	struct gpio_chip chip;
-	spinlock_t lock;
-	u8 __iomem *base;
-	unsigned int out_state;
+struct stx104_iio {
+	struct regmap *aio_data_map;
+	struct regmap *aio_ctl_map;
 };
 
 static int stx104_read_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
 {
 	struct stx104_iio *const priv = iio_priv(indio_dev);
-	struct stx104_reg __iomem *const reg = priv->reg;
+	int err;
 	unsigned int adc_config;
-	int adbu;
-	int gain;
+	unsigned int value;
+	unsigned int adc_status;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_HARDWAREGAIN:
-		/* get gain configuration */
-		adc_config = ioread8(&reg->acfg);
-		gain = adc_config & 0x3;
+		err = regmap_read(priv->aio_ctl_map, ADC_CONFIGURATION, &adc_config);
+		if (err)
+			return err;
 
-		*val = 1 << gain;
+		*val = 1 << FIELD_GET(GAIN, adc_config);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_RAW:
 		if (chan->output) {
-			*val = priv->chan_out_states[chan->channel];
+			err = regmap_read(priv->aio_data_map, DAC_OFFSET(chan->channel), &value);
+			if (err)
+				return err;
+			*val = value;
 			return IIO_VAL_INT;
 		}
 
 		/* select ADC channel */
-		iowrite8(chan->channel | (chan->channel << 4), &reg->achan);
+		err = regmap_write(priv->aio_ctl_map, ADC_CHANNEL, SAME_CHANNEL(chan->channel));
+		if (err)
+			return err;
 
 		/* trigger ADC sample capture by writing to the 8-bit
 		 * Software Strobe Register and wait for completion
 		 */
-		iowrite8(0, &reg->ssr_ad);
-		while (ioread8(&reg->cir_asr) & BIT(7));
-
-		*val = ioread16(&reg->ssr_ad);
+		err = regmap_write(priv->aio_ctl_map, SOFTWARE_STROBE, 0);
+		if (err)
+			return err;
+		do {
+			err = regmap_read(priv->aio_ctl_map, ADC_STATUS, &adc_status);
+			if (err)
+				return err;
+		} while (FIELD_GET(CNV, adc_status));
+
+		err = regmap_read(priv->aio_data_map, ADC_DATA, &value);
+		if (err)
+			return err;
+		*val = value;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OFFSET:
 		/* get ADC bipolar/unipolar configuration */
-		adc_config = ioread8(&reg->acfg);
-		adbu = !(adc_config & BIT(2));
+		err = regmap_read(priv->aio_ctl_map, ADC_CONFIGURATION, &adc_config);
+		if (err)
+			return err;
 
-		*val = -32768 * adbu;
+		*val = (FIELD_GET(ADBU, adc_config) == BIPOLAR) ? -32768 : 0;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		/* get ADC bipolar/unipolar and gain configuration */
-		adc_config = ioread8(&reg->acfg);
-		adbu = !(adc_config & BIT(2));
-		gain = adc_config & 0x3;
+		err = regmap_read(priv->aio_ctl_map, ADC_CONFIGURATION, &adc_config);
+		if (err)
+			return err;
 
 		*val = 5;
-		*val2 = 15 - adbu + gain;
+		*val2 = (FIELD_GET(ADBU, adc_config) == BIPOLAR) ? 14 : 15;
+		*val2 += FIELD_GET(GAIN, adc_config);
 		return IIO_VAL_FRACTIONAL_LOG2;
 	}
 
@@ -150,38 +238,36 @@ static int stx104_write_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int val, int val2, long mask)
 {
 	struct stx104_iio *const priv = iio_priv(indio_dev);
+	u8 gain;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_HARDWAREGAIN:
 		/* Only four gain states (x1, x2, x4, x8) */
 		switch (val) {
 		case 1:
-			iowrite8(0, &priv->reg->acfg);
+			gain = GAIN_X1;
 			break;
 		case 2:
-			iowrite8(1, &priv->reg->acfg);
+			gain = GAIN_X2;
 			break;
 		case 4:
-			iowrite8(2, &priv->reg->acfg);
+			gain = GAIN_X4;
 			break;
 		case 8:
-			iowrite8(3, &priv->reg->acfg);
+			gain = GAIN_X8;
 			break;
 		default:
 			return -EINVAL;
 		}
 
-		return 0;
+		return regmap_write(priv->aio_ctl_map, ADC_CONFIGURATION, gain);
 	case IIO_CHAN_INFO_RAW:
 		if (chan->output) {
 			/* DAC can only accept up to a 16-bit value */
 			if ((unsigned int)val > 65535)
 				return -EINVAL;
 
-			priv->chan_out_states[chan->channel] = val;
-			iowrite16(val, &priv->reg->dac[chan->channel]);
-
-			return 0;
+			return regmap_write(priv->aio_data_map, DAC_OFFSET(chan->channel), val);
 		}
 		return -EINVAL;
 	}
@@ -212,119 +298,66 @@ static const struct iio_chan_spec stx104_channels_diff[] = {
 	STX104_IN_CHAN(6, 1), STX104_IN_CHAN(7, 1)
 };
 
-static int stx104_gpio_get_direction(struct gpio_chip *chip,
-	unsigned int offset)
-{
-	/* GPIO 0-3 are input only, while the rest are output only */
-	if (offset < 4)
-		return 1;
-
-	return 0;
-}
-
-static int stx104_gpio_direction_input(struct gpio_chip *chip,
-	unsigned int offset)
-{
-	if (offset >= 4)
-		return -EINVAL;
-
-	return 0;
-}
-
-static int stx104_gpio_direction_output(struct gpio_chip *chip,
-	unsigned int offset, int value)
-{
-	if (offset < 4)
-		return -EINVAL;
-
-	chip->set(chip, offset, value);
-	return 0;
-}
-
-static int stx104_gpio_get(struct gpio_chip *chip, unsigned int offset)
+static int stx104_reg_mask_xlate(struct gpio_regmap *const gpio, const unsigned int base,
+				 unsigned int offset, unsigned int *const reg,
+				 unsigned int *const mask)
 {
-	struct stx104_gpio *const stx104gpio = gpiochip_get_data(chip);
-
+	/* Output lines are located at same register bit offsets as input lines */
 	if (offset >= 4)
-		return -EINVAL;
-
-	return !!(ioread8(stx104gpio->base) & BIT(offset));
-}
-
-static int stx104_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
-	unsigned long *bits)
-{
-	struct stx104_gpio *const stx104gpio = gpiochip_get_data(chip);
+		offset -= 4;
 
-	*bits = ioread8(stx104gpio->base);
+	*reg = base;
+	*mask = BIT(offset);
 
 	return 0;
 }
 
-static void stx104_gpio_set(struct gpio_chip *chip, unsigned int offset,
-	int value)
-{
-	struct stx104_gpio *const stx104gpio = gpiochip_get_data(chip);
-	const unsigned int mask = BIT(offset) >> 4;
-	unsigned long flags;
-
-	if (offset < 4)
-		return;
-
-	spin_lock_irqsave(&stx104gpio->lock, flags);
-
-	if (value)
-		stx104gpio->out_state |= mask;
-	else
-		stx104gpio->out_state &= ~mask;
-
-	iowrite8(stx104gpio->out_state, stx104gpio->base);
-
-	spin_unlock_irqrestore(&stx104gpio->lock, flags);
-}
-
 #define STX104_NGPIO 8
 static const char *stx104_names[STX104_NGPIO] = {
 	"DIN0", "DIN1", "DIN2", "DIN3", "DOUT0", "DOUT1", "DOUT2", "DOUT3"
 };
 
-static void stx104_gpio_set_multiple(struct gpio_chip *chip,
-	unsigned long *mask, unsigned long *bits)
+static int stx104_init_hw(struct stx104_iio *const priv)
 {
-	struct stx104_gpio *const stx104gpio = gpiochip_get_data(chip);
-	unsigned long flags;
-
-	/* verify masked GPIO are output */
-	if (!(*mask & 0xF0))
-		return;
+	int err;
 
-	*mask >>= 4;
-	*bits >>= 4;
+	/* configure device for software trigger operation */
+	err = regmap_write(priv->aio_ctl_map, ADC_CONTROL, SOFTWARE_TRIGGER);
+	if (err)
+		return err;
 
-	spin_lock_irqsave(&stx104gpio->lock, flags);
+	/* initialize gain setting to x1 */
+	err = regmap_write(priv->aio_ctl_map, ADC_CONFIGURATION, GAIN_X1);
+	if (err)
+		return err;
 
-	stx104gpio->out_state &= ~*mask;
-	stx104gpio->out_state |= *mask & *bits;
-	iowrite8(stx104gpio->out_state, stx104gpio->base);
+	/* initialize DAC outputs to 0V */
+	err = regmap_write(priv->aio_data_map, DAC_BASE, 0);
+	if (err)
+		return err;
+	err = regmap_write(priv->aio_data_map, DAC_BASE + AIO_DATA_STRIDE, 0);
+	if (err)
+		return err;
 
-	spin_unlock_irqrestore(&stx104gpio->lock, flags);
+	return 0;
 }
 
 static int stx104_probe(struct device *dev, unsigned int id)
 {
 	struct iio_dev *indio_dev;
 	struct stx104_iio *priv;
-	struct stx104_gpio *stx104gpio;
+	struct gpio_regmap_config gpio_config = {};
+	void __iomem *stx104_base;
+	struct regmap *aio_ctl_map;
+	struct regmap *aio_data_map;
+	struct regmap *dio_map;
 	int err;
+	unsigned int adc_status;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
 	if (!indio_dev)
 		return -ENOMEM;
 
-	stx104gpio = devm_kzalloc(dev, sizeof(*stx104gpio), GFP_KERNEL);
-	if (!stx104gpio)
-		return -ENOMEM;
-
 	if (!devm_request_region(dev, base[id], STX104_EXTENT,
 		dev_name(dev))) {
 		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
@@ -332,16 +365,35 @@ static int stx104_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
-	priv = iio_priv(indio_dev);
-	priv->reg = devm_ioport_map(dev, base[id], STX104_EXTENT);
-	if (!priv->reg)
+	stx104_base = devm_ioport_map(dev, base[id], STX104_EXTENT);
+	if (!stx104_base)
 		return -ENOMEM;
 
+	aio_ctl_map = devm_regmap_init_mmio(dev, stx104_base + AIO_BASE, &aio_ctl_regmap_config);
+	if (IS_ERR(aio_ctl_map))
+		return dev_err_probe(dev, PTR_ERR(aio_ctl_map),
+				     "Unable to initialize aio_ctl register map\n");
+	aio_data_map = devm_regmap_init_mmio(dev, stx104_base + AIO_BASE, &aio_data_regmap_config);
+	if (IS_ERR(aio_data_map))
+		return dev_err_probe(dev, PTR_ERR(aio_data_map),
+				     "Unable to initialize aio_data register map\n");
+	dio_map = devm_regmap_init_mmio(dev, stx104_base + DIO_REG, &dio_regmap_config);
+	if (IS_ERR(dio_map))
+		return dev_err_probe(dev, PTR_ERR(dio_map),
+				     "Unable to initialize dio register map\n");
+
+	priv = iio_priv(indio_dev);
+	priv->aio_ctl_map = aio_ctl_map;
+	priv->aio_data_map = aio_data_map;
+
 	indio_dev->info = &stx104_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	/* determine if differential inputs */
-	if (ioread8(&priv->reg->cir_asr) & BIT(5)) {
+	err = regmap_read(aio_ctl_map, ADC_STATUS, &adc_status);
+	if (err)
+		return err;
+
+	if (FIELD_GET(SD, adc_status) == DIFFERENTIAL) {
 		indio_dev->num_channels = ARRAY_SIZE(stx104_channels_diff);
 		indio_dev->channels = stx104_channels_diff;
 	} else {
@@ -351,41 +403,25 @@ static int stx104_probe(struct device *dev, unsigned int id)
 
 	indio_dev->name = dev_name(dev);
 
-	/* configure device for software trigger operation */
-	iowrite8(0, &priv->reg->acr);
+	err = stx104_init_hw(priv);
+	if (err)
+		return err;
 
-	/* initialize gain setting to x1 */
-	iowrite8(0, &priv->reg->acfg);
-
-	/* initialize DAC output to 0V */
-	iowrite16(0, &priv->reg->dac[0]);
-	iowrite16(0, &priv->reg->dac[1]);
-
-	stx104gpio->chip.label = dev_name(dev);
-	stx104gpio->chip.parent = dev;
-	stx104gpio->chip.owner = THIS_MODULE;
-	stx104gpio->chip.base = -1;
-	stx104gpio->chip.ngpio = STX104_NGPIO;
-	stx104gpio->chip.names = stx104_names;
-	stx104gpio->chip.get_direction = stx104_gpio_get_direction;
-	stx104gpio->chip.direction_input = stx104_gpio_direction_input;
-	stx104gpio->chip.direction_output = stx104_gpio_direction_output;
-	stx104gpio->chip.get = stx104_gpio_get;
-	stx104gpio->chip.get_multiple = stx104_gpio_get_multiple;
-	stx104gpio->chip.set = stx104_gpio_set;
-	stx104gpio->chip.set_multiple = stx104_gpio_set_multiple;
-	stx104gpio->base = &priv->reg->dio;
-	stx104gpio->out_state = 0x0;
-
-	spin_lock_init(&stx104gpio->lock);
-
-	err = devm_gpiochip_add_data(dev, &stx104gpio->chip, stx104gpio);
-	if (err) {
-		dev_err(dev, "GPIO registering failed (%d)\n", err);
+	err = devm_iio_device_register(dev, indio_dev);
+	if (err)
 		return err;
-	}
 
-	return devm_iio_device_register(dev, indio_dev);
+	gpio_config.parent = dev;
+	gpio_config.regmap = dio_map;
+	gpio_config.ngpio = STX104_NGPIO;
+	gpio_config.names = stx104_names;
+	gpio_config.reg_dat_base = GPIO_REGMAP_ADDR(DIO_REG);
+	gpio_config.reg_set_base = GPIO_REGMAP_ADDR(DIO_REG);
+	gpio_config.ngpio_per_reg = STX104_NGPIO;
+	gpio_config.reg_mask_xlate = stx104_reg_mask_xlate;
+	gpio_config.drvdata = dio_map;
+
+	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &gpio_config));
 }
 
 static struct isa_driver stx104_driver = {

base-commit: 46e33707fe95a21aa9896bded0be97285b779509
-- 
2.39.2

