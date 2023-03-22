Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F116C4AEA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjCVMnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjCVMna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:43:30 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFB81C306
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 05:43:28 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l15-20020a05600c4f0f00b003ed58a9a15eso11392882wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 05:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1679489007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gL2q9nK2sCWoMHOPkHjxQjCYyzKcPYLR8xpxNLwvnUw=;
        b=AmKpP1kIq1wAiLzeGy0jiXwfdhNgXGVu8ljLYUjM7x3KEXSe7QtPo4u2sm+P34YW5I
         P4YQL4eHrx7loh85gIfwpZGagDbIFtLsZMueyAsU7SmHtHhkYFRiTdk70ab7t8n74W+k
         sCEmiDL1GD275/5K7yvWceS21vyfM4Y4wHfVfILFo1NedrAw7TkC3Gcy7lbSueSc9GIN
         BvbVxOyy03nH2vf0I/5LCRj2edug2PcRzAhVbVG6b/Nv0UrsTJckkVUfe44FbXWH4JcK
         50cARqTwsFLDpqnCbHHfcO7enULY4/v29PZ4ebnZAjqGpRUPoHGRk6oHRKjFXyfeSsG/
         9TCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679489007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gL2q9nK2sCWoMHOPkHjxQjCYyzKcPYLR8xpxNLwvnUw=;
        b=Qow2OsYXB1Jri+w/xdmbwtjMRIplhq5d5WiWQkrD9A6eLK+2eKssNEXM1tx9xAt75s
         CkSlNuUbVv42X28W6AGXCum8soSWMtlir7DRmOXCq/PIDQjTFmKZrtT/HfvatMT711z6
         vVi8115wcBJbXfgeuVNfZ3n8AJ/e8ulr3iG50eyEe613NkBVy6qhprVH4DPjvYLn07mG
         myvty5qF8GUgO41ec3IMNEDG1AM/klpTPeS6/EXOqZvSVNpsSjSEqhAjMt4eyYYhZZJT
         kupMDevHB4NhsULMvovLYJyRoEGTqwjgJJUKtwCDizhgFQK3yVovXHwlROMrvDPUSomU
         mR+A==
X-Gm-Message-State: AO0yUKVrtNP2gdEK5fM3q3Kodpx/5cjVm1RIvgGyFbmacl2l3dAdpl++
        eTUXW5OgmYXj4Q9BLvBvRAWPyLdI6KuZ5+Fse9ET8A==
X-Google-Smtp-Source: AK7set/uHO9U604T2CSuRiOjl1lBA0+jDlA7G3i0723BCf2qZ574qwCZKpIBvCcy8YaxjDfgymkZ7Q==
X-Received: by 2002:a1c:4c13:0:b0:3ee:3d2d:841a with SMTP id z19-20020a1c4c13000000b003ee3d2d841amr4314452wmf.24.1679489007382;
        Wed, 22 Mar 2023 05:43:27 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id c15-20020adfef4f000000b002c7066a6f77sm13748526wrp.31.2023.03.22.05.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 05:43:27 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Lee Jones <lee@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 1/2] iio: max597x: Add support for max597x
Date:   Wed, 22 Mar 2023 13:43:15 +0100
Message-Id: <20230322124316.2147143-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

max597x has 10bit ADC for voltage & current monitoring.
Use iio framework to expose the same in sysfs.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/iio/adc/Kconfig       |  15 ++++
 drivers/iio/adc/Makefile      |   1 +
 drivers/iio/adc/max597x-iio.c | 162 ++++++++++++++++++++++++++++++++++
 3 files changed, 178 insertions(+)
 create mode 100644 drivers/iio/adc/max597x-iio.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 45af2302be53..0d1a3dea0b7d 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -735,6 +735,21 @@ config MAX1363
 	  To compile this driver as a module, choose M here: the module will be
 	  called max1363.
 
+config MAX597X_IIO
+	tristate "Maxim 597x power switch and monitor"
+	depends on I2C && OF
+	select MFD_MAX597X
+	help
+	  This driver enables support for the Maxim 597x smart switch and
+	  voltage/current monitoring interface using the Industrial I/O (IIO)
+	  framework. The Maxim 597x is a power switch and monitor that can
+	  provide voltage and current measurements via the I2C bus. Enabling
+	  this driver will allow user space applications to read the voltage
+	  and current measurements using IIO interfaces.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called max597x-iio.
+
 config MAX9611
 	tristate "Maxim max9611/max9612 ADC driver"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 36c18177322a..7ec0c2cf7bbb 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_MAX11205) += max11205.o
 obj-$(CONFIG_MAX11410) += max11410.o
 obj-$(CONFIG_MAX1241) += max1241.o
 obj-$(CONFIG_MAX1363) += max1363.o
+obj-$(CONFIG_MAX597X_IIO) += max597x-iio.o
 obj-$(CONFIG_MAX9611) += max9611.o
 obj-$(CONFIG_MCP320X) += mcp320x.o
 obj-$(CONFIG_MCP3422) += mcp3422.o
diff --git a/drivers/iio/adc/max597x-iio.c b/drivers/iio/adc/max597x-iio.c
new file mode 100644
index 000000000000..a35bab926313
--- /dev/null
+++ b/drivers/iio/adc/max597x-iio.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device driver for regulators in MAX5970 and MAX5978 IC
+ *
+ * Copyright (c) 2022 9elements GmbH
+ *
+ * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/iio/iio.h>
+#include <linux/of.h>
+#include <linux/i2c.h>
+#include <linux/mfd/max597x.h>
+#include <linux/regmap.h>
+#include <linux/version.h>
+#include <linux/platform_device.h>
+
+struct max597x_iio {
+	struct regmap *regmap;
+	int shunt_micro_ohms[MAX5970_NUM_SWITCHES];
+	unsigned int irng[MAX5970_NUM_SWITCHES];
+	unsigned int mon_rng[MAX5970_NUM_SWITCHES];
+};
+
+#define MAX597X_ADC_CHANNEL(_idx, _type) {			\
+	.type = IIO_ ## _type,					\
+	.indexed = 1,						\
+	.channel = (_idx),					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			      BIT(IIO_CHAN_INFO_SCALE),		\
+	.address = MAX5970_REG_ ## _type ## _L(_idx),		\
+}
+
+static const struct iio_chan_spec max5978_adc_iio_channels[] = {
+	MAX597X_ADC_CHANNEL(0, VOLTAGE),
+	MAX597X_ADC_CHANNEL(0, CURRENT),
+};
+
+static const struct iio_chan_spec max5970_adc_iio_channels[] = {
+	MAX597X_ADC_CHANNEL(0, VOLTAGE),
+	MAX597X_ADC_CHANNEL(0, CURRENT),
+	MAX597X_ADC_CHANNEL(1, VOLTAGE),
+	MAX597X_ADC_CHANNEL(1, CURRENT),
+};
+
+static int max597x_iio_read_raw(struct iio_dev *iio_dev,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2, long info)
+{
+	int ret;
+	struct max597x_iio *data = iio_priv(iio_dev);
+	unsigned int reg_l, reg_h;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_read(data->regmap, chan->address, &reg_l);
+		if (ret < 0)
+			return ret;
+		ret = regmap_read(data->regmap, chan->address - 1, &reg_h);
+		if (ret < 0)
+			return ret;
+		*val = (reg_h << 2) | (reg_l & 3);
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+
+		switch (chan->address) {
+		case MAX5970_REG_CURRENT_L(0):
+			fallthrough;
+		case MAX5970_REG_CURRENT_L(1):
+			/* in A, convert to mA */
+			*val = data->irng[chan->channel] * 1000;
+			*val2 =
+			    data->shunt_micro_ohms[chan->channel] * ADC_MASK;
+			return IIO_VAL_FRACTIONAL;
+
+		case MAX5970_REG_VOLTAGE_L(0):
+			fallthrough;
+		case MAX5970_REG_VOLTAGE_L(1):
+			/* in uV, convert to mV */
+			*val = data->mon_rng[chan->channel];
+			*val2 = ADC_MASK * 1000;
+			return IIO_VAL_FRACTIONAL;
+		}
+
+		break;
+	}
+	return -EINVAL;
+}
+
+static const struct iio_info max597x_adc_iio_info = {
+	.read_raw = &max597x_iio_read_raw,
+};
+
+static int max597x_iio_probe(struct platform_device *pdev)
+{
+	struct max597x_data *max597x = dev_get_drvdata(pdev->dev.parent);
+	struct i2c_client *i2c = to_i2c_client(pdev->dev.parent);
+	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	struct iio_dev *indio_dev;
+	struct max597x_iio *priv;
+	int ret, i;
+
+	if (!regmap)
+		return -EPROBE_DEFER;
+
+	if (!max597x || !max597x->num_switches)
+		return -EPROBE_DEFER;
+
+	/* registering iio */
+	indio_dev = devm_iio_device_alloc(&i2c->dev, sizeof(*priv));
+	if (!indio_dev) {
+		dev_err(&i2c->dev, "failed allocating iio device\n");
+		return -ENOMEM;
+	}
+	indio_dev->name = dev_name(&i2c->dev);
+	indio_dev->info = &max597x_adc_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	switch (max597x->num_switches) {
+	case MAX597x_TYPE_MAX5970:
+		indio_dev->channels = max5970_adc_iio_channels;
+		indio_dev->num_channels = ARRAY_SIZE(max5970_adc_iio_channels);
+		break;
+	case MAX597x_TYPE_MAX5978:
+		indio_dev->channels = max5978_adc_iio_channels;
+		indio_dev->num_channels = ARRAY_SIZE(max5978_adc_iio_channels);
+		break;
+	}
+
+	priv = iio_priv(indio_dev);
+	priv->regmap = regmap;
+	for (i = 0; i < indio_dev->num_channels; i++) {
+		priv->irng[i] = max597x->irng[i];
+		priv->mon_rng[i] = max597x->mon_rng[i];
+		priv->shunt_micro_ohms[i] = max597x->shunt_micro_ohms[i];
+	}
+
+	ret = devm_iio_device_register(&i2c->dev, indio_dev);
+	if (ret)
+		dev_err(&i2c->dev, "could not register iio device");
+
+	return ret;
+}
+
+static struct platform_driver max597x_iio_driver = {
+	.driver = {
+		.name = "max597x-iio",
+	},
+	.probe = max597x_iio_probe,
+};
+
+module_platform_driver(max597x_iio_driver);
+
+MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
+MODULE_DESCRIPTION("MAX5970_hot-swap controller driver");
+MODULE_LICENSE("GPL");

base-commit: 368eb79f738a21e16c2bdbcac2444dfa96b01aaa
-- 
2.39.1

